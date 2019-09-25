Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2665BC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B3F2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="XgGl+7z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfIYIsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:48:43 -0400
Received: from mail.synology.com ([211.23.38.101]:49999 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbfIYIsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:48:42 -0400
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Sep 2019 04:48:41 EDT
Received: from localhost.localdomain (unknown [10.17.32.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id AF93B92B0345;
        Wed, 25 Sep 2019 16:38:44 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1569400724; bh=qoQWCxWCJPyKO21TpgsOgMJlEEgWmStypzH+J3eiBUw=;
        h=From:To:Cc:Subject:Date;
        b=XgGl+7z+8JyOlb60HISxEuT/Y4gp2JCJZ0xdJ9+Ifq7JNszjy8tM32qHWa2vF7X4W
         wcAsFcfRLC1ez9Kx45SdkU+6GVcM1X/zlVD3+XdqPVSKiG2MHJui9Fu7RXe+1xI5b/
         0TFf03izZUhOFUk4bIIiL6ik/vA0SpvrcOFrZpHg=
From:   jiayeli <jiayeli@synology.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jia-Ye Li <jiayeli@synology.com>
Subject: [PATCH] staging: exfat: Use kvzalloc() instead of kzalloc() for exfat_sb_info
Date:   Wed, 25 Sep 2019 16:37:29 +0800
Message-Id: <20190925083729.4653-1-jiayeli@synology.com>
X-Mailer: git-send-email 2.17.1
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ye Li <jiayeli@synology.com>

Fix mount failed "Cannot allocate memory".

When the memory gets fragmented, kzalloc() might fail to allocate
physically contiguous pages for the struct exfat_sb_info (its size is
about 34KiB) even the total free memory is enough.
Use kvzalloc() to solve this problem.

Reviewed-by: Ethan Wu <ethanwu@synology.com>
Signed-off-by: Jia-Ye Li <jiayeli@synology.com>
---
 drivers/staging/exfat/exfat_super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5f6caee819a6..bfad2a6bbcb3 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/seq_file.h>
 #include <linux/pagemap.h>
 #include <linux/mpage.h>
@@ -3450,7 +3451,7 @@ static void exfat_free_super(struct exfat_sb_info *sbi)
 		kfree(sbi->options.iocharset);
 	/* mutex_init is in exfat_fill_super function. only for 3.7+ */
 	mutex_destroy(&sbi->s_lock);
-	kfree(sbi);
+	kvfree(sbi);
 }
 
 static void exfat_put_super(struct super_block *sb)
@@ -3845,7 +3846,7 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	 * the filesystem, since we're only just about to mount
 	 * it and have no inodes etc active!
 	 */
-	sbi = kzalloc(sizeof(struct exfat_sb_info), GFP_KERNEL);
+	sbi = kvzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	mutex_init(&sbi->s_lock);
-- 
2.17.1

