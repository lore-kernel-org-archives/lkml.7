Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD9CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4BA2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4+Pdt11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfJ3QDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:03:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35552 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfJ3QDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:03:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id m7so3314251lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmX4zrjZaoAtWMG4pGTvgGDFz+UMFVGZubr8Y23HkjY=;
        b=O4+Pdt11PD3uMpUXHaugaoxBTMgYtjANyaD2bpiuvaJ/l6Udb9TaF8SdCk6dzbhynu
         VxvQPLq+aXlsYwHm56zndbzxvWgxvmC+H7olT7D2c8JtFFcUuEO5LUxwPVwXpKK1dvSE
         CXScqaBnPdkR9tyGz1j/LudnlhiEXUBIuVgra8m/XTl2rzxZ4jEJNrKPDpDpleBqLU39
         WxJoDvKUUE/Yu+lDV/3fO5Gbd8W5wvVJQIWRtcStdrulCiPbhAhzfUmn0Y0HnX1VJb2A
         ou52D9RZXz7qDje6euuMEHGJB7okK9YykJoxFLhd7/tNV94p9uMwawhXUeg22hl/SmcJ
         XsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmX4zrjZaoAtWMG4pGTvgGDFz+UMFVGZubr8Y23HkjY=;
        b=hOhrRc6ASzPPTPv7UVtB5w5C0nqVdgmR1QeAc8HzUC01YKMx9Kamz13a67wk1WSx1z
         O1FzdWDHPudg4Pw5QIG+L7dmeM/Qq27Yv4j+kfpDRcioN0yyjC0ItgZbtHkzIcIaxhyt
         Q7QmNr8SJt/7ayZZh19hNjsNVN3ZPcFX/Di75yb2zOqrIVpN1tqC/ppxqhZA1cqKc0LW
         a3cme69BnRMd/ccrwcjtFf3S2WMN5L6mkO3xHOkjrAPNkJR7nyPYWs0Zxw8//+UfMINa
         RzgipwYyqqLFdsqH7a0mmJ67julvvPSNu9YAorXehmuURHzmxnOK/t29lHJXmGA+5E6I
         7nGA==
X-Gm-Message-State: APjAAAVTjGZNjuG+7BLoar3tyvQb1ttMoPKYSLghjsD5urJvt9P+3Kvz
        x13yv96VNC+laYtT2ZKjOjqNStjqi1+vss65MqVdizCBnNc=
X-Google-Smtp-Source: APXvYqyo3XKAkT+idJjW95ajUDT1ZDV4Ci10qi/AaY6BMJHKLOMic1DbYmAwL0BKYBa8gnj+itfJsDM7i7KLpIdI7pU=
X-Received: by 2002:a2e:96c1:: with SMTP id d1mr363547ljj.87.1572451416530;
 Wed, 30 Oct 2019 09:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-2-git-send-email-vincent.guittot@linaro.org> <20191030145133.GH3016@techsingularity.net>
In-Reply-To: <20191030145133.GH3016@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Oct 2019 17:03:24 +0100
Message-ID: <CAKfTPtDVcHpaXTVEfTU_0A=AKXiwRD5K1eVyC43DKSF49JFWAA@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] sched/fair: clean up asym packing
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 at 15:51, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Oct 18, 2019 at 03:26:28PM +0200, Vincent Guittot wrote:
> > Clean up asym packing to follow the default load balance behavior:
> > - classify the group by creating a group_asym_packing field.
> > - calculate the imbalance in calculate_imbalance() instead of bypassing it.
> >
> > We don't need to test twice same conditions anymore to detect asym packing
> > and we consolidate the calculation of imbalance in calculate_imbalance().
> >
> > There is no functional changes.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Acked-by: Rik van Riel <riel@surriel.com>
> > ---
> >  kernel/sched/fair.c | 63 ++++++++++++++---------------------------------------
> >  1 file changed, 16 insertions(+), 47 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1f0a5e1..617145c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7675,6 +7675,7 @@ struct sg_lb_stats {
> >       unsigned int group_weight;
> >       enum group_type group_type;
> >       int group_no_capacity;
> > +     unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
> >       unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
> >  #ifdef CONFIG_NUMA_BALANCING
> >       unsigned int nr_numa_running;
> > @@ -8129,9 +8130,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >        * ASYM_PACKING needs to move all the work to the highest
> >        * prority CPUs in the group, therefore mark all groups
> >        * of lower priority than ourself as busy.
> > +      *
> > +      * This is primarily intended to used at the sibling level.  Some
> > +      * cores like POWER7 prefer to use lower numbered SMT threads.  In the
> > +      * case of POWER7, it can move to lower SMT modes only when higher
> > +      * threads are idle.  When in lower SMT modes, the threads will
> > +      * perform better since they share less core resources.  Hence when we
> > +      * have idle threads, we want them to be the higher ones.
> >        */
> >       if (sgs->sum_nr_running &&
> >           sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
> > +             sgs->group_asym_packing = 1;
> >               if (!sds->busiest)
> >                       return true;
> >
>
> (I did not read any of the earlier implementations of this series, maybe
> this was discussed already in which case, sorry for the noise)
>
> Are you *sure* this is not a functional change?
>
> Asym packing is a twisty maze of headaches and I'm not familiar enough
> with it to be 100% certain without spending a lot of time on this. Even
> spotting how Power7 ends up using asym packing with lower-numbered SMT
> threads is a bit of a challenge.  Specifically, it relies on the scheduler
> domain SD_ASYM_PACKING flag for SMT domains to use the weak implementation
> of arch_asym_cpu_priority which by defaults favours the lower-numbered CPU.
>
> The check_asym_packing implementation checks that flag but I can't see
> the equiavlent type of check here. update_sd_pick_busiest  could be called

The checks of  SD_ASYM_PACKING and CPU_NOT_IDLE are already above in
the function but out of the patch.
In fact this part of update_sd_pick_busiest is already dedicated to
asym_packing.

What I'm doing is that instead of checking asym_packing in
update_sd_pick_busiest and then rechecking the same thing in
find_busiest_group, I save the check result and reuse it

Also patch 04 moves further this code

> for domains that span NUMA or basically any domain that does not specify
> SD_ASYM_PACKING and end up favouring a lower-numbered CPU (or whatever
> arch_asym_cpu_priority returns in the case of x86 which has a different
> idea for favoured CPUs).
>
> sched_asym_prefer appears to be a function that is very easy to use
> incorrectly. Should it take env and check the SD flags first?
>
> --
> Mel Gorman
> SUSE Labs
