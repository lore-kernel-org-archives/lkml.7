Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86256C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FC7208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575949343;
	bh=Igw+4dyj3v7+ABzLjUDiV/H+YDko7hWvb3F+LP9oFN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q6YieceLYM2pmm04myB4c+NM9knPd0MqAt0CYtdLxGVHi3G8xuc38eOAPmRaC4Gl3
	 jY/X5dodSk3hcuFrQrxpB3S+9vaPc1HiNBLZuihBf21bm4JNqh85KTtKYUUbdaftFv
	 EaMDkQtPf8PczzNNJ/Vv4tCKs3vxjjMRSpWtwx2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfLJDmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:42:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfLJDmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:42:21 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6E62073D;
        Tue, 10 Dec 2019 03:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949341;
        bh=Igw+4dyj3v7+ABzLjUDiV/H+YDko7hWvb3F+LP9oFN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zMSkd1sgKfyI/zUEe7k62stK2lBrH+73FUyFY7eJuNBx4DG5ZhBj+MjP5i+aqyxwI
         A7RViR2jLhH3YZ9kQB1RhyluW5wuyVjYB+ufiDnlTll8Vkgu+n17YFNseZKL0s1lq8
         KbhPlqsLT7YaXurTKpncFIykdGe3ef6025/8ERBk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/12] torture: Use gawk instead of awk for systime() function
Date:   Mon,  9 Dec 2019 19:42:06 -0800
Message-Id: <20191210034217.405-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210034119.GA32711@paulmck-ThinkPad-P72>
References: <20191210034119.GA32711@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In many environments, gawk provides systime(), but awk doesn't.
This commit therefore changes awk scripts using systime() to instead be
gawk scripts.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh         | 4 ++--
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index dc49a3b..86a217b 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -23,12 +23,12 @@ spinmax=${4-1000}
 
 n=1
 
-starttime=`awk 'BEGIN { print systime(); }' < /dev/null`
+starttime=`gawk 'BEGIN { print systime(); }' < /dev/null`
 
 while :
 do
 	# Check for done.
-	t=`awk -v s=$starttime 'BEGIN { print systime() - s; }' < /dev/null`
+	t=`gawk -v s=$starttime 'BEGIN { print systime() - s; }' < /dev/null`
 	if test "$t" -gt "$duration"
 	then
 		exit 0;
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 33c6696..1d98992 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -123,7 +123,7 @@ qemu_args=$5
 boot_args=$6
 
 cd $KVM
-kstarttime=`awk 'BEGIN { print systime() }' < /dev/null`
+kstarttime=`gawk 'BEGIN { print systime() }' < /dev/null`
 if test -z "$TORTURE_BUILDONLY"
 then
 	echo ' ---' `date`: Starting kernel
@@ -177,7 +177,7 @@ do
 	then
 		qemu_pid=`cat "$resdir/qemu_pid"`
 	fi
-	kruntime=`awk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
+	kruntime=`gawk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
 	if test -z "$qemu_pid" || kill -0 "$qemu_pid" > /dev/null 2>&1
 	then
 		if test $kruntime -ge $seconds
@@ -213,7 +213,7 @@ then
 	oldline="`tail $resdir/console.log`"
 	while :
 	do
-		kruntime=`awk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
+		kruntime=`gawk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
 		if kill -0 $qemu_pid > /dev/null 2>&1
 		then
 			:
-- 
2.9.5

