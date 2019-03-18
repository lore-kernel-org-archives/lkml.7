Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B169C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621C02075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rrfMdnRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfCRJjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:39:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55503 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387612AbfCRJgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:36:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so12174655wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=h4786BMZNn6YIyQEHwt6r6z6kCWEoZF/6YTERNJF/O0=;
        b=rrfMdnRu3Ull107xiZ+jeOK+eNK2XcFKaf6pXudJRbjt3rVyLFXCAlJ4pPPHSMVXmN
         kY+CPL69X0XiFndiMEQBL4BsYIMuWmjpdfdE6CN0BMl3e0FN1drTvzs4asQ1x7Dvx/G7
         FgirTi6zWOLeFJrZwmlzui+GxeWDQHFm/I6+UWjawZrgJWxeRGliNQEVUtv/tJ5OWhph
         /BHcg+nrz8SfOkoyMGo/tHSoa99IPPKfG26wr74oHfFTLInm/uBWf0bNJaXxjFOQ4L4D
         pDqIfQNP8o+W2spR7IGMmiNND0lnBVHKR2wrvIYDxNT6lIL8hFDmVEvh18t26yLTxIBa
         oJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=h4786BMZNn6YIyQEHwt6r6z6kCWEoZF/6YTERNJF/O0=;
        b=UhG78BON9IjKbxM2n/8bOPMw/dWYX00EEasMyNuM1Xl+/xo7o6lpfPKKKzQMWSPN0g
         8LMNdSHOkaUwPDPnRkJeUAC+qneDcRNVKkx0ejknuQx0pwEAZ0xDuWwqrtTzwULi7j3U
         VXBZtb0Xs9jgg+8UBsiqKz/6dhjADQj++zwTtZSjANl/Tk/XnQOgPA4m02hry+am1WIp
         l2qnbsOPrdG5jR4g2R/1vmGDJS3tmV6QMuGNqIpPZDd2qX/MiSHJeyYxIpI2pzGaa/uw
         E+iVXXDQTuUR0zncWuAf82fmQFc9O6SuewkAApmh60NhPdDP5CVL2eicRghUgaFK98k+
         j1ug==
X-Gm-Message-State: APjAAAXGIJTY9SOC5HkYLvHgX56G1omn2af8KwAn92WrnLXGyNcuyLam
        0SE08ZCQMh4WLvWVaElI8dqxQQ==
X-Google-Smtp-Source: APXvYqxYP8sppkrzHZCy/AJ6E/l0TIOw7rMKik7GuVVBxsYXYfEImWFE/rwo/B7Vk9cy5NuZ3edV8Q==
X-Received: by 2002:a1c:4d:: with SMTP id 74mr10029856wma.1.1552901772335;
        Mon, 18 Mar 2019 02:36:12 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id 3sm20091905wrk.68.2019.03.18.02.36.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 18 Mar 2019 02:36:11 -0700 (PDT)
Message-ID: <00349c895f338db73272a1b41297c7650e1a8938.camel@baylibre.com>
Subject: Re: [PATCH net-next 2/3] net: phy: add amlogic g12a mdio mux support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Mon, 18 Mar 2019 10:36:09 +0100
In-Reply-To: <20190317154821.GA22226@lunn.ch>
References: <20190314140135.19184-1-jbrunet@baylibre.com>
         <20190314140135.19184-3-jbrunet@baylibre.com>
         <20190316025448.GD29548@lunn.ch>
         <13432d537f671c8065693b7e53348f812e8bbc04.camel@baylibre.com>
         <20190317154821.GA22226@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-03-17 at 16:48 +0100, Andrew Lunn wrote:
> On Sat, Mar 16, 2019 at 06:02:45PM +0100, Jerome Brunet wrote:
> > On Sat, 2019-03-16 at 03:54 +0100, Andrew Lunn wrote:
> > > On Thu, Mar 14, 2019 at 03:01:34PM +0100, Jerome Brunet wrote:
> > > > > +static int _g12a_enable_internal_mdio(struct g12a_mdio_mux *priv)
> > > 
> > > You would generally use the _ prefix when you have a locked and an
> > > unlocked version. I don't see anything like this here. So please drop
> > > the _ .
> > > 
> > 
> > will do
> > 
> > > Nice to see the generic clock framework being used. I just wonder if
> > > this is the correct place to have this clock code. Can it be made part
> > > of the SoC clock code?
> > 
> > the PLL is local to this particular device.
> > 
> > In 'Soc clock code' (driver/clk/meson in this case) we usually put clock
> > controllers. Those controllers feeds the different devices of the SoC but we
> > tends some more clock elements in the consumer device
> > 
> > Usually, it is just a few mux, dividers and gates (like in
> > drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c) but in this case, we have
> > a PLL. IMO, it belongs here. Do you see a problem with this ?
> 
> Hi Jerome
> 
> Some maintainers like to have code in their directory structure. It
> would be good to check that the clock maintainer in happy with clock
> code under the network driver subtree. Also, the clock maintainer
> should also review this code. So please at least Cc: the clock
> maintainer and clock list on the next submission, 

I happen to be maintaining Amlogic clocks ;) but I can Cc Mike and Stephen if
you prefer.

> as well as netdev. I
> personally don't know the clock code well enough to review such code.

No problem.

FYI, It is not widespread yet but more and more drivers are creating clocks
using CCF. Here is a quick grep of the files including <linux/clk-provider.h>, 
excluding "drivers/clk/*"

drivers/acpi/acpi_amba.c
drivers/acpi/acpi_apd.c
drivers/acpi/acpi_lpss.c
drivers/clocksource/arc_timer.c
drivers/clocksource/timer-ti-dm.c
drivers/cpufreq/loongson1-cpufreq.c
drivers/cpufreq/qoriq-cpufreq.c
drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
drivers/gpu/drm/imx/imx-tve.c
drivers/gpu/drm/mediatek/mtk_mipi_tx.c
drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
drivers/gpu/drm/msm/dsi/pll/dsi_pll.h
drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c
drivers/gpu/drm/pl111/pl111_drm.h
drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
drivers/gpu/drm/sun4i/sun4i_dotclock.c
drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
drivers/gpu/drm/sun4i/sun8i_tcon_top.h
drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
drivers/gpu/drm/sun4i/sun4i_crtc.c
drivers/gpu/drm/tegra/sor.c
drivers/gpu/drm/vc4/vc4_dsi.c
drivers/gpu/ipu-v3/ipu-csi.c
drivers/i2c/busses/i2c-designware-platdrv.c
drivers/iio/adc/aspeed_adc.c
drivers/iio/adc/meson_saradc.c
drivers/mailbox/mtk-cmdq-mailbox.c
drivers/media/i2c/ov5640.c
drivers/media/platform/atmel/atmel-isc.c
drivers/media/platform/exynos4-is/media-dev.c
drivers/media/platform/exynos4-is/media-dev.h
drivers/media/platform/omap3isp/isp.h
drivers/memory/tegra/tegra124-emc.c
drivers/mfd/intel-lpss.c
drivers/mfd/intel_quark_i2c_gpio.c
drivers/mmc/host/meson-mx-sdio.c
drivers/mmc/host/sdhci-of-arasan.c
drivers/mmc/host/meson-gx-mmc.c
drivers/net/ethernet/cadence/macb_pci.c
drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
drivers/net/ieee802154/ca8210.c
drivers/phy/qualcomm/phy-qcom-qmp.c
drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
drivers/phy/rockchip/phy-rockchip-usb.c
drivers/phy/rockchip/phy-rockchip-typec.c
drivers/phy/rockchip/phy-rockchip-inno-usb2.c
drivers/pinctrl/tegra/pinctrl-tegra20.c
drivers/pwm/pwm-meson.c
drivers/rtc/rtc-ac100.c
drivers/rtc/rtc-pcf8563.c
drivers/rtc/rtc-m41t80.c
drivers/rtc/rtc-sun6i.c
drivers/rtc/rtc-ds1307.c
drivers/rtc/rtc-hym8563.c
drivers/spi/spi-pxa2xx-pci.c
drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
drivers/thermal/st/stm_thermal.c
drivers/usb/dwc3/dwc3-qcom.c


> 
> 	   Andrew


