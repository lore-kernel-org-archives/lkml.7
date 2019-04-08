Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0ABC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D86920880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0Wz4I8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDHF7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:59:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34853 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfDHF7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:59:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so6679849plp.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8wdMjzOHYL2rrqJib8VDWFyeI/1IpSfXKFoJL8GnNYk=;
        b=U0Wz4I8/W/Ap699nOO/X2Kl/h476TsFXIyECt3mDYXmDRS5S1SlHcxJSE3TXBG0U3R
         Kz9R+SoYedn4wivj8ZO1lSTxsZD+2gBHFWki9JEVb8ecV6qlFRnRbfo9QfM2h+wp0Kln
         DHFxmtJseCwudgJOOJZTe2stPGZCh9l7k8F7Rox9pdYBN8YEgEMyv5fkxut4v+8+Jkdr
         1L4flgk6xmdZJ9P6yBiWSNW8dnb1lb9C4PCc4VeDxGNyU3BW3zde+trqNK48L5LR+RWD
         CSnxxVJ6+pgbLo7Z0pgAdxPOoVwVXpUq1cjdHZgjDFpPKiqgvhPLI6P/fk8+McZS7fnL
         0EhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8wdMjzOHYL2rrqJib8VDWFyeI/1IpSfXKFoJL8GnNYk=;
        b=m4xATOycoe3XtdRzdzx7k96V+i7fNLo2WpOacs8C2ZIyCV3GygR/BkhdD+JCFcPL19
         C0eTMnc/iHU4AmWZZLg+k2AQL33PV5JIKO3RI2QKGHvIAVOBJTHT0BsyoNKYwcX6Y4dP
         TkrFHIQQDkxMlGxBlLhZYnnLgrkbVNFfRxqvf0RNvBINQZx5NsueQvRLNrDitNffo3M3
         uIQOcgKahXn9cCUcnZ7DefOl7NA59TgLT3T41dnEwtvfx7wUhT1FF0a+YysUvLgdh98s
         8sTqBXDLrbz62HMop9lmB/oVarGJMGHO8X9m84VdH0BRUV8sHZt+Bmx/NUXAOrxRgvOX
         YfYg==
X-Gm-Message-State: APjAAAVDx5XsqOSANWJyAm5+V4gdNaiiZRMMwmnjj0amARIp2n7uijqQ
        agQ96Amn5Osa8zI3pHKZQA==
X-Google-Smtp-Source: APXvYqwsaF/nQj2YcrL5MhiwLdcyPDT6c4NLgXtb/Kd9KxXUrkZXCJVNRO9zKMaK2C1RKNUxoUnODw==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr3652311plk.290.1554703159407;
        Sun, 07 Apr 2019 22:59:19 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e1sm34389658pfn.187.2019.04.07.22.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 22:59:18 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] kernel/crash_core: separate the parsing routines to lib/parse_crashkernel.c
Date:   Mon,  8 Apr 2019 13:58:34 +0800
Message-Id: <1554703115-15299-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
References: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beside kernel, at early boot stage, the KASLR code also needs to parse the
crashkernel=x@y or crashkernel=ramsize-range:size[,...][@offset] option,
and avoid to put randomized kernel in the region.

Extracting the parsing related routines to lib/parse_crashkernel.c, so it
will be handy included by other
files.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/crash_core.c     | 273 ---------------------------------------------
 lib/Makefile            |   2 +
 lib/parse_crashkernel.c | 289 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 291 insertions(+), 273 deletions(-)
 create mode 100644 lib/parse_crashkernel.c

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 093c9f9..37c4d6f 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -21,279 +21,6 @@ u32 *vmcoreinfo_note;
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
 static unsigned char *vmcoreinfo_data_safecopy;
 
-/*
- * parsing the "crashkernel" commandline
- *
- * this code is intended to be called from architecture specific code
- */
-
-
-/*
- * This function parses command lines in the format
- *
- *   crashkernel=ramsize-range:size[,...][@offset]
- *
- * The function returns 0 on success and -EINVAL on failure.
- */
-static int __init parse_crashkernel_mem(char *cmdline,
-					unsigned long long system_ram,
-					unsigned long long *crash_size,
-					unsigned long long *crash_base)
-{
-	char *cur = cmdline, *tmp;
-
-	/* for each entry of the comma-separated list */
-	do {
-		unsigned long long start, end = ULLONG_MAX, size;
-
-		/* get the start of the range */
-		start = memparse(cur, &tmp);
-		if (cur == tmp) {
-			pr_warn("crashkernel: Memory value expected\n");
-			return -EINVAL;
-		}
-		cur = tmp;
-		if (*cur != '-') {
-			pr_warn("crashkernel: '-' expected\n");
-			return -EINVAL;
-		}
-		cur++;
-
-		/* if no ':' is here, than we read the end */
-		if (*cur != ':') {
-			end = memparse(cur, &tmp);
-			if (cur == tmp) {
-				pr_warn("crashkernel: Memory value expected\n");
-				return -EINVAL;
-			}
-			cur = tmp;
-			if (end <= start) {
-				pr_warn("crashkernel: end <= start\n");
-				return -EINVAL;
-			}
-		}
-
-		if (*cur != ':') {
-			pr_warn("crashkernel: ':' expected\n");
-			return -EINVAL;
-		}
-		cur++;
-
-		size = memparse(cur, &tmp);
-		if (cur == tmp) {
-			pr_warn("Memory value expected\n");
-			return -EINVAL;
-		}
-		cur = tmp;
-		if (size >= system_ram) {
-			pr_warn("crashkernel: invalid size\n");
-			return -EINVAL;
-		}
-
-		/* match ? */
-		if (system_ram >= start && system_ram < end) {
-			*crash_size = size;
-			break;
-		}
-	} while (*cur++ == ',');
-
-	if (*crash_size > 0) {
-		while (*cur && *cur != ' ' && *cur != '@')
-			cur++;
-		if (*cur == '@') {
-			cur++;
-			*crash_base = memparse(cur, &tmp);
-			if (cur == tmp) {
-				pr_warn("Memory value expected after '@'\n");
-				return -EINVAL;
-			}
-		}
-	} else
-		pr_info("crashkernel size resulted in zero bytes\n");
-
-	return 0;
-}
-
-/*
- * That function parses "simple" (old) crashkernel command lines like
- *
- *	crashkernel=size[@offset]
- *
- * It returns 0 on success and -EINVAL on failure.
- */
-static int __init parse_crashkernel_simple(char *cmdline,
-					   unsigned long long *crash_size,
-					   unsigned long long *crash_base)
-{
-	char *cur = cmdline;
-
-	*crash_size = memparse(cmdline, &cur);
-	if (cmdline == cur) {
-		pr_warn("crashkernel: memory value expected\n");
-		return -EINVAL;
-	}
-
-	if (*cur == '@')
-		*crash_base = memparse(cur+1, &cur);
-	else if (*cur != ' ' && *cur != '\0') {
-		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-#define SUFFIX_HIGH 0
-#define SUFFIX_LOW  1
-#define SUFFIX_NULL 2
-static __initdata char *suffix_tbl[] = {
-	[SUFFIX_HIGH] = ",high",
-	[SUFFIX_LOW]  = ",low",
-	[SUFFIX_NULL] = NULL,
-};
-
-/*
- * That function parses "suffix"  crashkernel command lines like
- *
- *	crashkernel=size,[high|low]
- *
- * It returns 0 on success and -EINVAL on failure.
- */
-static int __init parse_crashkernel_suffix(char *cmdline,
-					   unsigned long long	*crash_size,
-					   const char *suffix)
-{
-	char *cur = cmdline;
-
-	*crash_size = memparse(cmdline, &cur);
-	if (cmdline == cur) {
-		pr_warn("crashkernel: memory value expected\n");
-		return -EINVAL;
-	}
-
-	/* check with suffix */
-	if (strncmp(cur, suffix, strlen(suffix))) {
-		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
-		return -EINVAL;
-	}
-	cur += strlen(suffix);
-	if (*cur != ' ' && *cur != '\0') {
-		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static __init char *get_last_crashkernel(char *cmdline,
-			     const char *name,
-			     const char *suffix)
-{
-	char *p = cmdline, *ck_cmdline = NULL;
-
-	/* find crashkernel and use the last one if there are more */
-	p = strstr(p, name);
-	while (p) {
-		char *end_p = strchr(p, ' ');
-		char *q;
-
-		if (!end_p)
-			end_p = p + strlen(p);
-
-		if (!suffix) {
-			int i;
-
-			/* skip the one with any known suffix */
-			for (i = 0; suffix_tbl[i]; i++) {
-				q = end_p - strlen(suffix_tbl[i]);
-				if (!strncmp(q, suffix_tbl[i],
-					     strlen(suffix_tbl[i])))
-					goto next;
-			}
-			ck_cmdline = p;
-		} else {
-			q = end_p - strlen(suffix);
-			if (!strncmp(q, suffix, strlen(suffix)))
-				ck_cmdline = p;
-		}
-next:
-		p = strstr(p+1, name);
-	}
-
-	if (!ck_cmdline)
-		return NULL;
-
-	return ck_cmdline;
-}
-
-static int __init __parse_crashkernel(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base,
-			     const char *name,
-			     const char *suffix)
-{
-	char	*first_colon, *first_space;
-	char	*ck_cmdline;
-
-	BUG_ON(!crash_size || !crash_base);
-	*crash_size = 0;
-	*crash_base = 0;
-
-	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
-
-	if (!ck_cmdline)
-		return -EINVAL;
-
-	ck_cmdline += strlen(name);
-
-	if (suffix)
-		return parse_crashkernel_suffix(ck_cmdline, crash_size,
-				suffix);
-	/*
-	 * if the commandline contains a ':', then that's the extended
-	 * syntax -- if not, it must be the classic syntax
-	 */
-	first_colon = strchr(ck_cmdline, ':');
-	first_space = strchr(ck_cmdline, ' ');
-	if (first_colon && (!first_space || first_colon < first_space))
-		return parse_crashkernel_mem(ck_cmdline, system_ram,
-				crash_size, crash_base);
-
-	return parse_crashkernel_simple(ck_cmdline, crash_size, crash_base);
-}
-
-/*
- * That function is the entry point for command line parsing and should be
- * called from the arch-specific code.
- */
-int __init parse_crashkernel(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
-{
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-					"crashkernel=", NULL);
-}
-
-int __init parse_crashkernel_high(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
-{
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
-}
-
-int __init parse_crashkernel_low(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
-{
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
-}
-
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/lib/Makefile b/lib/Makefile
index 3b08673..34ccb39 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -164,6 +164,8 @@ obj-$(CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT) += \
 	of-reconfig-notifier-error-inject.o
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 
+obj-$(CONFIG_CRASH_CORE) += parse_crashkernel.o
+
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
diff --git a/lib/parse_crashkernel.c b/lib/parse_crashkernel.c
new file mode 100644
index 0000000..f953930
--- /dev/null
+++ b/lib/parse_crashkernel.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * parsing the "crashkernel" commandline
+ *
+ * this code is intended to be called from architecture specific code
+ */
+#include <linux/crash_core.h>
+
+/*
+ * This function parses command lines in the format
+ *
+ *   crashkernel=ramsize-range:size[,...][@offset]
+ *
+ * The function returns 0 on success and -EINVAL on failure.
+ */
+static int __init parse_crashkernel_mem(char *cmdline,
+					unsigned long long system_ram,
+					unsigned long long *crash_size,
+					unsigned long long *crash_base)
+{
+	char *cur = cmdline, *tmp;
+
+	/* for each entry of the comma-separated list */
+	do {
+		unsigned long long start, end = ULLONG_MAX, size;
+
+		/* get the start of the range */
+		start = memparse(cur, &tmp);
+		if (cur == tmp) {
+			pr_warn("crashkernel: Memory value expected\n");
+			return -EINVAL;
+		}
+		cur = tmp;
+		if (*cur != '-') {
+			pr_warn("crashkernel: '-' expected\n");
+			return -EINVAL;
+		}
+		cur++;
+
+		/* if no ':' is here, than we read the end */
+		if (*cur != ':') {
+			end = memparse(cur, &tmp);
+			if (cur == tmp) {
+				pr_warn("crashkernel: Memory value expected\n");
+				return -EINVAL;
+			}
+			cur = tmp;
+			if (end <= start) {
+				pr_warn("crashkernel: end <= start\n");
+				return -EINVAL;
+			}
+		}
+
+		if (*cur != ':') {
+			pr_warn("crashkernel: ':' expected\n");
+			return -EINVAL;
+		}
+		cur++;
+
+		size = memparse(cur, &tmp);
+		if (cur == tmp) {
+			pr_warn("Memory value expected\n");
+			return -EINVAL;
+		}
+		cur = tmp;
+		if (size >= system_ram) {
+			pr_warn("crashkernel: invalid size\n");
+			return -EINVAL;
+		}
+
+		/* match ? */
+		if (system_ram >= start && system_ram < end) {
+			*crash_size = size;
+			break;
+		}
+	} while (*cur++ == ',');
+
+	if (*crash_size > 0) {
+		while (*cur && *cur != ' ' && *cur != '@')
+			cur++;
+		if (*cur == '@') {
+			cur++;
+			*crash_base = memparse(cur, &tmp);
+			if (cur == tmp) {
+				pr_warn("Memory value expected after '@'\n");
+				return -EINVAL;
+			}
+		}
+	} else
+		pr_info("crashkernel size resulted in zero bytes\n");
+
+	return 0;
+}
+
+/*
+ * That function parses "simple" (old) crashkernel command lines like
+ *
+ *	crashkernel=size[@offset]
+ *
+ * It returns 0 on success and -EINVAL on failure.
+ */
+static int __init parse_crashkernel_simple(char *cmdline,
+					   unsigned long long *crash_size,
+					   unsigned long long *crash_base)
+{
+	char *cur = cmdline;
+
+	*crash_size = memparse(cmdline, &cur);
+	if (cmdline == cur) {
+		pr_warn("crashkernel: memory value expected\n");
+		return -EINVAL;
+	}
+
+	if (*cur == '@')
+		*crash_base = memparse(cur+1, &cur);
+	else if (*cur != ' ' && *cur != '\0') {
+		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+
+#define SUFFIX_HIGH 0
+#define SUFFIX_LOW  1
+#define SUFFIX_NULL 2
+static __initdata char *suffix_tbl[] = {
+	[SUFFIX_HIGH] = ",high",
+	[SUFFIX_LOW]  = ",low",
+	[SUFFIX_NULL] = NULL,
+};
+
+/* At boot stage, KASLR does not care about crashkernel=size,[high|low], which
+ * never specifies the offset of region.
+ */
+#ifndef _BOOT_KASLR
+/*
+ * That function parses "suffix"  crashkernel command lines like
+ *
+ *	crashkernel=size,[high|low]
+ *
+ * It returns 0 on success and -EINVAL on failure.
+ */
+static int __init parse_crashkernel_suffix(char *cmdline,
+					   unsigned long long	*crash_size,
+					   const char *suffix)
+{
+	char *cur = cmdline;
+
+	*crash_size = memparse(cmdline, &cur);
+	if (cmdline == cur) {
+		pr_warn("crashkernel: memory value expected\n");
+		return -EINVAL;
+	}
+
+	/* check with suffix */
+	if (strncmp(cur, suffix, strlen(suffix))) {
+		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
+		return -EINVAL;
+	}
+	cur += strlen(suffix);
+	if (*cur != ' ' && *cur != '\0') {
+		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init __parse_crashkernel(char *cmdline,
+			     unsigned long long system_ram,
+			     unsigned long long *crash_size,
+			     unsigned long long *crash_base,
+			     const char *name,
+			     const char *suffix);
+
+int __init parse_crashkernel_high(char *cmdline,
+			     unsigned long long system_ram,
+			     unsigned long long *crash_size,
+			     unsigned long long *crash_base)
+{
+	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
+				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
+}
+
+int __init parse_crashkernel_low(char *cmdline,
+			     unsigned long long system_ram,
+			     unsigned long long *crash_size,
+			     unsigned long long *crash_base)
+{
+	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
+				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
+}
+#endif
+
+static __init char *get_last_crashkernel(char *cmdline,
+			     const char *name,
+			     const char *suffix)
+{
+	char *p = cmdline, *ck_cmdline = NULL;
+
+	/* find crashkernel and use the last one if there are more */
+	p = strstr(p, name);
+	while (p) {
+		char *end_p = strchr(p, ' ');
+		char *q;
+
+		if (!end_p)
+			end_p = p + strlen(p);
+
+		if (!suffix) {
+			int i;
+
+			/* skip the one with any known suffix */
+			for (i = 0; suffix_tbl[i]; i++) {
+				q = end_p - strlen(suffix_tbl[i]);
+				if (!strncmp(q, suffix_tbl[i],
+					     strlen(suffix_tbl[i])))
+					goto next;
+			}
+			ck_cmdline = p;
+		} else {
+			q = end_p - strlen(suffix);
+			if (!strncmp(q, suffix, strlen(suffix)))
+				ck_cmdline = p;
+		}
+next:
+		p = strstr(p+1, name);
+	}
+
+	if (!ck_cmdline)
+		return NULL;
+
+	return ck_cmdline;
+}
+
+static int __init __parse_crashkernel(char *cmdline,
+			     unsigned long long system_ram,
+			     unsigned long long *crash_size,
+			     unsigned long long *crash_base,
+			     const char *name,
+			     const char *suffix)
+{
+	char	*first_colon, *first_space;
+	char	*ck_cmdline;
+
+	BUG_ON(!crash_size || !crash_base);
+	*crash_size = 0;
+	*crash_base = 0;
+
+	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
+
+	if (!ck_cmdline)
+		return -EINVAL;
+
+	ck_cmdline += strlen(name);
+
+#ifndef _BOOT_KASLR
+	if (suffix)
+		return parse_crashkernel_suffix(ck_cmdline, crash_size,
+				suffix);
+#endif
+	/*
+	 * if the commandline contains a ':', then that's the extended
+	 * syntax -- if not, it must be the classic syntax
+	 */
+	first_colon = strchr(ck_cmdline, ':');
+	first_space = strchr(ck_cmdline, ' ');
+	if (first_colon && (!first_space || first_colon < first_space))
+		return parse_crashkernel_mem(ck_cmdline, system_ram,
+				crash_size, crash_base);
+
+	return parse_crashkernel_simple(ck_cmdline, crash_size, crash_base);
+}
+
+/*
+ * That function is the entry point for command line parsing and should be
+ * called from the arch-specific code.
+ */
+int __init parse_crashkernel(char *cmdline,
+			     unsigned long long system_ram,
+			     unsigned long long *crash_size,
+			     unsigned long long *crash_base)
+{
+	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
+					"crashkernel=", NULL);
+}
-- 
2.7.4

