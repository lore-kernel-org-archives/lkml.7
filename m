Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4548C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9146E21985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817252;
	bh=a07mUGGtDLw1O/GxAlCS3+F+irmF9H3XDmJT+P6GoAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jyQeluOL8t+0xGU0zFdFo3/9DKEvrLNHxiAO44qnGjzX21T17/isR8/lSQkiLeuma
	 Eg9ZQpg2L3+z8Bv6mUgH9zbEkEVErJPjWHB+SE4D4vCpSWF+wKCDBKKdQs429/2AmX
	 LrigwV3fy68WspZ7sZcfRTxOA74o2mt7sWm2ePiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfGVRkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbfGVRku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:40:50 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2667621901;
        Mon, 22 Jul 2019 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817249;
        bh=a07mUGGtDLw1O/GxAlCS3+F+irmF9H3XDmJT+P6GoAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2FaiNEJCnexeibp1hVncA+XMZ8NckS9Lqb24Kbta66NS4GibFY7bCt44n210/fng
         ls2z9e6nm40rQmLdPrED5MVdvZdn/Glbn2uy1VdMqna8dyJp5JRUKNCLyI609RQdy8
         CptxnUmHw4ahZ6Kn6P9pVJXPz3PmAaIELI7mYw9U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Denis Bakhvalov <denis.bakhvalov@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/37] perf script: Fix off by one in brstackinsn IPC computation
Date:   Mon, 22 Jul 2019 14:38:20 -0300
Message-Id: <20190722173839.22898-19-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When we hit the end of a program block, need to count the last
instruction too for the IPC computation. This caused large errors for
small blocks.

  % perf script -b ls / > /dev/null

Before:

  % perf script -F +brstackinsn --xed
  ...
        00007f94c9ac70d8                        jz 0x7f94c9ac70e3                       # PRED 3 cycles [36] 4.33 IPC
        00007f94c9ac70e3                        testb  $0x20, 0x31d(%rbx)
        00007f94c9ac70ea                        jnz 0x7f94c9ac70b0
        00007f94c9ac70ec                        testb  $0x8, 0x205ad(%rip)
        00007f94c9ac70f3                        jz 0x7f94c9ac6ff0               # PRED 1 cycles [37] 3.00 IPC

After:

  % perf script -F +brstackinsn --xed
  ...
        00007f94c9ac70d8                        jz 0x7f94c9ac70e3                       # PRED 3 cycles [15] 4.67 IPC
        00007f94c9ac70e3                        testb  $0x20, 0x31d(%rbx)
        00007f94c9ac70ea                        jnz 0x7f94c9ac70b0
        00007f94c9ac70ec                        testb  $0x8, 0x205ad(%rip)
        00007f94c9ac70f3                        jz 0x7f94c9ac6ff0               # PRED 1 cycles [16] 4.00 IPC

Suggested-by: Denis Bakhvalov <denis.bakhvalov@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190711181922.18765-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8f24865596af..0140ddb8dd0b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1059,7 +1059,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 			if (ip == end) {
-				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp,
+				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, ++insn, fp,
 							    &total_cycles);
 				if (PRINT_FIELD(SRCCODE))
 					printed += print_srccode(thread, x.cpumode, ip);
-- 
2.21.0

