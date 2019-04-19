Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09E6C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985F32064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfDSTKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:10:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:16194 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfDSTKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:10:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 02:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,369,1549958400"; 
   d="scan'208";a="144176402"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 19 Apr 2019 02:48:09 -0700
Received: from [10.125.252.182] (abudanko-mobl.ccr.corp.intel.com [10.125.252.182])
        by linux.intel.com (Postfix) with ESMTP id 517E5580259;
        Fri, 19 Apr 2019 02:48:07 -0700 (PDT)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2] perf record: collect user registers set jointly with dwarf
 stacks
Organization: Intel Corp.
Message-ID: <4d760d2d-d505-6e39-b971-c8c4e1c8d12c@linux.intel.com>
Date:   Fri, 19 Apr 2019 12:48:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When dwarf stacks are collected jointly with user specified register
set using --user-regs option like below the full register context is
still captured on a sample:

  $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- matrix.gcc.g.O3

  188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
  ... FP chain: nr:0
  ... user regs: mask 0xff0fff ABI 64-bit
  .... AX    0x53b
  .... BX    0x7ffedbdd3cc0
  .... CX    0xffffffff
  .... DX    0x33d3a
  .... SI    0x7f09b74c38d0
  .... DI    0x0
  .... BP    0x401260
  .... SP    0x7ffedbdd3cc0
  .... IP    0x401236
  .... FLAGS 0x20a
  .... CS    0x33
  .... SS    0x2b
  .... R8    0x7f09b74c3800
  .... R9    0x7f09b74c2da0
  .... R10   0xfffffffffffff3ce
  .... R11   0x246
  .... R12   0x401070
  .... R13   0x7ffedbdd5db0
  .... R14   0x0
  .... R15   0x0
  ... ustack: size 1024, offset 0xe0
   . data_src: 0x5080021
   ... thread: stack_test2.g.O:23828
   ...... dso: /root/abudanko/stacks/stack_test2.g.O3

After applying the change suggested in the patch the sample data contain
only user specified register values:

  $ perf record -g --call-graph dwarf,1024 --user-regs=BP -- matrix.gcc.g.03

  188368474305373 0x5e40 [0x470]: PERF_RECORD_SAMPLE(IP, 0x4002): 23839/23839: 0x401236 period: 1260507 addr: 0x7ffd3d85e96c
  ... FP chain: nr:0
  ... user regs: mask 0x1c0 ABI 64-bit
  .... BP    0x401260
  .... SP    0x7ffd3d85cc20
  .... IP    0x401236
  ... ustack: size 1024, offset 0x58
   . data_src: 0x5080021
   ... thread: stack_test2.g.O:23839
   ...... dso: /root/abudanko/stacks/stack_test2.g.O3

IP and SP registers (dwarf_regs) are collected anayways regardless of
the --user-regs option value provided from the command line:

  -g call-graph dwarf,K                         full_regs
  -g call-graph dwarf,K --user-regs=user_regs	user_regs | dwarf_regs
  --user-regs=user_regs                         user_regs

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v2:
- implemented dwarf register set to avoid corrupted trace 
  when --user-regs option value omits IP,SP

---
 tools/perf/arch/arm/include/perf_regs.h     | 3 +++
 tools/perf/arch/arm64/include/perf_regs.h   | 3 +++
 tools/perf/arch/powerpc/include/perf_regs.h | 3 +++
 tools/perf/arch/s390/include/perf_regs.h    | 3 +++
 tools/perf/arch/x86/include/perf_regs.h     | 3 +++
 tools/perf/util/evsel.c                     | 5 ++++-
 tools/perf/util/perf_regs.h                 | 1 +
 7 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/include/perf_regs.h b/tools/perf/arch/arm/include/perf_regs.h
index ed20e0253e25..550642e4b651 100644
--- a/tools/perf/arch/arm/include/perf_regs.h
+++ b/tools/perf/arch/arm/include/perf_regs.h
@@ -15,6 +15,9 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP	PERF_REG_ARM_PC
 #define PERF_REG_SP	PERF_REG_ARM_SP
 
+#define PERF_DWARF_REGS_MASK ((1ULL << PERF_REG_IP) | \
+			      (1ULL << PERF_REG_SP))
+
 static inline const char *perf_reg_name(int id)
 {
 	switch (id) {
diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
index baaa5e64a3fb..74391ab6f5a6 100644
--- a/tools/perf/arch/arm64/include/perf_regs.h
+++ b/tools/perf/arch/arm64/include/perf_regs.h
@@ -15,6 +15,9 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP	PERF_REG_ARM64_PC
 #define PERF_REG_SP	PERF_REG_ARM64_SP
 
+#define PERF_DWARF_REGS_MASK ((1ULL << PERF_REG_IP) | \
+			      (1ULL << PERF_REG_SP))
+
 static inline const char *perf_reg_name(int id)
 {
 	switch (id) {
diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
index e18a3556f5e3..a061f0ed12b0 100644
--- a/tools/perf/arch/powerpc/include/perf_regs.h
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -19,6 +19,9 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP     PERF_REG_POWERPC_NIP
 #define PERF_REG_SP     PERF_REG_POWERPC_R1
 
+#define PERF_DWARF_REGS_MASK ((1ULL << PERF_REG_IP) | \
+			      (1ULL << PERF_REG_SP))
+
 static const char *reg_names[] = {
 	[PERF_REG_POWERPC_R0] = "r0",
 	[PERF_REG_POWERPC_R1] = "r1",
diff --git a/tools/perf/arch/s390/include/perf_regs.h b/tools/perf/arch/s390/include/perf_regs.h
index bcfbaed78cc2..c11b04c3385d 100644
--- a/tools/perf/arch/s390/include/perf_regs.h
+++ b/tools/perf/arch/s390/include/perf_regs.h
@@ -14,6 +14,9 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP PERF_REG_S390_PC
 #define PERF_REG_SP PERF_REG_S390_R15
 
+#define PERF_DWARF_REGS_MASK ((1ULL << PERF_REG_IP) | \
+			      (1ULL << PERF_REG_SP))
+
 static inline const char *perf_reg_name(int id)
 {
 	switch (id) {
diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index 7f6d538f8a89..f7866be7b44f 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -24,6 +24,9 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP PERF_REG_X86_IP
 #define PERF_REG_SP PERF_REG_X86_SP
 
+#define PERF_DWARF_REGS_MASK ((1ULL << PERF_REG_IP) | \
+			      (1ULL << PERF_REG_SP))
+
 static inline const char *perf_reg_name(int id)
 {
 	switch (id) {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 84cfb9fe2fc6..e21746f4c76d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -702,7 +702,10 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
 		if (!function) {
 			perf_evsel__set_sample_bit(evsel, REGS_USER);
 			perf_evsel__set_sample_bit(evsel, STACK_USER);
-			attr->sample_regs_user |= PERF_REGS_MASK;
+			if (opts->sample_user_regs)
+				attr->sample_regs_user |= PERF_DWARF_REGS_MASK;
+			else
+				attr->sample_regs_user |= PERF_REGS_MASK;
 			attr->sample_stack_user = param->dump_size;
 			attr->exclude_callchain_user = 1;
 		} else {
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index c9319f8d17a6..3d2c3e299081 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -31,6 +31,7 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 #else
 #define PERF_REGS_MASK	0
 #define PERF_REGS_MAX	0
+#define PERF_DWARF_REGS_MASK PERF_REGS_MASK
 
 static inline const char *perf_reg_name(int id __maybe_unused)
 {
-- 
2.20.1

