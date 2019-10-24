Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7606ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A6C20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWFTxBFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438219AbfJXI3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:29:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39382 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJXI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:29:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id r141so1639947wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 01:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G4vdb56f6clb5k1zxUC/hpMvO/EV60ACJWqtpC79nFU=;
        b=MWFTxBFoF/A1/WoBHVj4CbXYa/Pfi+Fu/HBTS1OD78S8XdVhAfAv2FPoim6z/HL0fJ
         bAsjZ+nQU7xuGOSLAMS2cU1WpogE6lpqKrhD0fwpRUWBooxdm7oatdnbiFT1vKMQRuXI
         YUesDSYrlrXY7rtIkZZGFVWVQMmXWOoDkYjmG/FlPyxrTaFiOsrgcX/deoqQpQrz8WC9
         eb7bHMF072EjgrW7DtfWSSoYwWX/Okev8BmdNZBQGxbi/4F2jWxN2L1lgUa8PMMJyWd2
         9WdYf7WE46xuvVtBI4kSOqH1p5U/DpO+hajtJZ1AcsTM2xKtX35hm8MaY5eHyUBhdkRQ
         8xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G4vdb56f6clb5k1zxUC/hpMvO/EV60ACJWqtpC79nFU=;
        b=q5tD4r1THMXCZSo6HQfUZP0UnCOaUzbJkuqgxkk1RH3UWjZDEIO/1YZIGiOsS+gZQ0
         xL5Mkt9K1Ais7cM8M9EoeC7fVtvL+V8QNozhGsfeKD1Dpnpzq+MUmpk8qe8FVN4Jh5kn
         gUcy3PA57J49A7dmzzb0CuRrRfy42UCjubjowDrJoIQr5aniQqjx9ec/VgJLtVhYroaZ
         Eot5nh82rXq1IwxOb0RnNkvU15rW33jEicfnZAz6FFUOtLugTEZmTq+6NcvrGYHLoWEl
         jNkGConEt1MAeXgwu3yIQrRXNyPsdc5ddQgO5tJKAbd6v2ao6lnjkasDX84Tm9qZuylV
         JQUg==
X-Gm-Message-State: APjAAAW/iYTCxY+qM44Z6j4OpEGWh9+svEdKeyGOQVsSNIJkqArzH6XR
        iAW/UjnC3U/n3BAssZi8MCvt7w==
X-Google-Smtp-Source: APXvYqw2zO/n8ymN3AuSXm7TXS6NYxgbrnPVMDiRr7AlWcfRIHaJr278vr6HY3WfkjlqZz2KGKlL9A==
X-Received: by 2002:a7b:c049:: with SMTP id u9mr3667702wmc.12.1571905770490;
        Thu, 24 Oct 2019 01:29:30 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id j63sm2931576wmj.46.2019.10.24.01.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 01:29:29 -0700 (PDT)
Date:   Thu, 24 Oct 2019 09:29:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v4] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20191024082928.GL15843@dell>
References: <1571749359-15752-1-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1571749359-15752-1-git-send-email-gene.chen.richtek@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Add mfd driver for mt6360 pmic chip include
> Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com
> ---
>  drivers/mfd/Kconfig                |  12 +
>  drivers/mfd/Makefile               |   1 +
>  drivers/mfd/mt6360-core.c          | 457 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6360-private.h | 279 ++++++++++++++++++++++
>  include/linux/mfd/mt6360.h         |  32 +++
>  5 files changed, 781 insertions(+)
>  create mode 100644 drivers/mfd/mt6360-core.c
>  create mode 100644 include/linux/mfd/mt6360-private.h
>  create mode 100644 include/linux/mfd/mt6360.h
> 
> changelogs between v1 & v2
> - include missing header file
> 
> changelogs between v2 & v3
> - add changelogs
> 
> changelogs between v3 & v4
> - fix Kconfig description
> - replace mt6360_pmu_info with mt6360_pmu_data
> - replace probe with probe_new
> - remove unnecessary irq_chip variable
> - remove annotation
> - replace MT6360_MFD_CELL with OF_MFD_CELL

[...]

> +/* IRQ definitions */
> +struct mt6360_pmu_irq_desc {
> +	const char *name;
> +	irq_handler_t irq_handler;
> +};
> +
> +#define  MT6360_DT_VALPROP(name, type) \
> +			{#name, offsetof(type, name)}
> +
> +struct mt6360_val_prop {
> +	const char *name;
> +	size_t offset;
> +};
> +
> +static inline void mt6360_dt_parser_helper(struct device_node *np, void *data,
> +					   const struct mt6360_val_prop *props,
> +					   int prop_cnt)
> +{
> +	int i;
> +
> +	for (i = 0; i < prop_cnt; i++) {
> +		if (unlikely(!props[i].name))
> +			continue;
> +		of_property_read_u32(np, props[i].name, data + props[i].offset);
> +	}
> +}
> +
> +#define MT6360_PDATA_VALPROP(name, type, reg, shift, mask, func, base) \
> +			{offsetof(type, name), reg, shift, mask, func, base}
> +
> +struct mt6360_pdata_prop {
> +	size_t offset;
> +	u8 reg;
> +	u8 shift;
> +	u8 mask;
> +	u32 (*transform)(u32 val);
> +	u8 base;
> +};
> +
> +static inline int mt6360_pdata_apply_helper(void *context, void *pdata,
> +					   const struct mt6360_pdata_prop *prop,
> +					   int prop_cnt)
> +{
> +	int i, ret;
> +	u32 val;
> +
> +	for (i = 0; i < prop_cnt; i++) {
> +		val = *(u32 *)(pdata + prop[i].offset);
> +		if (prop[i].transform)
> +			val = prop[i].transform(val);
> +		val += prop[i].base;
> +		ret = regmap_update_bits(context,
> +			     prop[i].reg, prop[i].mask, val << prop[i].shift);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return 0;
> +}

Where are these helpers used?

Are they generic?

Why are they helpful to you, but not helpful to anyone else?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
