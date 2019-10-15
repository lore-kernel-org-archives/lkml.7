Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEC5ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E4D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfJOFeO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:34:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42154 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfJOFcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRF-0000Kl-52; Tue, 15 Oct 2019 07:32:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E22421C04F3;
        Tue, 15 Oct 2019 07:31:45 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:45 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace beauty: Add a x86 MSR cmd id->str table generator
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-ja080xawx08kedez855usnon@git.kernel.org>
References: <tip-ja080xawx08kedez855usnon@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750578.12254.13845674153073672746.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     693d345818e106318710ac150ae252b73765d0fa
Gitweb:        https://git.kernel.org/tip/693d345818e106318710ac150ae252b73765d0fa
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 26 Sep 2019 15:28:02 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 09 Oct 2019 11:23:52 -03:00

perf trace beauty: Add a x86 MSR cmd id->str table generator

Without parameters it'll parse tools/arch/x86/include/asm/msr-index.h
and output a table usable by tools, that will be wired up later to a
libtraceevent plugin registered from perf's glue code:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh
  static const char *x86_MSRs[] = {
 <SNIP>
  	[0x00000034] = "SMI_COUNT",
  	[0x0000003a] = "IA32_FEATURE_CONTROL",
  	[0x0000003b] = "IA32_TSC_ADJUST",
  	[0x00000040] = "LBR_CORE_FROM",
  	[0x00000048] = "IA32_SPEC_CTRL",
  	[0x00000049] = "IA32_PRED_CMD",
 <SNIP>
  	[0x0000010b] = "IA32_FLUSH_CMD",
  	[0x0000010F] = "TSX_FORCE_ABORT",
 <SNIP>
  	[0x00000198] = "IA32_PERF_STATUS",
  	[0x00000199] = "IA32_PERF_CTL",
  <SNIP>
  	[0x00000da0] = "IA32_XSS",
  	[0x00000dc0] = "LBR_INFO_0",
  	[0x00000ffc] = "IA32_BNDCFGS_RSVD",
  };

  #define x86_64_specific_MSRs_offset 0xc0000080
  static const char *x86_64_specific_MSRs[] = {
  	[0xc0000080 - x86_64_specific_MSRs_offset] = "EFER",
  	[0xc0000081 - x86_64_specific_MSRs_offset] = "STAR",
  	[0xc0000082 - x86_64_specific_MSRs_offset] = "LSTAR",
  	[0xc0000083 - x86_64_specific_MSRs_offset] = "CSTAR",
  	[0xc0000084 - x86_64_specific_MSRs_offset] = "SYSCALL_MASK",
  <SNIP>
  	[0xc0000103 - x86_64_specific_MSRs_offset] = "TSC_AUX",
  	[0xc0000104 - x86_64_specific_MSRs_offset] = "AMD64_TSC_RATIO",
  };

  #define x86_AMD_V_KVM_MSRs_offset 0xc0010000
  static const char *x86_AMD_V_KVM_MSRs[] = {
  	[0xc0010000 - x86_AMD_V_KVM_MSRs_offset] = "K7_EVNTSEL0",
  <SNIP>
  	[0xc0010114 - x86_AMD_V_KVM_MSRs_offset] = "VM_CR",
  	[0xc0010115 - x86_AMD_V_KVM_MSRs_offset] = "VM_IGNNE",
  	[0xc0010117 - x86_AMD_V_KVM_MSRs_offset] = "VM_HSAVE_PA",
  <SNIP>
  	[0xc0010240 - x86_AMD_V_KVM_MSRs_offset] = "F15H_NB_PERF_CTL",
  	[0xc0010241 - x86_AMD_V_KVM_MSRs_offset] = "F15H_NB_PERF_CTR",
  	[0xc0010280 - x86_AMD_V_KVM_MSRs_offset] = "F15H_PTSC",
  };

Then these will in turn be hooked up in a follow up patch to be used by
strarrays__scnprintf().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ja080xawx08kedez855usnon@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/tracepoints/x86_msr.sh | 40 +++++++++++++++++-
 1 file changed, 40 insertions(+)
 create mode 100755 tools/perf/trace/beauty/tracepoints/x86_msr.sh

diff --git a/tools/perf/trace/beauty/tracepoints/x86_msr.sh b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
new file mode 100755
index 0000000..831c02c
--- /dev/null
+++ b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 1 ] ; then
+	arch_x86_header_dir=tools/arch/x86/include/asm/
+else
+	arch_x86_header_dir=$1
+fi
+
+x86_msr_index=${arch_x86_header_dir}/msr-index.h
+
+# Support all later, with some hash table, for now chop off
+# Just the ones starting with 0x00000 so as to have a simple
+# array.
+
+printf "static const char *x86_MSRs[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x00000[[:xdigit:]]+)[[:space:]]*.*'
+egrep $regex ${x86_msr_index} | egrep -v 'MSR_(ATOM|P[46]|AMD64|IA32_TSCDEADLINE|IDT_FCR4)' | \
+	sed -r "s/$regex/\2 \1/g" | sort -n | \
+	xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n\n"
+
+# Remove MSR_K6_WHCR, clashes with MSR_LSTAR
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0xc0000[[:xdigit:]]+)[[:space:]]*.*'
+printf "#define x86_64_specific_MSRs_offset "
+egrep $regex ${x86_msr_index} | sed -r "s/$regex/\2/g" | sort -n | head -1
+printf "static const char *x86_64_specific_MSRs[] = {\n"
+egrep $regex ${x86_msr_index} | \
+	sed -r "s/$regex/\2 \1/g" | egrep -vw 'K6_WHCR' | sort -n | \
+	xargs printf "\t[%s - x86_64_specific_MSRs_offset] = \"%s\",\n"
+printf "};\n\n"
+
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0xc0010[[:xdigit:]]+)[[:space:]]*.*'
+printf "#define x86_AMD_V_KVM_MSRs_offset "
+egrep $regex ${x86_msr_index} | sed -r "s/$regex/\2/g" | sort -n | head -1
+printf "static const char *x86_AMD_V_KVM_MSRs[] = {\n"
+egrep $regex ${x86_msr_index} | \
+	sed -r "s/$regex/\2 \1/g" | sort -n | \
+	xargs printf "\t[%s - x86_AMD_V_KVM_MSRs_offset] = \"%s\",\n"
+printf "};\n"
