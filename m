Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FBACA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D37521D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="VifDnRc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503043AbfJYOGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:06:36 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42357 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407421AbfJYOGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:06:34 -0400
Received: by mail-yb1-f195.google.com with SMTP id 4so883883ybq.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9hV5nwXUEgXhwQ5IosopcGJTF2NHW7/vTGTmNW9G34I=;
        b=VifDnRc70NasJQuNqZ6GKXuHy+pog7Il9EYThxh46rlyggmTevIjVlWWW3BDI7BX8/
         wlYX5LkB0paoZC1KPIFgth+U25Pfzy2Dk+RpUyeGJsnhZnPg79LzGQqXe2KkzPXYRghH
         NqFkRvxXEQKju+Q6MFIb/wZkpDCWXgdNX0WvFHPXl+Hr4DgxgainAF6JcS6oBo3xgcg/
         vxUQBHZLFuS1+XqP0ChE2d7qlZoP4D5ficQilafhQ6deH/GmdCOz6+L4Zegsbr44ierq
         DMjOgUz0FWpLxwy3K8HlVU/BmUkx5ZqxIJDa/FJiJPTiMLvUlBUumiRmSBCIcGZa9FGd
         g7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9hV5nwXUEgXhwQ5IosopcGJTF2NHW7/vTGTmNW9G34I=;
        b=Jp7lo7qpG9/zSqGbmrU0vm6TukOixTBejQJyxJCJvLKoHxyOybA5xwvfO1RQZVyvH9
         eLyg+CuKdhA/uV/YtwGNazkt7/0Ik71n6NEEOEvVHd3GHS3tKK1NKhMY7A2p+booX1/A
         JkvoVUidK6eJ1Lw7LVA/STfXIPq8X93ZXfIxs6uvDjHx3EGypHSZdGX1SrurSrVceCja
         IC4/VpBgPw6gV8dfgzQjcXA1uoy9h+mI8qoxa4hbYrRUca7SGuMuCP4BmyHI1zMK1o8h
         jwPbsumpDecjawvztk+dzn7qIx02n7AhG+Lb8R+yJyrHF2FRuRYKg9CgyM5+MxlUEjz5
         as6Q==
X-Gm-Message-State: APjAAAVUoPXQivLSTCMEt91/JbjK2Un+G6KwAxBV/U+ra/H+M6RjxtYC
        BjAuzJ/7iZl8qRp4OB+JjZJB6Q==
X-Google-Smtp-Source: APXvYqx7fYQnCFaQaxuLFh4DK2xG1DIqcPQZX3c4Cb03ut+f4/rVew1nspg17lq1TCTJePaSNg3xIQ==
X-Received: by 2002:a25:7611:: with SMTP id r17mr3361276ybc.399.1572012393139;
        Fri, 25 Oct 2019 07:06:33 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id b201sm710130ywe.2.2019.10.25.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:06:32 -0700 (PDT)
Date:   Fri, 25 Oct 2019 10:06:32 -0400
From:   Sean Paul <sean@poorly.run>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Hai Li <hali@codeaurora.org>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Nikita Travkin <nikitos.tr@gmail.com>,
        freedreno@lists.freedesktop.org
Subject: Re: [Freedreno] [PATCH v2] drm/msm/dsi: Implement qcom,
 dsi-phy-regulator-ldo-mode for 28nm PHY
Message-ID: <20191025140632.GH85762@art_vandelay>
References: <20191023165617.28738-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023165617.28738-1-stephan@gerhold.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 06:56:17PM +0200, Stephan Gerhold wrote:
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

Thanks for your patch! I've pushed it to msm-next.

Sean

> ---
> Changes in v2: Move DCDC/LDO code into separate methods
> v1: https://lore.kernel.org/linux-arm-msm/20191021163425.83697-1-stephan@gerhold.net/
> 
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
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c | 42 +++++++++++++++++-----
>  1 file changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> index b3f678f6c2aa..b384ea20f359 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> @@ -39,15 +39,10 @@ static void dsi_28nm_dphy_set_timing(struct msm_dsi_phy *phy,
>  		DSI_28nm_PHY_TIMING_CTRL_11_TRIG3_CMD(0));
>  }
>  
> -static void dsi_28nm_phy_regulator_ctrl(struct msm_dsi_phy *phy, bool enable)
> +static void dsi_28nm_phy_regulator_enable_dcdc(struct msm_dsi_phy *phy)
>  {
>  	void __iomem *base = phy->reg_base;
>  
> -	if (!enable) {
> -		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CAL_PWR_CFG, 0);
> -		return;
> -	}
> -
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_0, 0x0);
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CAL_PWR_CFG, 1);
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_5, 0);
> @@ -56,6 +51,39 @@ static void dsi_28nm_phy_regulator_ctrl(struct msm_dsi_phy *phy, bool enable)
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_1, 0x9);
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_0, 0x7);
>  	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_4, 0x20);
> +	dsi_phy_write(phy->base + REG_DSI_28nm_PHY_LDO_CNTRL, 0x00);
> +}
> +
> +static void dsi_28nm_phy_regulator_enable_ldo(struct msm_dsi_phy *phy)
> +{
> +	void __iomem *base = phy->reg_base;
> +
> +	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_0, 0x0);
> +	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CAL_PWR_CFG, 0);
> +	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_5, 0x7);
> +	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_3, 0);
> +	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_2, 0x1);
> +	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_1, 0x1);
> +	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_4, 0x20);
> +
> +	if (phy->cfg->type == MSM_DSI_PHY_28NM_LP)
> +		dsi_phy_write(phy->base + REG_DSI_28nm_PHY_LDO_CNTRL, 0x05);
> +	else
> +		dsi_phy_write(phy->base + REG_DSI_28nm_PHY_LDO_CNTRL, 0x0d);
> +}
> +
> +static void dsi_28nm_phy_regulator_ctrl(struct msm_dsi_phy *phy, bool enable)
> +{
> +	if (!enable) {
> +		dsi_phy_write(phy->reg_base +
> +			      REG_DSI_28nm_PHY_REGULATOR_CAL_PWR_CFG, 0);
> +		return;
> +	}
> +
> +	if (phy->regulator_ldo_mode)
> +		dsi_28nm_phy_regulator_enable_ldo(phy);
> +	else
> +		dsi_28nm_phy_regulator_enable_dcdc(phy);
>  }
>  
>  static int dsi_28nm_phy_enable(struct msm_dsi_phy *phy, int src_pll_id,
> @@ -77,8 +105,6 @@ static int dsi_28nm_phy_enable(struct msm_dsi_phy *phy, int src_pll_id,
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
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
Sean Paul, Software Engineer, Google / Chromium OS
