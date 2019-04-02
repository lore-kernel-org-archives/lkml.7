Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD568C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986ED20645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbfDBPt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:49:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37867 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731650AbfDBPt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:49:26 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hBLfA-0003VL-5y; Tue, 02 Apr 2019 17:49:24 +0200
Message-ID: <1554220163.2338.2.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] ipuv3-crtc: add remove action for devres data
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Michael Grzeschik <m.grzeschik@pengutronix.de>, airlied@linux.ie,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, rafael@kernel.org,
        kernel@pengutronix.de
Date:   Tue, 02 Apr 2019 17:49:23 +0200
In-Reply-To: <20190402134904.588-2-m.grzeschik@pengutronix.de>
References: <0687f68004b28ed3a364b06a9eb64e2e@agner.ch>
         <20190402134904.588-1-m.grzeschik@pengutronix.de>
         <20190402134904.588-2-m.grzeschik@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Tue, 2019-04-02 at 15:49 +0200, Michael Grzeschik wrote:
> The destroy function in drm_mode_config_cleanup will remove the objects
> in ipu-drm-core by calling its destroy functions if the bind function
> fails. The drm_crtc is also part of the devres allocated ipu_crtc
> object. The ipu_crtc object will already be cleaned up if the bind for
> the crtc fails. This leads drm_crtc_cleanup try to clean already freed
> memory.
> 
> We fix this issue by adding the devres action ipu_crtc_remove_head which
> will remove its head from the objects in ipu-drm-core which then never
> calls its destroy function anymore.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/gpu/drm/imx/ipuv3-crtc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
> index ec3602ebbc1cd..fa1ee33a43d77 100644
> --- a/drivers/gpu/drm/imx/ipuv3-crtc.c
> +++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
> @@ -429,6 +429,14 @@ static int ipu_crtc_init(struct ipu_crtc *ipu_crtc,
>  	return ret;
>  }
>  
> +static void ipu_crtc_remove_head(void *data)
> +{
> +	struct ipu_crtc *ipu_crtc = data;
> +	struct drm_crtc *crtc = &ipu_crtc->base;
> +
> +	list_del(&crtc->head);

I don't think reaching into drm_crtc internals like this is going to be
robust. Currently, this is either missing the rest of drm_crtc_cleanup,
or it will crash if drm_crtc_init_with_planes hasn't been called yet.

I think you could call devm_add_action with a function that calls
drm_crtc_cleanup after drm_crtc_init_with_planes in ipu_crtc_init.

Alternatively, the ipu_crtc allocation could be changed to kzalloc. It
would then have to freed manually in the drm_crtc_funcs->destroy
callback.

regards
Philipp
