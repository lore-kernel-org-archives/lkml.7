Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D934C2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F4F214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950874;
	bh=d1mJ1n49nNM+kkuO2aLd3FM0NCS6Kt3EjC4AB7e9Ewc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DSgwstiqRHPihz/jr+ywc+0dixC/pJ7S0MyNgfYntMDQqrt8kNDmXDQ+u4AinMr2s
	 Xojtl5r2Dk62zTqD1wzSodkiJzX+bvglx/g9FcXxo+U/ibO6C6NTtNPBGkp6XeUa3e
	 qZzo9RvqmYFpzK999VKbC9ADHbtLB6SwwC96BboI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLJEHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:07:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfLJEHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:48 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E37B20836;
        Tue, 10 Dec 2019 04:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950868;
        bh=d1mJ1n49nNM+kkuO2aLd3FM0NCS6Kt3EjC4AB7e9Ewc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmISLtgCcWtZ7cS3AeCyDvGdsyBsKy78XqoZjU6p8H1ikH/WWOfchw2rfKJaRgigi
         5WuYJ8xR07sj65F+0y+MGgo9O9/Xtu1YDIdoZI3PSO3rb4pcH2MDpOR5i1pwC06H+G
         2RD8xAWEdhvZRAS9WNaW/UCrNwecthxxQs730MSU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/12] rcu: Move rcu_{expedited,normal} definitions into rcupdate.h
Date:   Mon,  9 Dec 2019 20:07:36 -0800
Message-Id: <20191210040741.2943-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040714.GA2715@paulmck-ThinkPad-P72>
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

This commit moves the rcu_{expedited,normal} definitions from
kernel/rcu/update.c to include/linux/rcupdate.h to make sure they are
in sync, and also to avoid the following warning from sparse:

kernel/ksysfs.c:150:5: warning: symbol 'rcu_expedited' was not declared. Should it be static?
kernel/ksysfs.c:167:5: warning: symbol 'rcu_normal' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 4 ++++
 kernel/rcu/update.c      | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index fe47024..bb363796 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -896,4 +896,8 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 	return false;
 }
 
+/* kernel/ksysfs.c definitions */
+extern int rcu_expedited;
+extern int rcu_normal;
+
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 1861103..294d357 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -51,9 +51,7 @@
 #define MODULE_PARAM_PREFIX "rcupdate."
 
 #ifndef CONFIG_TINY_RCU
-extern int rcu_expedited; /* from sysctl */
 module_param(rcu_expedited, int, 0);
-extern int rcu_normal; /* from sysctl */
 module_param(rcu_normal, int, 0);
 static int rcu_normal_after_boot;
 module_param(rcu_normal_after_boot, int, 0);
-- 
2.9.5

