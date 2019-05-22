Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B16C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871232173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="LfaGikSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfEVQcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:32:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46100 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfEVQcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:32:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id l26so2154307lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qThinqX735sf8pV9gEurKexsu6v0KDCesOpmYS6C1nU=;
        b=LfaGikSQzkfp3MTtTD2riyljAlYtgygqiQ76isa3QiDIAdNTkg9Psw2gEp57lgcaC9
         hXjQYzoyg9a+kq67pScg7J/emNvgOW+2y1jaoct/Ur1ocYSI/5NGNGEnCvBMlFnuc8qM
         lqKrn9Z35znXep5iHwzzV/gWqSWLC03boR0VrVXI/ZZAxTHijH+tSNR77NkL0BQmma0J
         UlJBJA2OYAQDSaD24DiicMLJe5rNn8y7PyzLUjbfBzxl+K90QZJntGOyARexDhDr8VY9
         s5FIGIA2dcOxR+igryXgPdS8i7Ypz9fLC10KN/KPb79JvSeIzU9NX9xqEZI5E8OhqCPa
         86lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qThinqX735sf8pV9gEurKexsu6v0KDCesOpmYS6C1nU=;
        b=DRuvem3zy33DyulEVYnp7ch15c0M/uJNGWwQ2GGd5T8zxaZYe/ZuV6XShwInLrE4co
         WWel7RXIg7bshv/7mFHSKhlI8g8ZeNp/45jEYkrx+wZojYulKC8IfAsvI7qgLk9+qbou
         ZhSSNnDhpX6HLwGPsoefc7vUW1lKXRch607waaiZVwVBVYcS4UA0SwmoT1Omt1oqMb3m
         sSEgPkE5gSlJ+MkpCS6bbRyk8++QvB5XWq9s/H2Fd2/ffgnoIkfpRCyliAQFLORCllp6
         oUdaxNOxQfMJs1WqNXPJGW5qdYT5N691ECr8OSoT0W2t4t1DVDx4v9P3Em4goJd+6gUS
         pzww==
X-Gm-Message-State: APjAAAWX2mHCsv9X9LLtT79eYWaym78ATUKbPER3OGryIk+iQF53TcaM
        chyH5CuQPeUNavlC5Z+afdC29w==
X-Google-Smtp-Source: APXvYqz93Mn96ebEH/DifbwBhBmr7sSu/xHP7uqRK6cUNes/iTbCorNF+sUo3nfTvqTFfsHOIWVLUA==
X-Received: by 2002:ac2:4213:: with SMTP id y19mr35566420lfh.66.1558542727839;
        Wed, 22 May 2019 09:32:07 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.14])
        by smtp.gmail.com with ESMTPSA id x16sm5367958lji.3.2019.05.22.09.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 09:32:07 -0700 (PDT)
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     masonccyang@mxic.com.tw, Geert Uytterhoeven <geert@linux-m68k.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, zhengxunli@mxic.com.tw,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus>
 <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell>
 <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell>
 <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
 <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com>
 <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
 <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com>
 <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw>
 <b51d1cb7-b3b5-208f-ab4c-145ecb57805d@cogentembedded.com> <OFAD9AA573.86373
 <44bc8f0a-cbdc-db4a-9a46-b8bae5cc37a2@cogentembedded.com>
 <OF5AF00898.3CE87C98-ON48258400.00259B16-48258400.0028A4F5@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <5e718d9f-3aeb-c2ef-0723-400497b2b98f@cogentembedded.com>
Date:   Wed, 22 May 2019 19:32:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OF5AF00898.3CE87C98-ON48258400.00259B16-48258400.0028A4F5@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/20/2019 10:23 AM, masonccyang@mxic.com.tw wrote:

>>>>> -------------------------------------------------------------->
>>>>>
>>>>> Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>>>>> ---------------------------------------------------------
>>>>>
>>>>>   RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
>>>>>
>>>>>   Required properties:
>>>>>   - compatible: should be an SoC-specific compatible value, followed 
> 
>>> by
>>>>>                   "renesas,rcar-gen3-rpc" as a fallback.
>>>>>                   supported SoC-specific values are:
>>>>>                   "renesas,r8a77995-rpc"  (R-Car D3)
>>>>>   - reg: should contain three register areas:
>>>>>           first for the base address of RPC-IF registers,
>>>>
>>>>    I'd drop "the base address" here.
>>>
>>> okay.
>>>
>>>>>           second for the direct mapping read mode and
>>>>>           third for the write buffer area.
>>>>>   - reg-names: should contain "regs", "dirmap" and "wbuf"
>>>>>   - clocks: should contain 1 entries for the module's clock
>>>>>   - clock-names: should contain "rpc"
>>>>
>>>>    I suspect we'd need the RPC/RPCD2 clocks mentioned as well (not 
> sure 
>>> yet)...
>>>
>>> Need it ?
>>
>>    You seem to call clk_get_rate() on the module clock, I doubt that's
>> correct topologically...

   clk_set_rate(), sorry.

> 
> I think it's correct but just like Geert mentioned that there is no any 
> patch
> in drivers/clk/renesas/r8a77995-cpg-mssr.c adding RPC-related clocks.
> 
> 
> I patched dt-bindings/clock/r8a77995-cpg-mssr.h for some simple testing
> 
> -#define R8A77995_CLK_RPC               29
> -#define R8A77995_CLK_RPCD2             30
> +#define R8A77995_CLK_RPC               31
> +#define R8A77995_CLK_RPCD2             32

   Hm, what does this do?

> by clk_prepare_enable() & clk_disable_unprepare() with CPG_MOD 917 
> on D3 draak board, it is working fine.

>>>>>   - SPI mode:git
>>>>>
>>>>>           rpc: rpc-if@ee200000 {
>>>>
>>>>    The node names should be generic, based on the device class. And in 
>>>> this
>>>> case I'd like to use "spi@ee200000" as otherwise dtc keeps bitching like 
>>>> below:
>>>
>>> okay, patch to
>>>
>>> rpc_if: spi@<...>
>>
>>    That, or just keep the node label.
> 
> okay.
> 
>>>>>   - HF mode:
>>>>>           rpc: rpc-if@ee200000 {
>>>>
>>>>    Again, spi@<...>.
>>>
>>> what about rpc_if: hf@<...>
>>
>>    Can't change the node name, as it's declared in the .dtsi files, not *.dts
>> ones. And "spi" works for the HF case as well -- no complaints from dtc. 
> :-)

   Maybe it's possible using the "name" prop, don't know...

> okay,
>  
> Patch DTS to
> ===============================================================> 
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +---------------------------------------------------------
> +
> +RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +                                "renesas,rcar-gen3-rpc" as a fallback.
> +                                supported SoC-specific values are:
> +                                "renesas,r8a77995-rpc"          (R-Car 
> D3)
> +- reg: should contain three register areas:
> +                first for RPC-IF registers,
> +                second for the direct mapping read mode and
> +                third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain 1 entries for the module's clock

   1 entry (clock node phandle and specifier).

> +- clock-names: should contain "rpc"
> +- power-domains: should contain system-controller(sysc) for 
> power-domain-cell

   What's "power-domain-cell"? I know "#power-domain-cells". I'd like this
to be "the power domain node's phandle and specifier".

> +- resets: should contain clock pulse generator(cpg) for reset-cell,

   It's "#reset-cells" again. I'd like this to be "the reset node's phandle
and specifier".

> +                  power-domain-cell and clock-cell

   Why mntion clock-cell at all here?

> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +
> +Example:
> +- SPI mode:
> +
> +                rpc: spi@ee200000 {
> +                                compatible = "renesas,r8a77995-rpc", 
> "renesas,rcar-gen3-rpc";
> +                                reg = <0 0xee200000 0 0x200>, <0 
> 0x08000000 0 0x4000000>,
> +                                      <0 0xee208000 0 0x100>;
> +                                reg-names = "regs", "dirmap", "wbuf";
> +                                clocks = <&cpg CPG_MOD 917>;
> +                                clock-names = "rpc";
> +                                power-domains = <&sysc 
> R8A77995_PD_ALWAYS_ON>;
> +                                resets = <&cpg 917>;
> +                                #address-cells = <1>;
> +                                #size-cells = <0>;
> +
> +                                flash@0 {
> +                                                compatible = 
> "jedec,spi-nor";
> +                                                reg = <0>;
> +                                                spi-max-frequency = 
> <40000000>;
> +                                                spi-tx-bus-width = <1>;
> +                                                spi-rx-bus-width = <1>;
> +                                };
> +                };
> +
> +- HF mode:

   HyperFlash, please.

> +                rpc: spi@ee200000 {
> +                                compatible = "renesas,r8a77995-rpc", 
> "renesas,rcar-gen3-rpc";
> +                                reg = <0 0xee200000 0 0x200>, <0 
> 0x08000000 0 0x4000000>,
> +                                      <0 0xee208000 0 0x100>;
> +                                reg-names = "regs", "dirmap", "wbuf";
> +                                clocks = <&cpg CPG_MOD 917>;
> +                                clock-names = "rpc";
> +                                power-domains = <&sysc 
> R8A77995_PD_ALWAYS_ON>;
> +                                resets = <&cpg 917>;
> +                                #address-cells = <1>;
> +                                #size-cells = <0>;

   And I don't think duplicating the same device node is a good idea...

> +                                flash@0 {
> +                                                compatible = 
> "cypress,hyperflash", "cfi-flash";
> +                                                reg = <0>;
> +                                };
> +                };
> ===============================================================<
> 
> thanks & best regards,
> Mason
[...]

MBR, Sergei
