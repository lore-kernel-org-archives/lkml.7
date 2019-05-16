Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFA0C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAAB2087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AqEuEc+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfEPKO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:14:57 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:55334 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:14:57 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ED7C3320;
        Thu, 16 May 2019 12:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1558001695;
        bh=hdHDpOn6XPeT8HCeSsf6x0SVf0Wl4BDWp5vvALPWmUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AqEuEc+3Hkk+pq/L7bssYGNH3Yllxa/OlVeqwuBQkQdGyAkzaQU6EeJfTk8WVJnPs
         MjsLwRz1GcjHCRDFkQlUdbPypKpo5WOf0+nyM2iAS+nk86NSrM0MaqfojXDCwZ8JKa
         0fz6L4cv85S3qT8xR0hIekDP5rSwZGn5lYYdQ1fc=
Date:   Thu, 16 May 2019 13:14:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/2] drm/rockchip: dw_hdmi: Handle suspend/resume
Message-ID: <20190516101438.GD4995@pendragon.ideasonboard.com>
References: <20190502223808.185180-1-dianders@chromium.org>
 <20190502223808.185180-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190502223808.185180-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

Thank you for the patch.

On Thu, May 02, 2019 at 03:38:08PM -0700, Douglas Anderson wrote:
> On Rockchip rk3288-based Chromebooks when you do a suspend/resume
> cycle:
> 
> 1. You lose the ability to detect an HDMI device being plugged in.
> 
> 2. If you're using the i2c bus built in to dw_hdmi then it stops
> working.
> 
> Let's call the core dw-hdmi's suspend/resume functions to restore
> things.
> 
> NOTE: in downstream Chrome OS (based on kernel 3.14) we used the
> "late/early" versions of suspend/resume because we found that the VOP
> was sometimes resuming before dw_hdmi and then calling into us before
> we were fully resumed.  For now I have gone back to the normal
> suspend/resume because I can't reproduce the problems.

Should this be solved with device links if needed ?

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index 4cdc9f86c2e5..deb0e8c30c03 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -542,11 +542,31 @@ static int dw_hdmi_rockchip_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __maybe_unused dw_hdmi_rockchip_suspend(struct device *dev)
> +{
> +	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
> +
> +	return dw_hdmi_suspend(hdmi->hdmi);
> +}
> +
> +static int __maybe_unused dw_hdmi_rockchip_resume(struct device *dev)
> +{
> +	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
> +
> +	return dw_hdmi_resume(hdmi->hdmi);
> +}
> +
> +const struct dev_pm_ops dw_hdmi_rockchip_pm = {

Missing static keyword ?

Apart from this,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	SET_SYSTEM_SLEEP_PM_OPS(dw_hdmi_rockchip_suspend,
> +				dw_hdmi_rockchip_resume)
> +};
> +
>  struct platform_driver dw_hdmi_rockchip_pltfm_driver = {
>  	.probe  = dw_hdmi_rockchip_probe,
>  	.remove = dw_hdmi_rockchip_remove,
>  	.driver = {
>  		.name = "dwhdmi-rockchip",
> +		.pm = &dw_hdmi_rockchip_pm,
>  		.of_match_table = dw_hdmi_rockchip_dt_ids,
>  	},
>  };

-- 
Regards,

Laurent Pinchart
