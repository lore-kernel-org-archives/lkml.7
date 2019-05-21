Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476EBC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D61F217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfEUI4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:56:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57045 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfEUI4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:56:43 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hT0Zd-00057d-TZ; Tue, 21 May 2019 10:56:41 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hT0Zd-0001Nd-F9; Tue, 21 May 2019 10:56:41 +0200
Date:   Tue, 21 May 2019 10:56:41 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel@pengutronix.de, linux-mtd@lists.infradead.org
Subject: nvmem creates multiple devices with the same name
Message-ID: <20190521085641.i6g5aijwa5zbolah@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:44:24 up 3 days, 15:02, 48 users,  load average: 0.16, 0.10, 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

nvmem derives the device name directly from the partition name of the
underlying device. IMO this is wrong since it's not possible to create
two partitions with the same name on different devices. In my case I
have a NAND device and a SPI NOR device which both happen to have a
partition named 'barebox'. This ends up with:

[   11.222196] sysfs: cannot create duplicate filename '/bus/nvmem/devices/barebox'
[   11.230136] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.2.0-rc1-00014-g793f23e5adb0-dirty #676
[   11.240414] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   11.247174] [<c0112928>] (unwind_backtrace) from [<c010d140>] (show_stack+0x10/0x14)
[   11.255171] [<c010d140>] (show_stack) from [<c0bd65cc>] (dump_stack+0xd8/0x110)
[   11.262722] [<c0bd65cc>] (dump_stack) from [<c031682c>] (sysfs_warn_dup+0x50/0x64)
[   11.270527] [<c031682c>] (sysfs_warn_dup) from [<c0316b34>] (sysfs_do_create_link_sd+0xcc/0xd8)
[   11.279487] [<c0316b34>] (sysfs_do_create_link_sd) from [<c06792a0>] (bus_add_device+0x80/0xfc)
[   11.288441] [<c06792a0>] (bus_add_device) from [<c0676208>] (device_add+0x328/0x608)
[   11.296423] [<c0676208>] (device_add) from [<c08bde64>] (nvmem_register.part.1+0x168/0x5e4)
[   11.305030] [<c08bde64>] (nvmem_register.part.1) from [<c06edb34>] (add_mtd_device+0x1e8/0x404)
[   11.313988] [<c06edb34>] (add_mtd_device) from [<c06f1004>] (add_mtd_partitions+0x74/0x15c)
[   11.322589] [<c06f1004>] (add_mtd_partitions) from [<c06f0da8>] (parse_mtd_partitions+0x180/0x368)
[   11.331807] [<c06f0da8>] (parse_mtd_partitions) from [<c06ede68>] (mtd_device_parse_register+0x40/0x164)
[   11.341560] [<c06ede68>] (mtd_device_parse_register) from [<c070654c>] (m25p_probe+0x118/0x200)
[   11.350513] [<c070654c>] (m25p_probe) from [<c073863c>] (spi_drv_probe+0x80/0xa4)

While it's easy to rename the partitions I see no reason why it should
be illegal to have two different (mtd) devices with eqeally named
partitions. Are there any suggestions how to register the nvmem devices
with a different name?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
