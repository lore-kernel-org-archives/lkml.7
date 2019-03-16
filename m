Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39747C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EE921903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h/+FCESL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfCPOfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:35:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54694 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfCPOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:35:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id f3so9176880wmj.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=WloqzDk5QBr/exoYt0fG/wnmKnIxkG14sEVgXfCaA2U=;
        b=h/+FCESLMYQLtDeMG5i68TXSjeayX/ywB7KM8bWoOk0oqxM8WZgvO5SjckV80OD0UC
         Erq88lRf5vOiQNZ8eZFdPHHargknyi3RJ17a8B1wannYvw3fD+hKeGzuUraYO3j5h5Y0
         5++CvtwnyWjwGk6Ft7lbK910XoP/JzLYC7F1WW1wYPyFSxh0LRwbR30/1HzHtF9Sgl8i
         iTkJ9GyQvOxZaX0YWaCa1VFA+mRRltBv08OX47r2Q0KnjZJmFQ2t7TCB3bVx7EkUCOxH
         X+5iJXMoMxp/HeouuYiqMe5KN3/VXNjh5hJWN30bsnpsLVa4r8r9XczzmPPVTHv34rmf
         Oqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=WloqzDk5QBr/exoYt0fG/wnmKnIxkG14sEVgXfCaA2U=;
        b=gCGOEcfVbu6o/Hh63DCezxTlfkfd6Dsw3ChMTuQrjYjA72QhGjb8pUCG3IHPRhe2tH
         hBjwD1dpXWdv/+Hrku3eBryI1X2siAmEke/8r+9CUNmHwQE76paFs3AzBSe7nfBYK2hE
         r1/aEe8eNx2rredkzkxH3IHix288HOgynVWY4edRHbJbxCoQ1TpjFoBd4nUwGjO37vN0
         NVZz9Vx9gKQtGMWF7XrtvZKWprMjVGdZecORg0Qizpo5UaIulPWdeRyHDxzNC95BW5Nj
         yAGpUnlBsz5MXdfOsGyhrO1vlh5Ij/uyPxvoiNW8V1WQMuHQl4TWQnMPYkYAYODi2FJD
         6G0w==
X-Gm-Message-State: APjAAAWHBKOn2aQeZPlxUAb0Nzp0DBEOuXbO3Z2y05wIAapgf6BmOkEp
        vGdcpk+eSBH6gLFryKgAykOHh5EoHOUCeg==
X-Google-Smtp-Source: APXvYqzBN0lYQVGGuZ/3US6K/t7o1QAOoodGL+SelzbUA3jAKA1ETTZSJIg3ID6HTwtSWqrHmrCz2A==
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr5596862wmh.28.1552746910763;
        Sat, 16 Mar 2019 07:35:10 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id c21sm7058420wre.35.2019.03.16.07.35.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Mar 2019 07:35:10 -0700 (PDT)
Message-ID: <5C8D099D.5020206@baylibre.com>
Date:   Sat, 16 Mar 2019 15:35:09 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/9] arm64: dts: meson: g12a: Add UART A, B & C nodes
 and pins
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-7-narmstrong@baylibre.com> <CAFBinCAa+ZjxJi491_dG+kvLFPLFoLXHFZToGP8W1ECeeqOYVQ@mail.gmail.com>
In-Reply-To: <CAFBinCAa+ZjxJi491_dG+kvLFPLFoLXHFZToGP8W1ECeeqOYVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/03/2019 22:24, Martin Blumenstingl a écrit :
> Hi Neil,
> 
> On Thu, Mar 7, 2019 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> This patch adds the 2 UART nodes in the EE power domain with the corresponding
>> pinctrl nodes.
> there are 3 UART controllers in the EE power domain

Good catch !

> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 82 +++++++++++++++++++++
>>  1 file changed, 82 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> index 2a700bb45d04..50e2cd36e08b 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> @@ -113,6 +113,61 @@
>>                                                 #gpio-cells = <2>;
>>                                                 gpio-ranges = <&periphs_pinctrl 0 0 86>;
>>                                         };
>> +
>> +                                       uart_a_pins: uart_a {
> (this applies to all new nodes)
> we started using dashes for the node names for new pin definitions on
> the GX SoCs.
> I don't remember where it was discussed exactly but I think this was
> requested from Rob

Yes I remember, will fix

> 
> since G12A is a new SoC we should do it "right" from the beginning
> 
> [...]
>> +                                       uart_ao_a_c_pins: uart_ao_a_c {
>> +                                               mux {
>> +                                                       groups = "uart_ao_a_rx_c",
>> +                                                                "uart_ao_a_tx_c";
>> +                                                       function = "uart_ao_a_c";
>> +                                                       bias-disable;
>> +                                               };
>> +                                       };
> I'm fine with this part if you mention it in the subject and/or the description
> uart_ao_a_c routes two pins from bank C (from the EE domain) to the
> uart_AO controller (from the AO domain)

Not sure DT is the right place for that, I think I'll remove this until
we have it actually used somewhere.

> 
>> +                                       uart_b_pins: uart_b {
>> +                                               mux {
>> +                                                       groups = "uart_b_tx",
>> +                                                                "uart_b_rx";
>> +                                                       function = "uart_b";
>> +                                                       bias-disable;
>> +                                               };
>> +                                       };
>> +
>> +                                       uart_c_pins: uart_c {
>> +                                               mux {
>> +                                                       groups = "uart_c_tx",
>> +                                                                "uart_c_rx";
>> +                                                       function = "uart_c";
>> +                                                       bias-disable;
>> +                                               };
>> +                                       };
>> +
>> +                                       uart_c_cts_rts_pins: uart_c_cts_rts {
>> +                                               mux {
>> +                                                       groups = "uart_c_cts",
>> +                                                                "uart_c_rts";
>> +                                                       function = "uart_c";
>> +                                                       bias-disable;
>> +                                               };
>> +                                       };
>> +                               };
>>                         };
>>
>>                         hiu: bus@3c000 {
>> @@ -256,6 +311,33 @@
>>                                 compatible = "amlogic,meson-g12a-clk-measure";
>>                                 reg = <0x0 0x18000 0x0 0x10>;
>>                         };
>> +
>> +                       uart_C: serial@22000 {
>> +                               compatible = "amlogic,meson-gx-uart";
>> +                               reg = <0x0 0x22000 0x0 0x18>;
>> +                               interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
>> +                               clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
> does uart_C really use CLKID_UART1? on GX uart_C uses CLKID_UART2

It seems so :
https://github.com/hardkernel/linux/blob/odroidn2-4.9.y/arch/arm64/boot/dts/amlogic/mesong12a.dtsi#L1020

Neil

> 
> 
> Regards
> Martin
> 
