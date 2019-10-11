Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85294ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ED7214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824536;
	bh=pJCL3+IMe0x0vubq8DlEtwCWPaRjkavbQxZsVCrBvb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SDIaZzpWrt2UnN0jXqnlfd6q+QRno0lURiaI89hXG36PqfFcET6VNYfuSPrqvQzVz
	 SfsPwHhQG9ssApyD+zuepg54sfsQhpO6hSED00Lls37XieGxcsZDj6Q4DCt6hQ0bPA
	 VzPuS5f7M2rIQk99i3N9biZsafHYl/Ny3iO204gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfJKUIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfJKUIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:08:54 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 894E021D56;
        Fri, 11 Oct 2019 20:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824533;
        bh=pJCL3+IMe0x0vubq8DlEtwCWPaRjkavbQxZsVCrBvb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JvA6bNLXIJetgF1kiHfW5dpEVmkh5f+rEBNi1fd74rrK56gVWyJs06cy2YLTY4hiv
         DgENHOinxHZnC3B3fZlKb4Jx4TGKSsIZZ18mneor4/NXGnFseFchf522ptkEDFN6o7
         CS7m3FaNTa1v8gMaCF310AAbVahkpkRb99xWBJNU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 27/69] perf trace beauty: Add a x86 MSR cmd id->str table generator
Date:   Fri, 11 Oct 2019 17:05:17 -0300
Message-Id: <20191011200559.7156-28-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 .../perf/trace/beauty/tracepoints/x86_msr.sh  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 tools/perf/trace/beauty/tracepoints/x86_msr.sh

diff --git a/tools/perf/trace/beauty/tracepoints/x86_msr.sh b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
new file mode 100755
index 000000000000..831c02cf0586
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
-- 
2.21.0

