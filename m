Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9511CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB6120854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392733AbfIFMpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:45:05 -0400
Received: from krieglstein.org ([188.68.35.71]:50976 "EHLO krieglstein.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388739AbfIFMpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:45:05 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Sep 2019 08:45:04 EDT
Received: from dabox.localnet (gateway.hbm.com [213.157.30.2])
        by krieglstein.org (Postfix) with ESMTPSA id DE7744010B;
        Fri,  6 Sep 2019 14:38:23 +0200 (CEST)
From:   Tim Sander <tim@krieglstein.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: mtd raw nand denali.c broken for Intel/Altera Cyclone V
Date:   Fri, 06 Sep 2019 14:38:23 +0200
Message-ID: <5143724.5TqzkYX0oI@dabox>
Organization: Sander and Lightning
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have noticed that there multiple breakages piling up for the denali nand
driver on the Intel/Altera Cyclone V. Unfortunately i had no time to track the
mainline kernel closely. So the breakage seems to pile up. I am a little
disapointed that Intel is not on the lookout that the kernel works on the
chips they are selling. I was really happy about the state of the platform
before concerning mainline support.

The failure starts with kernel 4.19 or stable kernel release 4.18.19. The
commit is ba4a1b62a2d742df9e9c607ac53b3bf33496508f. The problem here is that
our platform works with a zero in the SPARE_AREA_SKIP_BYTES register. But in
this case the patch assumes the default value 8 which is straight out  wrong
on this variant. Without this patch reverted all blocks of the nand flash are
beeing marked bad :-(.

When reverting the patch ba4a1b62a2d742df9e9c607ac53b3bf33496508f  i can boot
4.19.10 again.

With 5.0 the it goes further down the drain and i didn't manage to boot it
even with the above patch reverted.

I also tried 5.3-rc7 with the above patch reverted and the variable t_x dirty hacked to the
value 0x1388 as i got the impression that the timing calculation is off too. I still get an
interrupt error and boot failure:
[    0.817588] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
[    0.823946] nand: Micron MT29F2G08ABAEAWP
[    0.827965] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    1.887052] denali-nand-dt ff900000.nand: timeout while waiting for irq 0x1000
[    2.911056] denali-nand-dt ff900000.nand: timeout while waiting for irq 0x1000

I have seen this https://lore.kernel.org/patchwork/patch/983055/ thread and
this might fix at least the 4.19 boot problem.

I would be really happy for hints how to get the Intel Cyclone V working again.

Best regards
Tim



