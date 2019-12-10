Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E19C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0252465B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575949354;
	bh=O8zSgVKAg5FjaVRPXFRAgSlpaYk/7KotlPxmPGoBjpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZQoacVThtlTW4KGiFhQzUQj5LMOrTPe/UN0i6TXH7Ekbbv9M58YUYR/gguJHj/FAg
	 hBJJqpQ7HECqXtf/6JERS7hWCbS0F41JLLZ0idfzkj3xgQ2RxL/NiU7mkocINPIbd+
	 DLr40qr2bASJzSESSLyjas5Amv6iOR2BNlKps26o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfLJDmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:32832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfLJDm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:42:29 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5BF9222C4;
        Tue, 10 Dec 2019 03:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949348;
        bh=O8zSgVKAg5FjaVRPXFRAgSlpaYk/7KotlPxmPGoBjpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xIAsa6lJroSRwfUyaYatY1AIbzHZRRUDhGm0/tEZFSHLsBEPDuMVXSUGV6oX4BrWy
         rle21P0MNI49Il0Kkxb/HBFjLcdXe0tuxniloaWr4dJso6SvMeVmHZLIq2yZCJuE+P
         FuQYemvdvRpQ1jeLC5zesB/0wpZAbfk+8LFdZsOw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/12] torture: Hoist calls to lscpu to higher-level kvm.sh script
Date:   Mon,  9 Dec 2019 19:42:17 -0800
Message-Id: <20191210034217.405-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210034119.GA32711@paulmck-ThinkPad-P72>
References: <20191210034119.GA32711@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

On some kernels, concurrent calls to the lscpu command result in severe
slowdowns.  For example, on v4.16, a single lscpu invocation takes about
two milliseconds, four concurrent invocations more than two seconds,
and 16 concurrent invocations more than 20 seconds.  Given that the only
goal is to learn the number of CPUs, invoking lscpu but once suffices.
This commit therefore invokes lscpu early in kvm.sh execution, setting
the initial value of the TORTURE_ALLOTED_CPUS environment variable.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh |  7 +++----
 tools/testing/selftests/rcutorture/bin/kvm.sh            | 11 ++++++++---
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 1d98992..e035230 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -133,11 +133,10 @@ fi
 qemu_args="-enable-kvm -nographic $qemu_args"
 cpu_count=`configNR_CPUS.sh $resdir/ConfigFragment`
 cpu_count=`configfrag_boot_cpus "$boot_args" "$config_template" "$cpu_count"`
-vcpus=`identify_qemu_vcpus`
-if test $cpu_count -gt $vcpus
+if test "$cpu_count" -gt "$TORTURE_ALLOTED_CPUS"
 then
-	echo CPU count limited from $cpu_count to $vcpus | tee -a $resdir/Warnings
-	cpu_count=$vcpus
+	echo CPU count limited from $cpu_count to $TORTURE_ALLOTED_CPUS | tee -a $resdir/Warnings
+	cpu_count=$TORTURE_ALLOTED_CPUS
 fi
 qemu_args="`specify_qemu_cpus "$QEMU" "$qemu_args" "$cpu_count"`"
 
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index e19151c..78d18ab 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -24,7 +24,9 @@ dur=$((30*60))
 dryrun=""
 KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
 PATH=${KVM}/bin:$PATH; export PATH
-TORTURE_ALLOTED_CPUS=""
+. functions.sh
+
+TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
 TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
 TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
@@ -40,8 +42,6 @@ cpus=0
 ds=`date +%Y.%m.%d-%H:%M:%S`
 jitter="-1"
 
-. functions.sh
-
 usage () {
 	echo "Usage: $scriptname optional arguments:"
 	echo "       --bootargs kernel-boot-arguments"
@@ -93,6 +93,11 @@ do
 		checkarg --cpus "(number)" "$#" "$2" '^[0-9]*$' '^--'
 		cpus=$2
 		TORTURE_ALLOTED_CPUS="$2"
+		max_cpus="`identify_qemu_vcpus`"
+		if test "$TORTURE_ALLOTED_CPUS" -gt "$max_cpus"
+		then
+			TORTURE_ALLOTED_CPUS=$max_cpus
+		fi
 		shift
 		;;
 	--datestamp)
-- 
2.9.5

