Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CFCC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF002064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfGLQVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:21:22 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:53780 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfGLQVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:21:22 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id A5EC480335;
        Fri, 12 Jul 2019 18:21:18 +0200 (CEST)
Date:   Fri, 12 Jul 2019 18:21:17 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Nicolas.Ferre@microchip.com,
        Joshua Henderson <joshua.henderson@microchip.com>
Cc:     Joshua.Henderson@microchip.com, bbrezillon@kernel.org,
        airlied@linux.ie, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/atmel-hlcdc: set layer REP bit to enable replication
 logic
Message-ID: <20190712162117.GB18990@ravnborg.org>
References: <1562686509-8747-1-git-send-email-joshua.henderson@microchip.com>
 <13aa50e4-a726-3f82-b186-79b452199a02@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13aa50e4-a726-3f82-b186-79b452199a02@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8
        a=VwQbUJbxAAAA:8 a=uoxZAW4_gHUsVfBorzEA:9 a=CjuIK1q_8ugA:10
        a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua.

On Tue, Jul 09, 2019 at 04:24:49PM +0000, Nicolas.Ferre@microchip.com wrote:
> On 09/07/2019 at 17:35, Joshua Henderson wrote:
> > This bit enables replication logic to expand an RGB color less than 24
> > bits, to 24 bits, which is used internally for all formats.  Otherwise,
> > the least significant bits are always set to zero and the color may not
> > be what is expected.
> > 
> > Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Here is patchwork entry:
> https://patchwork.kernel.org/patch/11037167/
> 
> Thanks, best regards,
>    Nicolas
> 
> > ---
> >   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > index eb7c4cf..6f6cf61 100644
> > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > @@ -389,7 +389,7 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
> >   	atmel_hlcdc_layer_write_cfg(&plane->layer, ATMEL_HLCDC_LAYER_DMA_CFG,
> >   				    cfg);
> >   
> > -	cfg = ATMEL_HLCDC_LAYER_DMA;
> > +	cfg = ATMEL_HLCDC_LAYER_DMA | ATMEL_HLCDC_LAYER_REP;
> >   
> >   	if (plane->base.type != DRM_PLANE_TYPE_PRIMARY) {
> >   		cfg |= ATMEL_HLCDC_LAYER_OVR | ATMEL_HLCDC_LAYER_ITER2BL |

Thanks - this gave me an opportunity to read a bit more in the datasheet
of the controller.
Applied to drm-misc-next with Ack from Nicolas.

	Sam
