Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75A8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB6E2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfDOPgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:36:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:33648 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfDOPgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:36:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 08:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="140843503"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2019 08:36:17 -0700
Received: from [10.251.90.212] (abudanko-mobl.ccr.corp.intel.com [10.251.90.212])
        by linux.intel.com (Postfix) with ESMTP id 0BFB15804D6;
        Mon, 15 Apr 2019 08:36:14 -0700 (PDT)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1] perf record: collect user registers set jointly with dwarf
 stacks
Organization: Intel Corp.
Message-ID: <a83183c0-21f4-02af-1443-1a3fdb5d89c3@linux.intel.com>
Date:   Mon, 15 Apr 2019 18:36:13 +0300
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

  $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- matrix.gcc.g.03

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

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 84cfb9fe2fc6..29a223b4c699 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -702,7 +702,8 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
 		if (!function) {
 			perf_evsel__set_sample_bit(evsel, REGS_USER);
 			perf_evsel__set_sample_bit(evsel, STACK_USER);
-			attr->sample_regs_user |= PERF_REGS_MASK;
+			if (!opts->sample_user_regs)
+				attr->sample_regs_user |= PERF_REGS_MASK;
 			attr->sample_stack_user = param->dump_size;
 			attr->exclude_callchain_user = 1;
 		} else {
-- 
2.20.1

