Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00550C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFEE20872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNmt9DOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfIYWHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:07:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34096 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfIYWHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:07:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id r22so154385lfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 15:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1iYIPSzzIfXlRvnuiGOUUTDkEf43dGwEwse/Vb9bEnE=;
        b=bNmt9DOt5JGyHTmbNuyV+3+vaKOB/qnAuhWlp/ogagheP6TNEym2rVTA1feCUZZa/X
         8VpNWfRYn9wit6UwLwWcT8gtFiUxl3rx4s8Xd7H93ebVNBJ7JsEPlsqeBCdtm5U3vbMR
         FMWqBOlFOQQZ84IibgteeiCibYPpIUtPcGZFxNbLMnyZR5GvROP7FDMbC4xqOghCD48T
         K98sDCi5LkhmTuLccVPh7PQWS7TRZpWaxClvDMSdPC6Baet1yshzg0SFu6woVC0r8tVK
         S8daqjkDXi6tUfR6CoP149MQnZ10wTuZSlS3FghtViSM+sgsRoWjHIp4bCee/4UxIr/I
         k21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1iYIPSzzIfXlRvnuiGOUUTDkEf43dGwEwse/Vb9bEnE=;
        b=esLf6rZLsDW9PmvaEVgU8wZTytVRlgbV72Jah3CktxxEcs3gsw8ylSsy0qcRFFl+9o
         WzUmjLHycYltZHdhlATAc9ygtSOrt6aMsaVLCiZbxaKstEvyJJTLMoziw2OY9FTlFy9w
         bcGZV/XXirlFJqRkH/34iJPKIYBXOV6blIzveWMRS61rUngIwaRlrRpQVPSi/B4LHwDW
         sxp1BwaX+q8I2yrCyv+1mMhyQGMDdbbY9zF/Mxen8vU5SPjtiXNwPiw12FDn/i0EtLTq
         KVPrPmoq7SI3NqgwPN8D75b7E6yEfmUz25iXS0JkLm7V9CQKNisPfammKyRUjyqcaa3M
         t/VQ==
X-Gm-Message-State: APjAAAXVMJZnnSOMRGVvI94SaHAcbLppRkfwvYFG7EaWKLESlEqcNg6J
        rgDUGh5nqiKiLahoGUzI6Zd9Os4naFQDTxg6heo=
X-Google-Smtp-Source: APXvYqzQ9urJ1osGJ/GM8h+P3fUAwl88wO4YuHWVsid4KQT52oBLZ2uUS8ywSIqld0awN/kDwgIHGZgoRKowBXd7sv4=
X-Received: by 2002:ac2:4c8f:: with SMTP id d15mr161866lfl.74.1569449273985;
 Wed, 25 Sep 2019 15:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190612163345.GB26997@sinkpad> <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad> <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com> <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com> <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com> <CAERHkrurxjDvktGD+Xfjx7Bo5JtTCuqdYToQaDJTNbbRufFWMw@mail.gmail.com>
 <54fbb676-61f9-e76c-7be3-fe2c2bb473da@linux.intel.com>
In-Reply-To: <54fbb676-61f9-e76c-7be3-fe2c2bb473da@linux.intel.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 26 Sep 2019 06:07:42 +0800
Message-ID: <CAERHkrs4=pgG-+Bd=YLzZ2RWEPTDX0x70Zb4haTwSZODyC2NLw@mail.gmail.com>
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

On Thu, Sep 26, 2019 at 1:24 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On 9/24/19 7:40 PM, Aubrey Li wrote:
> > On Sat, Sep 7, 2019 at 2:30 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >> +static inline s64 core_sched_imbalance_delta(int src_cpu, int dst_cpu,
> >> +                       int src_sibling, int dst_sibling,
> >> +                       struct task_group *tg, u64 task_load)
> >> +{
> >> +       struct sched_entity *se, *se_sibling, *dst_se, *dst_se_sibling;
> >> +       s64 excess, deficit, old_mismatch, new_mismatch;
> >> +
> >> +       if (src_cpu == dst_cpu)
> >> +               return -1;
> >> +
> >> +       /* XXX SMT4 will require additional logic */
> >> +
> >> +       se = tg->se[src_cpu];
> >> +       se_sibling = tg->se[src_sibling];
> >> +
> >> +       excess = se->avg.load_avg - se_sibling->avg.load_avg;
> >> +       if (src_sibling == dst_cpu) {
> >> +               old_mismatch = abs(excess);
> >> +               new_mismatch = abs(excess - 2*task_load);
> >> +               return old_mismatch - new_mismatch;
> >> +       }
> >> +
> >> +       dst_se = tg->se[dst_cpu];
> >> +       dst_se_sibling = tg->se[dst_sibling];
> >> +       deficit = dst_se->avg.load_avg - dst_se_sibling->avg.load_avg;
> >> +
> >> +       old_mismatch = abs(excess) + abs(deficit);
> >> +       new_mismatch = abs(excess - (s64) task_load) +
> >> +                      abs(deficit + (s64) task_load);
> >
> > If I understood correctly, these formulas made an assumption that the task
> > being moved to the destination is matched the destination's core cookie.
>
> That's not the case.  We do not need to match the destination's core cookie,

I actually meant destination core's core cookie.

> as that may change after context switches. It needs to reduce the load mismatch
> with the destination CPU's sibling for that cgroup.

So the new_mismatch is not always true, especially when there are more
cgroups and
more core cookies on the system.

Thanks,
-Aubrey
