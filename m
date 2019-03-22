Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6643EC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F63221900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfCVLAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:00:16 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48369 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfCVLAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:00:16 -0400
X-Originating-IP: 90.88.33.153
Received: from aptenodytes (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3A95E60011;
        Fri, 22 Mar 2019 11:00:12 +0000 (UTC)
Message-ID: <5c5ef4c7869f9294cfb7128a8b0ee00cf2012e40.camel@bootlin.com>
Subject: Re: [PATCH RESEND] drm/vc4: Make sure to emit a tile coordinates
 between two MSAA loads.
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Date:   Fri, 22 Mar 2019 12:00:12 +0100
In-Reply-To: <20190206232550.12012-1-eric@anholt.net>
References: <20190206232550.12012-1-eric@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mercredi 06 février 2019 à 15:25 -0800, Eric Anholt a écrit :
> The HW only executes a load once the tile coordinates packet happens,
> and only tracks one at a time, so by emitting our two MSAA loads back
> to back we would end up with an undefined color or Z buffer.

This change deals with things that I'm not very familiar with, but here
is my take on what is happening here:

- When we have to do more than a single load in the same render command
list, we need to send out tile coordinates and a dummy store in between
the two, because of internal architecture requirements of the GPU;
- We're dealing with the color buffer first and then the z-stencil
buffer;
- As a result, we need to issue that dummy store in the block handling
the z-stencil, if there was a previous color load in the rcl;
- We previously only did that for non-MSAA z-stencil buffers (without
the FULL_RES flag);
- The same thing actually needs to be done for the MSAA case too, as
the reason why we need that dummy store also applies to MSAA loads.

If my understanding is correct, then consider this:
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Otherwise, I'd be happy to know what I misunderstood in the process!

Cheers,

Paul

> Fixes dEQP-EGL.functional.render.multi_context.gles2.rgb888_window
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/vc4/vc4_render_cl.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_render_cl.c b/drivers/gpu/drm/vc4/vc4_render_cl.c
> index 273984f71ae2..3c918eeaf56e 100644
> --- a/drivers/gpu/drm/vc4/vc4_render_cl.c
> +++ b/drivers/gpu/drm/vc4/vc4_render_cl.c
> @@ -148,6 +148,12 @@ static void emit_tile(struct vc4_exec_info *exec,
>  	}
>  
>  	if (setup->zs_read) {
> +		if (setup->color_read) {
> +			/* Exec previous load. */
> +			vc4_tile_coordinates(setup, x, y);
> +			vc4_store_before_load(setup);
> +		}
> +
>  		if (args->zs_read.flags &
>  		    VC4_SUBMIT_RCL_SURFACE_READ_IS_FULL_RES) {
>  			rcl_u8(setup, VC4_PACKET_LOAD_FULL_RES_TILE_BUFFER);
> @@ -156,12 +162,6 @@ static void emit_tile(struct vc4_exec_info *exec,
>  						    &args->zs_read, x, y) |
>  				VC4_LOADSTORE_FULL_RES_DISABLE_COLOR);
>  		} else {
> -			if (setup->color_read) {
> -				/* Exec previous load. */
> -				vc4_tile_coordinates(setup, x, y);
> -				vc4_store_before_load(setup);
> -			}
> -
>  			rcl_u8(setup, VC4_PACKET_LOAD_TILE_BUFFER_GENERAL);
>  			rcl_u16(setup, args->zs_read.bits);
>  			rcl_u32(setup, setup->zs_read->paddr +
> @@ -291,16 +291,15 @@ static int vc4_create_rcl_bo(struct drm_device *dev, struct vc4_exec_info *exec,
>  		}
>  	}
>  	if (setup->zs_read) {
> +		if (setup->color_read) {
> +			loop_body_size += VC4_PACKET_TILE_COORDINATES_SIZE;
> +			loop_body_size += VC4_PACKET_STORE_TILE_BUFFER_GENERAL_SIZE;
> +		}
> +
>  		if (args->zs_read.flags &
>  		    VC4_SUBMIT_RCL_SURFACE_READ_IS_FULL_RES) {
>  			loop_body_size += VC4_PACKET_LOAD_FULL_RES_TILE_BUFFER_SIZE;
>  		} else {
> -			if (setup->color_read &&
> -			    !(args->color_read.flags &
> -			      VC4_SUBMIT_RCL_SURFACE_READ_IS_FULL_RES)) {
> -				loop_body_size += VC4_PACKET_TILE_COORDINATES_SIZE;
> -				loop_body_size += VC4_PACKET_STORE_TILE_BUFFER_GENERAL_SIZE;
> -			}
>  			loop_body_size += VC4_PACKET_LOAD_TILE_BUFFER_GENERAL_SIZE;
>  		}
>  	}
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

