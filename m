Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URG_BIZ,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6EAC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7526020818
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YbagA9DT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfDIJTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:19:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38537 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfDIJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:19:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so507965wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3ag5sJqvcIjMNSZ8QaIbLgH94ITgQ+bgMzYDI9QKCQk=;
        b=YbagA9DTeerKxA3qUaAH2RdiuC9/vAXuMTvk2n+80R98GSfRAiaPmN5gmK+CsOBHc9
         +tAzHQkeEGRpXjY0zvPf81uYfI3uYpGk4Msc3SUsTMLiLcZgBNaVH+Xso+/F63TlU+uX
         Njm4sayFYFwhJLS/eagCkC7yM7wvOST//SO03P0FI8KtxOUPGM4o7LgTa5xzXJiUWCOo
         LK0qW+YgFZeCDnjXXkJUytTxow4ObiXph5WTd+0lLvx7VvA2ltYY9wrnakdySsr96C6/
         O+5RfQKWZtDybhrvFXvyFsA0bxnVfTBsrEv3PNLwMjXbJBwq0Zz0Orj4/0pH5gBYFOpg
         4Qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3ag5sJqvcIjMNSZ8QaIbLgH94ITgQ+bgMzYDI9QKCQk=;
        b=sPAN0fxC6hfnUbGiDVhLTpFPa9Qi6QTORke321Z0okL2RF4rcwWwyT5YPYsjeVg29T
         dVVpE3VLyoN33rOnt9pVs0N+ArnO8QAgpcc3QpGby/uBE9Ja1FItHSx8/UpP8CE7+MPV
         RI40FCYYuu6UbGJnMB3OkZxML0J7t7ObDW/ZeZCerA9jy2P8joc7XZjiyQ4RrTvpH2zd
         tw4BFcjKH2TS3cpFAoqH00tDMExgRLMgowddFCJepVRSs/T4tzf2uvv+yoZWkaeJly+6
         PT6ojEgaFqMwikZ5B//DQX+0OTS8tjHvBSm57Z6yMaNAlrTNl8klaXZZiqFioXO7mVpa
         IBiQ==
X-Gm-Message-State: APjAAAUOgT/chGymjQlJiPP3gALrsrJDqvcF4i0TTErxp9XYODRaGIc4
        Z6KJg1/e4U4vjPqfXflq7SfwS/cmssVMvg==
X-Google-Smtp-Source: APXvYqyt3e/B4gxJKgkgUYv9AbgS8HgC8CoYwB4sqCQw+PvdbKaj/ML72pB7TDDqj5sPix2HZ6ldJg==
X-Received: by 2002:a05:600c:211a:: with SMTP id u26mr21931829wml.74.1554801580329;
        Tue, 09 Apr 2019 02:19:40 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b134sm28601720wmd.26.2019.04.09.02.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:19:39 -0700 (PDT)
Subject: Re: [PATCH 04/11] drm/meson: Add G12A Support for VIU setup
To:     Jerome Brunet <jbrunet@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190325141824.21259-1-narmstrong@baylibre.com>
 <20190325141824.21259-5-narmstrong@baylibre.com>
 <8d1c3c13e2ad05aac1f28327ddaa0169ab204b50.camel@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <22905ebe-0edb-6cb4-98a2-99cfd6df2b1c@baylibre.com>
Date:   Tue, 9 Apr 2019 11:19:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8d1c3c13e2ad05aac1f28327ddaa0169ab204b50.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2019 10:42, Jerome Brunet wrote:
> On Mon, 2019-03-25 at 15:18 +0100, Neil Armstrong wrote:
>> Amlogic G12A SoC needs a different VIU setup code,
>> handle it.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/meson_viu.c | 72 ++++++++++++++++++++++++++++---
>>  1 file changed, 67 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
>> index ac0f3687e09a..0169c98b01c9 100644
>> --- a/drivers/gpu/drm/meson/meson_viu.c
>> +++ b/drivers/gpu/drm/meson/meson_viu.c
>> @@ -90,6 +90,34 @@ static int eotf_bypass_coeff[EOTF_COEFF_SIZE] = {
>>  	EOTF_COEFF_RIGHTSHIFT /* right shift */
>>  };
>>  
>> +void meson_viu_set_g12a_osd1_matrix(struct meson_drm *priv, int *m,
>> +				   bool csc_on)
>> +{
>> +	/* VPP WRAP OSD1 matrix */
>> +	writel(((m[0] & 0xfff) << 16) | (m[1] & 0xfff),
>> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_PRE_OFFSET0_1));
>> +	writel(m[2] & 0xfff,
>> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_PRE_OFFSET2));
>> +	writel(((m[3] & 0x1fff) << 16) | (m[4] & 0x1fff),
>> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_COEF00_01));
>> +	writel(((m[5] & 0x1fff) << 16) | (m[6] & 0x1fff),
>> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_COEF02_10));
>> +	writel(((m[7] & 0x1fff) << 16) | (m[8] & 0x1fff),
>> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_COEF11_12));
>> +	writel(((m[9] & 0x1fff) << 16) | (m[10] & 0x1fff),
>> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_COEF20_21));
>> +	writel((m[11] & 0x1fff) << 16,
>> +		priv->io_base +	_REG(VPP_WRAP_OSD1_MATRIX_COEF22));
>> +
>> +	writel(((m[18] & 0xfff) << 16) | (m[19] & 0xfff),
>> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_OFFSET0_1));
> 
> Can you define some of the masks and shifts above ? possibly the same define
> for all the registers I suppose ... maybe using FIELD_PREP ?

Ack

> 
>> +	writel(m[20] & 0xfff,
>> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_OFFSET2));
>> +
>> +	writel_bits_relaxed(BIT(0), csc_on ? BIT(0) : 0,
>> +		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_EN_CTRL));
>> +}
>> +
>>  void meson_viu_set_osd_matrix(struct meson_drm *priv,
>>  			      enum viu_matrix_sel_e m_select,
>>  			      int *m, bool csc_on)
>> @@ -336,14 +364,24 @@ void meson_viu_init(struct meson_drm *priv)
>>  	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>>  	    meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>>  		meson_viu_load_matrix(priv);
>> +	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +		meson_viu_set_g12a_osd1_matrix(priv, RGB709_to_YUV709l_coeff,
>> +					       true);
>>  
>>  	/* Initialize OSD1 fifo control register */
>>  	reg = BIT(0) |	/* Urgent DDR request priority */
>> -	      (4 << 5) | /* hold_fifo_lines */
>> -	      (3 << 10) | /* burst length 64 */
>> -	      (32 << 12) | /* fifo_depth_val: 32*8=256 */
>> -	      (2 << 22) | /* 4 words in 1 burst */
>> -	      (2 << 24);
>> +	      (4 << 5); /* hold_fifo_lines */
>> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +		reg |= (1 << 10) | /* burst length 32 */
>> +		       (32 << 12) | /* fifo_depth_val: 32*8=256 */
>> +		       (2 << 22) | /* 4 words in 1 burst */
>> +		       (2 << 24) |
>> +		       (1 << 31);
>> +	else
>> +		reg |= (3 << 10) | /* burst length 64 */
>> +		       (32 << 12) | /* fifo_depth_val: 32*8=256 */
>> +		       (2 << 22) | /* 4 words in 1 burst */
>> +		       (2 << 24);
> 
> Could you use the BIT() macro and add some defines ?

Ack

> 
>>  	writel_relaxed(reg, priv->io_base + _REG(VIU_OSD1_FIFO_CTRL_STAT));
>>  	writel_relaxed(reg, priv->io_base + _REG(VIU_OSD2_FIFO_CTRL_STAT));
>>  
>> @@ -369,6 +407,30 @@ void meson_viu_init(struct meson_drm *priv)
>>  	writel_relaxed(0x00FF00C0,
>>  			priv->io_base + _REG(VD2_IF0_LUMA_FIFO_SIZE));
>>  
>> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +		writel_relaxed(4 << 29 |
>> +				1 << 27 |
>> +				1 << 26 | /* blend_din0 input to blend0 */
>> +				1 << 25 | /* blend1_dout to blend2 */
>> +				1 << 24 | /* blend1_din3 input to blend1 */
>> +				1 << 20 |
>> +				0 << 16 |
>> +				1,
>> +				priv->io_base + _REG(VIU_OSD_BLEND_CTRL));
>> +		writel_relaxed(3 << 8 |
>> +				1 << 20,
>> +				priv->io_base + _REG(OSD1_BLEND_SRC_CTRL));
>> +		writel_relaxed(1 << 20,
>> +				priv->io_base + _REG(OSD2_BLEND_SRC_CTRL));
>> +		writel_relaxed(0, priv->io_base + _REG(VD1_BLEND_SRC_CTRL));
>> +		writel_relaxed(0, priv->io_base + _REG(VD2_BLEND_SRC_CTRL));
>> +		writel_relaxed(0,
>> +				priv->io_base + _REG(VIU_OSD_BLEND_DUMMY_DATA0));
>> +		writel_relaxed(0,
>> +				priv->io_base + _REG(VIU_OSD_BLEND_DUMMY_ALPHA));
>> +		writel_bits_relaxed(0x3 << 2, 0x3 << 2,
>> +				priv->io_base + _REG(DOLBY_PATH_CTRL));
> 
> Same for this hunk

Ack

> 
>> +	}
>>  
>>  	priv->viu.osd1_enabled = false;
>>  	priv->viu.osd1_commit = false;
> 
> 

Will fix in a follow-up patch, including GXBB/GXL/GXM.

Neil
