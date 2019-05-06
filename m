Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9E0C04AB2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4362087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfEFFtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 01:49:22 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:57922 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfEFFtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 01:49:06 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 01:48:55 EDT
Received: from [151.41.47.232] (account l.abeni@santannapisa.it HELO sweethome.home-life.hub)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 138841010; Mon, 06 May 2019 06:49:00 +0200
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
Subject: [RFC PATCH 4/6] sched/dl: Improve capacity-aware wakeup
Date:   Mon,  6 May 2019 06:48:34 +0200
Message-Id: <20190506044836.2914-5-luca.abeni@santannapisa.it>
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

Instead of considering the "static CPU bandwidth" allocated to
a SCHED_DEADLINE task (ratio between its maximum runtime and
reservation period), try to use the remaining runtime and time
to scheduling deadline.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/cpudeadline.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index d21f7905b9c1..111dd9ac837b 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -114,8 +114,13 @@ static inline int dl_task_fit(const struct sched_dl_entity *dl_se,
 			      int cpu, u64 *c)
 {
 	u64 cap = (arch_scale_cpu_capacity(NULL, cpu) * arch_scale_freq_capacity(cpu)) >> SCHED_CAPACITY_SHIFT;
-	s64 rel_deadline = dl_se->dl_deadline;
-	u64 rem_runtime  = dl_se->dl_runtime;
+	s64 rel_deadline = dl_se->deadline - sched_clock_cpu(smp_processor_id());
+	u64 rem_runtime  = dl_se->runtime;
+
+	if ((rel_deadline < 0) || (rel_deadline * dl_se->dl_runtime < dl_se->dl_deadline * rem_runtime)) {
+		rel_deadline = dl_se->dl_deadline;
+		rem_runtime  = dl_se->dl_runtime;
+	}
 
 	if (c)
 		*c = cap;
-- 
2.20.1

