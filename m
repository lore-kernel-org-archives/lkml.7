Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBD1C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424272064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TwUC/4C1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfDSTG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:06:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbfDSTGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:06:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JAk4VI239021
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 03:46:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JAk4VI239021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555670766;
        bh=KMXy5bFsHmIcSLl+yxjKCvjgONFeyAEA9qC3Y41B5cU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TwUC/4C1HQcJSbTh+TcwSApXefz1J4o/YQtPqTgjDyAdARUudvWAUHIuA3d34QfFE
         cbp/pDRQuOE/UTsfR/dvQcKEszED+mf+LXLi8bnnvQYU5SceT8fhp7BwqbxXcpeunS
         NKANgLBZsor8Y6VMd9GsVPpKifD2ZG2TYqSHkPN6x06ap8JL/yzfNl35igIHk4huJu
         OiDj6yDtwL6hsB/vAqcD4jXejTgDGuV7LU+EfJ8ugja2saKaLoYZyoqC7SQ/2b18So
         WKEhVsijMybKtMRAMUSiLREs+0wo3KypQ+VsL4DPjqE2+Z7x2ixKC2uT7UxSvdRCVk
         iYgPzlOQCIl/Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JAk0CK239018;
        Fri, 19 Apr 2019 03:46:00 -0700
Date:   Fri, 19 Apr 2019 03:46:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-03a33ecc26af28ca9535de2b0612c54deafa9728@git.kernel.org>
Cc:     davejwatson@fb.com, mingo@kernel.org, cl@linux.com,
        linux-kernel@vger.kernel.org, linux@arm.linux.org.uk,
        mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
        joelaf@google.com, catalin.marinas@arm.com, mtk.manpages@gmail.com,
        luto@amacapital.net, boqun.feng@gmail.com, pjt@google.com,
        bmaurer@fb.com, shuah@kernel.org, paulmck@linux.vnet.ibm.com,
        akpm@linux-foundation.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, hpa@zytor.com, josh@joshtriplett.org
Reply-To: will.deacon@arm.com, akpm@linux-foundation.org,
          rostedt@goodmis.org, catalin.marinas@arm.com, joelaf@google.com,
          davejwatson@fb.com, mingo@kernel.org, bmaurer@fb.com,
          pjt@google.com, paulmck@linux.vnet.ibm.com, shuah@kernel.org,
          linux@arm.linux.org.uk, mathieu.desnoyers@efficios.com,
          linux-kernel@vger.kernel.org, cl@linux.com, peterz@infradead.org,
          tglx@linutronix.de, luto@amacapital.net, josh@joshtriplett.org,
          hpa@zytor.com, boqun.feng@gmail.com, mtk.manpages@gmail.com,
          torvalds@linux-foundation.org
In-Reply-To: <20190305194755.2602-4-mathieu.desnoyers@efficios.com>
References: <20190305194755.2602-4-mathieu.desnoyers@efficios.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rseq] rseq/selftests: Adapt number of threads to the
 number of detected CPUs
Git-Commit-ID: 03a33ecc26af28ca9535de2b0612c54deafa9728
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

Commit-ID:  03a33ecc26af28ca9535de2b0612c54deafa9728
Gitweb:     https://git.kernel.org/tip/03a33ecc26af28ca9535de2b0612c54deafa9728
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Tue, 5 Mar 2019 14:47:55 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 12:42:14 +0200

rseq/selftests: Adapt number of threads to the number of detected CPUs

On smaller systems, running a test with 200 threads can take a long
time on machines with smaller number of CPUs.

Detect the number of online CPUs at test runtime, and multiply that
by 6 to have 6 rseq threads per CPU preempting each other.

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
