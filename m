Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8041C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B437E2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLCSz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:55:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:55568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfLCSz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:55:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0884CB12D;
        Tue,  3 Dec 2019 18:55:26 +0000 (UTC)
Subject: Re: [PATCH 6/6] dt-bindings: clk: realtek: add rtd1619 clock
 controller bindings
To:     James Tai <james.tai@realtek.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org,
        cylee12 <cylee12@realtek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20191203074513.9416-1-james.tai@realtek.com>
 <20191203074513.9416-7-james.tai@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <f16bc1ef-8b69-feb4-bf1a-b015d7f8618e@suse.de>
Date:   Tue, 3 Dec 2019 19:55:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191203074513.9416-7-james.tai@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

[dropping Palmer, adding Philipp]

Am 03.12.19 um 08:45 schrieb James Tai:
> From: cylee12 <cylee12@realtek.com>

Author.

$subject: clk vs. clock prefix

Lacking a commit message here.

> 
> Signed-off-by: Cheng-Yu Lee <cylee12@realtek.com>
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
>  .../bindings/clock/realtek,clocks.txt         | 38 +++++++++++++++++++

Please use YAML schema for any new bindings.

>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/realtek,clocks.txt

This patch needs to be ordered before patches using the binding in a
driver or DT. In this case it should've been squashed into 1/6.

> diff --git a/Documentation/devicetree/bindings/clock/realtek,clocks.txt b/Documentation/devicetree/bindings/clock/realtek,clocks.txt
> new file mode 100644
> index 000000000000..db101508ac6a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/realtek,clocks.txt
> @@ -0,0 +1,38 @@
> +Realtek Clock/Reset Controller
> +==============================
> +
> +Realtek CRT/ISO controller device-tree binding for Realtek Platforms.
> +
> +This binding uses the common clock binding[1].
> +
> +The controller node should be the child of a syscon node with the required
> +propertise:
> +
> +- compatible :
> +	should contain only one of the following:
> +		"realtek,rtd1619-cc" for RTD1619 CRT clock controller,
> +		"realtek,rtd1619-ic" for RTD1619 ISO clock controller,

-ic does not strike me as the best name, can we go with -iso-something
for consistency?

> +
> +- #clock-cells : should be 1.
> +
> +- #reset-cells : should be 1.
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Example:
> +
> +	crt@98000000 {

crt: syscon@...

Always prefer generic node names when possible.

> +		compatible = "realtek,rtd1619-crt", "simple-mfd", "syscon";

1) You must not use undefined compatible strings in your example! If we
want to use such compatibles (which I agree with in principle), then we
need to post separate bindings patches before you do so. The big issue
there is how to name them to work across SoC families. For that reason
my syscon series did not include dt-bindings, to not hold us up with
them. Drop it here for now?

2) You must retain the valid order, here defined by the syscon binding.
Like I said for the Mjolnir .dts. If we consequently use YAML schemas,
then you can check your .dts files with make dtbs_check and hopefully
notice it yourself before I complain. .dtsi patches are sadly missing in
this series, so you could only run limited make dt_binding_check.

> +		reg = <0x98000000 0x1000>;
> +
> +		cc: cc@98000000 {

cc: clock-controller@...

But you must not give a unit address in absence of reg.

> +			compatible = "realtek,rtd1619-cc";

reg missing. When you add it, you need #address-cells and #size-cells
above, too. Also ranges for completeness. In YAML it gets compile-tested
and should not sprout warnings.

> +			#clock-cells = <1>;
> +			#reset-cells = <1>;

BTW given the complex mappings that you attempt, wouldn't it be easier
to use #reset-cells = <2>? In that case one could again argue that a
per-bank node/driver will be easier.

> +		};
> +	};

Haven't tested this yet, but I wonder whether we could just use
"realtek,rtd1619-crt" for the clock controller directly and still use
the same node as syscon mfd? If not, it might be nice to describe in the
child node's reg what exactly is covered instead of just <0x0 0x1000>.

My point here is that the DT describes the hardware, but that does not
dictate how the Linux drivers bind to DT. clk is no platform_driver, so
you can have clk and reset drivers binding to the same DT compatible.
Did that for STM32 CRT once. However, don't hide the binding under clock
if it's really mfd - someone looking for reset bindings is going to have
a hard time finding them under clock.

> +
> +	consumer {
> +		clocks = <&cc CC_CKE_GSPI>;
> +	};
> +

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
