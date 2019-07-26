Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99E4C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B9B218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfGZSbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:31:36 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37000 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfGZSbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:31:35 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hr509-0005rd-V2; Fri, 26 Jul 2019 12:31:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hr508-0002Si-A4; Fri, 26 Jul 2019 12:31:32 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>
Cc:     lkp@01.org, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        kernel test robot <lkp@intel.com>
Date:   Fri, 26 Jul 2019 12:31:30 -0600
Message-Id: <20190726183130.9424-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us, lkp@01.org, allenbh@gmail.com, torvalds@linux-foundation.org, logang@deltatee.com, dave.jiang@intel.com, lkp@intel.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] NTB/msi: remove incorrect MODULE defines
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msi.c is not a module on its own right and should not have the
MODULE_[LICENSE|VERSION|AUTHOR|DESCRIPTION] definitions.

This caused a regression noticed by lkp with the following back
trace:

   WARNING: CPU: 0 PID: 1 at kernel/params.c:861 param_sysfs_init+0xb1/0x20a
   Modules linked in:
   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc1-00018-g26b3a37b928457 #2
   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
   RIP: 0010:param_sysfs_init+0xb1/0x20a
   Code: 24 38 e8 ec 17 2e fd 49 8b 7c 24 38 e8 76 fe ff ff 48 85 c0 48 89 c5 74 25 31 d2 4c 89 e6 48 89 c7 e8 6d 6f 3c fd 85 c0 74 02 <0f> 0b 48 89 ef 31 f6 e8 5d 70 a7 fe 48 89 ef e8 95 52 a7 fe 48 83
   RSP: 0000:ffff88806b0ffe30 EFLAGS: 00010282
   RAX: 00000000ffffffef RBX: ffffffff83774220 RCX: ffff88806a85e880
   RDX: 00000000ffffffef RSI: ffff88806b000400 RDI: ffff88806a8608c0
   RBP: ffff88806b392000 R08: ffffed100d61ff59 R09: ffffed100d61ff59
   R10: 0000000000000001 R11: ffffed100d61ff58 R12: ffffffff83974bc0
   R13: 0000000000000004 R14: 0000000000000028 R15: 00000000000003b9
   FS:  0000000000000000(0000) GS:ffff88806b800000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 0000000000000000 CR3: 000000000380e000 CR4: 00000000000406b0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   Call Trace:
    ? file_caps_disable+0x10/0x10
    ? locate_module_kobject+0xf2/0xf2
    do_one_initcall+0x47/0x1f0
    kernel_init_freeable+0x1b1/0x243
    ? rest_init+0xd0/0xd0
    kernel_init+0xa/0x130
    ? calculate_sigpending+0x63/0x80
    ? rest_init+0xd0/0xd0
    ret_from_fork+0x1f/0x30
   ---[ end trace 78201497ae74cc91 ]---

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 26b3a37b9284 ("NTB: Introduce MSI library")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/msi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 9dddf133658f..0a5e884a920c 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -6,11 +6,6 @@
 #include <linux/msi.h>
 #include <linux/pci.h>
 
-MODULE_LICENSE("Dual BSD/GPL");
-MODULE_VERSION("0.1");
-MODULE_AUTHOR("Logan Gunthorpe <logang@deltatee.com>");
-MODULE_DESCRIPTION("NTB MSI Interrupt Library");
-
 struct ntb_msi {
 	u64 base_addr;
 	u64 end_addr;
-- 
2.20.1

