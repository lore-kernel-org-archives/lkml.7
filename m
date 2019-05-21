Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520A6C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6AA2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tj92RRfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfEUIi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:38:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39086 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUIiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:38:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so106124wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sU8ZvVyOkwzWB64qjmD8yMis5IArCRr5jkybcZOcNyQ=;
        b=tj92RRfyqAVHu8xAj0p1uGTqIBYJT1dxLYHotISTrV0cODxptm82cF9djoqwCmK5zb
         Mo37mQPkAhfkLHYi340nUvpgFyOcYLsUMhYC2e4q7NxotZCVzgWAJnoDgM3qEt1pU8vg
         ORrXbfnVLhFv87i5z85rqnVz1vVXVIC84/oN0rQ/0x0vpO1cGc5AtsX10xvwaStUl/8A
         VskcJyEjjLq0Cx3bj7LVQBB0TnJRvTbWEiOJ8ZJfWAcqUTU1Ik1Rx0q4/y0rcLom1G3W
         6kG0elFABxAUa9IkInSW9EK+xZAenEFo1PX2FyS3DkFMFjYHcMZIQolmUKkVs75vFZTJ
         s1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sU8ZvVyOkwzWB64qjmD8yMis5IArCRr5jkybcZOcNyQ=;
        b=AV7EIIkHWu4kE2qk1PbK45Gr/o4k1RTqtre4Uuow7gdWmsUG6GMHDHSu78Y90RhHFf
         GEDmYOcUFvud+yEDkAeLwYqbvPCEOJnDJeu1RHFKqxPdsp/nG+JKy8IVksHcj5+LIPFb
         pWDML2fPL7wXbdvouRRaLzJX7psccp89Ail7IXHqv1TPzb9x33ZE1JulBL4b0eTw7+Xp
         rnMp3wY9BFMW5bP3euaIjkAG5YYgHYEVllEE+7dhnC0Q3IL5KogkmRJ9UMnQJMAdFAp5
         WAqUMOMm8+R+d+kFnbJG7MngZ7pSbIzaKsbQo+ThU//yMiBb23iG8IKBwP5LZr7gtSwx
         EZTw==
X-Gm-Message-State: APjAAAXaN/dYR5+ie7noxIszcwcSfRebBY6usFkRGMuNNqMdfJm8tWNT
        l9PKBGCoibj7yUsgY5TwvslLUPLhELEc0g==
X-Google-Smtp-Source: APXvYqwtUYJw7kwH6qgGypBkZAimWcISe6QiMUvyHjqYBaXsLB88g2mbRv2AfecGqKxjxqB9Y3P/AA==
X-Received: by 2002:a7b:ce03:: with SMTP id m3mr2277652wmc.99.1558427933334;
        Tue, 21 May 2019 01:38:53 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 197sm3217316wma.36.2019.05.21.01.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:38:52 -0700 (PDT)
Subject: Re: [PATCH 1/1] ARM: dts: meson8b: odroidc1: add the GPIO line names
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190328204721.25970-1-martin.blumenstingl@googlemail.com>
 <20190328204721.25970-2-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <b9e45b82-5ba9-ad0a-35ba-6bccdd0bc8ce@baylibre.com>
Date:   Tue, 21 May 2019 10:38:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328204721.25970-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2019 21:47, Martin Blumenstingl wrote:
> This adds the GPIO line names from the schematics to get them displayed
> in the debugfs output of each GPIO controller.
> 
> The schematics from Odroid-C1+ PCB revision 0.4 20150615 are used as
> referenced.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 52 ++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index 3b0e0f8fbc23..0157646e3a89 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -234,7 +234,59 @@
>  	};
>  };
>  
> +&gpio {
> +	gpio-line-names = /* Bank GPIOX */
> +			  "J2 Header Pin 35", "J2 Header Pin 36",
> +			  "J2 Header Pin 32", "J2 Header Pin 31",
> +			  "J2 Header Pin 29", "J2 Header Pin 18",
> +			  "J2 Header Pin 22", "J2 Header Pin 16",
> +			  "J2 Header Pin 23", "J2 Header Pin 21",
> +			  "J2 Header Pin 19", "J2 Header Pin 33",
> +			  "J2 Header Pin 8", "J2 Header Pin 10",
> +			  "J2 Header Pin 15", "J2 Header Pin 13",
> +			  "J2 Header Pin 24", "J2 Header Pin 26",
> +			  /* Bank GPIOY */
> +			  "Revision (upper)", "Revision (lower)",
> +			  "J2 Header Pin 7", "", "J2 Header Pin 12",
> +			  "J2 Header Pin 11", "", "", "",
> +			  "TFLASH_VDD_EN", "", "",
> +			  /* Bank GPIODV */
> +			  "VCCK_PWM (PWM_C)", "I2CA_SDA", "I2CA_SCL",
> +			  "I2CB_SDA", "I2CB_SCL", "VDDEE_PWM (PWM_D)",
> +			  "",
> +			  /* Bank GPIOH */
> +			  "HDMI_HPD", "HDMI_I2C_SDA", "HDMI_I2C_SCL",
> +			  "ETH_PHY_INTR", "ETH_PHY_NRST", "ETH_TXD1",
> +			  "ETH_TXD0", "ETH_TXD3", "ETH_TXD2",
> +			  "ETH_RGMII_TX_CLK",
> +			  /* Bank CARD */
> +			  "SD_DATA1 (SDB_D1)", "SD_DATA0 (SDB_D0)",
> +			  "SD_CLK",  "SD_CMD", "SD_DATA3 (SDB_D3)",
> +			  "SD_DATA2 (SDB_D2)", "SD_CDN (SD_DET_N)",
> +			  /* Bank BOOT */
> +			  "SDC_D0 (EMMC)", "SDC_D1 (EMMC)",
> +			  "SDC_D2 (EMMC)", "SDC_D3 (EMMC)",
> +			  "SDC_D4 (EMMC)", "SDC_D5 (EMMC)",
> +			  "SDC_D6 (EMMC)", "SDC_D7 (EMMC)",
> +			  "SDC_CLK (EMMC)", "SDC_RSTn (EMMC)",
> +			  "SDC_CMD (EMMC)", "BOOT_SEL", "", "", "",
> +			  "", "", "", "",
> +			  /* Bank DIF */
> +			  "ETH_RXD1", "ETH_RXD0", "ETH_RX_DV",
> +			  "RGMII_RX_CLK", "ETH_RXD3", "ETH_RXD2",
> +			  "ETH_TXEN", "ETH_PHY_REF_CLK_25MOUT",
> +			  "ETH_MDC", "ETH_MDIO";
> +};
> +
>  &gpio_ao {
> +	gpio-line-names = "UART TX", "UART RX", "",
> +			  "TF_3V3N_1V8_EN", "USB_HUB_RST_N",
> +			  "USB_OTG_PWREN", "J7 Header Pin 2",
> +			  "IR_IN", "J7 Header Pin 4",
> +			  "J7 Header Pin 6", "J7 Header Pin 5",
> +			  "J7 Header Pin 7", "HDMI_CEC",
> +			  "SYS_LED", "", "";
> +
>  	/*
>  	 * WARNING: The USB Hub on the Odroid-C1/C1+ needs a reset signal
>  	 * to be turned high in order to be detected by the USB Controller.
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
