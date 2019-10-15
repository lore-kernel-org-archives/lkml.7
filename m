Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9948DECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CC82064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbfJONse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:48:34 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48496 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfJONsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:48:33 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKNBY-0003f7-NK; Tue, 15 Oct 2019 14:48:24 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKNBY-0007JO-8w; Tue, 15 Oct 2019 14:48:24 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: move rcu_{expedited,normal} definitions into rcupdate.h
Date:   Tue, 15 Oct 2019 14:48:22 +0100
Message-Id: <20191015134822.28063-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the rcu_{expedited,normal} definitions into rcupdate.h
to make sure they are in sync, and avoid the following
warning from sparse:

kernel/ksysfs.c:150:5: warning: symbol 'rcu_expedited' was not declared. Should it be static?
kernel/ksysfs.c:167:5: warning: symbol 'rcu_normal' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/rcupdate.h | 4 ++++
 kernel/rcu/update.c      | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 75a2eded7aa2..a175d6e3ad77 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -894,4 +894,8 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 	return false;
 }
 
+/* kernel/ksysfs.c definitions */
+extern int rcu_expedited;
+extern int rcu_normal;
+
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 1861103662db..294d357abd0c 100644
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
2.23.0

