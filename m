Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6826FC74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41449206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXMfPXQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfGKQpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 12:45:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38522 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfGKQpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 12:45:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id z75so3211689pgz.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jwuRR8Q1l0rKbX4Ve134b1iXf6no8US/0ODaV1OtfJg=;
        b=fXMfPXQFw+BMXHj5sB7D5SZbRLL4yLO7dCFEcqra0z5M/ZOltBbf3Zj/Aao1hET4GD
         3azphRfZ11zhgbXjs3N4nbnKMwUU7+4dw6YKKXllbd+DssNy3TxDGCgkmV1ikNcZxL7/
         2ICwcXgXIJkPJwzLWiM4/yASDDXjIQa7HjC9IImhuA+FU4yWlR8FfIzidpqktofkWi8v
         Va0bLm/egQy7D/+XBHgq+GtkBfu9c1Y6IPWhZN8mcQmY/Fa8JG1MM4eSiK3ha3usflxA
         5VzG7L1PfesBb/hDoETF7jtEOnM6ltMdpQbSzf5oDTXZHnTRFG58VhAlAl5/e8gh0nzi
         EL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jwuRR8Q1l0rKbX4Ve134b1iXf6no8US/0ODaV1OtfJg=;
        b=olGX3BHkIHwKdYDfm/WjYzj/mdYXZKMyHz/LeSVtfS5xnJvWCchRPMyS6u/YJgyfws
         c1Kc2bEsppSOeuI/z/NB954GVOSs5rVPgST7loaIoh3hn8pKZc+yylZ/+LzKad9dsZig
         3Yxh754baau5+dwdVMT+dKFbaAVDFnzpgNDq5g4HXOuno3CnG/2+7M/nvYFrbiFJZhg9
         U8Lyh9Jup5S0C48QCBDIPGysiGUVq3VNM3sQptkE2RPiULM3oPUWwSV1EzYO76JDt6Bm
         z7rUCM+AIuPg6EoZ2JQWUMwMH64q/tHZZdM6kmGeI4hnK5RptOTEowEGf77xC97MPq7W
         NY2w==
X-Gm-Message-State: APjAAAXHv0Nzh6m1iPy6Ts5i27ogpENjKwH6w7EB+L0KxaisPbRstTry
        SJR/AmRZ9rxT8hBildxjWNe+Ww==
X-Google-Smtp-Source: APXvYqy1hl1yTY2tAfPT4CfLcn/3WL5Tytxe1BBNzeHmDCMgcsWevHevzfTkFxpehMNWKiRgxKFHTg==
X-Received: by 2002:a17:90a:2343:: with SMTP id f61mr6002098pje.130.1562863511049;
        Thu, 11 Jul 2019 09:45:11 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l189sm7116203pfl.7.2019.07.11.09.45.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:45:10 -0700 (PDT)
Date:   Thu, 11 Jul 2019 09:46:19 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/phy/dsi_phy: silence -EPROBE_DEFER warnings
Message-ID: <20190711164619.GT7234@tuxbook-pro>
References: <20190706111138.2238-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706111138.2238-1-masneyb@onstation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 06 Jul 04:11 PDT 2019, Brian Masney wrote:

> The following errors show up when booting the Nexus 5:
> 
> msm_dsi_phy fd922a00.dsi-phy: [drm:dsi_phy_driver_probe] *ERROR*
>  dsi_phy_regulator_init: failed to init regulator, ret=-517
> msm_dsi_phy fd922a00.dsi-phy: [drm:dsi_phy_driver_probe] *ERROR*
>  dsi_phy_driver_probe: failed to init regulator
> 
> dsi_phy_regulator_init() already logs the error, so no need to log
> the same error a second time in dsi_phy_driver_probe(). This patch
> also changes dsi_phy_regulator_init() to not log the error if the
> error code is -EPROBE_DEFER to reduce noise in dmesg.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> index 4097eca1b3ef..d0e1cc6728dc 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> @@ -396,8 +396,11 @@ static int dsi_phy_regulator_init(struct msm_dsi_phy *phy)
>  
>  	ret = devm_regulator_bulk_get(dev, num, s);
>  	if (ret < 0) {
> -		DRM_DEV_ERROR(dev, "%s: failed to init regulator, ret=%d\n",
> -						__func__, ret);
> +		if (ret != -EPROBE_DEFER)
> +			DRM_DEV_ERROR(dev,
> +				      "%s: failed to init regulator, ret=%d\n",
> +				      __func__, ret);

Some {} wouldn't hurt here, but not a big deal.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> +
>  		return ret;
>  	}
>  
> @@ -584,10 +587,8 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = dsi_phy_regulator_init(phy);
> -	if (ret) {
> -		DRM_DEV_ERROR(dev, "%s: failed to init regulator\n", __func__);
> +	if (ret)
>  		goto fail;
> -	}
>  
>  	phy->ahb_clk = msm_clk_get(pdev, "iface");
>  	if (IS_ERR(phy->ahb_clk)) {
> -- 
> 2.20.1
> 
