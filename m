Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC78C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F3421473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557779510;
	bh=m+kY0Zgpyu0lel7EqL2gjXaT8+eVkAzD9H5M/7qk0Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bsC7D/ah34Eep5YsOlfpivSDgryABeDKELkuUy9j3DeChR9lZAbgiAE+VXYLBX+Y6
	 V/aab+XkcG4+STXWPyHMz7aM5e9mECuTw4p1QCYDZWmEYrkaS0eHQjpegSIHOjyG6N
	 +SDqftEeY9K5Fti5OT3MqcGQWyNHyqaR46TAJLHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEMUbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:31:49 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41749 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEMUbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:31:49 -0400
Received: by mail-oi1-f195.google.com with SMTP id y10so10386594oia.8;
        Mon, 13 May 2019 13:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QMwu8DgxJVgdXd3GFba+2fxziogY4dsXbaDcgxIT5Y8=;
        b=qjCg34rWTV2+mvzNn+w31A94Ldy7gJO48efNHmQ8MzylR0wf+8lJdTv6SK0uh1cvSb
         COyPttZFw0mo1lPjxPO6dUupPuPJyzTtP34GDobRqDcAFQ9jnKF9OGPqjrjRE0HMtjAh
         XnrQgAzQoTxO0tCxZEBc8UX0OqMUaP0duihya8IG1uEj3jmZgk2aJT8qe3Wz6QfAK5iP
         He1W3ewMdMwL7K8S0TXoMI2DK1Ms5IGXxdPWy/HWcJ5Y7QY8CAy57rfXomjOAn4dEmIV
         qbwgoFv657fc0KIwZpT3FqyohsGG41Nb5mjZkJGt+9q0nA/0L3zTX864BmlEeQIpzjb7
         dWXg==
X-Gm-Message-State: APjAAAVIj3U5PbrMW0wDGsxMPixy1xXVw2HpTfHvO5loose82ztZ+zg3
        /7vI8tqOI+DJkmPua4pzHI82/7k=
X-Google-Smtp-Source: APXvYqzSADSgT0g7GGSCSubY4G8MUAxQgDIdsbP6OHhcEU0RTjMKQEa1eWxpjl5q8zZSqm1sI+1CCQ==
X-Received: by 2002:aca:4282:: with SMTP id p124mr638485oia.175.1557779508351;
        Mon, 13 May 2019 13:31:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 64sm5577713oth.47.2019.05.13.13.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 13:31:47 -0700 (PDT)
Date:   Mon, 13 May 2019 15:31:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v2] dt-bindings: clock: Add silabs,si5341
Message-ID: <20190513203146.GA24085@bogus>
References: <20190424090216.18417-1-mike.looijmans@topic.nl>
 <155623344648.15276.18213024444708122458@swboyd.mtv.corp.google.com>
 <3ea2d720-f49b-586c-e402-07db289b39a8@topic.nl>
 <155632584222.168659.9675557812377718927@swboyd.mtv.corp.google.com>
 <cd52a35b-d289-24e1-70db-9d63fd9f6448@topic.nl>
 <20190507140413.28335-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507140413.28335-1-mike.looijmans@topic.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 04:04:13PM +0200, Mike Looijmans wrote:
> Adds the devicetree bindings for the Si5341 and Si5340 chips from
> Silicon Labs. These are multiple-input multiple-output clock
> synthesizers.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Add data sheet reference.
>     Restructured to enable use of "assigned-clock*" properties to set
>     up both outputs and internal synthesizers.
>     Nicer indentation.
>     Updated subject line and body of commit message.
>     If these bindings are (mostly) acceptable, I'll post an updated
>     driver patch v2 to implement these changes.
> 
>  .../bindings/clock/silabs,si5341.txt          | 187 ++++++++++++++++++
>  1 file changed, 187 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5341.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/silabs,si5341.txt b/Documentation/devicetree/bindings/clock/silabs,si5341.txt
> new file mode 100644
> index 000000000000..6086dfcaeecf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/silabs,si5341.txt
> @@ -0,0 +1,187 @@
> +Binding for Silicon Labs Si5341 and Si5340 programmable i2c clock generator.
> +
> +Reference
> +[1] Si5341 Data Sheet
> +    https://www.silabs.com/documents/public/data-sheets/Si5341-40-D-DataSheet.pdf
> +[2] Si5341 Reference Manual
> +    https://www.silabs.com/documents/public/reference-manuals/Si5341-40-D-RM.pdf
> +
> +The Si5341 and Si5340 are programmable i2c clock generators with up to 10 output
> +clocks. The chip contains a PLL that sources 5 (or 4) multisynth clocks, which
> +in turn can be directed to any of the 10 (or 4) outputs through a divider.
> +The internal structure of the clock generators can be found in [2].
> +
> +The driver can be used in "as is" mode, reading the current settings from the
> +chip at boot, in case you have a (pre-)programmed device. If the PLL is not
> +configured when the driver probes, it assumes the driver must fully initialize
> +it.
> +
> +The device type, speed grade and revision are determined runtime by probing.
> +
> +The driver currently only supports XTAL input mode, and does not support any
> +fancy input configurations. They can still be programmed into the chip and
> +the driver will leave them "as is".
> +
> +==I2C device node==
> +
> +Required properties:
> +- compatible: shall be one of the following:
> +	"silabs,si5340" - Si5340 A/B/C/D
> +	"silabs,si5341" - Si5341 A/B/C/D
> +- reg: i2c device address, usually 0x74
> +- #clock-cells: from common clock binding; shall be set to 2.
> +	The first value is "0" for outputs, "1" for synthesizers.
> +	The second value is the output or synthesizer index.
> +- clocks: from common clock binding; list of parent clock  handles,
> +	corresponding to inputs. Use a fixed clock for the "xtal" input.
> +	At least one must be present.
> +- clock-names: One of: "xtal", "in0", "in1", "in2"
> +- vdd-supply: Regulator node for VDD
> +
> +Optional properties:
> +- vdda-supply: Regulator node for VDDA
> +- vdds-supply: Regulator node for VDDS
> +- silabs,pll-m-num, silabs,pll-m-den: Numerator and denominator for PLL
> +  feedback divider. Must be such that the PLL output is in the valid range. For
> +  example, to create 14GHz from a 48MHz xtal, use m-num=14000 and m-den=48. Only
> +  the fraction matters, using 3500 and 12 will deliver the exact same result.
> +  If these are not specified, and the PLL is not yet programmed when the driver
> +  probes, the PLL will be set to 14GHz.
> +- silabs,reprogram: When present, the driver will always assume the device must
> +  be initialized, and always performs the soft-reset routine. Since this will
> +  temporarily stop all output clocks, don't do this if the chip is generating
> +  the CPU clock for example.
> +- interrupts: Interrupt for INTRb pin.
> +
> +== Child nodes: Synthesizers ==
> +
> +In order to refer to the internal synthesizers, there can be a child node named
> +"synthesizers".
> +
> +Required synthesizers node properties:
> +- #address-cells: shall be set to 1.
> +- #size-cells: shall be set to 0.
> +
> +Each child of this node corresponds to a multisynth in the Si534X chip. This
> +allows the synthesizer to be referred to with assigned-clocks.

Why is this? It doesn't seem to me that you need this in DT. You can 
define the clock ID to refer to it in assigned-clocks without these 
nodes in DT.

> +
> +Required child node properties:
> +- reg: synthesizer index in range 0..4 for Si5341 and 0..3 for Si5340.
> +
> +== Child nodes: Outputs ==
> +
> +The child node "outputs" lists the output clocks.
> +
> +Required outputs node properties:
> +- #address-cells: shall be set to 1.
> +- #size-cells: shall be set to 0.
> +
> +Each of the clock outputs can be overwritten individually by
> +using a child node to the outputs child node. If a child node for a clock
> +output is not set, the configuration remains unchanged.
> +
> +Required child node properties:
> +- reg: number of clock output.
> +
> +Optional child node properties:
> +- vdd-supply: Regulator node for VDD for this output. The driver selects default
> +	values for common-mode and amplitude based on the voltage.
> +- silabs,format: Output format, one of:
> +	1 = differential (defaults to LVDS levels)
> +	2 = low-power (defaults to HCSL levels)
> +	4 = LVCMOS
> +- silabs,common-mode: Manually overide output common mode, see [2] for values

s/overide/override/

> +- silabs,amplitude: Manually override output amplitude, see [2] for values
> +- silabs,synth-master: boolean. If present, this output is allowed to change the
> +	multisynth frequency dynamically.
> +- silabs,disable-state : clock output disable state, shall be
> +	0 = clock output is driven LOW when disabled
> +	1 = clock output is driven HIGH when disabled
> +
> +==Example==
> +
> +/* 48MHz reference crystal */
> +ref48: ref48M {
> +	compatible = "fixed-clock";
> +	#clock-cells = <0>;
> +	clock-frequency = <48000000>;
> +};
> +
> +i2c-master-node {
> +	/* Programmable clock (for logic) */
> +	si5341: clock-generator@74 {
> +		reg = <0x74>;
> +		compatible = "silabs,si5341";
> +		#clock-cells = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&ref48>;
> +		clock-names = "xtal";
> +
> +		silabs,pll-m-num = <14000>; /* PLL at 14.0 GHz */
> +		silabs,pll-m-den = <48>;
> +		silabs,reprogram; /* Chips are not programmed, always reset */
> +
> +		synthesizers {
> +			synth@2 {
> +				reg = <2>;
> +			};
> +		};
> +
> +		outputs {
> +			out@0 {
> +				reg = <0>;
> +				silabs,format = <1>; /* LVDS 3v3 */
> +				silabs,common-mode = <3>;
> +				silabs,amplitude = <3>;
> +				silabs,synth-master;
> +			};
> +
> +			/*
> +			 * Output 6 configuration:
> +			 *  LVDS 1v8
> +			 */
> +			out@6 {
> +				reg = <6>;
> +				silabs,format = <1>; /* LVDS 1v8 */
> +				silabs,common-mode = <13>;
> +				silabs,amplitude = <3>;
> +			};
> +
> +			/*
> +			 * Output 8 configuration:
> +			 *  HCSL 3v3
> +			 */
> +			out@8 {
> +				reg = <8>;
> +				silabs,format = <2>;
> +				silabs,common-mode = <11>;
> +				silabs,amplitude = <3>;
> +			};
> +		};
> +	};
> +};
> +
> +some-video-node {
> +	/* Standard clock bindings */
> +	clock-names = "pixel";
> +	clocks = <&si5341 0 7>; /* Output 7 */
> +
> +	/* Set output 7 to use syntesizer 3 as its parent */
> +	assigned-clocks = <&si5341 0 7>, <&si5341 1 3>;
> +	assigned-clock-parents = <&si5341 1 3>;
> +	/* Set output 7 to 148.5 MHz using a synth frequency of 594 MHz */
> +	assigned-clock-rates = <148500000>, <594000000>;
> +};
> +
> +some-audio-node {
> +	clock-names = "i2s-clk";
> +	clocks = <&si5341 0 0>;
> +	/*
> +	 * since output 0 is a synth-master, the synth will be automatically set
> +	 * to an appropriate frequency when the audio driver requests another
> +	 * frequency. We give control over synth 2 to this output here.
> +	 */
> +	assigned-clocks = <&si5341 0 0>;
> +	assigned-clock-parents = <&si5341 1 2>;
> +};
> -- 
> 2.17.1
> 
