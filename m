Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B4CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695142064B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="gMj+jVjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfJURrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:47:22 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46041 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJURrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:47:22 -0400
Received: by mail-yw1-f65.google.com with SMTP id x65so5191895ywf.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5H0J7xirx1ylf4z2pSmNTwjFu/S9K2vX89QG1Dy0v+w=;
        b=gMj+jVjIXW623OIfzglGGSVZbu3lq3AbryiUjKmlH2UXOruYC/Qph4mQsyai4iE0Ag
         KQu4oAQMBCL9ISPeR3IuoEuy7feZQz1ng94BCTm7tcAeeQLjaYbdAhAxYU9qTwAHHgM7
         WMOs6eMrdlwUN8BYXgunm2uf8Cme+A6USegMWXc7TpvdBeFg3f7B2LP9Vo+YnDE/CEpi
         gsjz1sgalefuEAZyJZWLIsvWM/GzDIYPZ4geRwd7GkIgWdNHhw5YzWFOlcDyZT2v3EwF
         /5a1y4cPtGVByDfRO6gNo48/Pm7DtsXui8aiwi7XXVra3rbOLT676K8SlZvaA3hk/fnz
         F5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5H0J7xirx1ylf4z2pSmNTwjFu/S9K2vX89QG1Dy0v+w=;
        b=Z9IXEUhi90u4IRDcuBl0TEtfeeQM6qtqnyMfxTUQ93opc0NxX0+Fxu3Xr36JWfcBK6
         jHkULDB7F210ccY+qLo/u6B3Bxr4CbOvQdgqaSKKDOv4B7d3qE/sLIjbbqyOnoyJFvde
         WoTLAZ6lLZMbvt6FXTPBGETONy4B2kKlBQxJExzW6dneVLTJd3IrhUZYCpPrVoALBKyM
         TFxoH9HuTwuvUqUHCH0D5h4PCSVsXSnIeDDf3CNLWGA9Hp1FfZ7WM2FLB16wH/6DyF+9
         FzvKqja6Z09GYSOVOFyt0m6veqWUB8TQOoz8Rm2gzOj6PNQKYuyzKFb697hkPYYunn7z
         YLIQ==
X-Gm-Message-State: APjAAAXE8j30aJDqOzM40n4IkkNz/BASQl7lw09gKbOOtrFrn9TwoZge
        JWj7G3N4kEJVOppdhIgpkWCfXQ==
X-Google-Smtp-Source: APXvYqzVrMSTJWdXUseATcehzibcnZeTHKaPWzYhmKrKBPP4kNvq8VPTG4NSEfCxoGKfuBNP07h77A==
X-Received: by 2002:a81:70ce:: with SMTP id l197mr102192ywc.24.1571680040783;
        Mon, 21 Oct 2019 10:47:20 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id l21sm3312570ywl.0.2019.10.21.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 10:47:20 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:47:19 -0400
From:   Sean Paul <sean@poorly.run>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Hai Li <hali@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nikita Travkin <nikitos.tr@gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Implement qcom,dsi-phy-regulator-ldo-mode
 for 28nm PHY
Message-ID: <20191021174719.GC85762@art_vandelay>
References: <20191021163425.83697-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021163425.83697-1-stephan@gerhold.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 06:34:25PM +0200, Stephan Gerhold wrote:
> The DSI PHY regulator supports two regulator modes: LDO and DCDC.
> This mode can be selected using the "qcom,dsi-phy-regulator-ldo-mode"
> device tree property.
> 
> However, at the moment only the 20nm PHY driver actually implements
> that option. Add a check in the 28nm PHY driver to program the
> registers correctly for LDO mode.
> 
> Tested-by: Nikita Travkin <nikitos.tr@gmail.com> # l8150
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> This is needed to make the display work on Longcheer L8150,
> which has recently gained mainline support in:
> https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?id=16e8e8072108426029f0c16dff7fbe77fae3df8f
> 
> This patch is based on code from the downstream kernel:
> https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/drivers/video/msm/mdss/msm_mdss_io_8974.c?h=LA.BR.1.2.9.1-02310-8x16.0#n152
> 
> The LDO regulator configuration is taken from msm8916-qrd.dtsi:
> https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/arch/arm/boot/dts/qcom/msm8916-qrd.dtsi?h=LA.BR.1.2.9.1-02310-8x16.0#n56
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> index b3f678f6c2aa..4579e6de4532 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> @@ -48,6 +48,25 @@ static void dsi_28nm_phy_regulator_ctrl(struct msm_dsi_phy *phy, bool enable)
>  		return;
>  	}
>  
> +	if (phy->regulator_ldo_mode) {
> +		u32 ldo_ctrl;
> +
> +		if (phy->cfg->type == MSM_DSI_PHY_28NM_LP)
> +			ldo_ctrl = 0x05;
> +		else
> +			ldo_ctrl = 0x0d;
> +
> +		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_0, 0x0);
> +		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CAL_PWR_CFG, 0);
> +		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_5, 0x7);
> +		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_3, 0);
> +		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_2, 0x1);
> +		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_1, 0x1);
> +		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_4, 0x20);
> +		dsi_phy_write(phy->base + REG_DSI_28nm_PHY_LDO_CNTRL, ldo_ctrl);
> +		return;
> +	}

nit: Since this has minimal overlap with DCDC mode, I think it would read better
if you split this into 2 functions:
dsi_28nm_phy_regulator_enable_dcdc() and dsi_28nm_phy_regulator_enable_ldo()

So regulator_ctrl would look like:

static void dsi_28nm_phy_regulator_ctrl(struct msm_dsi_phy *phy, bool enable)
{
	void __iomem *base = phy->reg_base;

	if (!enable) {
		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CAL_PWR_CFG, 0);
		return;
	}

	if (phy->regulator_ldo_mode)
                dsi_28nm_phy_regulator_enable_ldo()
        else
                dsi_28nm_phy_regulator_enable_dcdc()
}


> +
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_0, 0x0);
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CAL_PWR_CFG, 1);
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_5, 0);
> @@ -56,6 +75,7 @@ static void dsi_28nm_phy_regulator_ctrl(struct msm_dsi_phy *phy, bool enable)
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_1, 0x9);
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_0, 0x7);
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_4, 0x20);
> +	dsi_phy_write(phy->base + REG_DSI_28nm_PHY_LDO_CNTRL, 0x00);
>  }
>  
>  static int dsi_28nm_phy_enable(struct msm_dsi_phy *phy, int src_pll_id,
> @@ -77,8 +97,6 @@ static int dsi_28nm_phy_enable(struct msm_dsi_phy *phy, int src_pll_id,
>  
>  	dsi_28nm_phy_regulator_ctrl(phy, true);
>  
> -	dsi_phy_write(base + REG_DSI_28nm_PHY_LDO_CNTRL, 0x00);
> -
>  	dsi_28nm_dphy_set_timing(phy, timing);
>  
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_CTRL_1, 0x00);
> -- 
> 2.23.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
