Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5495C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0FA2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfHNKF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:05:27 -0400
Received: from foss.arm.com ([217.140.110.172]:51364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfHNKF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:05:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D7D6344;
        Wed, 14 Aug 2019 03:05:26 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E96B3F694;
        Wed, 14 Aug 2019 03:05:24 -0700 (PDT)
Date:   Wed, 14 Aug 2019 11:05:18 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Morten Borup Petersen <morten_bp@live.dk>,
        Tushar Khandelwal <tushar.khandelwal@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tushar.2nov@gmail.com" <tushar.2nov@gmail.com>,
        "nd@arm.com" <nd@arm.com>,
        Morten Borup Petersen <morten.petersen@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding
 documentation
Message-ID: <20190814100518.GA21898@e107155-lin>
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
 <20190717192616.1731-2-tushar.khandelwal@arm.com>
 <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
 <CABb+yY1SeHTgZQNAHJW+dZG=khah5c5igtKy+MrjADnZF29Aow@mail.gmail.com>
 <VI1PR0601MB21113C48E719B2C79EC2FE508FC20@VI1PR0601MB2111.eurprd06.prod.outlook.com>
 <CABb+yY3yMWbUiQnJgfQhwnW1OM3aoFL3ZFc018E-fxGichi-4Q@mail.gmail.com>
 <VI1PR0601MB2111A5A4E951F011D389A8978FD90@VI1PR0601MB2111.eurprd06.prod.outlook.com>
 <CABb+yY3Ni7wV+ui1LO7TERWQH_BoakZbPq961wdRPB4X-nwS2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY3Ni7wV+ui1LO7TERWQH_BoakZbPq961wdRPB4X-nwS2A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:36:56AM -0500, Jassi Brar wrote:
[...]

> > >>
> > >> As mentioned in the response to your initial comment, the driver does
> > >> not currently support mixing protocols.
> > >>
> > > Thanks for acknowledging that limitation. But lets also address it.
> > >
> >
> > We are hesitant to dedicate time to developing mixing protocols given
> > that we don't have any current usecase nor any current platform which
> > would support this.
> >
> Can you please share the client code against which you tested this driver?
> From my past experience, I realise it is much more efficient to tidyup
> the code myself, than endlessly trying to explain the benefits.
>

Thanks for the patience and offer. Can we try the same with MHUv1 and SCMI
upstream driver.

The firmware just uses High Priority physical channel bit 0 and 2 as Tx
and bit 1 and 3 as Rx. Bit 2 and 3 are for perf which shouldn't get blocked
by bit 0 and 1. I mean I can have 10 requests covering clocks/sensors and
others on bit 0 and 1, but the bits 2 and 3 are dedicated for DVFS and
shouldn't be blocked because of other non DVFS requests.

The DT looks something like this(modified MHU binding for 2 cells)

	mailbox: mhu@2b1f0000 {
		compatible = "arm,primecell";
		reg = <0x0 0x2b1f0000 0x0 0x1000>;
		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
		interrupt-names = "mhu_lpri_rx",
				  "mhu_hpri_rx";
		#mbox-cells = <2>;
		mbox-name = "ARM-MHU";
		clocks = <&soc_refclk100mhz>;
		clock-names = "apb_pclk";
	};
	firmware {
		scmi {
			compatible = "arm,scmi";
			mbox-names = "tx", "rx";
			mboxes = <&mailbox 0 0 &mailbox 0 1>;
			#address-cells = <1>;
			#size-cells = <0>;

			scmi_devpd: protocol@11 {
				reg = <0x11>;
				#power-domain-cells = <1>;
			};

			scmi_dvfs: protocol@13 {
				reg = <0x13>;
				#clock-cells = <1>;
				mbox-names = "tx", "rx";
				mboxes = <&mailbox 0 2 &mailbox 0 3>;
			};

			scmi_clk: protocol@14 {
				reg = <0x14>;
				#clock-cells = <1>;
			};

			scmi_sensors0: protocol@15 {
				reg = <0x15>;
				#thermal-sensor-cells = <1>;
			};
		};
	};

--
Regards,
Sudeep

