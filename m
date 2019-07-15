Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FBAC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67FB2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfGOJ2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:28:39 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfGOJ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:28:39 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1cvQ-1iSrg40HAu-011ysw; Mon, 15 Jul 2019 11:28:12 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qian Cai <cai@lca.pw>,
        Yuyang Du <duyuyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, frederic@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] locking/lockdep: hide unused 'class' variable
Date:   Mon, 15 Jul 2019 11:27:49 +0200
Message-Id: <20190715092809.736834-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wZfW9h1qpdFpJ4IpaPX7d0kXx4FD5/38Kk/764IrBkHKfldxQKY
 ugCf+FDOZLmnZfoVoJa/wOEI/nwzr59F3Dhtb50i6IvjAAoZgK5H7Q4ZrjUtzn19wnZ7h9S
 RUXJG2ERKsgAMmPOqXI96d5nMWgmtiIedzF3d5z/a/BZ8F7cAJ1WHCm7Cd7o4F9JeF/aJp3
 SJqihu1wl4HTqK9Ro19eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mni9IFMBseU=:K+uZJ5nr/DZWB5GJmnsDls
 DnmwxopoOaRB00WdcDYzRFwkIw6dMLTefYSbxWwagwCMkx9ZfIltqXSuPw0tlLW2X4Lw8TnXZ
 MitLXKpcdPv+CcHFDrnntsgNn2cCXDvGe6KFXYfXhu3dHTxOZ4RBTHOnrNS/evYc1uERJzos1
 4fQ3SVvY9qJ4CIBt2NamS/8S9EJkxwzhoGBygRG70iL8VYCWIEgo76ccrwah/HtuVxV3ZOS/+
 kkVhMNgis9MGC6jwnbFA5BTafhKoTZs+2W11oXwD6JGqpR3nMR8v9aY+53VyDGSaFUllWsDtO
 RzUExDovWCPv78zkuUCTKTHyFL/nD8x9O0XUPLswifAhq+Lx96+VNIAgjlhz9dRJmcjEYVNGF
 rwSLcvE7NPkTz2vld1yxrGbX8p1juz0b+H/cvmVSbYyLzvtEm2i2q/yuoFqdy9RIAVAdEaeTU
 ccgvbbigJCaFywo89+G+0WPTBwIhnczy88ALhIje8bh0yWFbthn7RqXJ0pZImxDdDj+54km/0
 nWrpU/nAMDgzzd1eQW0qcyC7vc8NKqfvXfik4iEXfNGzD9k2pTE9Oc45VQdVbNlxvKVlF6Bhs
 nk7ktw5nuzCHjU3YNxbJPRQyvDxlWXe1LOerLujjzgWdTLcqxXUMUx1jkppxv+/rGtuJ4Fk8h
 fVOy2wIlJrnwQ3/04VVf5ybO8qu977QsggE+VTDPL4uVXSN8f9/CVIloQBFB5B4v6UcLgrbuw
 4hNdeTB5XuALsY99JNANic4aANgvxlP2adxhrw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage is now hidden in an #ifdef, so we need to move
the variable itself in there as well to avoid this warning:

kernel/locking/lockdep_proc.c:203:21: error: unused variable 'class' [-Werror,-Wunused-variable]

Fixes: 68d41d8c94a3 ("locking/lockdep: Fix lock used or unused stats error")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/locking/lockdep_proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 65b6a1600c8f..bda006f8a88b 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -200,7 +200,6 @@ static void lockdep_stats_debug_show(struct seq_file *m)
 
 static int lockdep_stats_show(struct seq_file *m, void *v)
 {
-	struct lock_class *class;
 	unsigned long nr_unused = 0, nr_uncategorized = 0,
 		      nr_irq_safe = 0, nr_irq_unsafe = 0,
 		      nr_softirq_safe = 0, nr_softirq_unsafe = 0,
@@ -211,6 +210,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 		      sum_forward_deps = 0;
 
 #ifdef CONFIG_PROVE_LOCKING
+	struct lock_class *class;
+
 	list_for_each_entry(class, &all_lock_classes, lock_entry) {
 
 		if (class->usage_mask == 0)
-- 
2.20.0

