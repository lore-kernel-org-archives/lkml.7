Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436DEC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142E922CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="g9/LqEDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfHTHbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:31:02 -0400
Received: from mail.intenta.de ([178.249.25.132]:33896 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfHTHbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:31:01 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 03:31:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=DkLrTcyw02QsvPxs9EBd44X1AWWhv0U810ENHIUA/sU=;
        b=g9/LqEDF6XZckbNpR3jQejUs+HROnv2ykoZqqW2LC3V0TRMF2Zror6CHw4XIqioagA1NqXfY2Hahhxhx29qHokl12gcv4G34RkrM7q34dON5IihNfGJ6cyX82A84E3aeO+m5JBBKDx2nnwozUNRUy1HeP4ylgQ8VosgTe68aImulKo3K3I6QdZAUZYsEG27vkH7mLsJcc41ionMy1M7zSKrfEPUgtXXLO3ZKIfyK+2oDGPtkMK9tEr/l8bzqk2BXZbHB/trlDKTodhi+kGnzi5tQCemiYBSVVb4fhlpoPtC5NNWmoLZ4MQilhaFyaaJQ2KxtWmrZ+cOSA+yfzUmAIA==;
X-CTCH-RefID: str=0001.0A0C020F.5D5BA055.0034,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Date:   Tue, 20 Aug 2019 09:25:08 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
CC:     <miquel.raynal@bootlin.com>, <bbrezillon@kernel.org>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <yamada.masahiro@socionext.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srinivas.goud@xilinx.com>, <shubhrajyoti.datta@xilinx.com>,
        <svemula@xilinx.com>, <nagasuresh12@gmail.com>,
        <michal.simek@xilinx.com>
Subject: Re: [LINUX PATCH v19] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Message-ID: <20190820072507.GA23478@laureti-dev>
References: <20190730114337.6601-1-naga.sureshkumar.relli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190730114337.6601-1-naga.sureshkumar.relli@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 30, 2019 at 05:43:37AM -0600, Naga Sureshkumar Relli wrote:
> Add driver for arm pl353 static memory controller nand interface.
> This controller is used in Xilinx Zynq SoC for interfacing the
> NAND flash memory.

Is there a reason that you dropped me from the Cc list? If you Cc me,
the feedback loop is faster. Please continue to Cc me on this driver.

> -> Tested Micron MT29F2G08ABAEAWP (On-die capable) and AMD/Spansion S34ML01G1.

I tested this version of the driver with this exact Micron flash in an
on-die configuration against v5.3-rc4. The patch applied cleanly and
built without problems. The driver detects the chip and works
"somewhat". One can interact with portions of the flash, but the amount
of ECC errors returned makes it unusable. I was able to reproduce the
same issue on multiple devices.

...
[   14.909894] jffs2: mtd->read(0x178 bytes from 0x21e0688) returned ECC error
[   14.917250] jffs2: mtd->read(0x800 bytes from 0x21e0000) returned ECC error
[   14.952765] jffs2: mtd->read(0x364 bytes from 0x21c049c) returned ECC error
[   14.960070] jffs2: mtd->read(0x6f8 bytes from 0x21c0108) returned ECC error
[   14.967435] jffs2: mtd->read(0x800 bytes from 0x21c0000) returned ECC error
[   15.001194] ------------[ cut here ]------------
[   15.006092] WARNING: CPU: 0 PID: 94 at drivers/mtd/nand/raw/nand_micron.c:245 micron_nand_read_page_on_die_ecc+0x394/0x3a0
[   15.018148] ---[ end trace 2d1d02f05cac8fbb ]---
[   15.022909] jffs2: error: (94) jffs2_get_inode_nodes: can not read 344 bytes from 0x021a16a8, error code: -22.
[   15.035205] jffs2: error: (94) jffs2_do_read_inode_internal: cannot read nodes for ino 8375, returned error is -22
[   15.045744] jffs2: Returned error for crccheck of ino #8375. Expect badness...
[   15.231220] jffs2: Checked all inodes but still 0x15361c bytes of unchecked space?
[   15.238851] jffs2: No space for garbage collection. Aborting GC thread
...

I cannot confirm that the driver works.

For completeness sake, here is the decompiled DT that I used:

memory-controller@e000e000 {
	#address-cells = <0x2>;
	#size-cells = <0x1>;
	status = "okay";
	clock-names = "memclk", "apb_pclk";
	clocks = <0x1 0xb 0x1 0x2c>;
	compatible = "arm,pl353-smc-r2p1", "arm,primecell";
	interrupt-parent = <0x4>;
	interrupts = <0x0 0x12 0x4>;
	ranges = <0x0 0x0 0xe1000000 0x1000000>;
	reg = <0xe000e000 0x1000>;

	flash@e1000000 {
		status = "okay";
		compatible = "arm,pl353-nand-r2p1";
		reg = <0x0 0x0 0x1000000>;
		#address-cells = <0x1>;
		#size-cells = <0x1>;
		nand-ecc-mode = "on-die";
		nand-bus-width = <0x8>;

	};
};

I am posting a decompiled DT, because parts are generated using
https://github.com/Xilinx/device-tree-xlnx.

The driver from the xlnx 4.14 tree continues to work with the hardware I
used for testing.

Helmut
