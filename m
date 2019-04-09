Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFC8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5023920663
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="L4KmCZ9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDIImy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:42:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56319 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIImy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:42:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so2404057wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MMRmbUUoKf6lNXiZliLNrH2n/I7r3OiqvnQ2Vsn1GXo=;
        b=L4KmCZ9GOkTS/KMKEAqXIfS49XISBE9oE20NVh+SVFn4k97Z77RTSwJWw+DWTLp2FC
         X1En5M9bNEGgep0q+ztX3x/o1tZmfJEOGd4B1cEm1/xx9ObLqCd8GIdGnqpNslle+Wu0
         KSX95Qgfdw6ieXG/LSl8vg2nmUKkSQDu0s5IK3DFT4Ik+2oDKuG7HbPlizem8HexGvMA
         c6S35uNMRaXan6xz50dAyTJ+5gzT7mcKj3KpgsIpp/SBMaEphuWIbUZEViSultfaSeMH
         hUbRXnhK4j/hHDIF+oOqsfKCCDrfJuke/aZXui0cH4AI6vhAAQ70eCF1lfquBlLwG7SY
         owIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MMRmbUUoKf6lNXiZliLNrH2n/I7r3OiqvnQ2Vsn1GXo=;
        b=dyPZX2HneHTxPofy8YsaXRjHkcae6x9XmrNUbnckyW8+r3uoz9/c+pnOlsl/Jdu4st
         DG9F05mqopaU4fBpMXuKWeLDYDaycwy+mjp6626TGPBxVc56NgS8n9KPBvjNs0QvWUyd
         JJ1XDwnxknhpnVvgFP5wIE7EzagQP8S+01r9Bw7m9errzyBKyWFB0VfwFU8DOt4zAOKV
         pjTuW6ONL4xa0kfdmWvIsYB420hOZER1s4irY7ITHjeFOSIQb0kJJyhT4gHVCsg0ufy6
         eC/scsl19khINHJLCqtxo+8w9rGj3aMQMPwU2gvsuDgu9CfqeqNa1DwF7KO5kjZOB3+R
         MoDQ==
X-Gm-Message-State: APjAAAXnb5Eg16rhAZWDIPpykRaGveh6lxG+qYcU6GhIsDrQtmZSKegO
        WFunzaID37SxHwbanwTfUgXN6Q==
X-Google-Smtp-Source: APXvYqy78fXu9pZFg7grGvSqxz9gKRk5PEQAsSi4Yq7Pk8U8dwZRmLlNJbeA3Bjiwj/gCv/QXuhzDQ==
X-Received: by 2002:a1c:ef08:: with SMTP id n8mr14976204wmh.85.1554799371556;
        Tue, 09 Apr 2019 01:42:51 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id g12sm30827532wrw.40.2019.04.09.01.42.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Apr 2019 01:42:50 -0700 (PDT)
Message-ID: <8d1c3c13e2ad05aac1f28327ddaa0169ab204b50.camel@baylibre.com>
Subject: Re: [PATCH 04/11] drm/meson: Add G12A Support for VIU setup
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Apr 2019 10:42:49 +0200
In-Reply-To: <20190325141824.21259-5-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
         <20190325141824.21259-5-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 15:18 +0100, Neil Armstrong wrote:
> Amlogic G12A SoC needs a different VIU setup code,
> handle it.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_viu.c | 72 ++++++++++++++++++++++++++++---
>  1 file changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
> index ac0f3687e09a..0169c98b01c9 100644
> --- a/drivers/gpu/drm/meson/meson_viu.c
> +++ b/drivers/gpu/drm/meson/meson_viu.c
> @@ -90,6 +90,34 @@ static int eotf_bypass_coeff[EOTF_COEFF_SIZE] = {
>  	EOTF_COEFF_RIGHTSHIFT /* right shift */
>  };
>  
> +void meson_viu_set_g12a_osd1_matrix(struct meson_drm *priv, int *m,
> +				   bool csc_on)
> +{
> +	/* VPP WRAP OSD1 matrix */
> +	writel(((m[0] & 0xfff) << 16) | (m[1] & 0xfff),
> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_PRE_OFFSET0_1));
> +	writel(m[2] & 0xfff,
> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_PRE_OFFSET2));
> +	writel(((m[3] & 0x1fff) << 16) | (m[4] & 0x1fff),
> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_COEF00_01));
> +	writel(((m[5] & 0x1fff) << 16) | (m[6] & 0x1fff),
> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_COEF02_10));
> +	writel(((m[7] & 0x1fff) << 16) | (m[8] & 0x1fff),
> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_COEF11_12));
> +	writel(((m[9] & 0x1fff) << 16) | (m[10] & 0x1fff),
> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_COEF20_21));
> +	writel((m[11] & 0x1fff) << 16,
> +		priv->io_base +	_REG(VPP_WRAP_OSD1_MATRIX_COEF22));
> +
> +	writel(((m[18] & 0xfff) << 16) | (m[19] & 0xfff),
> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_OFFSET0_1));

Can you define some of the masks and shifts above ? possibly the same define
for all the registers I suppose ... maybe using FIELD_PREP ?

> +	writel(m[20] & 0xfff,
> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_OFFSET2));
> +
> +	writel_bits_relaxed(BIT(0), csc_on ? BIT(0) : 0,
> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_EN_CTRL));
> +}
> +
>  void meson_viu_set_osd_matrix(struct meson_drm *priv,
>  			      enum viu_matrix_sel_e m_select,
>  			      int *m, bool csc_on)
> @@ -336,14 +364,24 @@ void meson_viu_init(struct meson_drm *priv)
>  	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>  	    meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>  		meson_viu_load_matrix(priv);
> +	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
> +		meson_viu_set_g12a_osd1_matrix(priv, RGB709_to_YUV709l_coeff,
> +					       true);
>  
>  	/* Initialize OSD1 fifo control register */
>  	reg = BIT(0) |	/* Urgent DDR request priority */
> -	      (4 << 5) | /* hold_fifo_lines */
> -	      (3 << 10) | /* burst length 64 */
> -	      (32 << 12) | /* fifo_depth_val: 32*8=256 */
> -	      (2 << 22) | /* 4 words in 1 burst */
> -	      (2 << 24);
> +	      (4 << 5); /* hold_fifo_lines */
> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
> +		reg |= (1 << 10) | /* burst length 32 */
> +		       (32 << 12) | /* fifo_depth_val: 32*8=256 */
> +		       (2 << 22) | /* 4 words in 1 burst */
> +		       (2 << 24) |
> +		       (1 << 31);
> +	else
> +		reg |= (3 << 10) | /* burst length 64 */
> +		       (32 << 12) | /* fifo_depth_val: 32*8=256 */
> +		       (2 << 22) | /* 4 words in 1 burst */
> +		       (2 << 24);

Could you use the BIT() macro and add some defines ?

>  	writel_relaxed(reg, priv->io_base + _REG(VIU_OSD1_FIFO_CTRL_STAT));
>  	writel_relaxed(reg, priv->io_base + _REG(VIU_OSD2_FIFO_CTRL_STAT));
>  
> @@ -369,6 +407,30 @@ void meson_viu_init(struct meson_drm *priv)
>  	writel_relaxed(0x00FF00C0,
>  			priv->io_base + _REG(VD2_IF0_LUMA_FIFO_SIZE));
>  
> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
> +		writel_relaxed(4 << 29 |
> +				1 << 27 |
> +				1 << 26 | /* blend_din0 input to blend0 */
> +				1 << 25 | /* blend1_dout to blend2 */
> +				1 << 24 | /* blend1_din3 input to blend1 */
> +				1 << 20 |
> +				0 << 16 |
> +				1,
> +				priv->io_base + _REG(VIU_OSD_BLEND_CTRL));
> +		writel_relaxed(3 << 8 |
> +				1 << 20,
> +				priv->io_base + _REG(OSD1_BLEND_SRC_CTRL));
> +		writel_relaxed(1 << 20,
> +				priv->io_base + _REG(OSD2_BLEND_SRC_CTRL));
> +		writel_relaxed(0, priv->io_base + _REG(VD1_BLEND_SRC_CTRL));
> +		writel_relaxed(0, priv->io_base + _REG(VD2_BLEND_SRC_CTRL));
> +		writel_relaxed(0,
> +				priv->io_base + _REG(VIU_OSD_BLEND_DUMMY_DATA0));
> +		writel_relaxed(0,
> +				priv->io_base + _REG(VIU_OSD_BLEND_DUMMY_ALPHA));
> +		writel_bits_relaxed(0x3 << 2, 0x3 << 2,
> +				priv->io_base + _REG(DOLBY_PATH_CTRL));

Same for this hunk

> +	}
>  
>  	priv->viu.osd1_enabled = false;
>  	priv->viu.osd1_commit = false;


