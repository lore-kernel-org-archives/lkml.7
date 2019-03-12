Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEA3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D7E214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eB/Ww7os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfCLVCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:02:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43860 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLVCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:02:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id l11so2719210pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=s1zAivap7ECwynYe4xnVyvyJ8rC0V8FIe7PE8u9zfRQ=;
        b=eB/Ww7os4vu6TCDty5HZIcM8A5fEpeK8Sg857UyvOmz+ZrRNseLtbo2x68efFdLvvH
         2Adu4yDCZXj8vFZtVdL9X3FjHcw9/p1mEjOzj+yyh20cpC5AZZIucn3cITVDpn8os2Oq
         Ld4uWb5a5BCBgielP5mXu0oQ6VoeT6CToO941JkRRMtw3Knqz3CLchfEAd0TYCNo6t4C
         2l/mkUAgG54L8fZw29svQqK8moR0lRmV1GIfxk7OhOs1TsWY27n4KDiJM2f7PQaV80KA
         1DE0nfBrYCfubh5GbrSo/X24lHdOovbhGnxn4BOZ2eyqBIePj3PJ0PgahWVFfa40y0Xq
         eDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=s1zAivap7ECwynYe4xnVyvyJ8rC0V8FIe7PE8u9zfRQ=;
        b=Pzz527b+gcwyzHO+lTJqUNrzd+T5erDzvJSCy5jVRcx1PMar9gM9FVFGbK0nL439YJ
         8r3Kho0ZXof3miZAuscPFaSsTLDOQQcRZwzHLIqvko50YjLTXeXzC0ynh+VcZG05tNOV
         NX6oOuNBJDLEd3xO/ufxHcIrDL8M0NiF3gcqFsewETW7cmRM6SENQMdb+xz9oOLb9uY2
         bROLZmtNVpYetqgOylnl4nDOP6dKcLm8dQdPDqKb2+c0KzNPjGGR6kqBfteVCUtOB9IP
         FQt/zNFfPgZF8QnboKbEh7W4YSIBMdVhL+Zs1spbuPArs/LFBlthaOKq1EGYQvJ7xleq
         WyvA==
X-Gm-Message-State: APjAAAVfZCeh9ocF9OhaRyDwUPd3X9Ds/RBT9O8G+JMzdm8shcgWJ90K
        C3Yfv9mqploYDhB1ncZPoNWszQ==
X-Google-Smtp-Source: APXvYqwcYN+hh84jUZuAHGI1ZxzE4OR034TULZaPm2fef+FgtZiXl3TM7o/j3jKlW8Y/kpPLjIfXmw==
X-Received: by 2002:a63:fc49:: with SMTP id r9mr36671226pgk.447.1552424566702;
        Tue, 12 Mar 2019 14:02:46 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:1daf:3f96:9f7f:33ba])
        by smtp.googlemail.com with ESMTPSA id q62sm22235827pfi.183.2019.03.12.14.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 14:02:46 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] arm64: dts: meson: g12a: Add UART A, B & C nodes and pins
In-Reply-To: <20190307151342.7381-7-narmstrong@baylibre.com>
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-7-narmstrong@baylibre.com>
Date:   Tue, 12 Mar 2019 14:02:45 -0700
Message-ID: <7hbm2fu7pm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patch adds the 2 UART nodes in the EE power domain with the corresponding
> pinctrl nodes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Similar to PATCH 4/9, are you wanting to move this to the board series?

Kevin

> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 82 +++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index 2a700bb45d04..50e2cd36e08b 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -113,6 +113,61 @@
>  						#gpio-cells = <2>;
>  						gpio-ranges = <&periphs_pinctrl 0 0 86>;
>  					};
> +
> +					uart_a_pins: uart_a {
> +						mux {
> +							groups = "uart_a_tx",
> +								 "uart_a_rx";
> +							function = "uart_a";
> +							bias-disable;
> +						};
> +					};
> +
> +					uart_a_cts_rts_pins: uart_a_cts_rts {
> +						mux {
> +							groups = "uart_a_cts",
> +								 "uart_a_rts";
> +							function = "uart_a";
> +							bias-disable;
> +						};
> +					};
> +
> +					uart_ao_a_c_pins: uart_ao_a_c {
> +						mux {
> +							groups = "uart_ao_a_rx_c",
> +								 "uart_ao_a_tx_c";
> +							function = "uart_ao_a_c";
> +							bias-disable;
> +						};
> +					};
> +
> +					uart_b_pins: uart_b {
> +						mux {
> +							groups = "uart_b_tx",
> +								 "uart_b_rx";
> +							function = "uart_b";
> +							bias-disable;
> +						};
> +					};
> +
> +					uart_c_pins: uart_c {
> +						mux {
> +							groups = "uart_c_tx",
> +								 "uart_c_rx";
> +							function = "uart_c";
> +							bias-disable;
> +						};
> +					};
> +
> +					uart_c_cts_rts_pins: uart_c_cts_rts {
> +						mux {
> +							groups = "uart_c_cts",
> +								 "uart_c_rts";
> +							function = "uart_c";
> +							bias-disable;
> +						};
> +					};
> +				};
>  			};
>  
>  			hiu: bus@3c000 {
> @@ -256,6 +311,33 @@
>  				compatible = "amlogic,meson-g12a-clk-measure";
>  				reg = <0x0 0x18000 0x0 0x10>;
>  			};
> +
> +			uart_C: serial@22000 {
> +				compatible = "amlogic,meson-gx-uart";
> +				reg = <0x0 0x22000 0x0 0x18>;
> +				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
> +
> +			uart_B: serial@23000 {
> +				compatible = "amlogic,meson-gx-uart";
> +				reg = <0x0 0x23000 0x0 0x18>;
> +				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
> +
> +			uart_A: serial@24000 {
> +				compatible = "amlogic,meson-gx-uart";
> +				reg = <0x0 0x24000 0x0 0x18>;
> +				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
>  		};
>  	};
>  
> -- 
> 2.20.1
