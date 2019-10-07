Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1230DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA59321479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfJGOtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:49:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfJGOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUK2-0005v9-SG; Mon, 07 Oct 2019 16:49:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8FE8E1C0895;
        Mon,  7 Oct 2019 16:49:14 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:14 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf annotate: Fix arch specific ->init() failure errors
Cc:     "Russell King - ARM Linux admin" <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-pqx7srcv7tixgid251aeboj6@git.kernel.org>
References: <tip-pqx7srcv7tixgid251aeboj6@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157045975454.9978.13938755107104036230.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     42d7a9107d83223a5fcecc6732d626a6c074cbc2
Gitweb:        https://git.kernel.org/tip/42d7a9107d83223a5fcecc6732d626a6c074cbc2
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 30 Sep 2019 15:48:12 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:30:03 -03:00

perf annotate: Fix arch specific ->init() failure errors

They are called from symbol__annotate() and to propagate errors that can
help understand the problem make them return what
symbol__strerror_disassemble() known, i.e. errno codes and other
annotation specific errors in a special, out of errnos, range.

Reported-by: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-pqx7srcv7tixgid251aeboj6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/annotate/instructions.c   | 4 ++--
 tools/perf/arch/arm64/annotate/instructions.c | 4 ++--
 tools/perf/arch/s390/annotate/instructions.c  | 6 ++++--
 tools/perf/arch/x86/annotate/instructions.c   | 6 ++++--
 tools/perf/util/annotate.c                    | 6 ++++++
 tools/perf/util/annotate.h                    | 2 ++
 6 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/arch/arm/annotate/instructions.c
index e1d4b48..2ff6ced 100644
--- a/tools/perf/arch/arm/annotate/instructions.c
+++ b/tools/perf/arch/arm/annotate/instructions.c
@@ -37,7 +37,7 @@ static int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 
 	arm = zalloc(sizeof(*arm));
 	if (!arm)
-		return -1;
+		return ENOMEM;
 
 #define ARM_CONDS "(cc|cs|eq|ge|gt|hi|le|ls|lt|mi|ne|pl|vc|vs)"
 	err = regcomp(&arm->call_insn, "^blx?" ARM_CONDS "?$", REG_EXTENDED);
@@ -59,5 +59,5 @@ out_free_call:
 	regfree(&arm->call_insn);
 out_free_arm:
 	free(arm);
-	return -1;
+	return SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
 }
diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 43aa93e..037e292 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -95,7 +95,7 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 
 	arm = zalloc(sizeof(*arm));
 	if (!arm)
-		return -1;
+		return ENOMEM;
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
@@ -118,5 +118,5 @@ out_free_call:
 	regfree(&arm->call_insn);
 out_free_arm:
 	free(arm);
-	return -1;
+	return SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
 }
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 89bb8f2..a50e70b 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -164,8 +164,10 @@ static int s390__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	if (!arch->initialized) {
 		arch->initialized = true;
 		arch->associate_instruction_ops = s390__associate_ins_ops;
-		if (cpuid)
-			err = s390__cpuid_parse(arch, cpuid);
+		if (cpuid) {
+			if (s390__cpuid_parse(arch, cpuid))
+				err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
+		}
 	}
 
 	return err;
diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 44f5aba..7eb5621 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -196,8 +196,10 @@ static int x86__annotate_init(struct arch *arch, char *cpuid)
 	if (arch->initialized)
 		return 0;
 
-	if (cpuid)
-		err = x86__cpuid_parse(arch, cpuid);
+	if (cpuid) {
+		if (x86__cpuid_parse(arch, cpuid))
+			err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
+	}
 
 	arch->initialized = true;
 	return err;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1de1a70..dc15352 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1631,6 +1631,12 @@ int symbol__strerror_disassemble(struct symbol *sym __maybe_unused, struct map *
 	case SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF:
 		scnprintf(buf, buflen, "Please link with binutils's libopcode to enable BPF annotation");
 		break;
+	case SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP:
+		scnprintf(buf, buflen, "Problems with arch specific instruction name regular expressions.");
+		break;
+	case SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING:
+		scnprintf(buf, buflen, "Problems while parsing the CPUID in the arch specific initialization.");
+		break;
 	default:
 		scnprintf(buf, buflen, "Internal error: Invalid %d error code\n", errnum);
 		break;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d94be91..116e21f 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -370,6 +370,8 @@ enum symbol_disassemble_errno {
 
 	SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX	= __SYMBOL_ANNOTATE_ERRNO__START,
 	SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF,
+	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING,
+	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP,
 
 	__SYMBOL_ANNOTATE_ERRNO__END,
 };
