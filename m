Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE01C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77619218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbfB1HMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:12:30 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:54474 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731392AbfB1HM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:12:26 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0971239-0.103795-0.799081;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07423;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.E2MIXMl_1551337935;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.E2MIXMl_1551337935)
          by smtp.aliyun-inc.com(10.147.40.44);
          Thu, 28 Feb 2019 15:12:20 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [PATCH v12 0/4] pstore/block: new support logger for block devices
Date:   Thu, 28 Feb 2019 15:12:24 +0800
Message-Id: <1551337948-16451-1-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why should we need pstore_block?
1. Most embedded intelligent equipment have no persistent ram, which
increases costs. We perfer to cheaper solutions, like block devices.
In fast, there is already a sample for block device logger in driver
MTD (drivers/mtd/mtdoops.c).
2. Do not any equipment have battery, which means that it lost all data
on general ram if power failure. Pstore has little to do for these
equipments.

[PATCH v12]
On patch 4:
1. Modify the document according to Randy Dunlap's suggestion.

[PATCH v11]
Change patchset label from RFC to PATCH

[PATCH v10]
Cancel DT support for blkoops temporarily.
On patch 1:
1. pstore/blk should unlink PSTORE_BLKDEV when unregister.
On patch 2:
1. cancel DT support temporarily. I will submit other patches to support DT
   when DT maintainers acked.
2. add spin lock to protect blkz_info when modify panic operations.
3. change default value of total size on Kconfig from 1024 to 0.

[PATCH v9]
On patch 1:
1. rename part_path/part_size, members of blkz_info, to blkdev/total_size
2. if total_size is zero, get size from @blkdev
3. support multiple variants for @blkdev, such as partuuid, major with minor,
   and /dev/xxxx. See details on Documentation.
4. get size from block device
5. add depends on CONFIG_BLOCK
On patch 2:
1. update document
On patch 3:
1. update codes for new blkzone. Blkoops support insmod without total_size.
   for example: "insmod ./blkoops.ko blkdev=93:6" (major:minor).
2. use late_initcalls rather than module_init, to avoid block device not ready.
3. support for block driver to add panic apis to blkoops. By this, block
   driver can do the least work that just provides panic operations.
On patch 5:
1. update document

[PATCH v8]
On patch 2:
1. move DT to /bindings/pstore
2. Delete details for kernel.

[PATCH v7]
On patch 1:
1. Fix line over 80 characters.
On patch 2:
1. Insert a separate patch for DT bindings.

[PATCH v6]
On patch 1:
1. Fix according to email from Kees Cook, including spelling mistakes,
   explicit overflow test, none of the zeroing etc.
2. Do not recover data but metadata of dmesg when panic.
3. No need to take recovery when do erase.
4. Do not use "blkoops" for blkzone any more because "blkoops" is used for
   other module now. (rename blkbuf to blkoops)
On patch 2:
1. Rename blkbuf to blkoops.
2. Add Kconfig/device tree/module parameters settings for blkoops.
3. Add document for device tree.
On patch 3:
1. Blkoops support pmsg.
2. Fix description for new version patch.
On patch 4:
1. Fix description for new version patch.

[PATCH v5]
On patch 1:
1. rename pstore/rom to pstore/blk
2. Do not allocate any memory in the write path of panic. So, use local
array instead in function romz_recover_dmesg_meta.
3. Add C header file "linux/fs.h" to fix implicit declaration of function
   'filp_open','kernel_read'...
On patch 3:
1. If panic, do not recover pmsg but flush if it is dirty.
2. Fix erase pmsg failed.
On patch 4:
1. Create a document for pstore/blk

[PATCH v4]
On patch 1:
1. Fix always true condition '(--i >= 0) => (0-u32max >= 0)' in function
   romz_init_zones by defining variable i to 'int' rahter than
   'unsigned int'.
2. To make codes more easily to read, we use macro READ_NEXT_ZONE for
   return value of romz_dmesg_read if it need to read next zone.
   Moveover, we assign READ_NEXT_ZONE -1024 rather than 0.
3. Add 'FLUSH_META' to 'enum romz_flush_mode' and rename 'NOT_FLUSH' to
   'FLUSH_NONE'
4. Function romz_zone_write work badly with FLUSH_PART mode as badly
   address and offset to write.
On patch 3:
NEW SUPPORT psmg for pstore_rom.

[PATCH v3]
On patch 1:
Fix build as module error for undefined 'vfs_read' and 'vfs_write'
Both of 'vfs_read' and 'vfs_write' haven't be exproted yet, so we use
'kernel_read' and 'kernel_write' instead.

[PATCH v2]
On patch 1:
Fix build as module error for redefinition of 'romz_unregister' and
'romz_register'

[PATCH v1]
On patch 1:
Core codes of pstore_rom, which works well on allwinner(sunxi) platform.
On patch 2:
A sample for pstore_rom, using general ram rather than block device.

liaoweixiong (4):
  pstore/blk: new support logger for block devices
  pstore/blk: add blkoops for pstore_blk
  pstore/blk: support pmsg for pstore block
  Documentation: pstore/blk: create document for pstore_blk

 Documentation/admin-guide/pstore-block.rst |  233 ++++++
 MAINTAINERS                                |    3 +-
 fs/pstore/Kconfig                          |  147 ++++
 fs/pstore/Makefile                         |    5 +
 fs/pstore/blkoops.c                        |  208 +++++
 fs/pstore/blkzone.c                        | 1242 ++++++++++++++++++++++++++++
 include/linux/pstore_blk.h                 |   87 ++
 7 files changed, 1924 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/pstore-block.rst
 create mode 100644 fs/pstore/blkoops.c
 create mode 100644 fs/pstore/blkzone.c
 create mode 100644 include/linux/pstore_blk.h

-- 
1.9.1

