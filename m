Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43910C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DD021743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mgm6r/dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387800AbfHVOTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:19:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39326 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbfHVOTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:19:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so5612438wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:date:message-id:mime-version;
        bh=gBgmKyJYFdCpscwxxha8Re10EltDsjWfbzB7SNj8fMI=;
        b=mgm6r/dqpypOrTVzEP/TQZstSNriWYGVB7QzZRvEEwfsEZV6ueLzcP1anpCOCbhT+S
         NjhbVv3g/wFFrBdsTN7H7conolLLTIgdPYkYq2FzKF/IAyOrcjojoHekNyP4W5US4iSY
         Zj5nMbVKMDuZlafdyI/2WYq2hkTjdrfT0eqiF/mx9Quv5rOdRnBqpIdwP/fvfufXD7e9
         FrbDysAs8JKkSo0WMAe2iBNwtH/T15yU9nzIf5B9TonKYZPyCFVpPwPefGG2K0oZlcqq
         dWyjB3SkrDMpRexOAdU/vu2HbdB6rKRsshctv5sYlebdomurjGRfoUsTyim3+g9MPJUY
         bL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=gBgmKyJYFdCpscwxxha8Re10EltDsjWfbzB7SNj8fMI=;
        b=PrdyT+HwG2Y75gAxcfE3yUUXS72RVxL+LzkhTcYfV/QrEUFGZS374AojDXvsb1wbAB
         gz+82SOBmF/33CcH6aH6pwZ0Iu1FKjEVtQe0gg27cjbIvwHnF3TGjRGf00XBwFAQmQW9
         Y9eAEYl9b8B+2JjCYTdKPCw62hD3BlpTLDQY8nrXDdVkb61VWMA7kFUKIcMvP8G8O2ff
         gn4fIY1tEVvbqpFWjIvFuerX1GwwfxNyqkzkYKKFH+NSCUB4pbWfKYo6Br0OIH+99Yvv
         z8LsQig84vEFiWiAyXF9JbhqhMtls7jQTb99jlBSB2hf3PGe47tzKGEssjOJDVdAnTPJ
         A3tg==
X-Gm-Message-State: APjAAAU3PGC794PVRF4TdikHb9rSyfDClonAQ4tPa8fJfgmiUX6kFr9K
        Fqlq6fxudf6qjHNcnW7yn5dwwA==
X-Google-Smtp-Source: APXvYqxl3JkwwWyvwM8tz0v1fdEIXqxaoXFVyEZL00RwVo44hOoYD1UUjfqdAhDYpaPEZ7IeyrKoIg==
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr10002107wrv.237.1566483554850;
        Thu, 22 Aug 2019 07:19:14 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c8sm24542373wrn.50.2019.08.22.07.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 07:19:14 -0700 (PDT)
From:   Julien Masson <jmasson@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: meson: use match data to detect vpu compatibility
In-Reply-To: <87o90hzi3x.fsf@masson.i-did-not-set--mail-host-address--so-tickle-me>
Date:   Thu, 22 Aug 2019 16:19:12 +0200
Message-ID: <87k1b5z3j3.fsf@masson.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu 22 Aug 2019 at 16:14, Julien Masson <jmasson@baylibre.com> wrote:

> On 22/08/2019 11:03, Julien Masson wrote:
>> This patch introduce new enum which contains all VPU family (GXBB,
>> GXL, GXM and G12A).
>> This enum is used to detect the VPU compatible with the device.
>> 
>> We only need to set .data to the corresponding enum in the device
>> table, no need to check .compatible string anymore.
>> 
>> Signed-off-by: Julien Masson <jmasson@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/meson_crtc.c      |  2 +-
>>  drivers/gpu/drm/meson/meson_drv.c       | 12 +++--
>>  drivers/gpu/drm/meson/meson_drv.h       | 15 +++++-
>>  drivers/gpu/drm/meson/meson_dw_hdmi.c   |  2 +-
>>  drivers/gpu/drm/meson/meson_overlay.c   |  2 +-
>>  drivers/gpu/drm/meson/meson_plane.c     | 10 ++--
>>  drivers/gpu/drm/meson/meson_vclk.c      | 64 ++++++++++++-------------
>>  drivers/gpu/drm/meson/meson_venc.c      |  2 +-
>>  drivers/gpu/drm/meson/meson_venc_cvbs.c | 10 ++--
>>  drivers/gpu/drm/meson/meson_viu.c       | 10 ++--
>>  drivers/gpu/drm/meson/meson_vpp.c       | 10 ++--
>>  11 files changed, 77 insertions(+), 62 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
>> index bba25325aa9c..57ae1c13d1e6 100644
>> --- a/drivers/gpu/drm/meson/meson_crtc.c
>> +++ b/drivers/gpu/drm/meson/meson_crtc.c
>> @@ -575,7 +575,7 @@ int meson_crtc_create(struct meson_drm *priv)
>>  		return ret;
>>  	}
>>  
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>  		meson_crtc->enable_osd1 = meson_g12a_crtc_enable_osd1;
>>  		meson_crtc->enable_vd1 = meson_g12a_crtc_enable_vd1;
>>  		meson_crtc->viu_offset = MESON_G12A_VIU_OFFSET;
>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>> index ae0166181606..97e9945f66c0 100644
>> --- a/drivers/gpu/drm/meson/meson_drv.c
>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>> @@ -380,10 +380,14 @@ static int compare_of(struct device *dev, void *data)
>>  
>>  /* Possible connectors nodes to ignore */
>>  static const struct of_device_id connectors_match[] = {
>> -	{ .compatible = "composite-video-connector" },
>> -	{ .compatible = "svideo-connector" },
>> -	{ .compatible = "hdmi-connector" },
>> -	{ .compatible = "dvi-connector" },
>> +	{ .compatible = "amlogic,meson-gxbb-vpu",
>> +	  .data       = (void *)VPU_COMPATIBLE_GXBB },
>> +	{ .compatible = "amlogic,meson-gxl-vpu",
>> +	  .data       = (void *)VPU_COMPATIBLE_GXL },
>> +	{ .compatible = "amlogic,meson-gxm-vpu",
>> +	  .data       = (void *)VPU_COMPATIBLE_GXM },
>> +	{ .compatible = "amlogic,meson-g12a-vpu",
>> +	  .data       = (void *)VPU_COMPATIBLE_G12A },
>>  	{}
>>  };

Oups I sent the wrong version of this patch, this is wrong.
I must set .data in struct dt_match instead of connectors_match.
Will be done in v2, sorry for that.

>>  
>> diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
>> index c9aaec1a846e..eab8c710c4e3 100644
>> --- a/drivers/gpu/drm/meson/meson_drv.h
>> +++ b/drivers/gpu/drm/meson/meson_drv.h
>> @@ -9,6 +9,7 @@
>>  
>>  #include <linux/device.h>
>>  #include <linux/of.h>
>> +#include <linux/of_device.h>
>>  #include <linux/regmap.h>
>>  
>>  struct drm_crtc;
>> @@ -16,6 +17,13 @@ struct drm_device;
>>  struct drm_plane;
>>  struct meson_drm;
>>  
>> +enum vpu_compatible {
>> +	VPU_COMPATIBLE_GXBB = 0,
>> +	VPU_COMPATIBLE_GXL  = 1,
>> +	VPU_COMPATIBLE_GXM  = 2,
>> +	VPU_COMPATIBLE_G12A = 3,
>> +};
>> +
>>  struct meson_drm {
>>  	struct device *dev;
>>  	void __iomem *io_base;
>> @@ -116,9 +124,12 @@ struct meson_drm {
>>  };
>>  
>>  static inline int meson_vpu_is_compatible(struct meson_drm *priv,
>> -					  const char *compat)
>> +					  enum vpu_compatible family)
>>  {
>> -	return of_device_is_compatible(priv->dev->of_node, compat);
>> +	enum vpu_compatible compat =
>> +		(enum vpu_compatible)of_device_get_match_data(priv->dev);
>
> Can you store the family into struct meson_drm at probe then check the variable here instead ?
>
> Otherwise the rest looks fine.
>
> Neil
>

Yes sure, I will send you this change in v2 :)

>> +
>> +	return compat == family;
>>  }
>>  
>>  #endif /* __MESON_DRV_H */
>> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> index f893ebd0b799..68bbd987147b 100644
>> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> @@ -937,7 +937,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>>  	reset_control_reset(meson_dw_hdmi->hdmitx_phy);
>>  
>>  	/* Enable APB3 fail on error */
>> -	if (!meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +	if (!meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>  		writel_bits_relaxed(BIT(15), BIT(15),
>>  				    meson_dw_hdmi->hdmitx + HDMITX_TOP_CTRL_REG);
>>  		writel_bits_relaxed(BIT(15), BIT(15),
>> diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
>> index 5aa9dcb4b35e..2468b0212d52 100644
>> --- a/drivers/gpu/drm/meson/meson_overlay.c
>> +++ b/drivers/gpu/drm/meson/meson_overlay.c
>> @@ -513,7 +513,7 @@ static void meson_overlay_atomic_disable(struct drm_plane *plane,
>>  	priv->viu.vd1_enabled = false;
>>  
>>  	/* Disable VD1 */
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>  		writel_relaxed(0, priv->io_base + _REG(VD1_BLEND_SRC_CTRL));
>>  		writel_relaxed(0, priv->io_base + _REG(VD2_BLEND_SRC_CTRL));
>>  		writel_relaxed(0, priv->io_base + _REG(VD1_IF0_GEN_REG + 0x17b0));
>> diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
>> index b9e1e117fb85..ed543227b00d 100644
>> --- a/drivers/gpu/drm/meson/meson_plane.c
>> +++ b/drivers/gpu/drm/meson/meson_plane.c
>> @@ -138,7 +138,7 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
>>  				      OSD_ENDIANNESS_LE);
>>  
>>  	/* On GXBB, Use the old non-HDR RGB2YUV converter */
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB))
>>  		priv->viu.osd1_blk0_cfg[0] |= OSD_OUTPUT_COLOR_RGB;
>>  
>>  	switch (fb->format->format) {
>> @@ -292,7 +292,7 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
>>  	priv->viu.osd1_blk0_cfg[3] = ((dest.x2 - 1) << 16) | dest.x1;
>>  	priv->viu.osd1_blk0_cfg[4] = ((dest.y2 - 1) << 16) | dest.y1;
>>  
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>  		priv->viu.osd_blend_din0_scope_h = ((dest.x2 - 1) << 16) | dest.x1;
>>  		priv->viu.osd_blend_din0_scope_v = ((dest.y2 - 1) << 16) | dest.y1;
>>  		priv->viu.osb_blend0_size = dst_h << 16 | dst_w;
>> @@ -308,8 +308,8 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
>>  
>>  	if (!meson_plane->enabled) {
>>  		/* Reset OSD1 before enabling it on GXL+ SoCs */
>> -		if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -		    meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>> +		if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>> +		    meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL))
>>  			meson_viu_osd1_reset(priv);
>>  
>>  		meson_plane->enabled = true;
>> @@ -327,7 +327,7 @@ static void meson_plane_atomic_disable(struct drm_plane *plane,
>>  	struct meson_drm *priv = meson_plane->priv;
>>  
>>  	/* Disable OSD1 */
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
>>  		writel_bits_relaxed(VIU_OSD1_POSTBLD_SRC_OSD1, 0,
>>  				    priv->io_base + _REG(OSD1_BLEND_SRC_CTRL));
>>  	else
>> diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
>> index 869231c93617..ac491a781952 100644
>> --- a/drivers/gpu/drm/meson/meson_vclk.c
>> +++ b/drivers/gpu/drm/meson/meson_vclk.c
>> @@ -242,7 +242,7 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
>>  	unsigned int val;
>>  
>>  	/* Setup PLL to output 1.485GHz */
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB)) {
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x5800023d);
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x00404e00);
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x0d5c5091);
>> @@ -254,8 +254,8 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
>>  		/* Poll for lock bit */
>>  		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
>>  					 (val & HDMI_PLL_LOCK), 10, 0);
>> -	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
>> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>> +		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL)) {
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x4000027b);
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x800cb300);
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0xa6212844);
>> @@ -272,7 +272,7 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
>>  		/* Poll for lock bit */
>>  		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
>>  					 (val & HDMI_PLL_LOCK), 10, 0);
>> -	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x1a0504f7);
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x00010000);
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x00000000);
>> @@ -300,7 +300,7 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
>>  				VCLK2_DIV_MASK, (55 - 1));
>>  
>>  	/* select vid_pll for vclk2 */
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
>>  		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
>>  					VCLK2_SEL_MASK, (0 << VCLK2_SEL_SHIFT));
>>  	else
>> @@ -455,7 +455,7 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
>>  {
>>  	unsigned int val;
>>  
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB)) {
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x58000200 | m);
>>  		if (frac)
>>  			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2,
>> @@ -475,8 +475,8 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
>>  		/* Poll for lock bit */
>>  		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL,
>>  					 val, (val & HDMI_PLL_LOCK), 10, 0);
>> -	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
>> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>> +		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL)) {
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x40000200 | m);
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x800cb000 | frac);
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x860f30c4);
>> @@ -493,7 +493,7 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
>>  		/* Poll for lock bit */
>>  		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
>>  				(val & HDMI_PLL_LOCK), 10, 0);
>> -	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x0b3a0400 | m);
>>  
>>  		/* Enable and reset */
>> @@ -545,36 +545,36 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
>>  		} while(1);
>>  	}
>>  
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
>>  				3 << 16, pll_od_to_reg(od1) << 16);
>> -	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>> +		 meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
>>  				3 << 21, pll_od_to_reg(od1) << 21);
>> -	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
>>  				3 << 16, pll_od_to_reg(od1) << 16);
>>  
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
>>  				3 << 22, pll_od_to_reg(od2) << 22);
>> -	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>> +		 meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
>>  				3 << 23, pll_od_to_reg(od2) << 23);
>> -	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
>>  				3 << 18, pll_od_to_reg(od2) << 18);
>>  
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
>>  				3 << 18, pll_od_to_reg(od3) << 18);
>> -	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>> +		 meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
>>  				3 << 19, pll_od_to_reg(od3) << 19);
>> -	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
>>  				3 << 20, pll_od_to_reg(od3) << 20);
>>  }
>> @@ -585,7 +585,7 @@ static unsigned int meson_hdmi_pll_get_m(struct meson_drm *priv,
>>  					 unsigned int pll_freq)
>>  {
>>  	/* The GXBB PLL has a /2 pre-multiplier */
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB))
>>  		pll_freq /= 2;
>>  
>>  	return pll_freq / XTAL_FREQ;
>> @@ -605,12 +605,12 @@ static unsigned int meson_hdmi_pll_get_frac(struct meson_drm *priv,
>>  	unsigned int frac;
>>  
>>  	/* The GXBB PLL has a /2 pre-multiplier and a larger FRAC width */
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB)) {
>>  		frac_max = HDMI_FRAC_MAX_GXBB;
>>  		parent_freq *= 2;
>>  	}
>>  
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
>>  		frac_max = HDMI_FRAC_MAX_G12A;
>>  
>>  	/* We can have a perfect match !*/
>> @@ -631,15 +631,15 @@ static bool meson_hdmi_pll_validate_params(struct meson_drm *priv,
>>  					   unsigned int m,
>>  					   unsigned int frac)
>>  {
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB)) {
>>  		/* Empiric supported min/max dividers */
>>  		if (m < 53 || m > 123)
>>  			return false;
>>  		if (frac >= HDMI_FRAC_MAX_GXBB)
>>  			return false;
>> -	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu") ||
>> -		   meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>> +		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL) ||
>> +		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>  		/* Empiric supported min/max dividers */
>>  		if (m < 106 || m > 247)
>>  			return false;
>> @@ -759,7 +759,7 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
>>  	/* Set HDMI PLL rate */
>>  	if (!od1 && !od2 && !od3) {
>>  		meson_hdmi_pll_generic_set(priv, pll_base_freq);
>> -	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
>> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB)) {
>>  		switch (pll_base_freq) {
>>  		case 2970000:
>>  			m = 0x3d;
>> @@ -776,8 +776,8 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
>>  		}
>>  
>>  		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
>> -	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
>> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>> +		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL)) {
>>  		switch (pll_base_freq) {
>>  		case 2970000:
>>  			m = 0x7b;
>> @@ -794,7 +794,7 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
>>  		}
>>  
>>  		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
>> -	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>  		switch (pll_base_freq) {
>>  		case 2970000:
>>  			m = 0x7b;
>> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
>> index 679d2274531c..4efd7864d5bf 100644
>> --- a/drivers/gpu/drm/meson/meson_venc.c
>> +++ b/drivers/gpu/drm/meson/meson_venc.c
>> @@ -1759,7 +1759,7 @@ void meson_venc_disable_vsync(struct meson_drm *priv)
>>  void meson_venc_init(struct meson_drm *priv)
>>  {
>>  	/* Disable CVBS VDAC */
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>  		regmap_write(priv->hhi, HHI_VDAC_CNTL0_G12A, 0);
>>  		regmap_write(priv->hhi, HHI_VDAC_CNTL1_G12A, 8);
>>  	} else {
>> diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meson/meson_venc_cvbs.c
>> index 6dc130a24070..9ab27aecfcf3 100644
>> --- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
>> +++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
>> @@ -155,7 +155,7 @@ static void meson_venc_cvbs_encoder_disable(struct drm_encoder *encoder)
>>  	struct meson_drm *priv = meson_venc_cvbs->priv;
>>  
>>  	/* Disable CVBS VDAC */
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>  		regmap_write(priv->hhi, HHI_VDAC_CNTL0_G12A, 0);
>>  		regmap_write(priv->hhi, HHI_VDAC_CNTL1_G12A, 0);
>>  	} else {
>> @@ -174,14 +174,14 @@ static void meson_venc_cvbs_encoder_enable(struct drm_encoder *encoder)
>>  	writel_bits_relaxed(VENC_VDAC_SEL_ATV_DMD, 0,
>>  			    priv->io_base + _REG(VENC_VDAC_DACSEL0));
>>  
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB)) {
>>  		regmap_write(priv->hhi, HHI_VDAC_CNTL0, 1);
>>  		regmap_write(priv->hhi, HHI_VDAC_CNTL1, 0);
>> -	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
>> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>> +		 meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL)) {
>>  		regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0xf0001);
>>  		regmap_write(priv->hhi, HHI_VDAC_CNTL1, 0);
>> -	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>  		regmap_write(priv->hhi, HHI_VDAC_CNTL0_G12A, 0x906001);
>>  		regmap_write(priv->hhi, HHI_VDAC_CNTL1_G12A, 0);
>>  	}
>> diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
>> index e70cd55d56c9..68cf2c2eca5f 100644
>> --- a/drivers/gpu/drm/meson/meson_viu.c
>> +++ b/drivers/gpu/drm/meson/meson_viu.c
>> @@ -353,10 +353,10 @@ void meson_viu_init(struct meson_drm *priv)
>>  			    priv->io_base + _REG(VIU_OSD2_CTRL_STAT));
>>  
>>  	/* On GXL/GXM, Use the 10bit HDR conversion matrix */
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -	    meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>> +	    meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL))
>>  		meson_viu_load_matrix(priv);
>> -	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
>>  		meson_viu_set_g12a_osd1_matrix(priv, RGB709_to_YUV709l_coeff,
>>  					       true);
>>  
>> @@ -367,7 +367,7 @@ void meson_viu_init(struct meson_drm *priv)
>>  		VIU_OSD_WORDS_PER_BURST(4) | /* 4 words in 1 burst */
>>  		VIU_OSD_FIFO_LIMITS(2);      /* fifo_lim: 2*16=32 */
>>  
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
>>  		reg |= meson_viu_osd_burst_length_reg(32);
>>  	else
>>  		reg |= meson_viu_osd_burst_length_reg(64);
>> @@ -394,7 +394,7 @@ void meson_viu_init(struct meson_drm *priv)
>>  	writel_relaxed(0x00FF00C0,
>>  			priv->io_base + _REG(VD2_IF0_LUMA_FIFO_SIZE));
>>  
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>  		writel_relaxed(VIU_OSD_BLEND_REORDER(0, 1) |
>>  			       VIU_OSD_BLEND_REORDER(1, 0) |
>>  			       VIU_OSD_BLEND_REORDER(2, 0) |
>> diff --git a/drivers/gpu/drm/meson/meson_vpp.c b/drivers/gpu/drm/meson/meson_vpp.c
>> index 1429f3be6028..154837688ab0 100644
>> --- a/drivers/gpu/drm/meson/meson_vpp.c
>> +++ b/drivers/gpu/drm/meson/meson_vpp.c
>> @@ -91,20 +91,20 @@ static void meson_vpp_write_vd_scaling_filter_coefs(struct meson_drm *priv,
>>  void meson_vpp_init(struct meson_drm *priv)
>>  {
>>  	/* set dummy data default YUV black */
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL))
>>  		writel_relaxed(0x108080, priv->io_base + _REG(VPP_DUMMY_DATA1));
>> -	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu")) {
>> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM)) {
>>  		writel_bits_relaxed(0xff << 16, 0xff << 16,
>>  				    priv->io_base + _REG(VIU_MISC_CTRL1));
>>  		writel_relaxed(VPP_PPS_DUMMY_DATA_MODE,
>>  			       priv->io_base + _REG(VPP_DOLBY_CTRL));
>>  		writel_relaxed(0x1020080,
>>  				priv->io_base + _REG(VPP_DUMMY_DATA1));
>> -	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
>>  		writel_relaxed(0xf, priv->io_base + _REG(DOLBY_PATH_CTRL));
>>  
>>  	/* Initialize vpu fifo control registers */
>> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
>>  		writel_relaxed(VPP_OFIFO_SIZE_DEFAULT,
>>  			       priv->io_base + _REG(VPP_OFIFO_SIZE));
>  	else
> @@ -113,7 +113,7 @@ void meson_vpp_init(struct meson_drm *priv)
>  	writel_relaxed(VPP_POSTBLEND_HOLD_LINES(4) | VPP_PREBLEND_HOLD_LINES(4),
>  		       priv->io_base + _REG(VPP_HOLD_LINES));
>  
> -	if (!meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
> +	if (!meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>  		/* Turn off preblend */
>  		writel_bits_relaxed(VPP_PREBLEND_ENABLE, 0,
>  				    priv->io_base + _REG(VPP_MISC));
> 

-- 
Julien Masson
