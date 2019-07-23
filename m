Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AA0C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E947229EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563912360;
	bh=a07mUGGtDLw1O/GxAlCS3+F+irmF9H3XDmJT+P6GoAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r8bbp5e8DwmgSCZLIx42pzv9FGR6QP8012KEUqs769jI2Qc9lR5xOB8sXvoCJKRgl
	 uwZNQNwwq+0aez9ay+JHHNhhM99Bd8AUJBNruIcZ9DWLya8x9BzQXzbUXuP8QezzMv
	 b804wu/DW8nD6vXMgp21EnPvvoI3pF2A7ekRZOjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbfGWUF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfGWUF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:05:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.218.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91841229EB;
        Tue, 23 Jul 2019 20:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563912357;
        bh=a07mUGGtDLw1O/GxAlCS3+F+irmF9H3XDmJT+P6GoAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFBPIaZCsTvU4LwaXxOPRNKGpr3clIfL/y5vh40SzD8Hvg5CC0+ow9Hw98mhLxnb2
         fbSt6oL9Qrpozl8zaqtlz0dKATZRNDdt5BQKyFs8YrktXGawqJh8EaQ7oDef1Eut2Y
         e9uJiHlT2hoH8hRlN+LbmEdw6XSQz9x2Xp6YgKs0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Denis Bakhvalov <denis.bakhvalov@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/10] perf script: Fix off by one in brstackinsn IPC computation
Date:   Tue, 23 Jul 2019 17:05:23 -0300
Message-Id: <20190723200530.14090-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
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

