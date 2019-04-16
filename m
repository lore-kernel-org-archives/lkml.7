Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A26BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4720E2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VLA9+5WB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfDPLXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:23:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38159 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPLXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:23:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so24863551wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=b/G5+2IKb4PAJeRbqkm/KrAQjVm2iADH4HhYLIXqUtE=;
        b=VLA9+5WBQh1N/5EA0d3gsKHXwN+KTGenFXZHf9Ki4Ecz4TNH+V9iJW7r8aOLDfntu/
         5ZZvtA8UxU4D4SjupNK1sDJPs1lzzKNm2CtHdDIfg8aqNrD8kSdLXKYx+i9IyaRh+HRW
         08+NUMPXg9F11fbmRgeCceckdvkIB7RDvFECr5gyFv95BR5M5tz1OnM3R4P4kJfbOPI1
         cRwH2XTfXtHLcU+/dXGURLgeiRiTVJMvM4yqfCLr8DWkOSug3OXH5MXvWMgRckFyMu45
         IwtMBpoGBiBnJbK6Ltp8NkTBctKTDmknAcWi7ZlPkOaz6V9gl/+bDDmp2cUdswb9AneZ
         uH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=b/G5+2IKb4PAJeRbqkm/KrAQjVm2iADH4HhYLIXqUtE=;
        b=K4AcAoitJp5ZTdcUwnaV4iPorkjnCjkTT0pT1K6mBZSdVLKDCIfrJpdAJODoFvdM34
         m8hlm8ln3gQWAm6zn3SFl3O9xqs4cgiclOPT9/BxjSgjF5vIjw0YOTvr1VRQve5rJFzv
         UQ7NXtjko2w3wqmeB0XhZ2fQp+tzFMojkmV0bzcVHb0kSZcWBnwxvjZhnVg0xW3cDEU3
         m9kUAFpiPiKKKwbYbhtyTh0zaB3Ts+5t15BUrh0jJVAhk5UbGQT2lCj4w2bMekAM8JLY
         QvrK+2CnsUncZZ7dwv25KN6OdPmWoEkqEKUSmqRmBEkh5EJPIszijwM9YBbsMtBFU01P
         aVVw==
X-Gm-Message-State: APjAAAXbT2a/E4JcZjOh0G4XDZbtsM9KK7P5lc+ZYfkFQ8qU+CTNgojB
        9Wl7pxzuYgKw8GiWTEWozL1vXDzeV+CCWA==
X-Google-Smtp-Source: APXvYqzIfOFtHgxAEbRckGHwi/bONhwXTFCZSqWgjT/V4uHDXkHp5zRqZCbL83lPUll6gjId0M5lWw==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr25270055wmj.62.1555413828814;
        Tue, 16 Apr 2019 04:23:48 -0700 (PDT)
Received: from [192.168.1.77] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id c10sm61492893wru.83.2019.04.16.04.23.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 04:23:47 -0700 (PDT)
Message-ID: <5CB5BB43.5040007@baylibre.com>
Date:   Tue, 16 Apr 2019 13:23:47 +0200
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Yue Haibing <yuehaibing@huawei.com>, airlied@linux.ie,
        daniel@ffwll.ch, khilman@baylibre.com
CC:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/meson: Make some functions static
References: <20190413141455.34020-1-yuehaibing@huawei.com>
In-Reply-To: <20190413141455.34020-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/04/2019 16:14, Yue Haibing a écrit :
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warnings:
> 
> drivers/gpu/drm/meson/meson_viu.c:93:6: warning: symbol 'meson_viu_set_g12a_osd1_matrix' was not declared. Should it be static?
> drivers/gpu/drm/meson/meson_viu.c:121:6: warning: symbol 'meson_viu_set_osd_matrix' was not declared. Should it be static?
> drivers/gpu/drm/meson/meson_viu.c:190:6: warning: symbol 'meson_viu_set_osd_lut' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/meson/meson_viu.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
> index 0169c98..b590723 100644
> --- a/drivers/gpu/drm/meson/meson_viu.c
> +++ b/drivers/gpu/drm/meson/meson_viu.c
> @@ -90,8 +90,8 @@ static int eotf_bypass_coeff[EOTF_COEFF_SIZE] = {
>  	EOTF_COEFF_RIGHTSHIFT /* right shift */
>  };
>  
> -void meson_viu_set_g12a_osd1_matrix(struct meson_drm *priv, int *m,
> -				   bool csc_on)
> +static void meson_viu_set_g12a_osd1_matrix(struct meson_drm *priv,
> +					   int *m, bool csc_on)
>  {
>  	/* VPP WRAP OSD1 matrix */
>  	writel(((m[0] & 0xfff) << 16) | (m[1] & 0xfff),
> @@ -118,8 +118,8 @@ void meson_viu_set_g12a_osd1_matrix(struct meson_drm *priv, int *m,
>  		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_EN_CTRL));
>  }
>  
> -void meson_viu_set_osd_matrix(struct meson_drm *priv,
> -			      enum viu_matrix_sel_e m_select,
> +static void meson_viu_set_osd_matrix(struct meson_drm *priv,
> +				     enum viu_matrix_sel_e m_select,
>  			      int *m, bool csc_on)
>  {
>  	if (m_select == VIU_MATRIX_OSD) {
> @@ -187,10 +187,10 @@ void meson_viu_set_osd_matrix(struct meson_drm *priv,
>  #define OSD_EOTF_LUT_SIZE 33
>  #define OSD_OETF_LUT_SIZE 41
>  
> -void meson_viu_set_osd_lut(struct meson_drm *priv, enum viu_lut_sel_e lut_sel,
> -			   unsigned int *r_map, unsigned int *g_map,
> -			   unsigned int *b_map,
> -			   bool csc_on)
> +static void
> +meson_viu_set_osd_lut(struct meson_drm *priv, enum viu_lut_sel_e lut_sel,
> +		      unsigned int *r_map, unsigned int *g_map,
> +		      unsigned int *b_map, bool csc_on)
>  {
>  	unsigned int addr_port;
>  	unsigned int data_port;
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
