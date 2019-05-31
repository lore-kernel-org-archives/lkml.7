Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5E1C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313142685A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvbFz7kI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEaLkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 07:40:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35152 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEaLkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 07:40:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id h11so9322648ljb.2;
        Fri, 31 May 2019 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nPmul1q9AAucCoI9yY3uJOYKaMzqR7bEf/iEX/aqjE=;
        b=bvbFz7kIlrTImz4Is9rlZJVgVwodHyMIKxGHokBpzd3jyqtrT+N3NzxY7rOqC0jweG
         DSMZZjQ+lcwWYldWhwcDc6MDUtSmWwU3lgIaW3V5IyaiIDgkEjIvhuCYGUTr8M0RXuNc
         O0fzNTX5I8oSooPoLDLs8veC2SMwcgA6oTQ+UL8SCdBdiEoIVyFPp0IdTRROhpyNeEUv
         A412MMiyx1SG8fEtAf6TQL1kE94zOSIAiATRg50MnYQ2Ik19C6EtVxcBkBP8ZtR7diXt
         L9XnCkcFed8oQ1GOfN+jt5Xvm9HOqpOQ6rHsp4ZVcmffoJmFb6KLq7aIIXjJo1M84mUf
         Waxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nPmul1q9AAucCoI9yY3uJOYKaMzqR7bEf/iEX/aqjE=;
        b=DXmctQ/mUZ5nusAS6ZR28aP0A2G2+YM9Ta2vQNS/FtOrH3pMxdmo1pcKm7C1+EG+cB
         MLffxEltpQV0RZmO333LJFBF08e7Yytn6YFJ1x4tjO8EbKVYN/KqdKtKy7uFXbzQ3ifu
         Lt+51ZmyNxXSE9HdOmrXRq+Z3wVfMnqlTYBf0OIPu8xRy1Gyxo4yxwQCDh+4AsHl5KcR
         z+Y63LCkI2kuecRp9DtaCBye+aUQ7iq2zD8lnGGTPdlgZbh3bpUB3nzMuQaOKAvTNNqk
         9sYQaI6uAFMEPs768yMAFo6iB/gF8Pgq6PMvvZVdK2o0K4Q8PYhiOQLVUv+wRqVLe/cC
         WTyQ==
X-Gm-Message-State: APjAAAUXouDIqFENC7G0/9T73Rz11XQH2XROeH03ZTfC7yngH/fnshBR
        zfflQgottKmqym+/+ufgVYVd5tDN+tjlIiXAGQU=
X-Google-Smtp-Source: APXvYqyCAo8ow6MnnWWOBWsq1Cm0GTfIZYIH3tTY29CEmrrLVa3t2AA8hrgydqxU4pH85ptW2LRQNyKxfPY6IS4halk=
X-Received: by 2002:a2e:890c:: with SMTP id d12mr5463170lji.107.1559302798500;
 Fri, 31 May 2019 04:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190530094706.865-1-Anson.Huang@nxp.com> <20190530094706.865-2-Anson.Huang@nxp.com>
In-Reply-To: <20190530094706.865-2-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 31 May 2019 08:39:49 -0300
Message-ID: <CAOMZO5D1B1tKs8eu_a8hXs193+TukHAYHiCEyk5g63p1S-cnbg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add i.MX8MN dtsi support
To:     Yongcai Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Ping Bai <ping.bai@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, pankaj.bansal@nxp.com,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 6:45 AM <Anson.Huang@nxp.com> wrote:

> +                       gpio1: gpio@30200000 {
> +                               compatible = "fsl,imx8mn-gpio", "fsl,imx35-gpio";
> +                               reg = <0x30200000 0x10000>;
> +                               interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +                                            <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;

No GPIO clocks entries?

> +                       usbphynop1: usbphynop1 {
> +                               compatible = "usb-nop-xceiv";
> +                               clocks = <&clk IMX8MN_CLK_USB_PHY_REF>;
> +                               assigned-clocks = <&clk IMX8MN_CLK_USB_PHY_REF>;
> +                               assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_100M>;
> +                               clock-names = "main_clk";
> +                       };

 usbphynop1 does not have any registers associated, so it should be
placed outside the soc.

Building with W=1 should warn you about that.

> +                       usbphynop2: usbphynop2 {
> +                               compatible = "usb-nop-xceiv";
> +                               clocks = <&clk IMX8MN_CLK_USB_PHY_REF>;
> +                               assigned-clocks = <&clk IMX8MN_CLK_USB_PHY_REF>;
> +                               assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_100M>;
> +                               clock-names = "main_clk";
> +                       };
> +

Ditto
