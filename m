Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D6BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CDC2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK0J5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:57:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:16795 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfK0J5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 04:57:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 01:57:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,249,1571727600"; 
   d="scan'208";a="199133590"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.70])
  by orsmga007.jf.intel.com with ESMTP; 27 Nov 2019 01:57:27 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/2] perf script: Fix invalid LBR/binary mismatch error
Date:   Wed, 27 Nov 2019 11:56:31 +0200
Message-Id: <20191127095631.15663-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'len' returned by grab_bb() includes an extra MAXINSN bytes to allow
for the last instruction, so the the final 'offs' will not be 'len'.
Fix the error condition logic accordingly.

Before:

  $ perf record -e '{intel_pt//,cpu/mem_inst_retired.all_loads,aux-sample-size=8192/pp}:u' grep -rqs jhgjhg /boot
  [ perf record: Woken up 19 times to write data ]
  [ perf record: Captured and wrote 2.274 MB perf.data ]
  $ perf script -F +brstackinsn --xed --itrace=i1usl100 | head
            grep 13759 [002]  8091.310257:       1862                                        instructions:uH:      5641d58069eb bmexec+0x86b (/bin/grep)
        bmexec+2485:
        00005641d5806b35                        jnz 0x5641d5806bd0              # MISPRED
        00005641d5806bd0                        movzxb  (%r13,%rdx,1), %eax
        00005641d5806bd6                        add %rdi, %rax
        00005641d5806bd9                        movzxb  -0x1(%rax), %edx
        00005641d5806bdd                        cmp %rax, %r14
        00005641d5806be0                        jnb 0x5641d58069c0              # MISPRED
        mismatch of LBR data and executable
        00005641d58069c0                        movzxb  (%r13,%rdx,1), %edi

After:

  $ perf script -F +brstackinsn --xed --itrace=i1usl100 | head
            grep 13759 [002]  8091.310257:       1862                                        instructions:uH:      5641d58069eb bmexec+0x86b (/bin/grep)
        bmexec+2485:
        00005641d5806b35                        jnz 0x5641d5806bd0              # MISPRED
        00005641d5806bd0                        movzxb  (%r13,%rdx,1), %eax
        00005641d5806bd6                        add %rdi, %rax
        00005641d5806bd9                        movzxb  -0x1(%rax), %edx
        00005641d5806bdd                        cmp %rax, %r14
        00005641d5806be0                        jnb 0x5641d58069c0              # MISPRED
        00005641d58069c0                        movzxb  (%r13,%rdx,1), %edi
        00005641d58069c6                        add %rax, %rdi

Reported-by: Andi Kleen <ak@linux.intel.com>
Fixes: e98df280bc2a ("perf script brstackinsn: Fix recovery from LBR/binary mismatch")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e8db26b9b29e..e2406b291c1c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1126,7 +1126,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				insn++;
 			}
 		}
-		if (off != (unsigned)len)
+		if (off != end - start)
 			printed += fprintf(fp, "\tmismatch of LBR data and executable\n");
 	}
 
-- 
2.17.1

