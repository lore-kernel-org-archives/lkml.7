Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBC1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E8A2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8q+1AVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCGRZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:25:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40240 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGRZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:25:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id h1so11944037pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1uA6Wnc1JXO6Z/KXP18r76DXk74dLIbMETnvZuX2eQo=;
        b=r8q+1AVtcLlSCG/omYgZqF8a93jYl60llXuHFROd7Q7mKoI6gJoc7vydhlJjLUbrra
         HbjXWJ5Xvldqdqd2JMSLTCxVopXfNgeov4DZMl3jnR/6S4LOQlOUCqHXfzcxu75gV+mT
         mTgOi+M/Pj7XILsv4MAg5FQAxpflcBpdSG4xdtAx5Yje4W1mkamSf36RwMQ3fjKfhUDi
         vt+TFi8RQEiTKrxTtORluBXZsPtQSuwUx7bwg0tntz96U5l1QKATYB5H+yW30j6nOWtN
         Aij0hqLowb82E7vjZbdelB+S35TZ+v4AzHRabQlrNPZ0LdzPzYx1pbHcPYIdDx7Kiiw5
         UNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1uA6Wnc1JXO6Z/KXP18r76DXk74dLIbMETnvZuX2eQo=;
        b=BwJ+ARj0rbYuhLXwW6vv9FLdZQyK2hS9Im40lpw94ya2iOaQYDKBLsIfw/DYVQSmvX
         Oy+mID62KFTMKxr+6lPGreDKtcBfEc3DZ8HAQY/bHDoPNiQTz7B4DtcdMzeBnxZKNgjp
         nx4hXP/VKnn+zvvWPsN5SVdIUwLjDOrcSBpG3+HpTAIyiR0h55gbew9GJliW6nd1xFLW
         KX982l6FVOHBVDdfOTg2T+UAAU4iKfs3Zf2ZxWx8k+jrIz8Spo6m5YLcBD/XuLJYH985
         1KWfJjXhlXLqocq9g+9WR0k7K8CVBg0Irf22yCXc8ZUzjt8Fcw2ex2hPAdjVQr8htd6T
         60DA==
X-Gm-Message-State: APjAAAXtHAniCahLjzgKK02YAl2NrIC3vNCLif8a6DoeCF09GvWsMevE
        LvsFieSg5uEUtAuFZTjaedDv
X-Google-Smtp-Source: APXvYqy/EVBjgFmSxedN5fV/SRT9nKOanUhI6AchQDwARZBhUzCGXswXZzYo6NfEpqapfGE3MLLOEQ==
X-Received: by 2002:a65:468f:: with SMTP id h15mr12513524pgr.391.1551979508978;
        Thu, 07 Mar 2019 09:25:08 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:740f:d61c:f9e8:217e:aed4:aa31])
        by smtp.gmail.com with ESMTPSA id z67sm16870723pfi.152.2019.03.07.09.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 09:25:08 -0800 (PST)
Date:   Thu, 7 Mar 2019 22:55:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        amit.kucheria@linaro.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: bitmain: Add GPIO Line names for Sophon
 Edge board
Message-ID: <20190307172501.GB9268@Mani-XPS-13-9360>
References: <20190226115022.19022-1-manivannan.sadhasivam@linaro.org>
 <20190226115022.19022-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226115022.19022-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 05:20:22PM +0530, Manivannan Sadhasivam wrote:
> Add GPIO line names for Sophon Edge board based on BM1880 SoC from
> Bitmain. Line names are based on the board schematics as well as the
> 96Boards Consumer Edition specification v1.0.
> 

Applied for v5.2 with Linus's Reviewed-by tag.

Thanks,
Mani

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../boot/dts/bitmain/bm1880-sophon-edge.dts   | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts b/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
> index 6a3255597138..6bdf4c101c61 100644
> --- a/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
> +++ b/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
> @@ -8,6 +8,28 @@
>  
>  #include "bm1880.dtsi"
>  
> +/*
> + * GPIO name legend: proper name = the GPIO line is used as GPIO
> + *         NC = not connected (pin out but not routed from the chip to
> + *              anything the board)
> + *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
> + *         LSEC = Low Speed External Connector
> + *         HSEC = High Speed External Connector
> + *
> + * Line names are taken from the schematic "sophon-edge-schematics"
> + * version, 1.0210.
> + *
> + * For the lines routed to the external connectors the
> + * lines are named after the 96Boards CE Specification 1.0,
> + * Appendix "Expansion Connector Signal Description".
> + *
> + * When the 96Board naming of a line and the schematic name of
> + * the same line are in conflict, the 96Board specification
> + * takes precedence. This is only for the informational
> + * lines i.e. "[FOO]", the GPIO named lines "GPIO-A" thru "GPIO-L"
> + * are the only ones actually used for GPIO.
> + */
> +
>  / {
>  	compatible = "bitmain,sophon-edge", "bitmain,bm1880";
>  	model = "Sophon Edge";
> @@ -32,6 +54,98 @@
>  		clock-frequency = <500000000>;
>  		#clock-cells = <0>;
>  	};
> +
> +	soc {
> +		gpio0: gpio@50027000 {
> +			porta: gpio-controller@0 {
> +				gpio-line-names =
> +					"GPIO-A", /* GPIO0, LSEC pin 23 */
> +					"GPIO-C", /* GPIO1, LSEC pin 25 */
> +					"[GPIO2_PHY0_RST]", /* GPIO2 */
> +					"GPIO-E", /* GPIO3, LSEC pin 27 */
> +					"[USB_DET]", /* GPIO4 */
> +					"[EN_P5V]", /* GPIO5 */
> +					"[VDDIO_MS1_SEL]", /* GPIO6 */
> +					"GPIO-G", /* GPIO7, LSEC pin 29 */
> +					"[BM_TUSB_RST_L]", /* GPIO8 */
> +					"[EN_P5V_USBHUB]", /* GPIO9 */
> +					"NC",
> +					"LED_WIFI", /* GPIO11 */
> +					"LED_BT", /* GPIO12 */
> +					"[BM_BLM8221_EN_L]", /* GPIO13 */
> +					"NC", /* GPIO14 */
> +					"NC", /* GPIO15 */
> +					"NC", /* GPIO16 */
> +					"NC", /* GPIO17 */
> +					"NC", /* GPIO18 */
> +					"NC", /* GPIO19 */
> +					"NC", /* GPIO20 */
> +					"NC", /* GPIO21 */
> +					"NC", /* GPIO22 */
> +					"NC", /* GPIO23 */
> +					"NC", /* GPIO24 */
> +					"NC", /* GPIO25 */
> +					"NC", /* GPIO26 */
> +					"NC", /* GPIO27 */
> +					"NC", /* GPIO28 */
> +					"NC", /* GPIO29 */
> +					"NC", /* GPIO30 */
> +					"NC"; /* GPIO31 */
> +			};
> +		};
> +
> +		gpio1: gpio@50027400 {
> +			portb: gpio-controller@0 {
> +				gpio-line-names =
> +					"NC", /* GPIO32 */
> +					"NC", /* GPIO33 */
> +					"[I2C0_SDA]", /* GPIO34, LSEC pin 17 */
> +					"[I2C0_SCL]", /* GPIO35, LSEC pin 15 */
> +					"[JTAG0_TDO]", /* GPIO36 */
> +					"[JTAG0_TCK]", /* GPIO37 */
> +					"[JTAG0_TDI]", /* GPIO38 */
> +					"[JTAG0_TMS]", /* GPIO39 */
> +					"[JTAG0_TRST_X]", /* GPIO40 */
> +					"[JTAG1_TDO]", /* GPIO41 */
> +					"[JTAG1_TCK]", /* GPIO42 */
> +					"[JTAG1_TDI]", /* GPIO43 */
> +					"[CPU_TX]", /* GPIO44 */
> +					"[CPU_RX]", /* GPIO45 */
> +					"[UART1_TXD]", /* GPIO46 */
> +					"[UART1_RXD]", /* GPIO47 */
> +					"[UART0_TXD]", /* GPIO48 */
> +					"[UART0_RXD]", /* GPIO49 */
> +					"GPIO-I", /* GPIO50, LSEC pin 31 */
> +					"GPIO-K", /* GPIO51, LSEC pin 33 */
> +					"USER_LED2", /* GPIO52 */
> +					"USER_LED1", /* GPIO53 */
> +					"[UART0_RTS]", /* GPIO54 */
> +					"[UART0_CTS]", /* GPIO55 */
> +					"USER_LED4", /* GPIO56, JTAG1_TRST_X */
> +					"USER_LED3", /* GPIO57, JTAG1_TMS */
> +					"[I2S0_SCLK]", /* GPIO58 */
> +					"[I2S0_FS]", /* GPIO59 */
> +					"[I2S0_SDI]", /* GPIO60 */
> +					"[I2S0_SDO]", /* GPIO61 */
> +					"GPIO-B", /* GPIO62, LSEC pin 24 */
> +					"GPIO-F"; /* GPIO63, I2S1_SCLK, LSEC pin 28 */
> +			};
> +		};
> +
> +		gpio2: gpio@50027800 {
> +			portc: gpio-controller@0 {
> +				gpio-line-names =
> +					"GPIO-D", /* GPIO64, I2S1_FS, LSEC pin 26 */
> +					"GPIO-J", /* GPIO65, I2S1_SDI, LSEC pin 32 */
> +					"GPIO-H", /* GPIO66, I2S1_SDO, LSEC pin 30 */
> +					"GPIO-L", /* GPIO67, LSEC pin 34 */
> +					"[SPI0_CS]", /* GPIO68, SPI1_CS, LSEC pin 12 */
> +					"[SPI0_DIN]", /* GPIO69, SPI1_SDI, LSEC pin 10 */
> +					"[SPI0_DOUT]", /* GPIO70, SPI1_SDO, LSEC pin 14 */
> +					"[SPI0_SCLK]"; /* GPIO71, SPI1_SCK, LSEC pin 8 */
> +			};
> +		};
> +	};
>  };
>  
>  &uart0 {
> -- 
> 2.17.1
> 
