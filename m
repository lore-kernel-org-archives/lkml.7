Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE503C5B57D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9759420848
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDGz+aDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfGHEFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:05:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33953 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfGHEFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 00:05:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so14826163otk.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qs74MNXeX8PUd5IlEIr3DdDrdTGpDJ2VkIsqNY9133o=;
        b=vDGz+aDCGW4wDelVIhNKQxbg/e7MV9jEJZKH9NxVG2vyV754beiX2Y32hDXxxRu1xn
         eYGUHwug99CIUe/F66wSqBhG5kWnfjHWqo+ZmFLltihwe5yMlQkHW3Hay3pjthHZgEaU
         pcAUOgcO+dicWGKdHQUv/J6hKb5sMopNndwHc5GVhJzH7c+zG8MenF0j0nlOvsct8Fgt
         Iod0CZblgBS7Eo9uq9v+RpFa6uWd3q08cPSq1g4C98Rkmxu3e0n1eiVsnf21Sy4NcFme
         BiFxoxaTBLCSRq9/99d6a5jWg9ziwkn72ymfMCdmbt1g8P3iu4X3X5ppg6U08iMmVg3G
         iK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qs74MNXeX8PUd5IlEIr3DdDrdTGpDJ2VkIsqNY9133o=;
        b=G5pdl+fsqx/+82hSdVHIhcV6B5f7GsFCpL0X0MQOZ9pc6Ey2S68TBih2owJ5dVXCQG
         bqT49Y1e7NM40VVtkM8lqq0Bq/cxZPd0j+rb+pOILW9PAHpCxCVIHF+W8hsnqM6URTZx
         izlC6xqUIv4ZP1fh4Q6S/N4EDqUn4tyHKsExC/n0p0kz08TuHdhFaO/cY8fKl2hqxy8W
         ZoXBUdBtcAjw+0UGtKHCnZgJYautIbgYRxes/LjVadu0f3QNhR2S/jekri4IS7r3zrOg
         4patIMaGN7RtsKThypkDZY0xF0Ut66q4Y55wI6ZUBYLjVqo9hazl/qpZsPQrEF1P7QUD
         52YA==
X-Gm-Message-State: APjAAAVg3UZSAFXciwsmZXzSTMeH4XOKf6K3hXBWaCO1H08WBJzIQkPt
        PKWJKjgrJswxg7rMywkbQ4PkVoKRGLLXPMqKhpTd/AY+
X-Google-Smtp-Source: APXvYqwxgtz+M2bm7WpCizdRAK1PqQi4uEX9nuOiY1ii0RK6aNn5uFZ06xOOfkFT10KzwbNv5azClviwBlDb1MwGEu8=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr12003060oto.118.1562558754128;
 Sun, 07 Jul 2019 21:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <1561711901-4755-1-git-send-email-wanpengli@tencent.com> <1561711901-4755-2-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1561711901-4755-2-git-send-email-wanpengli@tencent.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 8 Jul 2019 12:05:44 +0800
Message-ID: <CANRm+CyBP8qd6pYcyX_biGBwOcdjdqMqazNjSnq2H6QNE+OsHw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/isolation: Prefer housekeeping cpu in local node
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kindly ping for these two patches, :)
On Fri, 28 Jun 2019 at 16:51, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> In real product setup, there will be houseeking cpus in each nodes, it
> is prefer to do housekeeping from local node, fallback to global online
> cpumask if failed to find houseeking cpu from local node.
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v3 -> v4:
>  * have a static function for sched_numa_find_closest
>  * cleanup sched_numa_find_closest comments
> v2 -> v3:
>  * add sched_numa_find_closest comments
> v1 -> v2:
>  * introduce sched_numa_find_closest
>
>  kernel/sched/isolation.c | 12 ++++++++++--
>  kernel/sched/sched.h     |  8 +++++---
>  kernel/sched/topology.c  | 20 ++++++++++++++++++++
>  3 files changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 7b9e1e0..191f751 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -16,9 +16,17 @@ static unsigned int housekeeping_flags;
>
>  int housekeeping_any_cpu(enum hk_flags flags)
>  {
> -       if (static_branch_unlikely(&housekeeping_overridden))
> -               if (housekeeping_flags & flags)
> +       int cpu;
> +
> +       if (static_branch_unlikely(&housekeeping_overridden)) {
> +               if (housekeeping_flags & flags) {
> +                       cpu = sched_numa_find_closest(housekeeping_mask, smp_processor_id());
> +                       if (cpu < nr_cpu_ids)
> +                               return cpu;
> +
>                         return cpumask_any_and(housekeeping_mask, cpu_online_mask);
> +               }
> +       }
>         return smp_processor_id();
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 802b1f3..ec65d90 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1261,16 +1261,18 @@ enum numa_topology_type {
>  extern enum numa_topology_type sched_numa_topology_type;
>  extern int sched_max_numa_distance;
>  extern bool find_numa_distance(int distance);
> -#endif
> -
> -#ifdef CONFIG_NUMA
>  extern void sched_init_numa(void);
>  extern void sched_domains_numa_masks_set(unsigned int cpu);
>  extern void sched_domains_numa_masks_clear(unsigned int cpu);
> +extern int sched_numa_find_closest(const struct cpumask *cpus, int cpu);
>  #else
>  static inline void sched_init_numa(void) { }
>  static inline void sched_domains_numa_masks_set(unsigned int cpu) { }
>  static inline void sched_domains_numa_masks_clear(unsigned int cpu) { }
> +static inline int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
> +{
> +       return nr_cpu_ids;
> +}
>  #endif
>
>  #ifdef CONFIG_NUMA_BALANCING
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index f751ce0..4eea2c9 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1724,6 +1724,26 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
>         }
>  }
>
> +/*
> + * sched_numa_find_closest() - given the NUMA topology, find the cpu
> + *                             closest to @cpu from @cpumask.
> + * cpumask: cpumask to find a cpu from
> + * cpu: cpu to be close to
> + *
> + * returns: cpu, or nr_cpu_ids when nothing found.
> + */
> +int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
> +{
> +       int i, j = cpu_to_node(cpu);
> +
> +       for (i = 0; i < sched_domains_numa_levels; i++) {
> +               cpu = cpumask_any_and(cpus, sched_domains_numa_masks[i][j]);
> +               if (cpu < nr_cpu_ids)
> +                       return cpu;
> +       }
> +       return nr_cpu_ids;
> +}
> +
>  #endif /* CONFIG_NUMA */
>
>  static int __sdt_alloc(const struct cpumask *cpu_map)
> --
> 2.7.4
>
