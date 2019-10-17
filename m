Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B3DECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CDD2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391741AbfJQLB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:01:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52656 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfJQLB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:01:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iL3X1-0006fC-Ma; Thu, 17 Oct 2019 13:01:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 379671C009F;
        Thu, 17 Oct 2019 13:01:23 +0200 (CEST)
Date:   Thu, 17 Oct 2019 11:01:23 -0000
From:   "tip-bot2 for Zhenzhong Duan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/acpi: Move get_cmdline_acpi_rsdp() under
 #ifdef guard
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1569719633-32164-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1569719633-32164-1-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Message-ID: <157131008302.29376.13454551774742695304.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c83672e12b98de42bc4549d806588fc3955f8935
Gitweb:        https://git.kernel.org/tip/c83672e12b98de42bc4549d806588fc3955f8935
Author:        Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate:    Sun, 29 Sep 2019 09:13:52 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Oct 2019 12:55:49 +02:00

x86/boot/acpi: Move get_cmdline_acpi_rsdp() under #ifdef guard

When building with "EXTRA_CFLAGS=-Wall" gcc warns:

arch/x86/boot/compressed/acpi.c:29:30: warning: get_cmdline_acpi_rsdp defined but not used [-Wunused-function]

get_cmdline_acpi_rsdp() is only used when CONFIG_RANDOMIZE_BASE and
CONFIG_MEMORY_HOTREMOVE are both enabled, so any build where one of these
config options is disabled has this issue.

Move the function under the same ifdef guard as the call site.

[ tglx: Add context to the changelog so it becomes useful ]

Fixes: 41fa1ee9c6d6 ("acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1569719633-32164-1-git-send-email-zhenzhong.duan@oracle.com

---
 arch/x86/boot/compressed/acpi.c | 48 ++++++++++++++++----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 149795c..25019d4 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -21,30 +21,6 @@
 struct mem_vector immovable_mem[MAX_NUMNODES*2];
 
 /*
- * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
- * digits, and '\0' for termination.
- */
-#define MAX_ADDR_LEN 19
-
-static acpi_physical_address get_cmdline_acpi_rsdp(void)
-{
-	acpi_physical_address addr = 0;
-
-#ifdef CONFIG_KEXEC
-	char val[MAX_ADDR_LEN] = { };
-	int ret;
-
-	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
-	if (ret < 0)
-		return 0;
-
-	if (kstrtoull(val, 16, &addr))
-		return 0;
-#endif
-	return addr;
-}
-
-/*
  * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
  * ACPI_TABLE_GUID are found, take the former, which has more features.
  */
@@ -298,6 +274,30 @@ acpi_physical_address get_rsdp_addr(void)
 }
 
 #if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE)
+/*
+ * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
+ * digits, and '\0' for termination.
+ */
+#define MAX_ADDR_LEN 19
+
+static acpi_physical_address get_cmdline_acpi_rsdp(void)
+{
+	acpi_physical_address addr = 0;
+
+#ifdef CONFIG_KEXEC
+	char val[MAX_ADDR_LEN] = { };
+	int ret;
+
+	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
+	if (ret < 0)
+		return 0;
+
+	if (kstrtoull(val, 16, &addr))
+		return 0;
+#endif
+	return addr;
+}
+
 /* Compute SRAT address from RSDP. */
 static unsigned long get_acpi_srat_table(void)
 {
