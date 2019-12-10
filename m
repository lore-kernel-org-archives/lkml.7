Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75326C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1782077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575949387;
	bh=7L6+LJ3mKyRaJ5D/Ui49jomhEQenVN+LQSRFY/2aOZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UvP2FtGL9s4wK0iZyJMoLYDlryVd9PBGxhKyzg2j4LC76t+SdyfpeV4c476q8i8Um
	 3BrTOJg4+WFPTeGHFbHyXDcbkR/94AwkeMW8u45eHS5IkoX9Sgs+iSyVSbJtre7/tP
	 zI9RTQWSeGYIohVH11Cnz9ShAVBd9ZL8L2YD3NbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfLJDnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfLJDmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:42:23 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF2120838;
        Tue, 10 Dec 2019 03:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949342;
        bh=7L6+LJ3mKyRaJ5D/Ui49jomhEQenVN+LQSRFY/2aOZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=riJcszPP7zCtgNHBupQ5HD0PM+ws7kyx1PybkZfvhL5yjyu2RSJVM85YZQkY9XDJx
         RfUEom4Z0NCVrRcVM1iJx/HhAyfodqCZ3Xp2QSzKPwOatgVjoy68GCUpi8m85jAqoO
         +ABxCU//G+z9nPoGtiomQTak1iMVS85A1+Dd/j5E=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/12] torture: Handle jitter for CPUs that cannot be offlined
Date:   Mon,  9 Dec 2019 19:42:08 -0800
Message-Id: <20191210034217.405-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210034119.GA32711@paulmck-ThinkPad-P72>
References: <20191210034119.GA32711@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, jitter.sh assumes that the underlying hypervisor will be
configured with all CPUs hotpluggable, with the possible exception
of CPU 0.  However, there are installations where the hypervisor
prohibits offlining, which breaks jitter.sh.  This commit therefore
lists the CPUs that cannot be offlined up front, and checks for the
case where no CPU can be offlined in the loop.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 26 ++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 86a217b..30cb5b2 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -25,6 +25,18 @@ n=1
 
 starttime=`gawk 'BEGIN { print systime(); }' < /dev/null`
 
+nohotplugcpus=
+for i in /sys/devices/system/cpu/cpu[0-9]*
+do
+	if test -f $i/online
+	then
+		:
+	else
+		curcpu=`echo $i | sed -e 's/^[^0-9]*//'`
+		nohotplugcpus="$nohotplugcpus $curcpu"
+	fi
+done
+
 while :
 do
 	# Check for done.
@@ -35,13 +47,15 @@ do
 	fi
 
 	# Set affinity to randomly selected online CPU
-	cpus=`grep 1 /sys/devices/system/cpu/*/online |
-		sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//'`
-
-	# Do not leave out poor old cpu0 which may not be hot-pluggable
-	if [ ! -f "/sys/devices/system/cpu/cpu0/online" ]; then
-		cpus="0 $cpus"
+	if cpus=`grep 1 /sys/devices/system/cpu/*/online 2>&1 |
+		 sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//'`
+	then
+		:
+	else
+		cpus=
 	fi
+	# Do not leave out non-hot-pluggable CPUs
+	cpus="$cpus $nohotplugcpus"
 
 	cpumask=`awk -v cpus="$cpus" -v me=$me -v n=$n 'BEGIN {
 		srand(n + me + systime());
-- 
2.9.5

