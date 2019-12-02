Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B5AC43141
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9F82070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="EBVy3LiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLBVcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:32:20 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:53293 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLBVcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:32:20 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 258E122FFC;
        Mon,  2 Dec 2019 22:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1575322336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cmBUIDjXbaH6gYvi3PQRfhA7L3Y7n+FXkoteSMH40vQ=;
        b=EBVy3LiYphh91ps24yCY7oA7J20YqXWU1rBnQus3fRDfSSmaeK7OW4zS88+hyFZAfc4ZfE
        0CGGhSCAfRddkevBMTrCvFngCXnRiq9O+xL0cdACFCdG4yoJzSfSIUhJJcPMoiy9Su5VVY
        mDCvcUENN41MKIQTvJ53Fg4n87BWHAE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Dec 2019 22:32:16 +0100
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
Cc:     Wen He <wen.he_1@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v10 1/2] dt/bindings: clk: Add YAML schemas for LS1028A Display
 Clock bindings
In-Reply-To: <20191202184758.GA8408@bogus>
References: <20191127101525.44516-1-wen.he_1@nxp.com>
 <20191202184758.GA8408@bogus>
Message-ID: <e876f247860d728498df37705e7dfba2@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 258E122FFC
X-Spamd-Result: default: False [-0.10 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         NEURAL_HAM(-0.00)[-0.619];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2019-12-02 19:47, schrieb Rob Herring:
> On Wed, Nov 27, 2019 at 06:15:24PM +0800, Wen He wrote:
>> LS1028A has a clock domain PXLCLK0 used for provide pixel clocks to 
>> Display
>> output interface. Add a YAML schema for this.
>> 
>> Signed-off-by: Wen He <wen.he_1@nxp.com>
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> change in v10:
>>         - Add optional feild 'vco-frequency'.
>> 
>>  .../devicetree/bindings/clock/fsl,plldig.yaml | 54 
>> +++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/clock/fsl,plldig.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml 
>> b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
>> new file mode 100644
>> index 000000000000..ee5b5c61a471
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
>> @@ -0,0 +1,54 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/bindings/clock/fsl,plldig.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NXP QorIQ Layerscape LS1028A Display PIXEL Clock Binding
>> +
>> +maintainers:
>> +  - Wen He <wen.he_1@nxp.com>
>> +
>> +description: |
>> +  NXP LS1028A has a clock domain PXLCLK0 used for the Display output
>> +  interface in the display core, as implemented in TSMC CLN28HPM PLL.
>> +  which generate and offers pixel clocks to Display.
>> +
>> +properties:
>> +  compatible:
>> +    const: fsl,ls1028a-plldig
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#clock-cells':
>> +    const: 0
>> +
>> +  vco-frequency:
> 
> Needs vendor prefix and unit suffix:
> 
> fsl,vco-hz
> 
> Or you could perhaps just use 'clock-frequency'.

Ok, fsl,vco-hz sounds good. clock-frequency sounds like it is the 
output.

-michael

>> +     $ref: '/schemas/types.yaml#/definitions/uint32'
>> +     description: Optional for VCO frequency of the PLL in Hertz.
>> +        The VCO frequency of this PLL cannot be changed during 
>> runtime
>> +        only at startup. Therefore, the output frequencies are very
>> +        limited and might not even closely match the requested 
>> frequency.
>> +        To work around this restriction the user may specify its own
>> +        desired VCO frequency for the PLL. The frequency has to be in 
>> the
>> +        range of 650000000 to 1300000000.
>> +        If not set, the default frequency is 1188000000.
> 
> A bunch of constraints you've listed here that should be schema rather
> than freeform text:
> 
> minimum: 650000000
> maximum: 1300000000
> default: 1188000000
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - '#clock-cells'
>> +
>> +examples:
>> +  # Display PIXEL Clock node:
>> +  - |
>> +    dpclk: clock-display@f1f0000 {
>> +        compatible = "fsl,ls1028a-plldig";
>> +        reg = <0x0 0xf1f0000 0x0 0xffff>;
>> +        #clock-cells = <0>;
>> +        clocks = <&osc_27m>;
>> +    };
>> +
>> +...
>> --
>> 2.17.1
>> 
