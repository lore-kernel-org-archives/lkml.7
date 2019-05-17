Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50659C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2968C2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfEQUIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 16:08:10 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59811 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfEQUIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 16:08:09 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B510940008;
        Fri, 17 May 2019 20:08:00 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/1] arm64: dts: marvell: mcbin: enlarge PCI memory window
In-Reply-To: <20190517161123.9293-1-xypron.glpk@gmx.de>
References: <20190517161123.9293-1-xypron.glpk@gmx.de>
Date:   Fri, 17 May 2019 22:08:00 +0200
Message-ID: <87k1eozvxb.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heinrich Schuchardt,

> Running a graphics adapter on the MACCHIATObin fails due to an
> insufficently sized memory window.
I think "insufficient" is enough or I miss something.

>
> Enlarge the memory window for the PCIe slot to 512 MiB.
>
> With the patch I am able to use a GT710 graphics adapter with 1 GB onboard
> memory.
>
> These are the mapped memory areas that the graphics adapter is actually
> using:
>
> Region 0: Memory at cc000000 (32-bit, non-prefetchable) [size=16M]
> Region 1: Memory at c0000000 (64-bit, prefetchable) [size=128M]
> Region 3: Memory at c8000000 (64-bit, prefetchable) [size=32M]
> Region 5: I/O ports at 1000 [size=128]
> Expansion ROM at ca000000 [disabled] [size=512K]

From my point of view this patch is correct, I don't think it is a
problem to map more memory. So I applied on it mvebu/dt64.

But I add also Thomas in CC who know better the PCIe support on mvebu/

Thanks,

Gregory


>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> index 329f8ceeebea..205071b45a32 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> @@ -184,6 +184,8 @@
>  	num-lanes = <4>;
>  	num-viewport = <8>;
>  	reset-gpios = <&cp0_gpio2 20 GPIO_ACTIVE_LOW>;
> +	ranges = <0x81000000 0x0 0xf9010000 0x0 0xf9010000 0x0 0x10000
> +		  0x82000000 0x0 0xc0000000 0x0 0xc0000000 0x0 0x20000000>;
>  	status = "okay";
>  };
>
> --
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
