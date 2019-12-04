Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5476C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0729206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLDKFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:05:46 -0500
Received: from foss.arm.com ([217.140.110.172]:53838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfLDKFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:05:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C507E1FB;
        Wed,  4 Dec 2019 02:05:45 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7776C3F52E;
        Wed,  4 Dec 2019 02:05:44 -0800 (PST)
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
To:     John Stultz <john.stultz@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <c61cf647-ecb6-b9fa-51f2-8efa36134757@arm.com>
 <14a8e456-1f89-0dff-ae89-61e8b6d5593b@arm.com>
 <7548a890-d32b-7e7d-4f84-4ebf635c3e8a@arm.com>
 <CALAqxLVDaiJWd7W5+FBKs=Mq8AHw52fApPc_Xu2gTq9DTn0vgQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e4760a3f-4035-30b1-8464-645fbfa441ce@arm.com>
Date:   Wed, 4 Dec 2019 10:05:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLVDaiJWd7W5+FBKs=Mq8AHw52fApPc_Xu2gTq9DTn0vgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 03:46, John Stultz wrote:
> Thanks for the quick patch! Unfortunately I still managed to trip it
> with this patch :(
> 

I think I would've been more confused if it had fixed it than if it hadn't.
Figured it was worth a shot anyway.


I have a DB845 stashed somewhere but I've never used one, so it's probably
going to take me some time to get it up and running.

In the meantime, I'd suggest running it again with the following appended
patch. It gets rid of the unused parameter, which gets rid of the isra,
which should let us get a faulty line number more easily than by rummaging
through objdump.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..4c3a8f188d45 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5575,8 +5575,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 }
 
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p,
-		  int this_cpu, int sd_flag);
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
 
 /*
  * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
@@ -5665,7 +5664,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 			continue;
 		}
 
-		group = find_idlest_group(sd, p, cpu, sd_flag);
+		group = find_idlest_group(sd, p, cpu);
 		if (!group) {
 			sd = sd->child;
 			continue;
@@ -8370,8 +8369,7 @@ static bool update_pick_idlest(struct sched_group *idlest,
  * Assumes p is allowed on at least one CPU in sd.
  */
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p,
-		  int this_cpu, int sd_flag)
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 {
 	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
 	struct sg_lb_stats local_sgs, tmp_sgs;
