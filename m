Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671B1C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC782070A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575383490;
	bh=paDjy7hZsmQkcUp7jKSH70ftPLffSgdTsEFpUetgz24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LmHpNAuTjpUEwU76UYt5+wFJlrlB0Nd7Co1c4QQhSfVbCg1z8ebysfKzc4mdkE3Xf
	 g1j4apbH75mgob2Fkr024uUPH0PM3vJi+WYL83JqgmlhF9AXbh/JBhCaWI/jKdcCGs
	 BiIp2le4mHFJ0HGbXsv5f1UznAfRb8XC5ipR/5fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfLCOb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:31:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfLCOb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:31:28 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 488E220659;
        Tue,  3 Dec 2019 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575383487;
        bh=paDjy7hZsmQkcUp7jKSH70ftPLffSgdTsEFpUetgz24=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KZ3PkNnslqc7BEkuj8s892JHiyp111mpjo13oyKF2LEIsAAcH/hc5JifebD94uck3
         nvVaUSye1Jaz8ajRoUANeZarO5PaXCebynHCFsWg9UsJyvHq5vbTBbBh+fkKJlWy4n
         ygD9D5lhomlPo1jbX8Cgfpm0LyJHYR996Q4klzU0=
Received: by mail-qv1-f44.google.com with SMTP id o18so1579749qvf.1;
        Tue, 03 Dec 2019 06:31:27 -0800 (PST)
X-Gm-Message-State: APjAAAX6siZ28IpYyeoB3c/o2qRLnuo9Wg30ZnPj1yXqUYOrwEaagzCE
        U9MCCDpKb2WB+zZn94r4sH/h7CZZ61hN5lHs1A==
X-Google-Smtp-Source: APXvYqxDBnGQNKjTk3qSKKiOvMvxPKQPV7m6ur08FqhiSl9j9w8DAHBF3481M9puWdGG8hXS2X7yJKuiKlMAjUfp4E0=
X-Received: by 2002:a05:6214:11ac:: with SMTP id u12mr5420247qvv.85.1575383483847;
 Tue, 03 Dec 2019 06:31:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
 <3da2492c244962c27b21aad87bfa6bf74f568f1d.1575376664.git-series.andrew@aj.id.au>
In-Reply-To: <3da2492c244962c27b21aad87bfa6bf74f568f1d.1575376664.git-series.andrew@aj.id.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Dec 2019 08:31:10 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+3qXJbTu9G42g11PLJH-A0XeSQmJKj0obO32QFna3dEA@mail.gmail.com>
Message-ID: <CAL_Jsq+3qXJbTu9G42g11PLJH-A0XeSQmJKj0obO32QFna3dEA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: ipmi: aspeed: Introduce a v2 binding for KCS
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     openipmi-developer@lists.sourceforge.net,
        Corey Minyard <minyard@acm.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 6:36 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The v2 binding utilises reg and renames some of the v1 properties.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt | 20 +++++---
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
> index d98a9bf45d6c..76b180ebbde4 100644
> --- a/Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
> +++ b/Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
> @@ -1,9 +1,10 @@
> -* Aspeed KCS (Keyboard Controller Style) IPMI interface
> +# Aspeed KCS (Keyboard Controller Style) IPMI interface
>
>  The Aspeed SOCs (AST2400 and AST2500) are commonly used as BMCs
>  (Baseboard Management Controllers) and the KCS interface can be
>  used to perform in-band IPMI communication with their host.
>
> +## v1
>  Required properties:
>  - compatible : should be one of
>      "aspeed,ast2400-kcs-bmc"
> @@ -12,14 +13,21 @@ Required properties:
>  - kcs_chan : The LPC channel number in the controller
>  - kcs_addr : The host CPU IO map address
>
> +## v2
> +Required properties:
> +- compatible : should be one of
> +    "aspeed,ast2400-kcs-bmc-v2"
> +    "aspeed,ast2500-kcs-bmc-v2"
> +- reg : The address and size of the IDR, ODR and STR registers
> +- interrupts : interrupt generated by the controller
> +- slave-reg : The host CPU IO map address

aspeed,slave-reg

>
>  Example:
>
> -    kcs3: kcs3@0 {
> -        compatible = "aspeed,ast2500-kcs-bmc";
> -        reg = <0x0 0x80>;
> +    kcs3: kcs@24 {
> +        compatible = "aspeed,ast2500-kcs-bmc-v2";
> +        reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;

What are the other registers in this address space? I'm not so sure
this is an improvement if you end up with a bunch of nodes with single
registers.

>          interrupts = <8>;
> -        kcs_chan = <3>;
> -        kcs_addr = <0xCA2>;
> +        slave-reg = <0xca2>;
>          status = "okay";
>      };
> --
> git-series 0.9.1
