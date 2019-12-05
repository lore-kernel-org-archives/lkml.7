Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF379C2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E21224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575568251;
	bh=IEqN5jALA/tA1YwYPL5ex66SSXu8AQtHWEUKdGhqRN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u1wKcfA+UM1vCrOY7wZbckeyXNfWuoobtQSTKj+q/872cAWCdbhlb8/llIdMgACFa
	 78rzO5rbbmLIQOAhjp1fiwQ+IizORP0BqfR4VHdGckq7K4HWNgPFsGhRgcWFFaRGhm
	 cHoWBGUsFpQo0VBGu449KTSW0FeQxbBqrT8ZK56E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfLERuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730003AbfLERuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:50:50 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 338D7224F8;
        Thu,  5 Dec 2019 17:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575568249;
        bh=IEqN5jALA/tA1YwYPL5ex66SSXu8AQtHWEUKdGhqRN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jv3ZvTVd98uAIGB6m+6El9AuZjrji4nvWOsrKMNDD8TiCO5nT87xnA3Yf1QeziTxN
         lk5rB0wL3h59uQ5dhlTyHfKZ30ogmZebK3SrY2JPBgIediOyDtZPGo0FWQSZ4cDplx
         RsASs/RLUC1ViKTYH7YovnPzW8ckzMXRL5RuTDgg=
Received: by mail-qv1-f45.google.com with SMTP id y8so1605386qvk.6;
        Thu, 05 Dec 2019 09:50:49 -0800 (PST)
X-Gm-Message-State: APjAAAXlNAYAE925RqL7cD/HeD+VNLzuIa1l++epG0vzSmkFKNgiQSia
        bLB/omhMpO0MW6LJl4Hk5G94dZu0sXGwZH+Cfg==
X-Google-Smtp-Source: APXvYqxvPvfcZUTfd2X07Gu3YCHbfqmczpAcwIz+b4jGQZwl3ynTJkYLAYgYk4otbiDmIz2Cwk7T274xtOb2NDzSwfs=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr8183566qvu.136.1575568248163;
 Thu, 05 Dec 2019 09:50:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
 <3da2492c244962c27b21aad87bfa6bf74f568f1d.1575376664.git-series.andrew@aj.id.au>
 <CAL_Jsq+3qXJbTu9G42g11PLJH-A0XeSQmJKj0obO32QFna3dEA@mail.gmail.com> <40d554c0-de62-4d45-bbcc-dd3a3aa12a65@www.fastmail.com>
In-Reply-To: <40d554c0-de62-4d45-bbcc-dd3a3aa12a65@www.fastmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 5 Dec 2019 11:50:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLgmU8m-zT8-K=peENshJx7Gx2Hn9RoZ-zbnqLUmqBQpw@mail.gmail.com>
Message-ID: <CAL_JsqLgmU8m-zT8-K=peENshJx7Gx2Hn9RoZ-zbnqLUmqBQpw@mail.gmail.com>
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

On Wed, Dec 4, 2019 at 11:12 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Wed, 4 Dec 2019, at 01:01, Rob Herring wrote:
> > On Tue, Dec 3, 2019 at 6:36 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > The v2 binding utilises reg and renames some of the v1 properties.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt | 20 +++++---
> > >  1 file changed, 14 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
> > > index d98a9bf45d6c..76b180ebbde4 100644
> > > --- a/Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
> > > +++ b/Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
> > > @@ -1,9 +1,10 @@
> > > -* Aspeed KCS (Keyboard Controller Style) IPMI interface
> > > +# Aspeed KCS (Keyboard Controller Style) IPMI interface
> > >
> > >  The Aspeed SOCs (AST2400 and AST2500) are commonly used as BMCs
> > >  (Baseboard Management Controllers) and the KCS interface can be
> > >  used to perform in-band IPMI communication with their host.
> > >
> > > +## v1
> > >  Required properties:
> > >  - compatible : should be one of
> > >      "aspeed,ast2400-kcs-bmc"
> > > @@ -12,14 +13,21 @@ Required properties:
> > >  - kcs_chan : The LPC channel number in the controller
> > >  - kcs_addr : The host CPU IO map address
> > >
> > > +## v2
> > > +Required properties:
> > > +- compatible : should be one of
> > > +    "aspeed,ast2400-kcs-bmc-v2"
> > > +    "aspeed,ast2500-kcs-bmc-v2"
> > > +- reg : The address and size of the IDR, ODR and STR registers
> > > +- interrupts : interrupt generated by the controller
> > > +- slave-reg : The host CPU IO map address
> >
> > aspeed,slave-reg
>
> I don't agree, as it's not an aspeed-specific behaviour. This property
> controls where the device appears in the host's LPC IO address space,
> which is a common problem for any LPC IO device exposed by the BMC
> to the host.

Then document it as such. Common properties go into common binding documents.

> > >  Example:
> > >
> > > -    kcs3: kcs3@0 {
> > > -        compatible = "aspeed,ast2500-kcs-bmc";
> > > -        reg = <0x0 0x80>;
> > > +    kcs3: kcs@24 {
> > > +        compatible = "aspeed,ast2500-kcs-bmc-v2";
> > > +        reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;
> >
> > What are the other registers in this address space? I'm not so sure
> > this is an improvement if you end up with a bunch of nodes with single
> > registers.
>
> Put into practice the bindings give the following patch: on the AST2500:

Okay, that's an unfortunate interleaving, but seems fine.

>
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index e8feb8b66a2f..5d51f469cbf0 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -399,22 +399,22 @@
>                                         #size-cells = <1>;
>                                         ranges = <0x0 0x0 0x80>;
>
> -                                       kcs1: kcs1@0 {
> -                                               compatible = "aspeed,ast2500-kcs-bmc";
> +                                       kcs1: kcs@24 {
> +                                               compatible = "aspeed,ast2500-kcs-bmc-v2";
> +                                               reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;
>                                                 interrupts = <8>;
> -                                               kcs_chan = <1>;
>                                                 status = "disabled";
>                                         };
> -                                       kcs2: kcs2@0 {
> -                                               compatible = "aspeed,ast2500-kcs-bmc";
> +                                       kcs2: kcs@28 {
> +                                               compatible = "aspeed,ast2500-kcs-bmc-v2";
> +                                               reg = <0x28 0x1>, <0x34 0x1>, <0x40 0x1>;
>                                                 interrupts = <8>;
> -                                               kcs_chan = <2>;
>                                                 status = "disabled";
>                                         };
> -                                       kcs3: kcs3@0 {
> -                                               compatible = "aspeed,ast2500-kcs-bmc";
> +                                       kcs3: kcs@2c {
> +                                               compatible = "aspeed,ast2500-kcs-bmc-v2";
> +                                               reg = <0x2c 0x1>, <0x38 0x1>, <0x44 0x1>;
>                                                 interrupts = <8>;
> -                                               kcs_chan = <3>;
>                                                 status = "disabled";
>                                         };
>                                 };
> @@ -428,10 +428,10 @@
>                                         #size-cells = <1>;
>                                         ranges = <0x0 0x80 0x1e0>;
>
> -                                       kcs4: kcs4@0 {
> -                                               compatible = "aspeed,ast2500-kcs-bmc";
> +                                       kcs4: kcs@94 {
> +                                               compatible = "aspeed,ast2500-kcs-bmc-v2";
> +                                               reg = <0x94 0x1>, <0x98 0x1>, <0x9c 0x1>;
>                                                 interrupts = <8>;
> -                                               kcs_chan = <4>;
>                                                 status = "disabled";
>                                         };
>
> The aim is to fix these warnings which appear for every aspeed-based devicetree:
>
>         arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unit_address_vs_reg): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs1@0: node has a unit name, but no reg property
>         arch/arm/boot/dts/aspeed-g5.dtsi:382.19-387.8: Warning (unit_address_vs_reg): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs2@0: node has a unit name, but no reg property
>         arch/arm/boot/dts/aspeed-g5.dtsi:388.19-393.8: Warning (unit_address_vs_reg): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs3@0: node has a unit name, but no reg property
>         arch/arm/boot/dts/aspeed-g5.dtsi:405.19-410.8: Warning (unit_address_vs_reg): /ahb/apb/lpc@1e789000/lpc-host@80/kcs4@0: node has a unit name, but no reg property
>         arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs1@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs2@0)
>         arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs1@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs3@0)
>         arch/arm/boot/dts/aspeed-g5.dtsi:382.19-387.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs2@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs3@0)
>         arch/arm/boot/dts/aspeed-g5.dtsi:405.19-410.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-host@80/kcs4@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-host@80/lpc-ctrl@0)
>
> Andrew
