Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CA2C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD053207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLISAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:00:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:8143 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfLISAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:00:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 09:42:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="210158419"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 09 Dec 2019 09:42:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D7429A0; Mon,  9 Dec 2019 19:42:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] x86/mtrr: Use strstrip() to cut extra spaces
Date:   Mon,  9 Dec 2019 19:42:48 +0200
Message-Id: <20191209174248.45342-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209174248.45342-1-andriy.shevchenko@linux.intel.com>
References: <20191209174248.45342-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cut all white spaces surrounding the passed line.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/cpu/mtrr/if.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index a51eb8e4c079..9d251efdf064 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -97,10 +97,9 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	int i, err;
 	unsigned long reg;
 	unsigned long long base, size;
-	char *ptr;
+	char *ptr, *l;
 	char line[LINE_SIZE];
 	int length;
-	size_t linelen;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -112,23 +111,20 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	if (length < 0)
 		return length;
 
-	linelen = strlen(line);
-	ptr = line + linelen - 1;
-	if (linelen && *ptr == '\n')
-		*ptr = '\0';
+	l = strstrip(line);
 
-	if (!strncmp(line, "disable=", 8)) {
-		reg = simple_strtoul(line + 8, &ptr, 0);
+	if (!strncmp(l, "disable=", 8)) {
+		reg = simple_strtoul(l + 8, &ptr, 0);
 		err = mtrr_del_page(reg, 0, 0);
 		if (err < 0)
 			return err;
 		return len;
 	}
 
-	if (strncmp(line, "base=", 5))
+	if (strncmp(l, "base=", 5))
 		return -EINVAL;
 
-	base = simple_strtoull(line + 5, &ptr, 0);
+	base = simple_strtoull(l + 5, &ptr, 0);
 	ptr = skip_spaces(ptr);
 
 	if (strncmp(ptr, "size=", 5))
-- 
2.24.0

