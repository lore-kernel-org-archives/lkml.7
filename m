Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E357C10F05
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208E62086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCQSCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:02:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:6475 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfCQSCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:02:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Mar 2019 11:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,490,1544515200"; 
   d="scan'208";a="135093367"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 17 Mar 2019 11:02:13 -0700
Subject: [PATCH] device-dax: Drop register_filesystem()
From:   Dan Williams <dan.j.williams@intel.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 17 Mar 2019 10:49:34 -0700
Message-ID: <155284497431.996981.8629530520988419809.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device-dax fs is only there to allocate a common inode for each
device-node that refers to the same device by major:minor. It is
otherwise not user mountable and need not be displayed in
/proc/filesystems.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/super.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index ccb22d8db3a2..3d6a9e61e358 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -615,10 +615,6 @@ static int dax_fs_init(void)
 	if (!dax_cache)
 		return -ENOMEM;
 
-	rc = register_filesystem(&dax_fs_type);
-	if (rc)
-		goto err_register_fs;
-
 	dax_mnt = kern_mount(&dax_fs_type);
 	if (IS_ERR(dax_mnt)) {
 		rc = PTR_ERR(dax_mnt);
@@ -629,8 +625,6 @@ static int dax_fs_init(void)
 	return 0;
 
  err_mount:
-	unregister_filesystem(&dax_fs_type);
- err_register_fs:
 	kmem_cache_destroy(dax_cache);
 
 	return rc;
@@ -639,7 +633,6 @@ static int dax_fs_init(void)
 static void dax_fs_exit(void)
 {
 	kern_unmount(dax_mnt);
-	unregister_filesystem(&dax_fs_type);
 	kmem_cache_destroy(dax_cache);
 }
 

