Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B3A20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="joGi4rAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfC1L5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:57:02 -0400
Received: from mail.intenta.de ([178.249.25.132]:25512 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfC1L5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:57:01 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2019 07:57:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=oSY35PUiHXMZ1roga5ESZj/qIxX6nAtZzDR9iWObKTo=;
        b=joGi4rAtclASx7OvKLBXmp6yjSLcP3HWOEDunjrjeP+J27NwLLTWYrxMMOjRou2aPnWZQpZdfxHAgRs62fMzfRxVzQ8T+AHTrRGZuM26khkvSKlfIMouT6yewjos1jUHmaE1dA6kUW0sHLILFUTHPU05uZl4MVVQO+hAnjgizw6Kblg3GtvIhUjuNGXUumuLvcj2VGe9swbfI4plEcb8WPGRssQ8Tc97AGQYRwxhxHO9SxBj1Srbk7c0Xyap/nZULsYRDUEho91R1KRZUbakdwdeVxpeJYjgquX08v43RzcscRWkcJRw3QKQ9TUqkax/yuEKr5xzz3BGSA9xwzOy7Q==;
X-CTCH-RefID: str=0001.0A0C0203.5C9CB52C.00BE,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Date:   Thu, 28 Mar 2019 12:51:06 +0100
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v13] rawnand: pl353: Add basic driver for arm pl353
 smc nand interface
Message-ID: <20190328115106.i7ytk2uqno7i4h4u@laureti-dev>
References: <1549694247-24625-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20190326132721.52e7ktnptgwvzeor@laureti-dev>
 <MWHPR02MB26235ED95B0F0AE89B2A0972AF580@MWHPR02MB2623.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <MWHPR02MB26235ED95B0F0AE89B2A0972AF580@MWHPR02MB2623.namprd02.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

On Wed, Mar 27, 2019 at 09:13:59AM +0000, Naga Sureshkumar Relli wrote:
> It's a on-die ECC capable device. Did u mentioned nand-ecc-mode = "on-die" in dts.
> The same part I tested by mentioning "on-die" property in dts and it worked for me.
> Please share the dts entries for NAND.
> Also if it is x8 bus then please mention nand-bus-width = <8>;
> If it is x16 mention nand-bus-width = <16>;

Thank you for pointing at the relevant properties. Indeed, these were
missing in my previous tests. I am now using the following dt (generated
from multiple fragments, giving the decompiled dt here):

| memory-controller@e000e000 {
| 	#address-cells = <0x2>;
| 	#size-cells = <0x1>;
| 	status = "okay";
| 	clock-names = "memclk", "apb_pclk";
| 	clocks = <0x1 0xb 0x1 0x2c>;
| 	compatible = "arm,pl353-smc-r2p1", "arm,primecell";
| 	interrupt-parent = <0x4>;
| 	interrupts = <0x0 0x12 0x4>;
| 	ranges = <0x0 0x0 0xe1000000 0x1000000>;
| 	reg = <0xe000e000 0x1000>;
| 
| 	flash@e1000000 {
| 		status = "okay";
| 		compatible = "arm,pl353-nand-r2p1";
| 		reg = <0x0 0x0 0x1000000>;
| 		#address-cells = <0x1>;
| 		#size-cells = <0x1>;
| 		nand-ecc-mode = "on-die";
| 		nand-ecc-algo = "hamming";
| 		nand-bus-width = <0x8>;
| 	};
| };

With this dt, the device is successfully initialized and the data read
is mostly intact. When using it with jffs2, I get loads of ECC errors
though (offsets and lengths vary):

| jffs2: mtd->read(0x800 bytes from 0xb60000) returned ECC error

Reverting back to the out-of-tree driver (4.14), it works normally, so a
hardware defect seems unlikely. I compared a register dump of the smc between
those drivers and the only difference I could find was NAND timings (at
0xE000E180), which are much lower with the new drivers as it does not consume
the arm,nand-cycle-* properties that the old driver consumed. I tried hard
coding the previous timings, but the ECC errors persist. This leads me to
conclude that timings are not the cause for what I am seeing.

Is there anything else I can try to diagnose it?

Helmut
