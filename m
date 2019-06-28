Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3043DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B462133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF5tVCEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfF1HTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:19:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41324 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfF1HT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:19:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id g7so3551039oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYgxIggiL3Vp6cFFumrIC01sT9mQSZw9XN9GhM4BPlg=;
        b=YF5tVCEhSN/WHSd7ULCwYD/YsEEZ0Q0uUDsBVYfxRymbVvtT+P8W19sfS5LvTN2dwb
         21YkZSshy6M97XDhdqUmk2oALasr73OPRARA9kNpXjyqwcRAMUtbKU/cK/eeJS6A2ufI
         5B/wfqnKU7mRpSsjgs7e12zSmBXXTWT6pKCftl0tOvbAqHl85prfVrdX1eDFjjN9XsZe
         oJrkOqWhBWHcRVuvpa4P1wQ1OtziUzrMIwZY5gzdPEKqNdu3TfVxTngxMDgsqwxSzNLd
         Hk4Ja9Pcjmy4T9/iWdTDZc62BWB85lgUBaOmlYLK1y4bor7oql7fDT9t2momu4lSywhR
         wBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYgxIggiL3Vp6cFFumrIC01sT9mQSZw9XN9GhM4BPlg=;
        b=KucdkHHYRcgZldZk4CMkPbfhBKNJklyx3z/8YL4fW9mOO3xP1IO3yUVeqSUAkP5qgj
         4rs0pebAFbRn3nvOvjztpD9OMLUV/6uEAFFPb37ZaEJCEI1ywJUX76yw2G4mjzPCLL1E
         6DlowkY5soI3+OiuEYhRpVWatjgEcTa5AsRdvBdEyLXfbBXNT/ME0mvpGgj3kzY4mBXh
         uJoe1JwfN5VejbSbLTTXrGCPJDVZP9GCVeQZGNXp5gfAnVplTSOqkXB5V+kBFoG3qqJ1
         Uu+uQnGDXWNHqCN4l3BTvMaumDjnk56kAU3N//w5Eln3Th2Svt6PytxFI+ECpUmqxX9M
         F35A==
X-Gm-Message-State: APjAAAWvAbxFAQLf9OQBWhF2rcQZqigbDKiaR73BGgx4iFdmcoNB8Mwq
        iT31U2Vg9RoJGTPX6+4vgPgpPHsEkV6KIcHNglM=
X-Google-Smtp-Source: APXvYqyMFNH5Q9DiFatk977XULxwMFGEehFqctz9ddVqVeq9tP+T/B6jtsuiHqqu1lRbnbjSJKANpLRhwAZrOHm9NyA=
X-Received: by 2002:aca:544b:: with SMTP id i72mr891266oib.174.1561706368854;
 Fri, 28 Jun 2019 00:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <1561682593-12071-1-git-send-email-wanpengli@tencent.com>
 <1561682593-12071-2-git-send-email-wanpengli@tencent.com> <20190628065802.GA27699@linux.vnet.ibm.com>
In-Reply-To: <20190628065802.GA27699@linux.vnet.ibm.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 28 Jun 2019 15:19:17 +0800
Message-ID: <CANRm+Cz4R5OOga34DDepCP_yOtXXCqTxD8bs_rvgtQbjS8d1hw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] sched/isolation: Prefer housekeeping cpu in
 local node
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar,
On Fri, 28 Jun 2019 at 14:58, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Wanpeng Li <kernellwp@gmail.com> [2019-06-28 08:43:13]:
>
>
> >
> > +/*
> > + * sched_numa_find_closest() - given the NUMA topology, find the cpu
> > + *                             closest to @cpu from @cpumask.
> > + * cpumask: cpumask to find a cpu from
> > + * cpu: cpu to be close to
> > + *
> > + * returns: cpu, or >= nr_cpu_ids when nothing found (or !NUMA).
>
> One nit:
> I dont see sched_numa_find_closest returning anything greater than
> nr_cpu_ids. So 's/>= //' for the above comment.
>
> > + */
> > +int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
> > +{
> > +#ifdef CONFIG_NUMA
> > +     int i, j = cpu_to_node(cpu);
> > +
> > +     for (i = 0; i < sched_domains_numa_levels; i++) {
> > +             cpu = cpumask_any_and(cpus, sched_domains_numa_masks[i][j]);
> > +             if (cpu < nr_cpu_ids)
> > +                     return cpu;
> > +     }
> > +#endif
> > +     return nr_cpu_ids;
> > +}
> > +
>
> Should we have a static function for sched_numa_find_closest instead of
> having #ifdef in the function?
>
> >  static int __sdt_alloc(const struct cpumask *cpu_map)
> >  {
> >       struct sched_domain_topology_level *tl;

So, how about add this?

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a7e7d8c..5f2b262 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1225,13 +1225,17 @@ enum numa_topology_type {
 extern void sched_init_numa(void);
 extern void sched_domains_numa_masks_set(unsigned int cpu);
 extern void sched_domains_numa_masks_clear(unsigned int cpu);
+extern int sched_numa_find_closest(const struct cpumask *cpus, int cpu);
 #else
 static inline void sched_init_numa(void) { }
 static inline void sched_domains_numa_masks_set(unsigned int cpu) { }
 static inline void sched_domains_numa_masks_clear(unsigned int cpu) { }
+static inline int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
+{
+    return nr_cpu_ids;
+}
 #endif

-extern int sched_numa_find_closest(const struct cpumask *cpus, int cpu);

 #ifdef CONFIG_NUMA_BALANCING
 /* The regions in numa_faults array from task_struct */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 72731ed..9372c18 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1734,19 +1734,16 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
     }
 }

-#endif /* CONFIG_NUMA */
-
 /*
  * sched_numa_find_closest() - given the NUMA topology, find the cpu
  *                             closest to @cpu from @cpumask.
  * cpumask: cpumask to find a cpu from
  * cpu: cpu to be close to
  *
- * returns: cpu, or >= nr_cpu_ids when nothing found (or !NUMA).
+ * returns: cpu, or nr_cpu_ids when nothing found.
  */
 int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
 {
-#ifdef CONFIG_NUMA
     int i, j = cpu_to_node(cpu);

     for (i = 0; i < sched_domains_numa_levels; i++) {
@@ -1754,10 +1751,11 @@ int sched_numa_find_closest(const struct
cpumask *cpus, int cpu)
         if (cpu < nr_cpu_ids)
             return cpu;
     }
-#endif
     return nr_cpu_ids;
 }

+#endif /* CONFIG_NUMA */
+
 static int __sdt_alloc(const struct cpumask *cpu_map)
 {
     struct sched_domain_topology_level *tl;
