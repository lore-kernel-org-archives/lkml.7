Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0EFC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C994F2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbfETPyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:54:22 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:53239 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732031AbfETPyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:54:21 -0400
X-Originating-IP: 90.88.22.185
Received: from windsurf (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E5F2D20011;
        Mon, 20 May 2019 15:54:10 +0000 (UTC)
Date:   Mon, 20 May 2019 17:54:10 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] arm64: dts: marvell: mcbin: enlarge PCI memory
 window
Message-ID: <20190520175410.4c941bfc@windsurf>
In-Reply-To: <20190517161123.9293-1-xypron.glpk@gmx.de>
References: <20190517161123.9293-1-xypron.glpk@gmx.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heinrich,

On Fri, 17 May 2019 18:11:23 +0200
Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> Running a graphics adapter on the MACCHIATObin fails due to an
> insufficently sized memory window.
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

While I understand the change, I find it is a bit of a "one-off"
solution, which will only work specifically for the MacchiatoBin. But
admittedly, there isn't really a good generic solution: depending on
the number of PCIe ports and what you connect to them, you will need
windows of different sizes.

On older Armada platforms, it works a bit better because we have a
single PCIe MEM aperture and a single PCIe I/O aperture, from which all
PCIe ports allocate: each PCIe interface is a child bus of an emulated
root port.

Unfortunately, on Armada 7K/8K, each PCIe interface is seen as an
independent root complex, so we have one PCIe I/O aperture and one PCIe
MEM aperture for each.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
