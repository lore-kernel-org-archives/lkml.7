Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53ACC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF3920644
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbfIRUAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:00:54 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40441 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389392AbfIRUAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:00:53 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MuluN-1hsjpK0RUJ-00rtNj; Wed, 18 Sep 2019 22:00:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Michal Koutny <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>,
        Alessio Balsini <balsini@android.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/uclamp: fix building without cgroup
Date:   Wed, 18 Sep 2019 21:59:43 +0200
Message-Id: <20190918195957.2220297-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W6UnziFG3kMCKWVGK+UTFHQlxIRQdKUTIDJ084gJZNTBsNtL7DS
 dIuyXGOXC7wMu+LXWQVKCmOS7f1ED5X/+W23rhvFmZ93oFgE6dfpAMXgOvH0XsmyNoLI3HH
 9EnW60Z64dOFjUQLl3GMhcwW0ZEpXdMLhyawy9laQr3otaNuyucqgiaS9ZYKYwm+7BwmvNo
 lml5Whhi/b4JIrqCPw5YQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:22tuQPy5xkA=:KvoQAZKEoK6LxT2oHtVPVc
 ArlCWm49saLo3vvbFy7b0J/kg085fN00/Q5QUfI4TbRZLDl9lqlbLkNpzC3LCb4XYlJkztfp3
 305Us38WHV3xkRh+yGqfA7e8TVT8ScVOJzcREwt6w9u6yeaVnFm4mDK4FPjfyGRnsXU/BJ243
 gmIVYQz58PEGIvC9bQSRXsfCtvywqV4A4CwKT4QvaVXNUYlhDNEGDF23Kx55LgmDBT216Bfq1
 1F3CRAvCyjJZZIt4UoiqnFZNneg9ggAxzDWKK6113tdZ3S7DgTXyC5n5Yi8XNFg/T0uWyFbOF
 F7LWk14nNQQui/iCHz+GCJVb5cZjWh1ij4q0YRRu3m9rYZn64rVBRPMc36xOdQ5gT2hfghBJu
 IYxghUa6ZygtVyiX0nY+sNaFzLZgVJDBMzbQLFUZxskz+RTkAte2lrO473Hq1yEH6llyQ6W8y
 j3E6bhndiCjh0+n8RmJZNmUwrUZeZrSBJ9I8DE0MPFgeTYt9qrygw5IrwGBTSf/tEzPRyJ60L
 2czBoeaycs2DRHw1QxCCfzXrcebpF800dASrtfU26Z+ZPxGjZ6b5wmoA93s9MxJBTjMMzee1n
 thAkmXgZ9MU8BFV+AOD2x5mmrIa/XGBnwQjGjFHabl5ZvZCxS24qvEfVPdQo6XU4y8ZNRwTQ3
 d7Vy2j1mW58k7kc16CGtjPEnPhaz5ot1w5g/uQ5o+JN0ha8YlquTQRDVMMWPyLMeeXyafCMJN
 DQUYlSZQrcg17vzB4iRCZvJbc5qfZhGOBNGZi7I34TabvtMXZYp3gdVRaEERdDEEELsvQCZ0J
 8cX1th/rNi+sy1R9n0wHu9GRRmND6m5FOYLy0pZCOoip57cwiXS6aLgPUNYdZbWDXXQFuBt+9
 OsArzbrOdKCUMDbdYOLw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The css_task_iter interfaces are defined conditionally and
cause build failures when used in other configurations:

kernel/sched/core.c:1081:23: error: variable has incomplete type 'struct css_task_iter'
kernel/sched/core.c:1084:2: error: implicit declaration of function 'css_task_iter_start' [-Werror,-Wimplicit-function-declaration]
kernel/sched/core.c:1085:14: error: implicit declaration of function 'css_task_iter_next' [-Werror,-Wimplicit-function-declaration]
kernel/sched/core.c:1091:2: error: implicit declaration of function 'css_task_iter_end' [-Werror,-Wimplicit-function-declaration]

As this code is unused anyway in that configuration, just put
it into the same #ifdef. This also avoids possible warnings
about unused inline functions.

Fixes: babbe170e053 ("sched/uclamp: Update CPU's refcount on TG's clamp changes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f9a1346a5fa9..f25e3949a5ba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1043,6 +1043,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
 static inline void
 uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
 {
@@ -1091,7 +1092,6 @@ uclamp_update_active_tasks(struct cgroup_subsys_state *css,
 	css_task_iter_end(&it);
 }
 
-#ifdef CONFIG_UCLAMP_TASK_GROUP
 static void cpu_util_update_eff(struct cgroup_subsys_state *css);
 static void uclamp_update_root_tg(void)
 {
-- 
2.20.0

