Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3963C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC33218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sk1vB9wH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCOVYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:24:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42109 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfCOVYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:24:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id m4so8501221oim.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+hW0z2dd1SHc5BKAuV0zrVmjtjnG3YL5VMfmXJlZUpc=;
        b=sk1vB9wHXD2wI//jjdDtEMLS0YilpbyGqfZkBdHDpPTDkSkG5BcNBdeysHIKDx7C/E
         nbyz/M7jt5xImNZ3YXHGXL6DALiVhaDrn39unzJQrc9OsIH31TS10PgbtjiUPMVIeYes
         KmdFYBnV7jeqeGn958jCa5C+7cOzx4L5intlt4cp5iGBIgVQpGDP9Do2Ze80SpVU81vF
         znO5yFYOzzarVraTzlfdjHGKTpjVFUIQNNdEmp16hDG3zj2UZPiuH+X8L4avoZiggpvp
         T1zULdRvt6U4qOkncEfdbny/Ihe17fud3C0Xtv6sJ0xOBYZ03otDrnQerVSvfTzDucoL
         P/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hW0z2dd1SHc5BKAuV0zrVmjtjnG3YL5VMfmXJlZUpc=;
        b=folkQSGh8wCtjMwp/tfa9SqfQGyLkhGRwfYrcuGciwhIyzuHc/CJVmtrSqV4RRc5/9
         cZB/p06vpT7s+4mL9Jw6aLhngptSz510WrWNfegCm7H5DyM6+7//wjfpAww/cU5uuO7o
         90azrGpglmRyHBwTLlaHa37ZXMR68sNT4Zl6byZ9qIzlg3vWzW6z/jPucJKaBPjW9Ru5
         d+mf5AoibMeYFV7fgMH8fROe4ILBlWFB19GzYVgSXKwb+ocjAO9fTxuELH1mniEuUdXe
         quy6DDbVSHHgauIUmNozdR7jbX0j4gUNkkHbiNd2tDCEEYriat64x9o+yY3x9dUGpG+O
         Gaqg==
X-Gm-Message-State: APjAAAXmxrwcBz//Ng7fdd6ZA7GGSDSKaEBylEQb7SfgG53ConFuK/LS
        py5MOJzeHkvF9I57x8MWg30lYh18P7PbJ3YbEzMBI0SA
X-Google-Smtp-Source: APXvYqyTSgAtWjpuD6HYTr726bLg4oaK0jMZ6W/z0kpuIXXQUWcHXBsdSm65lvHI1oaMA4/tWR/+MnTKyXY/vE4qe74=
X-Received: by 2002:aca:6209:: with SMTP id w9mr2934595oib.47.1552685093538;
 Fri, 15 Mar 2019 14:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-7-narmstrong@baylibre.com>
In-Reply-To: <20190307151342.7381-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 22:24:42 +0100
Message-ID: <CAFBinCAa+ZjxJi491_dG+kvLFPLFoLXHFZToGP8W1ECeeqOYVQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] arm64: dts: meson: g12a: Add UART A, B & C nodes and pins
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Mar 7, 2019 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This patch adds the 2 UART nodes in the EE power domain with the corresponding
> pinctrl nodes.
there are 3 UART controllers in the EE power domain

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 82 +++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index 2a700bb45d04..50e2cd36e08b 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -113,6 +113,61 @@
>                                                 #gpio-cells = <2>;
>                                                 gpio-ranges = <&periphs_pinctrl 0 0 86>;
>                                         };
> +
> +                                       uart_a_pins: uart_a {
(this applies to all new nodes)
we started using dashes for the node names for new pin definitions on
the GX SoCs.
I don't remember where it was discussed exactly but I think this was
requested from Rob

since G12A is a new SoC we should do it "right" from the beginning

[...]
> +                                       uart_ao_a_c_pins: uart_ao_a_c {
> +                                               mux {
> +                                                       groups = "uart_ao_a_rx_c",
> +                                                                "uart_ao_a_tx_c";
> +                                                       function = "uart_ao_a_c";
> +                                                       bias-disable;
> +                                               };
> +                                       };
I'm fine with this part if you mention it in the subject and/or the description
uart_ao_a_c routes two pins from bank C (from the EE domain) to the
uart_AO controller (from the AO domain)

> +                                       uart_b_pins: uart_b {
> +                                               mux {
> +                                                       groups = "uart_b_tx",
> +                                                                "uart_b_rx";
> +                                                       function = "uart_b";
> +                                                       bias-disable;
> +                                               };
> +                                       };
> +
> +                                       uart_c_pins: uart_c {
> +                                               mux {
> +                                                       groups = "uart_c_tx",
> +                                                                "uart_c_rx";
> +                                                       function = "uart_c";
> +                                                       bias-disable;
> +                                               };
> +                                       };
> +
> +                                       uart_c_cts_rts_pins: uart_c_cts_rts {
> +                                               mux {
> +                                                       groups = "uart_c_cts",
> +                                                                "uart_c_rts";
> +                                                       function = "uart_c";
> +                                                       bias-disable;
> +                                               };
> +                                       };
> +                               };
>                         };
>
>                         hiu: bus@3c000 {
> @@ -256,6 +311,33 @@
>                                 compatible = "amlogic,meson-g12a-clk-measure";
>                                 reg = <0x0 0x18000 0x0 0x10>;
>                         };
> +
> +                       uart_C: serial@22000 {
> +                               compatible = "amlogic,meson-gx-uart";
> +                               reg = <0x0 0x22000 0x0 0x18>;
> +                               interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
> +                               clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
does uart_C really use CLKID_UART1? on GX uart_C uses CLKID_UART2


Regards
Martin
