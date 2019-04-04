Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F55C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935B72171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367874;
	bh=sDCsD5SS1vfN+GZgccppNm+vuSDZVE9HCl105K/wOp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aNRt4K1Cmt6b7/tQJ4rq4HwrQKt6nfI885SPBnXu4FSJ8ntl7kl8Xq1ANRN8KGzyO
	 YMQduqk8IYypSoL6xEMUzcCz5UPYA3Llr4R3qwqQUSWBe/QWx4NIYVWe3FnylmMZO7
	 ygovdw+NzjlVySREZLr4+PteFkJcWtbr1ohwjiWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfDDIvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:51:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbfDDIvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:51:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A4B820882;
        Thu,  4 Apr 2019 08:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367869;
        bh=sDCsD5SS1vfN+GZgccppNm+vuSDZVE9HCl105K/wOp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anx4uqoSf2ZZF0HxDH6LyY7vSbBHE8B/gGGJfM4ykF7hRvFTPTiK8grTc7lUXRbxU
         p0xogfYS6FauawD2oFUuVS6hf01h/mfuaXzA1SIG2vm15wjXl9PxRVZf4k9pUjixYq
         lcEuC4MIS0WURefRYIl93KJlAuPYW/Q8JIzbzLKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 43/91] perf test: Fix failure of evsel-tp-sched test on s390
Date:   Thu,  4 Apr 2019 10:47:27 +0200
Message-Id: <20190404084537.956404709@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 66b53f10eb18..ea772d41e472 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -42,7 +42,7 @@ int test__perf_evsel__tp_sched_test(int subtest __maybe_unused)
 		return -1;
 	}
 
-	if (perf_evsel__test_field(evsel, "prev_comm", 16, true))
+	if (perf_evsel__test_field(evsel, "prev_comm", 16, false))
 		ret = -1;
 
 	if (perf_evsel__test_field(evsel, "prev_pid", 4, true))
@@ -54,7 +54,7 @@ int test__perf_evsel__tp_sched_test(int subtest __maybe_unused)
 	if (perf_evsel__test_field(evsel, "prev_state", sizeof(long), true))
 		ret = -1;
 
-	if (perf_evsel__test_field(evsel, "next_comm", 16, true))
+	if (perf_evsel__test_field(evsel, "next_comm", 16, false))
 		ret = -1;
 
 	if (perf_evsel__test_field(evsel, "next_pid", 4, true))
@@ -72,7 +72,7 @@ int test__perf_evsel__tp_sched_test(int subtest __maybe_unused)
 		return -1;
 	}
 
-	if (perf_evsel__test_field(evsel, "comm", 16, true))
+	if (perf_evsel__test_field(evsel, "comm", 16, false))
 		ret = -1;
 
 	if (perf_evsel__test_field(evsel, "pid", 4, true))
-- 
2.19.1



