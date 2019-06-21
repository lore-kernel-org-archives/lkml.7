Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0820EC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FC72084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="tto/SWz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfFULVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:21:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40175 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfFULVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:21:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so6183429wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 04:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XAz5+1ZugVE5GkUQUctoaFL1CCKytfPvugsjxndG7cg=;
        b=tto/SWz336iwBga4qSfNB9bs/TG22rJdxD0IgYr48cvF+K3ateyntpV/dUlyNZDL61
         ZLmokGp2bumZ7ODNLi9hYawLy0ew4Tk4C8HYpY1KSFzvlUZ0JQy8pe5muHT9SrWzTdQB
         yS9mlZ5DdniDCQDobAj8u4NHQNZWlHRXhQOTnjF6h9uk3/UQGqKgWVLKuVyeh4FolkiB
         XsndbKlT3d5S3p5Tuq6uyLwJrbLlRk6APCom3X6vj3bR+ZP6fvBER+KgTzvkADIwJFj1
         NDW4ZTD04S0vvZS9mhTv5HU6C8OzFt/MmxYbz6ppjN/DcMTLKCClTY084IXbfdw9Vlke
         n89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XAz5+1ZugVE5GkUQUctoaFL1CCKytfPvugsjxndG7cg=;
        b=MCoiIrzlO0URNnX8oOcmS//Zo5Jr6MsCu7CKUORcAkDywS36/yMxu1iABkug5FZaKl
         Nz+WBIhyMDIIQfQOzsgBtwLtgwMbe10LNPCH54QoQXc3VZPBf7X3XTbGgq5AELvaSUTH
         o0Zu8tU+hLfAU/l38+ANkBtM7DECSkSofsIVAx1uRkbiJMmNLIOZQ3x/I2EqawkZIXL+
         601Oiq+LRpd/tKOWl4BpkRJtX3bF29Tl7SBlC8+TTXPU+0AQGrdSTiozURS6YYhis1x6
         qmWq9zGtCncsFBAQRnPgsYxVWpLidUAPtKCo8Sl/SiYGBC12sGv+FY+6Mx4nraQDZKHf
         Y/9Q==
X-Gm-Message-State: APjAAAULgzYD64zqMbwh1Aq+EIQDDhri2hqlGG5dtBt5EBVdfy2fzMIi
        yqEHBRR2RIT7+k8bJ620lojiUzz/OVM3sx4FS5xMAQ==
X-Google-Smtp-Source: APXvYqwCkNmbGI1oEoF6P2VDTiGVGuWQkJhUYyk74HPQNXJGI2qWaNAhuxz1OHfnUA9Lp5z2MnK0iWTp48u7p/OPB3E=
X-Received: by 2002:a1c:2dc2:: with SMTP id t185mr3889348wmt.52.1561116068934;
 Fri, 21 Jun 2019 04:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <1561114429-29612-1-git-send-email-yash.shah@sifive.com> <1561114429-29612-2-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1561114429-29612-2-git-send-email-yash.shah@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 21 Jun 2019 16:50:58 +0530
Message-ID: <CAAhSdy2uuUDkB5wa1FJzBFqDtNi2HBWs-s7G3BhCpwGs=LRohg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, sachin.ghadi@sifive.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 4:27 PM Yash Shah <yash.shah@sifive.com> wrote:
>
> DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver added
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 16 ++++++++++++++++
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  9 +++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> index 4e8fbde..c53b4ea 100644
> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> @@ -225,5 +225,21 @@
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                 };
> +               eth0: ethernet@10090000 {
> +                       compatible = "sifive,fu540-macb";
> +                       interrupt-parent = <&plic0>;
> +                       interrupts = <53>;
> +                       reg = <0x0 0x10090000 0x0 0x2000
> +                              0x0 0x100a0000 0x0 0x1000>;
> +                       reg-names = "control";
> +                       status = "disabled";
> +                       local-mac-address = [00 00 00 00 00 00];
> +                       clock-names = "pclk", "hclk";
> +                       clocks = <&prci PRCI_CLK_GEMGXLPLL>,
> +                                <&prci PRCI_CLK_GEMGXLPLL>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +
>         };
>  };
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 4da8870..d783bf2 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -63,3 +63,12 @@
>                 disable-wp;
>         };
>  };
> +
> +&eth0 {
> +       status = "okay";
> +       phy-mode = "gmii";
> +       phy-handle = <&phy1>;
> +       phy1: ethernet-phy@0 {
> +               reg = <0>;
> +       };
> +};
> --
> 1.9.1
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
