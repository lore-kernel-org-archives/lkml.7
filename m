Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CE0C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 19:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5975121721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 19:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGBS77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:59:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59216 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfGBS76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:59:58 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B91032639CD;
        Tue,  2 Jul 2019 19:59:57 +0100 (BST)
Date:   Tue, 2 Jul 2019 20:59:55 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel@pengutronix.de
Subject: Re: nvmem creates multiple devices with the same name
Message-ID: <20190702205955.65f1bce2@collabora.com>
In-Reply-To: <20190521085641.i6g5aijwa5zbolah@pengutronix.de>
References: <20190521085641.i6g5aijwa5zbolah@pengutronix.de>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 10:56:41 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Hi all,
> 
> nvmem derives the device name directly from the partition name of the
> underlying device. IMO this is wrong since it's not possible to create
> two partitions with the same name on different devices. In my case I
> have a NAND device and a SPI NOR device which both happen to have a
> partition named 'barebox'. This ends up with:

Hm, I think I had suggested to use dev_name(&mtd->dev) instead of
mtd->name at some point. But then you have the problem that MTD
numbering is dependent on the probe order which is not guaranteed to
stay the same, so exposing nvmem devices using "mtdXX" name is not super
user-friendly.

> 
> [   11.222196] sysfs: cannot create duplicate filename '/bus/nvmem/devices/barebox'
> [   11.230136] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.2.0-rc1-00014-g793f23e5adb0-dirty #676
> [   11.240414] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   11.247174] [<c0112928>] (unwind_backtrace) from [<c010d140>] (show_stack+0x10/0x14)
> [   11.255171] [<c010d140>] (show_stack) from [<c0bd65cc>] (dump_stack+0xd8/0x110)
> [   11.262722] [<c0bd65cc>] (dump_stack) from [<c031682c>] (sysfs_warn_dup+0x50/0x64)
> [   11.270527] [<c031682c>] (sysfs_warn_dup) from [<c0316b34>] (sysfs_do_create_link_sd+0xcc/0xd8)
> [   11.279487] [<c0316b34>] (sysfs_do_create_link_sd) from [<c06792a0>] (bus_add_device+0x80/0xfc)
> [   11.288441] [<c06792a0>] (bus_add_device) from [<c0676208>] (device_add+0x328/0x608)
> [   11.296423] [<c0676208>] (device_add) from [<c08bde64>] (nvmem_register.part.1+0x168/0x5e4)
> [   11.305030] [<c08bde64>] (nvmem_register.part.1) from [<c06edb34>] (add_mtd_device+0x1e8/0x404)
> [   11.313988] [<c06edb34>] (add_mtd_device) from [<c06f1004>] (add_mtd_partitions+0x74/0x15c)
> [   11.322589] [<c06f1004>] (add_mtd_partitions) from [<c06f0da8>] (parse_mtd_partitions+0x180/0x368)
> [   11.331807] [<c06f0da8>] (parse_mtd_partitions) from [<c06ede68>] (mtd_device_parse_register+0x40/0x164)
> [   11.341560] [<c06ede68>] (mtd_device_parse_register) from [<c070654c>] (m25p_probe+0x118/0x200)
> [   11.350513] [<c070654c>] (m25p_probe) from [<c073863c>] (spi_drv_probe+0x80/0xa4)
> 
> While it's easy to rename the partitions I see no reason why it should
> be illegal to have two different (mtd) devices with eqeally named
> partitions. Are there any suggestions how to register the nvmem devices
> with a different name?

Note that some MTD users are expecting MTD names to be unique to work
properly, the example I have in mind is UBI that can be passed the
partition to attach to using the ubi:<part-name> format, but I'm pretty
sure we have other places making the same assumption. I guess not
enforcing mtd->name uniqueness was a bad idea, but I'm not sure we can
change that now.
