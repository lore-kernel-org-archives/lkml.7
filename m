Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2950C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA6A2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jPqr/6Ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfGSLx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:53:58 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46099 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbfGSLx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:53:58 -0400
Received: by mail-vs1-f66.google.com with SMTP id r3so21305551vsr.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 04:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biEayFt+VruGovDKa3i0LGzkhdkRNPx2sXZYzz56x6U=;
        b=jPqr/6Mlm/0/pJK4JP6UC30mDBqkzqAztFJLe3h+6SEe9YMj5ao3HwyrxaIM5Bv4Ra
         Bm7CWyGDK5+SDHUfZKyKuOTqcThuTd9f70KeCl6i+fIOVRu6g20omrBGnh2w5ewzSRg4
         e23Kq9iizjeG0J3cvawImzFPyq4DEE8PIGHwfdYUXfNzAEoU/ByIxdEE4YDY1IuddtZw
         cNfgleAGWH3pXzl8fAsg/ybtoC2hNcAcNaTVgKxsZPMlyMxtvOmmsDp50Ylj1uDvUu5t
         RrSZrj7JilYo1igG+dDX3fv2pCd28LpZMUDQkq7bxHxli/lwPPAqyyvqfnW53jnclsV8
         fVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biEayFt+VruGovDKa3i0LGzkhdkRNPx2sXZYzz56x6U=;
        b=iBrCNh9lhnlaKIDZGdHwJuArkbXGqG4Xr1dw0BlQuq6HX7pP3pbsco7gRVUKUVNXQp
         XbZHiGt9AbNKfdWL0Zpda67hPqr7pTMvS4FD+vkhG8u7ZUhFsAQtUQnHznaQ+/JN8fIV
         /9qXJ2ye+qBt3AiAyec/O8n4IB50LyrCZOzvcd6i6jM4e6Fht2kM+UrlMjUqEsRF36+R
         t3rwPOcMN8SMQ+yJINy+OAJ26Cwadpy5v5wuaDo+LCCzZ8vkX8wFWeX/Pd1TNkWkupaQ
         s74QSFh1Bv5UanhjSn5dicXZo7kTXreCVuwNFaph9NrJjmWKTf8L8Wwv0BkB01WjV4qt
         Ul7w==
X-Gm-Message-State: APjAAAUkHYlR/tF66OFwCyNu++yy8QYZuDRwAR8L4RL0esqRI8pBKEPe
        BxFMa49NE5DRhrG0YejgtY/Q3dUBo2HWu8JDytLUUg==
X-Google-Smtp-Source: APXvYqwWYrFQyvu6/xqxMA02acIpkSbnOTgebtxdq98QYxw/X8cgoILh6soRL04ZOIZlo8DcDFZfelQM0P8zJtJqS2Q=
X-Received: by 2002:a67:300f:: with SMTP id w15mr27551944vsw.116.1563537237115;
 Fri, 19 Jul 2019 04:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <1563534631-15897-1-git-send-email-yash.shah@sifive.com> <1563534631-15897-3-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1563534631-15897-3-git-send-email-yash.shah@sifive.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Fri, 19 Jul 2019 17:23:45 +0530
Message-ID: <CAARK3H=D1N8gO0Z82_MCtgr5DtT1=E0wzYbn-y451ASgxV-qBg@mail.gmail.com>
Subject: Re: [PATCH 3/3] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
To:     Yash Shah <yash.shah@sifive.com>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        nicolas.ferre@microchip.com,
        Sachin Ghadi <sachin.ghadi@sifive.com>, ynezz@true.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series looks good to me.

Reviewed-by: Sagar Kadam <sagar.kadam@sifive.com>

On Fri, Jul 19, 2019 at 4:41 PM Yash Shah <yash.shah@sifive.com> wrote:
>
> DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver added
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 15 +++++++++++++++
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  9 +++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> index cc73522..588669f0 100644
> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> @@ -231,5 +231,20 @@
>                         #size-cells = <0>;
>                         status = "disabled";
>                 };
> +               eth0: ethernet@10090000 {
> +                       compatible = "sifive,fu540-c000-gem";
> +                       interrupt-parent = <&plic0>;
> +                       interrupts = <53>;
> +                       reg = <0x0 0x10090000 0x0 0x2000
> +                              0x0 0x100a0000 0x0 0x1000>;
> +                       local-mac-address = [00 00 00 00 00 00];
> +                       clock-names = "pclk", "hclk";
> +                       clocks = <&prci PRCI_CLK_GEMGXLPLL>,
> +                                <&prci PRCI_CLK_GEMGXLPLL>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
>         };
>  };
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 0b55c53..85c17a7 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -76,3 +76,12 @@
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
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
