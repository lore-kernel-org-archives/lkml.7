Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9B1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B40120863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="P71m8OOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfCYBfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 21:35:45 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60420 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbfCYBfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 21:35:44 -0400
Received: from pendragon.ideasonboard.com (30.net042126252.t-com.ne.jp [42.126.252.30])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 93B0CE2;
        Mon, 25 Mar 2019 02:35:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553477742;
        bh=uVv2BnxOvPEtDyxqJzQuBCekV7R/hZ+h6ZqFjdp8zf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P71m8OOkFmaqXPjrgI69CN0Zfy8U4NrN8cmCXI/G2cwplcoEGeQA3UqvF7BOj4/zt
         spokaCPHUM1Dy3ytodbtlPYGa5sTrtfRxuJ+2peXKysRAOhgQ6t2EhJvjnqDHuHmVR
         7LcanhwPz98SL373g8c/BOllmB5rex5ogVHWnPu0=
Date:   Mon, 25 Mar 2019 03:35:31 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     maxime.ripard@bootlin.com, a.hajda@samsung.com, airlied@linux.ie,
        daniel@ffwll.ch, wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drm/bridge/synopsys: dw-hdmi: Add an option to
 suppress loading CEC driver
Message-ID: <20190325013531.GB4540@pendragon.ideasonboard.com>
References: <20190324212144.3652-1-jernej.skrabec@siol.net>
 <20190324212144.3652-2-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190324212144.3652-2-jernej.skrabec@siol.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

Thank you for the patch.

On Sun, Mar 24, 2019 at 10:21:42PM +0100, Jernej Skrabec wrote:
> DW HDMI controller on some Allwinner SoCs has support for CEC, but due
> to additional logic put between CEC controller and pins, it doesn't work
> correctly, at least not with a lot of instrusive changes. Fortunately,
> it's still possible to bitbang protocol.
> 
> For such cases, add a platform option to suppress loading CEC driver. If
> DW HDMI CEC driver would be loaded, it wouldn't work anyway and only
> cause a confusion with multiple /dev entries.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
>  include/drm/bridge/dw_hdmi.h              | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index a63e5f0dae56..fdda26f8b056 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2634,7 +2634,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  		hdmi->audio = platform_device_register_full(&pdevinfo);
>  	}
>  
> -	if (config0 & HDMI_CONFIG0_CEC) {
> +	if (!plat_data->is_cec_unusable && (config0 & HDMI_CONFIG0_CEC)) {
>  		cec.hdmi = hdmi;
>  		cec.ops = &dw_hdmi_cec_ops;
>  		cec.irq = irq;
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 66e70770cce5..764b8bcfa62c 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -144,6 +144,8 @@ struct dw_hdmi_plat_data {
>  	int (*configure_phy)(struct dw_hdmi *hdmi,
>  			     const struct dw_hdmi_plat_data *pdata,
>  			     unsigned long mpixelclock);
> +
> +	unsigned int is_cec_unusable : 1;

Strictly speaking your CEC controller isn't unusable, it's just a bit
difficult to use it according to your commit message. Would disable_cec
be a more appropriate field name ? And how difficult would it be to
support the hardware CEC controller, would that result in changes that
could be useful to other vendors too ?

>  };
>  
>  struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,

-- 
Regards,

Laurent Pinchart
