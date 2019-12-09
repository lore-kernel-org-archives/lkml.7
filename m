Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4935CC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F52520836
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLIRmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:42:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:13261 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfLIRmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:42:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 09:42:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="244532940"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 09 Dec 2019 09:42:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CAFDE122; Mon,  9 Dec 2019 19:42:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] x86/mtrr: Make use of macros from mm.h
Date:   Mon,  9 Dec 2019 19:42:47 +0200
Message-Id: <20191209174248.45342-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use predefined macros from mm.h instead of open coded PAGE_ALIGNED()
and PFN_DOWN(). This will show explicitly the meaning of the operations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/cpu/mtrr/if.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 4d36dcc1cf87..a51eb8e4c079 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -2,6 +2,7 @@
 #include <linux/capability.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
+#include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
@@ -49,10 +50,10 @@ mtrr_file_add(unsigned long base, unsigned long size,
 		FILE_FCOUNT(file) = fcount;
 	}
 	if (!page) {
-		if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1)))
+		if (!PAGE_ALIGNED(base) || !PAGE_ALIGNED(size))
 			return -EINVAL;
-		base >>= PAGE_SHIFT;
-		size >>= PAGE_SHIFT;
+		base = PFN_DOWN(base);
+		size = PFN_DOWN(size);
 	}
 	reg = mtrr_add_page(base, size, type, true);
 	if (reg >= 0)
@@ -68,10 +69,10 @@ mtrr_file_del(unsigned long base, unsigned long size,
 	int reg;
 
 	if (!page) {
-		if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1)))
+		if (!PAGE_ALIGNED(base) || !PAGE_ALIGNED(size))
 			return -EINVAL;
-		base >>= PAGE_SHIFT;
-		size >>= PAGE_SHIFT;
+		base = PFN_DOWN(base);
+		size = PFN_DOWN(size);
 	}
 	reg = mtrr_del_page(-1, base, size);
 	if (reg < 0)
@@ -134,7 +135,7 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 		return -EINVAL;
 
 	size = simple_strtoull(ptr + 5, &ptr, 0);
-	if ((base & 0xfff) || (size & 0xfff))
+	if (!PAGE_ALIGNED(base) || !PAGE_ALIGNED(size))
 		return -EINVAL;
 	ptr = skip_spaces(ptr);
 
@@ -146,8 +147,8 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	if (i < 0)
 		return i;
 
-	base >>= PAGE_SHIFT;
-	size >>= PAGE_SHIFT;
+	base = PFN_DOWN(base);
+	size = PFN_DOWN(size);
 	err = mtrr_add_page((unsigned long)base, (unsigned long)size, i, true);
 	if (err < 0)
 		return err;
-- 
2.24.0

