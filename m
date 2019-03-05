Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C2EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DD1205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RwcMjT57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfCETsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:48:17 -0500
Received: from mail.efficios.com ([167.114.142.138]:37248 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfCETsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:48:13 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2DB82A18CF;
        Tue,  5 Mar 2019 14:48:12 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id IG0NUGcLH32O; Tue,  5 Mar 2019 14:48:11 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B02BEA18BF;
        Tue,  5 Mar 2019 14:48:11 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B02BEA18BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1551815291;
        bh=Cfb0if2j7qr27a8wQq79l8o8zLis2u6tHcSE1XnbL0Q=;
        h=From:To:Date:Message-Id;
        b=RwcMjT57CCVwPlCtW9WC1K/KVEu5Lry/6FXIWSlKehVnjmc2Qd2iHAIcdYib28TAZ
         ddIsGi/kIVe2GyfzrIL28QOvwFlJ4jZWnQn/6I+BTXPtjsw8gBYd98qySe5Q1MEoQV
         wHETi8cLMOaBXuaBPG3WfLTZwnAMAkgS10PpJCur5F4k8J3U0zzAhqkcGEQOtj7bMx
         dcb/rGFk3aj0pvfbDX4kXCIWceoD08mOCUxc/R9yeiBc4PjvZ7s/7fJb++NILy8C1W
         Tfg7+zkmZKVUVxjpiU/jPtBLMtI7t3uSty/W6KT33dtRKTXqxrAgRt0EMo8vgW5Vno
         v/dGrqRYQkz0g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id y6WjNiJ1kjWk; Tue,  5 Mar 2019 14:48:11 -0500 (EST)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 443BEA18AE;
        Tue,  5 Mar 2019 14:48:11 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH for 5.1 3/3] rseq/selftests: Adapt number of threads to the number of detected cpus
Date:   Tue,  5 Mar 2019 14:47:55 -0500
Message-Id: <20190305194755.2602-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On smaller systems, running a test with 200 threads can take a long
time on machines with smaller number of CPUs.

Detect the number of online cpus at test runtime, and multiply that
by 6 to have 6 rseq threads per cpu preempting each other.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: linux-kselftest@vger.kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Chris Lameter <cl@linux.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 tools/testing/selftests/rseq/run_param_test.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index 3acd6d75ff9f..e426304fd4a0 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+ or MIT
 
+NR_CPUS=`grep '^processor' /proc/cpuinfo | wc -l`
+
 EXTRA_ARGS=${@}
 
 OLDIFS="$IFS"
@@ -28,15 +30,16 @@ IFS="$OLDIFS"
 
 REPS=1000
 SLOW_REPS=100
+NR_THREADS=$((6*${NR_CPUS}))
 
 function do_tests()
 {
 	local i=0
 	while [ "$i" -lt "${#TEST_LIST[@]}" ]; do
 		echo "Running test ${TEST_NAME[$i]}"
-		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
+		./param_test ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		echo "Running compare-twice test ${TEST_NAME[$i]}"
-		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
+		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		let "i++"
 	done
 }
-- 
2.11.0

