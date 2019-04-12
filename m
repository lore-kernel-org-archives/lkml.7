Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5E5C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B1F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll5IRfx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfDLRof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:44:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45829 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfDLRod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:44:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id o26so9012142edv.12;
        Fri, 12 Apr 2019 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/2ytwIMIZYcI6klqoHHRK8Z6kQRD8WS0cZSWXt7raY=;
        b=Ll5IRfx0vSVpqltPMKqd1x4MQCJIDp2XJk/uR8o3po3mlARJHPen5ft2Mk1LZG/RdO
         /SFkEwuoonqYc/4x+KEwjyfT0JU/TutvHP0nak8wXSUs5M7ZQDSAwssGTrdx7qS6e8CL
         +aeCSB/3wgHy1QIuBIoio0ba4NK2q1kAXp4FZGQ6ZuUzNTCFXoC1+4CXoED5Ea5z42CQ
         qZoLsTqhuGLURrZDXuXZFryeIuX/ODDPPzu+NaCjzh41ICQNuKqjJiJZC0pkSdE/RCSZ
         8tZORYOk3BC4WX8Arg4WPa9qh/4t3tQFi/9PIeIk5TdVARX751LovUDXptUXFidfC1I8
         Rfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=u/2ytwIMIZYcI6klqoHHRK8Z6kQRD8WS0cZSWXt7raY=;
        b=fSWghCBwjFqsDbkKNlt5R+xqtkeWGnf7v66QA9gEV43PRcrfuVOGRvK86PRP/GUJ+i
         flaZ0N23RZYVuoCeoBWQt0xdBRIWmKKK2g0eoDTcockO4tWvfusHlj/oO53LCiFUcGnj
         kzik9a0XjMfioA0zhiSHByKF0wE0eK15RxxCOmXjxXcrAnPVZ2am3D13uMBAE3WMlFIA
         /ft9OIiunQXYRXkS5c3JJL+e1+bybPUdf382HE4iq1LsnS+mxlufzoE0Q63LaXvRrjxz
         VQ9IIu6iW5DX1sQjYOCkNK9BIiqmDrmm+ZF/SGlHPKm3w4idRdNCWvP/C4GNNJRHWgXe
         Q3rg==
X-Gm-Message-State: APjAAAWECflV8xbDqwez9CayyxXmrf51BAIJb+9HtC6WmFI/2/DgKsQm
        HR5MimTnMNakDXrITcfdRzg=
X-Google-Smtp-Source: APXvYqxz5fe6BTZw/D+mxlkG8MfT9NW+CUfUAj1DD1a7ERdlvYemCyJWpdapxfnUayG8T2Q6fvKWZQ==
X-Received: by 2002:a17:906:46c8:: with SMTP id k8mr23319722ejs.24.1555091070164;
        Fri, 12 Apr 2019 10:44:30 -0700 (PDT)
Received: from ziggy.stardust (89.red-2-139-173.staticip.rima-tde.net. [2.139.173.89])
        by smtp.gmail.com with ESMTPSA id p13sm4417393edx.96.2019.04.12.10.44.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 10:44:29 -0700 (PDT)
Subject: Re: [PATCH 05/24] soc: mediatek: pwrap: add support for MT8516 pwrap
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-6-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <58cd38e5-ee3e-6fb8-939f-663f18dcc07b@gmail.com>
Date:   Fri, 12 Apr 2019 19:44:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190323211612.860-6-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/03/2019 22:15, Fabien Parent wrote:
> Add the code to support the pwrap IP on the MediaTek MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 106 +++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)

applied to v5.1-next/soc

Thanks!

> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index b3ba2301f569..73f0be0567bd 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -381,6 +381,10 @@ enum pwrap_regs {
>  	PWRAP_EXT_GPS_AUXADC_RDATA_ADDR,
>  	PWRAP_GPSINF_0_STA,
>  	PWRAP_GPSINF_1_STA,
> +
> +	/* MT8516 only regs */
> +	PWRAP_OP_TYPE,
> +	PWRAP_MSB_FIRST,
>  };
>  
>  static int mt2701_regs[] = {
> @@ -852,6 +856,91 @@ static int mt8183_regs[] = {
>  	[PWRAP_WACS2_VLDCLR] =			0xC28,
>  };
>  
> +static int mt8516_regs[] = {
> +	[PWRAP_MUX_SEL] =		0x0,
> +	[PWRAP_WRAP_EN] =		0x4,
> +	[PWRAP_DIO_EN] =		0x8,
> +	[PWRAP_SIDLY] =			0xc,
> +	[PWRAP_RDDMY] =			0x10,
> +	[PWRAP_SI_CK_CON] =		0x14,
> +	[PWRAP_CSHEXT_WRITE] =		0x18,
> +	[PWRAP_CSHEXT_READ] =		0x1c,
> +	[PWRAP_CSLEXT_START] =		0x20,
> +	[PWRAP_CSLEXT_END] =		0x24,
> +	[PWRAP_STAUPD_PRD] =		0x28,
> +	[PWRAP_STAUPD_GRPEN] =		0x2c,
> +	[PWRAP_STAUPD_MAN_TRIG] =	0x40,
> +	[PWRAP_STAUPD_STA] =		0x44,
> +	[PWRAP_WRAP_STA] =		0x48,
> +	[PWRAP_HARB_INIT] =		0x4c,
> +	[PWRAP_HARB_HPRIO] =		0x50,
> +	[PWRAP_HIPRIO_ARB_EN] =		0x54,
> +	[PWRAP_HARB_STA0] =		0x58,
> +	[PWRAP_HARB_STA1] =		0x5c,
> +	[PWRAP_MAN_EN] =		0x60,
> +	[PWRAP_MAN_CMD] =		0x64,
> +	[PWRAP_MAN_RDATA] =		0x68,
> +	[PWRAP_MAN_VLDCLR] =		0x6c,
> +	[PWRAP_WACS0_EN] =		0x70,
> +	[PWRAP_INIT_DONE0] =		0x74,
> +	[PWRAP_WACS0_CMD] =		0x78,
> +	[PWRAP_WACS0_RDATA] =		0x7c,
> +	[PWRAP_WACS0_VLDCLR] =		0x80,
> +	[PWRAP_WACS1_EN] =		0x84,
> +	[PWRAP_INIT_DONE1] =		0x88,
> +	[PWRAP_WACS1_CMD] =		0x8c,
> +	[PWRAP_WACS1_RDATA] =		0x90,
> +	[PWRAP_WACS1_VLDCLR] =		0x94,
> +	[PWRAP_WACS2_EN] =		0x98,
> +	[PWRAP_INIT_DONE2] =		0x9c,
> +	[PWRAP_WACS2_CMD] =		0xa0,
> +	[PWRAP_WACS2_RDATA] =		0xa4,
> +	[PWRAP_WACS2_VLDCLR] =		0xa8,
> +	[PWRAP_INT_EN] =		0xac,
> +	[PWRAP_INT_FLG_RAW] =		0xb0,
> +	[PWRAP_INT_FLG] =		0xb4,
> +	[PWRAP_INT_CLR] =		0xb8,
> +	[PWRAP_SIG_ADR] =		0xbc,
> +	[PWRAP_SIG_MODE] =		0xc0,
> +	[PWRAP_SIG_VALUE] =		0xc4,
> +	[PWRAP_SIG_ERRVAL] =		0xc8,
> +	[PWRAP_CRC_EN] =		0xcc,
> +	[PWRAP_TIMER_EN] =		0xd0,
> +	[PWRAP_TIMER_STA] =		0xd4,
> +	[PWRAP_WDT_UNIT] =		0xd8,
> +	[PWRAP_WDT_SRC_EN] =		0xdc,
> +	[PWRAP_WDT_FLG] =		0xe0,
> +	[PWRAP_DEBUG_INT_SEL] =		0xe4,
> +	[PWRAP_DVFS_ADR0] =		0xe8,
> +	[PWRAP_DVFS_WDATA0] =		0xec,
> +	[PWRAP_DVFS_ADR1] =		0xf0,
> +	[PWRAP_DVFS_WDATA1] =		0xf4,
> +	[PWRAP_DVFS_ADR2] =		0xf8,
> +	[PWRAP_DVFS_WDATA2] =		0xfc,
> +	[PWRAP_DVFS_ADR3] =		0x100,
> +	[PWRAP_DVFS_WDATA3] =		0x104,
> +	[PWRAP_DVFS_ADR4] =		0x108,
> +	[PWRAP_DVFS_WDATA4] =		0x10c,
> +	[PWRAP_DVFS_ADR5] =		0x110,
> +	[PWRAP_DVFS_WDATA5] =		0x114,
> +	[PWRAP_DVFS_ADR6] =		0x118,
> +	[PWRAP_DVFS_WDATA6] =		0x11c,
> +	[PWRAP_DVFS_ADR7] =		0x120,
> +	[PWRAP_DVFS_WDATA7] =		0x124,
> +	[PWRAP_SPMINF_STA] =		0x128,
> +	[PWRAP_CIPHER_KEY_SEL] =	0x12c,
> +	[PWRAP_CIPHER_IV_SEL] =		0x130,
> +	[PWRAP_CIPHER_EN] =		0x134,
> +	[PWRAP_CIPHER_RDY] =		0x138,
> +	[PWRAP_CIPHER_MODE] =		0x13c,
> +	[PWRAP_CIPHER_SWRST] =		0x140,
> +	[PWRAP_DCM_EN] =		0x144,
> +	[PWRAP_DCM_DBC_PRD] =		0x148,
> +	[PWRAP_SW_RST] =		0x168,
> +	[PWRAP_OP_TYPE] =		0x16c,
> +	[PWRAP_MSB_FIRST] =		0x170,
> +};
> +
>  enum pmic_type {
>  	PMIC_MT6323,
>  	PMIC_MT6351,
> @@ -869,6 +958,7 @@ enum pwrap_type {
>  	PWRAP_MT8135,
>  	PWRAP_MT8173,
>  	PWRAP_MT8183,
> +	PWRAP_MT8516,
>  };
>  
>  struct pmic_wrapper;
> @@ -1297,6 +1387,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  	case PWRAP_MT6765:
>  	case PWRAP_MT6797:
>  	case PWRAP_MT8173:
> +	case PWRAP_MT8516:
>  		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
>  		break;
>  	case PWRAP_MT7622:
> @@ -1765,6 +1856,18 @@ static const struct pmic_wrapper_type pwrap_mt8183 = {
>  	.init_soc_specific = pwrap_mt8183_init_soc_specific,
>  };
>  
> +static struct pmic_wrapper_type pwrap_mt8516 = {
> +	.regs = mt8516_regs,
> +	.type = PWRAP_MT8516,
> +	.arb_en_all = 0xff,
> +	.int_en_all = ~(u32)(BIT(31) | BIT(2)),
> +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.caps = PWRAP_CAP_DCM,
> +	.init_reg_clock = pwrap_mt2701_init_reg_clock,
> +	.init_soc_specific = NULL,
> +};
> +
>  static const struct of_device_id of_pwrap_match_tbl[] = {
>  	{
>  		.compatible = "mediatek,mt2701-pwrap",
> @@ -1787,6 +1890,9 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
>  	}, {
>  		.compatible = "mediatek,mt8183-pwrap",
>  		.data = &pwrap_mt8183,
> +	}, {
> +		.compatible = "mediatek,mt8516-pwrap",
> +		.data = &pwrap_mt8516,
>  	}, {
>  		/* sentinel */
>  	}
> 
