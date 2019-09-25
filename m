Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B3C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250912064A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAelqBhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411407AbfIYCkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 22:40:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38722 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391325AbfIYCkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 22:40:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id b20so3954517ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 19:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xs4RXQjyzW7C8m4DnwnvsoXCB5OteR+eiGEoFHczrgA=;
        b=lAelqBhbNyRU7u20C6MPOKep7/TkgC4L6FvoFz5gTEnJLVU8h65ZwBumNGpmai4gAC
         6dXQ3dGtcs8Xg7GyiZpYlpK0I5xxGosEF4Thvd4DCh0sfkdVZd5B3bIhp22jHBfem2bi
         gawmmAvBQ72pmKCG9P4HZyLKq8vRvRplZdG6T/h6yPhGLG0udCKX33Q4eHVJnekXZDHJ
         qvmw9KHeSxBvHxZa4BxPpH8GxEOyVO1VsZWiZFY+ose08RXT3Y3hnNLPxpPgF7VJq9fX
         kYRp34WaG63xmtp9giCjZChlD89lt33Sht1kaAyNhjFjD0EOwCb8nTR1Z/4MJ6by3Ogs
         rgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xs4RXQjyzW7C8m4DnwnvsoXCB5OteR+eiGEoFHczrgA=;
        b=rfR5XJOo2W+VFKjrUCefjIhuYYfPXmZ4UiFr0nKzi7Rl0MR6CtmXprqs7vVWISjSG2
         OicQEPifbKo/kS+lE/xI/vRTBAwl7u1qjthZMgnJ7y3/Yf72RbdpsRGg8VRiFDf+hKom
         splVSLQVjk0jOND9FIWMA2RNoon+HRjEYd3UZr76gNl/4JI8d0RxzgWPB+1+ahGMhHzg
         KZLTjQS7g9O7E3X7nKQUjC5eB5ntDTc57MsZWJrqDpRIHn/FXlRL8aY/kKWB3lJyRU2k
         UYw90mFVwPQVudv8mAoH9esYEvrYC9g1Ra1YIDeu72HrjLhM0+yjA6XXdKSUneXthpup
         sSQQ==
X-Gm-Message-State: APjAAAXKmGKVcwPtIRasnHR16VfR27hlgCTrlLB9j1Hv/yagidzcFT7o
        BmmWZPLkoGeRIEyxxSlONVt4ZVF1PSCzu6I7M8o=
X-Google-Smtp-Source: APXvYqyaGBkpuE6Jdo5PPMDf+3TrE1UPQVGwT2LzfJNy/2y7U+s20iMF1/zuuG+mR5PaVUUdqYbTbS0Np/Re/sP3UTk=
X-Received: by 2002:a2e:4704:: with SMTP id u4mr4011601lja.203.1569379220651;
 Tue, 24 Sep 2019 19:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190612163345.GB26997@sinkpad> <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad> <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com> <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com> <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
In-Reply-To: <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 25 Sep 2019 10:40:09 +0800
Message-ID: <CAERHkrurxjDvktGD+Xfjx7Bo5JtTCuqdYToQaDJTNbbRufFWMw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Dario Faggioli <dfaggioli@suse.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 2:30 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> +static inline s64 core_sched_imbalance_delta(int src_cpu, int dst_cpu,
> +                       int src_sibling, int dst_sibling,
> +                       struct task_group *tg, u64 task_load)
> +{
> +       struct sched_entity *se, *se_sibling, *dst_se, *dst_se_sibling;
> +       s64 excess, deficit, old_mismatch, new_mismatch;
> +
> +       if (src_cpu == dst_cpu)
> +               return -1;
> +
> +       /* XXX SMT4 will require additional logic */
> +
> +       se = tg->se[src_cpu];
> +       se_sibling = tg->se[src_sibling];
> +
> +       excess = se->avg.load_avg - se_sibling->avg.load_avg;
> +       if (src_sibling == dst_cpu) {
> +               old_mismatch = abs(excess);
> +               new_mismatch = abs(excess - 2*task_load);
> +               return old_mismatch - new_mismatch;
> +       }
> +
> +       dst_se = tg->se[dst_cpu];
> +       dst_se_sibling = tg->se[dst_sibling];
> +       deficit = dst_se->avg.load_avg - dst_se_sibling->avg.load_avg;
> +
> +       old_mismatch = abs(excess) + abs(deficit);
> +       new_mismatch = abs(excess - (s64) task_load) +
> +                      abs(deficit + (s64) task_load);

If I understood correctly, these formulas made an assumption that the task
being moved to the destination is matched the destination's core cookie. so if
the task is not matched with dst's core cookie and still have to stay
in the runqueue
then the formula becomes not correct.

>  /**
>   * update_sg_lb_stats - Update sched_group's statistics for load balancing.
>   * @env: The load balancing environment.
> @@ -8345,7 +8492,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 else
>                         load = source_load(i, load_idx);
>
> -               sgs->group_load += load;

Why is this load update line removed?

> +               core_sched_imbalance_scan(sgs, i, env->dst_cpu);
> +
>                 sgs->group_util += cpu_util(i);
>                 sgs->sum_nr_running += rq->cfs.h_nr_running;
>

Thanks,
-Aubrey
