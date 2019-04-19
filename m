Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F985C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC822064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Fx4pjhec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfDSTGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:06:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729470AbfDSTGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:06:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JAiSSi238311
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 03:44:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JAiSSi238311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555670669;
        bh=JinSCEjvJ0qCv6F7YwC7UTaq0RGuXmVuVbYLvFlmBOI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Fx4pjhecthiIRTX6Gt/mLoLPbNJrVZ7bwacRC+LB3qIgb+k8aIUbYdDkwmmWUfDqR
         J1Wpljzct9dkiJ6+Qym2Rqf6ED8qNQlNLwzgcfE1kZvfkwzDJbvNZ+Rqm25yTBsmWo
         cQkW+hpWuCT1diOZw52LIbBjEUKP1op5iGJZbGHwMMVozGhfF6YoIld/wcdCbiDa9E
         lxhUYDR0Rryhgha7qDK3JK05yON2zp2YhtDKwq5wRo83MarmEEeSEiCSnrNrb0aPrC
         skbUyQqN0NI2tUinIR6fdz9j1ym10j8fpOQBIlYSgR9XqWN6CZZV0BQfSoQrm7j2uU
         NEL3wbr8zG3wA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JAiR1x238308;
        Fri, 19 Apr 2019 03:44:27 -0700
Date:   Fri, 19 Apr 2019 03:44:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-90083998312324599cb2a546020755cdc934de0f@git.kernel.org>
Cc:     josh@joshtriplett.org, catalin.marinas@arm.com, joelaf@google.com,
        paulmck@linux.vnet.ibm.com, hpa@zytor.com, mtk.manpages@gmail.com,
        tglx@linutronix.de, mathieu.desnoyers@efficios.com, bmaurer@fb.com,
        rostedt@goodmis.org, davejwatson@fb.com, boqun.feng@gmail.com,
        pjt@google.com, will.deacon@arm.com, torvalds@linux-foundation.org,
        linux@arm.linux.org.uk, cl@linux.com, akpm@linux-foundation.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        luto@amacapital.net, peterz@infradead.org
Reply-To: mathieu.desnoyers@efficios.com, tglx@linutronix.de,
          bmaurer@fb.com, josh@joshtriplett.org, catalin.marinas@arm.com,
          joelaf@google.com, paulmck@linux.vnet.ibm.com, hpa@zytor.com,
          mtk.manpages@gmail.com, akpm@linux-foundation.org, cl@linux.com,
          linux-kernel@vger.kernel.org, shuah@kernel.org, mingo@kernel.org,
          luto@amacapital.net, peterz@infradead.org, davejwatson@fb.com,
          rostedt@goodmis.org, boqun.feng@gmail.com,
          torvalds@linux-foundation.org, pjt@google.com,
          will.deacon@arm.com, linux@arm.linux.org.uk
In-Reply-To: <20190305194755.2602-4-mathieu.desnoyers@efficios.com>
References: <20190305194755.2602-4-mathieu.desnoyers@efficios.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rseq] rseq/selftests: Adapt number of threads to the
 number of detected cpus
Git-Commit-ID: 90083998312324599cb2a546020755cdc934de0f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  90083998312324599cb2a546020755cdc934de0f
Gitweb:     https://git.kernel.org/tip/90083998312324599cb2a546020755cdc934de0f
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Tue, 5 Mar 2019 14:47:55 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 12:39:32 +0200

rseq/selftests: Adapt number of threads to the number of detected cpus

On smaller systems, running a test with 200 threads can take a long
time on machines with smaller number of CPUs.

Detect the number of online cpus at test runtime, and multiply that
by 6 to have 6 rseq threads per cpu preempting each other.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Lameter <cl@linux.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-api@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Link: http://lkml.kernel.org/r/20190305194755.2602-4-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
