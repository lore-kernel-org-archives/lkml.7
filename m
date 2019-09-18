Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F4DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D711D207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfIRUib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:38:31 -0400
Received: from foss.arm.com ([217.140.110.172]:49136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731602AbfIRUia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:38:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D13D01000;
        Wed, 18 Sep 2019 13:38:29 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 261703F67D;
        Wed, 18 Sep 2019 13:38:27 -0700 (PDT)
Subject: Re: [PATCH] sched/uclamp: fix building without cgroup
To:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
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
References: <20190918195957.2220297-1-arnd@arndb.de>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4194ccd0-d6ef-aa50-d367-7366fe48ffa9@arm.com>
Date:   Wed, 18 Sep 2019 21:38:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918195957.2220297-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 18/09/2019 20:59, Arnd Bergmann wrote:
> The css_task_iter interfaces are defined conditionally and
> cause build failures when used in other configurations:
> 
> kernel/sched/core.c:1081:23: error: variable has incomplete type 'struct css_task_iter'
> kernel/sched/core.c:1084:2: error: implicit declaration of function 'css_task_iter_start' [-Werror,-Wimplicit-function-declaration]
> kernel/sched/core.c:1085:14: error: implicit declaration of function 'css_task_iter_next' [-Werror,-Wimplicit-function-declaration]
> kernel/sched/core.c:1091:2: error: implicit declaration of function 'css_task_iter_end' [-Werror,-Wimplicit-function-declaration]
> 
> As this code is unused anyway in that configuration, just put
> it into the same #ifdef. This also avoids possible warnings
> about unused inline functions.
> 
> Fixes: babbe170e053 ("sched/uclamp: Update CPU's refcount on TG's clamp changes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patrick's submitted the same thing at:

  https://lkml.kernel.org/r/8736gv2gbv.fsf@arm.com

so you may want to holler in that thread. Those kind of things really should
get caught by the 0day bot but it seems it's been on sick leave lately :/

> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f9a1346a5fa9..f25e3949a5ba 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1043,6 +1043,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>  		uclamp_rq_dec_id(rq, p, clamp_id);
>  }
>  
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
>  static inline void
>  uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
>  {
> @@ -1091,7 +1092,6 @@ uclamp_update_active_tasks(struct cgroup_subsys_state *css,
>  	css_task_iter_end(&it);
>  }
>  
> -#ifdef CONFIG_UCLAMP_TASK_GROUP
>  static void cpu_util_update_eff(struct cgroup_subsys_state *css);
>  static void uclamp_update_root_tg(void)
>  {
> 
