Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123CAC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E187F2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEFFtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 01:49:16 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:57922 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfEFFtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 01:49:10 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 01:48:55 EDT
Received: from [151.41.47.232] (account l.abeni@santannapisa.it HELO sweethome.home-life.hub)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 138841012; Mon, 06 May 2019 06:49:02 +0200
From:   Luca Abeni <luca.abeni@santannapisa.it>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        luca abeni <luca.abeni@santannapisa.it>
Subject: [RFC PATCH 6/6] sched/dl: Try not to select a too fast core
Date:   Mon,  6 May 2019 06:48:36 +0200
Message-Id: <20190506044836.2914-7-luca.abeni@santannapisa.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506044836.2914-1-luca.abeni@santannapisa.it>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luca abeni <luca.abeni@santannapisa.it>

When a task can fit on multiple CPU cores, try to select the slowest
core that is able to properly serve the task. This avoids useless
future migrations, leaving the "fast cores" idle for more heavyweight
tasks.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/cpudeadline.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 2a4ac7b529b7..897ed71af515 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -143,17 +143,24 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 	       struct cpumask *later_mask)
 {
 	const struct sched_dl_entity *dl_se = &p->dl;
+	struct cpumask tmp_mask;
 
 	if (later_mask &&
-	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_allowed)) {
+	    cpumask_and(&tmp_mask, cp->free_cpus, &p->cpus_allowed)) {
 		int cpu, max_cpu = -1;
-		u64 max_cap = 0;
+		u64 max_cap = 0, min_cap = SCHED_CAPACITY_SCALE * SCHED_CAPACITY_SCALE;
 
-		for_each_cpu(cpu, later_mask) {
+		cpumask_clear(later_mask);
+		for_each_cpu(cpu, &tmp_mask) {
 			u64 cap;
 
-			if (!dl_task_fit(&p->dl, cpu, &cap))
-				cpumask_clear_cpu(cpu, later_mask);
+			if (dl_task_fit(&p->dl, cpu, &cap) && (cap <= min_cap)) {
+				if (cap < min_cap) {
+					min_cap = cap;
+					cpumask_clear(later_mask);
+				}
+				cpumask_set_cpu(cpu, later_mask);
+			}
 
 			if (cap > max_cap) {
 				max_cap = cap;
-- 
2.20.1

