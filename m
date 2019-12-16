Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9218C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773EC2176D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="UTOAgPsO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gSN3UzMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLPTpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:45:14 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:41765 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbfLPTpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:45:14 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 466455D4D;
        Mon, 16 Dec 2019 14:45:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 16 Dec 2019 14:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=D
        jvFrxDSCUB8eHUxPxhWbB5MN/QXEIpJKqGs29bik/g=; b=UTOAgPsOjSc+PDzq2
        TbV6VqaDsig1q/9HC0HZls8uW/UfF92M6kz8uVaYweaShAQ86mt3HUi+6xgIBtSS
        IN81PFgUCVp1R4u/b+GbHcnrbQ+BNhlcz6am7yjqD8jqTRC962j7P1kEJBG3O4sr
        r4J6UypswoxE5dgHG8gH4Ti09ujX/ZHfx25SEH/XigHNjsxAtzZKOSCCuUPwHRzg
        ZTmuNgKtAl7MGqz8TiaumGtfQw24xhdrRLoymswgzbnoduHe4ZNvDT31OZRkwuz1
        QRnm70bxu0bhEmaeNlbhxIrJtJrZBanakVxM2tlk6szU2P19jWvIrLYuZDl6A9Vl
        1+d8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=DjvFrxDSCUB8eHUxPxhWbB5MN/QXEIpJKqGs29bik
        /g=; b=gSN3UzMBPqefR5puzS2Eoul+JnCupRGeA3+Mn1i3BbrRkPWk4eyWteLFB
        +UfODa3iFvIGgJZddtqcozNUmz/nISHp/I08itXnmkzjODvEK6xuDwmsOq5V0VER
        961d8duFPgrc0mORchgTTTVEAZYxdi2EbULJuky/sD01xgRe383sjQ8Dg63YFtZS
        8gW0YUYoJawuZjxTCFHsA+KcwI/TbH6q4Y7BzbsE0OVzRdIbNBLUU05LlliW4Oue
        /oegQHBNZ5XTftx3+WNQL3MhFQBQ3FnNaqhXGUA7KOq02EKGG3T8pIpj/t5IRHKB
        31FAwfssmDnWaJmmZ/QS7Q/oEcKlw==
X-ME-Sender: <xms:xd73XZS8AFm5-oK7L4gysz86ed_XseCLVKRzGzEpEOkZz8D3O0M6og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddthedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeejtddrudefhedrudeg
    kedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrg
    hnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:xd73XWtslmQDVjFi9lufQzu1iJwpxInNF_j5RUC4VnpwjWVYk8sUtw>
    <xmx:xd73XX5KS_VJ1EqaXUq84fnyy1KnNRJvIP9NT-glll3Uc6A71PDWKQ>
    <xmx:xd73XZhzyr7B5ADOnIFlz9ZS3hAojyzhc3ibEFMF5ERI6_rj7Q8eKw>
    <xmx:yN73XUCJ4FpkwtUkmMecIXBKBLhJLWsPPYbHvRUtJ_wlEKfy-ReDbQ>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1B15C80061;
        Mon, 16 Dec 2019 14:45:09 -0500 (EST)
Subject: Re: [PATCH v5 2/8] dt-bindings: mailbox: Add a sun6i message box
 binding
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20191215042455.51001-1-samuel@sholland.org>
 <20191215042455.51001-3-samuel@sholland.org>
 <20191216140422.on4bredklgdxywbw@gilmour.lan>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <d3a1c7c2-953a-cbfe-970e-c00f9a9f5742@sholland.org>
Date:   Mon, 16 Dec 2019 13:45:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216140422.on4bredklgdxywbw@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/16/19 8:04 AM, Maxime Ripard wrote:
> Hi,
> 
> On Sat, Dec 14, 2019 at 10:24:49PM -0600, Samuel Holland wrote:
>> This mailbox hardware is present in Allwinner sun6i, sun8i, sun9i, and
>> sun50i SoCs. Add a device tree binding for it. As it has only been
>> tested on the A83T, A64, H3/H5, and H6 SoCs, only those compatibles are
>> included.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  .../mailbox/allwinner,sun6i-a31-msgbox.yaml   | 78 +++++++++++++++++++
>>  1 file changed, 78 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml b/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
>> new file mode 100644
>> index 000000000000..dd746e07acfd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
>> @@ -0,0 +1,78 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mailbox/allwinner,sun6i-a31-msgbox.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Allwinner sunxi Message Box
>> +
>> +maintainers:
>> +  - Samuel Holland <samuel@sholland.org>
>> +
>> +description: |
>> +  The hardware message box on sun6i, sun8i, sun9i, and sun50i SoCs is a
>> +  two-user mailbox controller containing 8 unidirectional FIFOs. An interrupt
>> +  is raised for received messages, but software must poll to know when a
>> +  transmitted message has been acknowledged by the remote user. Each FIFO can
>> +  hold four 32-bit messages; when a FIFO is full, clients must wait before
>> +  attempting more transmissions.
>> +
>> +  Refer to ./mailbox.txt for generic information about mailbox device-tree
>> +  bindings.
>> +
>> +properties:
>> +  compatible:
>> +     items:
>> +      - enum:
>> +          - allwinner,sun8i-a83t-msgbox
>> +          - allwinner,sun8i-h3-msgbox
>> +          - allwinner,sun50i-a64-msgbox
>> +          - allwinner,sun50i-h6-msgbox
>> +      - const: allwinner,sun6i-a31-msgbox
> 
> This will fail for the A31, since it won't have two compatibles but
> just one.

You asked me earlier to only include compatibles that had been tested, so I did.
This hasn't been tested on the A31, so there's no A31-only compatible.

> You can have something like this if you want to do it with an enum:
> 
> compatible:
>   oneOf:
>     - const: allwinner,sun6i-a31-msgbox
>     - items:
>       - enum:
>         - allwinner,sun8i-a83t-msgbox
>         - allwinner,sun8i-h3-msgbox
>         - allwinner,sun50i-a64-msgbox
>         - allwinner,sun50i-h6-msgbox
>       - const: allwinner,sun6i-a31-msgbox
> 
>> +  reg:
>> +    items:
>> +      - description: MMIO register range
> 
> There's no need for an obvious description like this.
> Just set it to maxItems: 1

Will do for v6.

>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: bus clock
>> +
>> +  resets:
>> +    maxItems: 1
>> +    description: bus reset
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description: controller interrupt
> 
> Ditto, you can drop the description here.

Will do for v6.

>> +  '#mbox-cells':
>> +    const: 1
> 
> However, you should document what the argument is about?

Ok. "Number of cells used to encode a mailbox specifier" should work.

>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - resets
>> +  - interrupts
>> +  - '#mbox-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/sun8i-h3-ccu.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/reset/sun8i-h3-ccu.h>
>> +
>> +    msgbox: mailbox@1c17000 {
>> +            compatible = "allwinner,sun8i-h3-msgbox",
>> +                         "allwinner,sun6i-a31-msgbox";
>> +            reg = <0x01c17000 0x1000>;
>> +            clocks = <&ccu CLK_BUS_MSGBOX>;
>> +            resets = <&ccu RST_BUS_MSGBOX>;
>> +            interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>> +            #mbox-cells = <1>;
>> +    };
> 
> Look good otherwise, thanks!
> Maxime
> 

Thanks,
Samuel
