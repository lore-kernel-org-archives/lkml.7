Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C3EC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8538421783
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561563918;
	bh=gYFjiQbQQDdwcLzpj1YTXjQ0WKeNjpheQWJEGAvEQpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B1ENzuBruW+v5PTqoZpyN8DY0pgWrDrbAwyXYD9NKp7fcazc21vU/C7h5kwelxEo2
	 h4JFTGWA8FRqU2aZRE6PPlJcjaFXoFHI4ea9abBnPSkMyil4zCE2B68K2FQzYE+p6o
	 tr4R9VLwuvexc8WByhAmKwHN2WMBkMibYFwj+vn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFZPpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFZPpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:45:17 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 782F62177B;
        Wed, 26 Jun 2019 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561563915;
        bh=gYFjiQbQQDdwcLzpj1YTXjQ0WKeNjpheQWJEGAvEQpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLNkYyvzIc+SzkkHxVfETGL/GzAQUAqWWgwZJUtBYoSVqAzHWXbvNKpbs6ty9ktyo
         CPopkxUT+hTK04+uqdHr4YZufTm4aPgTpvG+wzN3dycyqFBMUTPUfLfyIj7ruGYLQQ
         LrQ8Q/BTm1xUk8ZCyRiuDaVCL1jsGORFx5wgZye0=
Date:   Wed, 26 Jun 2019 17:45:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] sched/nohz: Optimize get nohz timer target
Message-ID: <20190626154511.GA29951@lenoir>
References: <1560827581-8827-1-git-send-email-wanpengli@tencent.com>
 <CANRm+Cw6nVOy=SZw1wrh=8+1fzOfaOZcoWBeKTa8n3UXZLik=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+Cw6nVOy=SZw1wrh=8+1fzOfaOZcoWBeKTa8n3UXZLik=g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 08:42:19AM +0800, Wanpeng Li wrote:
> Cc Frederic,
> On Tue, 18 Jun 2019 at 11:13, Wanpeng Li <kernellwp@gmail.com> wrote:
> >
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > On a machine, cpu 0 is used for housekeeping, other 39 cpus are in
> > nohz_full mode. We can observe huge time burn in the loop for seaching
> > nearest busy housekeeper cpu by ftrace.
> >
> >   2)               |                        get_nohz_timer_target() {
> >   2)   0.240 us    |                          housekeeping_test_cpu();
> >   2)   0.458 us    |                          housekeeping_test_cpu();
> >
> >   ...
> >
> >   2)   0.292 us    |                          housekeeping_test_cpu();
> >   2)   0.240 us    |                          housekeeping_test_cpu();
> >   2)   0.227 us    |                          housekeeping_any_cpu();
> >   2) + 43.460 us   |                        }
> >
> > This patch optimizes the searching logic by finding a nearest housekeeper
> > cpu in the housekeeping cpumask, it can minimize the worst searching time
> > from ~44us to < 10us in my testing.
> >
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> >  kernel/sched/core.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 83bd6bb..db550cf 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -548,11 +548,12 @@ int get_nohz_timer_target(void)
> >
> >         rcu_read_lock();
> >         for_each_domain(cpu, sd) {
> > -               for_each_cpu(i, sched_domain_span(sd)) {
> > +               for_each_cpu_and(i, sched_domain_span(sd),
> > +                       housekeeping_cpumask(HK_FLAG_TIMER)) {
> >                         if (cpu == i)
> >                                 continue;
> >
> > -                       if (!idle_cpu(i) && housekeeping_cpu(i, HK_FLAG_TIMER)) {
> > +                       if (!idle_cpu(i)) {
> >                                 cpu = i;
> >                                 goto unlock;
> >                         }

Nice, but you also need to handle the default case that doesn't make much sense anymore.
It hasn't ever been clear anyway. The last iterated buzy housekeeper can become
a random candidate while current CPU is a better fallback if it is a housekeeper. Also
you're enhancing housekeeping_any_cpu() in another patch so give it a better chance:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48a7fda..c5229d71540a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -539,27 +539,32 @@ void resched_cpu(int cpu)
  */
 int get_nohz_timer_target(void)
 {
-	int i, cpu = smp_processor_id();
+	int i, cpu = smp_processor_id(), default_cpu = -1;
 	struct sched_domain *sd;
 
-	if (!idle_cpu(cpu) && housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		return cpu;
+	if (housekeeping_cpu(cpu, HK_FLAG_TIMER)) {
+		if (!idle_cpu(cpu))
+			return cpu;
+		default_cpu = cpu;
+	}
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
-		for_each_cpu(i, sched_domain_span(sd)) {
+		for_each_cpu_and(i, sched_domain_span(sd),
+				 housekeeping_cpumask(HK_FLAG_TIMER)) {
 			if (cpu == i)
 				continue;
 
-			if (!idle_cpu(i) && housekeeping_cpu(i, HK_FLAG_TIMER)) {
+			if (!idle_cpu(i)) {
 				cpu = i;
 				goto unlock;
 			}
 		}
 	}
 
-	if (!housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
+	if (default_cpu == -1)
+		default_cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
+	cpu = default_cpu;
 unlock:
 	rcu_read_unlock();
 	return cpu;
