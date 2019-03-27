Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA0DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2DC206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714703;
	bh=HJGvBuaXPYvkiJgtICL0SGVjZC5YdKICtLAeVf4HRPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bdTm9OK/AoDLkcx48leknqIWBnuQRX8v8gtQUWoIB+F+3f2jP38eWuLyVXCyjprH0
	 g+ViMkBVdWKR3EH2SKAWjsGVpd4/90Rd0cIcP/W3jOjjyEGJWk0wtJJC5VNEGQltGt
	 bBs6IEbz3MgH1huKT/pPuLaB5fn/xMEy4C7HyVJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbfC0SF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387674AbfC0SFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D0962075C;
        Wed, 27 Mar 2019 18:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709924;
        bh=HJGvBuaXPYvkiJgtICL0SGVjZC5YdKICtLAeVf4HRPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPNFtww2fyU0v2W/vfzSuX2NuQPNsu30mpedjmneMkbgEQF8eu9u4IrFxP6ZPCreH
         hsAslPnBJ9QmGgA6TOSzgZY4/Fm68KVl8S1zbpVQ7gPwSVrd3EKhUhn1iz1ut1bdp6
         SGrZ4H152uh0RH/U1V+jdAhjCIFQuv7QXb096Ku8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 115/262] perf test: Fix failure of 'evsel-tp-sched' test on s390
Date:   Wed, 27 Mar 2019 13:59:30 -0400
Message-Id: <20190327180158.10245-115-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 03d309711d687460d1345de8a0363f45b1c8cd11 ]

Commit 489338a717a0 ("perf tests evsel-tp-sched: Fix bitwise operator")
causes test case 14 "Parse sched tracepoints fields" to fail on s390.

This test succeeds on x86.

In fact this test now fails on all architectures with type char treated
as type unsigned char.

The root cause is the signed-ness of character arrays in the tracepoints
sched_switch for structure members prev_comm and next_comm.

On s390 the output of:

 [root@m35lp76 perf]# cat /sys/kernel/debug/tracing/events/sched/sched_switch/format
 name: sched_switch
 ID: 287
 format:
   field:unsigned short common_type; offset:0; size:2;	signed:0;
   ...
   field:char prev_comm[16]; offset:8; size:16;	signed:0;
   ...
   field:char next_comm[16]; offset:40; size:16; signed:0;

reveals the character arrays prev_comm and next_comm are per
default unsigned char and have values in the range of 0..255.

On x86 both fields are signed as this output shows:
 [root@f29]# cat /sys/kernel/debug/tracing/events/sched/sched_switch/format
 name: sched_switch
 ID: 287
 format:
   field:unsigned short common_type; offset:0; size:2;	signed:0;
   ...
   field:char prev_comm[16]; offset:8; size:16;	signed:1;
   ...
   field:char next_comm[16]; offset:40; size:16; signed:1;

and the character arrays prev_comm and next_comm are per default signed
char and have values in the range of -1..127.  The implementation of
type char is architecture specific.

Since the character arrays in both tracepoints sched_switch and
sched_wakeup should contain ascii characters, simply omit the check for
signedness in the test case.

Output before:

  [root@m35lp76 perf]# ./perf test -F 14
  14: Parse sched tracepoints fields                        :
  --- start ---
  sched:sched_switch: "prev_comm" signedness(0) is wrong, should be 1
  sched:sched_switch: "next_comm" signedness(0) is wrong, should be 1
  sched:sched_wakeup: "comm" signedness(0) is wrong, should be 1
  ---- end ----
  14: Parse sched tracepoints fields                        : FAILED!
  [root@m35lp76 perf]#

Output after:

  [root@m35lp76 perf]# ./perf test -Fv 14
  14: Parse sched tracepoints fields                        :
  --- start ---
  ---- end ----
  Parse sched tracepoints fields: Ok
  [root@m35lp76 perf]#

Fixes: 489338a717a0 ("perf tests evsel-tp-sched: Fix bitwise operator")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20190219153639.31267-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/evsel-tp-sched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index 5cbba70bcdd0..ea7acf403727 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -43,7 +43,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 		return -1;
 	}
 
-	if (perf_evsel__test_field(evsel, "prev_comm", 16, true))
+	if (perf_evsel__test_field(evsel, "prev_comm", 16, false))
 		ret = -1;
 
 	if (perf_evsel__test_field(evsel, "prev_pid", 4, true))
@@ -55,7 +55,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 	if (perf_evsel__test_field(evsel, "prev_state", sizeof(long), true))
 		ret = -1;
 
-	if (perf_evsel__test_field(evsel, "next_comm", 16, true))
+	if (perf_evsel__test_field(evsel, "next_comm", 16, false))
 		ret = -1;
 
 	if (perf_evsel__test_field(evsel, "next_pid", 4, true))
@@ -73,7 +73,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 		return -1;
 	}
 
-	if (perf_evsel__test_field(evsel, "comm", 16, true))
+	if (perf_evsel__test_field(evsel, "comm", 16, false))
 		ret = -1;
 
 	if (perf_evsel__test_field(evsel, "pid", 4, true))
-- 
2.19.1

