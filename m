Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FEAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D967724656
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575949360;
	bh=mU6YqZke+0tGNu021ySMmB1xwlHx9nd7WnQngizhidw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0LmqWrPxVAWB6xet/aWfn6VdNJwLY6YNmw9rqSyRpxVUm5nKtKmqCyXwDgihf44Od
	 HxWxJU5kOwZ7ztApD8Phh7JXyP3hsIBN3eGtCnYPmqXQouhbkY/DweF0G1XQteNddv
	 Zd/vAj6fAjOLxifElG/ar1yfF/fyTbqdMkyH8xKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLJDmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:42:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfLJDm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:42:28 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A91D24654;
        Tue, 10 Dec 2019 03:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949347;
        bh=mU6YqZke+0tGNu021ySMmB1xwlHx9nd7WnQngizhidw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXjOO30xAtVl4fJSAS9yyJI0Gi0VKwtpgCoAInfF2O0NUOro7IdMSSPHu5YjwJTyp
         nplcOR7KA+GCk+aRBnKWBr99EjZRk1cA0799FbJ0tGYNZaSdhmj7AtN/WM6VfZ2I+x
         zNzKv3ks1QNeepHhyOTXF1DBsjEIcdG9Lbjp+riU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/12] torture: Allow "CFLIST" to specify default list of scenarios
Date:   Mon,  9 Dec 2019 19:42:16 -0800
Message-Id: <20191210034217.405-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210034119.GA32711@paulmck-ThinkPad-P72>
References: <20191210034119.GA32711@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

On a large system, it can be convenient to tell rcutorture to run
several instances of the default scenarios.  Currently, this requires
explicitly listing them, for example, "--configs '2*SRCU-N 2*SRCU-P...'".
Although this works, it is rather inconvenient.

This commit therefore allows "CFLIST" to be specified to indicate the
default list of scenarios called out in the relevant CFLIST file, for
example, for RCU, tools/testing/selftests/rcutorture/configs/rcu/CFLIST.
In addition, multipliers may be used to run multiple instances of all
the scenarios.  For example, on a 256-CPU system, "--configs '3*CFLIST'"
would run three instances of each scenario concurrently with one CPU
left over.  Thus "--configs '3*CFLIST TINY01'" would exactly consume all
256 CPUs, which makes rcutorture's jitter feature more effective.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 7251858..e19151c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -198,9 +198,10 @@ fi
 
 CONFIGFRAG=${KVM}/configs/${TORTURE_SUITE}; export CONFIGFRAG
 
+defaultconfigs="`tr '\012' ' ' < $CONFIGFRAG/CFLIST`"
 if test -z "$configs"
 then
-	configs="`cat $CONFIGFRAG/CFLIST`"
+	configs=$defaultconfigs
 fi
 
 if test -z "$resdir"
@@ -209,7 +210,7 @@ then
 fi
 
 # Create a file of test-name/#cpus pairs, sorted by decreasing #cpus.
-touch $T/cfgcpu
+configs_derep=
 for CF in $configs
 do
 	case $CF in
@@ -222,15 +223,21 @@ do
 		CF1=$CF
 		;;
 	esac
+	for ((cur_rep=0;cur_rep<$config_reps;cur_rep++))
+	do
+		configs_derep="$configs_derep $CF1"
+	done
+done
+touch $T/cfgcpu
+configs_derep="`echo $configs_derep | sed -e "s/\<CFLIST\>/$defaultconfigs/g"`"
+for CF1 in $configs_derep
+do
 	if test -f "$CONFIGFRAG/$CF1"
 	then
 		cpu_count=`configNR_CPUS.sh $CONFIGFRAG/$CF1`
 		cpu_count=`configfrag_boot_cpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
 		cpu_count=`configfrag_boot_maxcpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
-		for ((cur_rep=0;cur_rep<$config_reps;cur_rep++))
-		do
-			echo $CF1 $cpu_count >> $T/cfgcpu
-		done
+		echo $CF1 $cpu_count >> $T/cfgcpu
 	else
 		echo "The --configs file $CF1 does not exist, terminating."
 		exit 1
-- 
2.9.5

