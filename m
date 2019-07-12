Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F481C742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAB22064A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfGLQcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:32:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51270 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfGLQcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:32:39 -0400
Received: from pc-381.home (2a01cb0c80061e00e835b5cf688fec09.ipv6.abo.wanadoo.fr [IPv6:2a01:cb0c:8006:1e00:e835:b5cf:688f:ec09])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3D11028BBD0;
        Fri, 12 Jul 2019 17:32:38 +0100 (BST)
Date:   Fri, 12 Jul 2019 18:32:34 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas.Ferre@microchip.com,
        Joshua Henderson <joshua.henderson@microchip.com>,
        bbrezillon@kernel.org, airlied@linux.ie,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/atmel-hlcdc: set layer REP bit to enable
 replication logic
Message-ID: <20190712183234.35427352@pc-381.home>
In-Reply-To: <20190712162117.GB18990@ravnborg.org>
References: <1562686509-8747-1-git-send-email-joshua.henderson@microchip.com>
        <13aa50e4-a726-3f82-b186-79b452199a02@microchip.com>
        <20190712162117.GB18990@ravnborg.org>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019 18:21:17 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> Hi Joshua.
> 
> On Tue, Jul 09, 2019 at 04:24:49PM +0000, Nicolas.Ferre@microchip.com wrote:
> > On 09/07/2019 at 17:35, Joshua Henderson wrote:  
> > > This bit enables replication logic to expand an RGB color less than 24
> > > bits, to 24 bits, which is used internally for all formats.  Otherwise,
> > > the least significant bits are always set to zero and the color may not
> > > be what is expected.
> > > 
> > > Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>  
> > 
> > Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > 
> > Here is patchwork entry:
> > https://patchwork.kernel.org/patch/11037167/
> > 
> > Thanks, best regards,
> >    Nicolas
> >   
> > > ---
> > >   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > > index eb7c4cf..6f6cf61 100644
> > > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > > @@ -389,7 +389,7 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
> > >   	atmel_hlcdc_layer_write_cfg(&plane->layer, ATMEL_HLCDC_LAYER_DMA_CFG,
> > >   				    cfg);
> > >   
> > > -	cfg = ATMEL_HLCDC_LAYER_DMA;
> > > +	cfg = ATMEL_HLCDC_LAYER_DMA | ATMEL_HLCDC_LAYER_REP;
> > >   
> > >   	if (plane->base.type != DRM_PLANE_TYPE_PRIMARY) {
> > >   		cfg |= ATMEL_HLCDC_LAYER_OVR | ATMEL_HLCDC_LAYER_ITER2BL |  
> 
> Thanks - this gave me an opportunity to read a bit more in the datasheet
> of the controller.
> Applied to drm-misc-next with Ack from Nicolas.

Was about to add my R-b and ask you to apply the patch. I'm glad you
didn't wait for my feedback though, that means I'll soon be able to
remove my name from the Atmel HLCDC entry in MAINTAINERS ;-).
