Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25ECC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5915215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InHu5zUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFUBlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:41:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34546 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfFUBlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:41:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so4756128otk.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rzeo006/jzKSPbm/r6/uBrpWXDZY3RJIqz2UkltKFyE=;
        b=InHu5zUe2eCXIwwtW0YOX9gE+fyok9lXwN7cVGa4LDl8uiFbj5KtVU7tjR2Q3cbsZw
         s7WbGsOSewa1njscsIAyEn7uZrD9r+eyBqXnL2jRE7tXwqRos1abF7o8FHOMd7X/I8KP
         1TjN7xcOZfVlgnSvgS389tb2seOt2ZZCuALShhDwKxnuzq8DnXkERb83GnpNPkNysW/m
         SxEGAVKvao4sRWK8IcykA5zInIe1APOFnj261YgJTuIlUjr0mLLpivhtS2kKOr54595j
         EB9bvH9nEDQO8btvJf4HU7D0VCWn3jyb05uoMVY5FlrSBvmoqiwFHbotzOEeccKodt8B
         lH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rzeo006/jzKSPbm/r6/uBrpWXDZY3RJIqz2UkltKFyE=;
        b=KQkqxR3Ihhnd/zDo9DfFjstp5ZrtXbfsPfksx1V7w79HhKEO9Snu58PQcOaUhNvi6a
         gu7yBo8LpgUOrNfAnpU3qlralnTvF0TpJxgX3V3s9k1O09djUej1QYr/5eeBriECyPxA
         Ct+HvDVSpmZhNQXMlb9BAdMrp6Z+PfOc+pw+f0UCkv59DxCeTogRMzr3hieYUy5g0VIO
         ASXTu2+BOVqA8bPGmmMofMjkCNaobRnE4QME3wvoWdbMX1bMRyfZBLuBMRlzcuvBq00d
         2otD94pHI4FZ02C8AhMCbHjlia8pQNcLkPPiOPf5tUE8SGAaXOAAosLZ4DHFD3HkYYPO
         ySKQ==
X-Gm-Message-State: APjAAAV4+gvTAc1P1fKVCSyQoNLule0WMqwsRMF3DRjnnMrUW7if8y/e
        wSSwPuIwlXmyYpf+7Ig3dclgewCfuUHFE1fqSPc=
X-Google-Smtp-Source: APXvYqyc2uHg7iq570Lo7bKCfpjFfDQTFm/HBeMCa5eMK1ady5LaV1BB4tBXqYIIi/0EMVPC2X6gWsvrhstVsfXSfzU=
X-Received: by 2002:a9d:62c4:: with SMTP id z4mr5878774otk.56.1561080890907;
 Thu, 20 Jun 2019 18:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <1561030614-17026-1-git-send-email-wanpengli@tencent.com> <20190620123807.GX3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190620123807.GX3436@hirez.programming.kicks-ass.net>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 21 Jun 2019 09:36:04 +0800
Message-ID: <CANRm+CwfaafP6vwo-zu==G6BTmZb64xUDB+Ko7xsFy-iVGFXUg@mail.gmail.com>
Subject: Re: [PATCH] sched/isolation: Prefer housekeeping cpu in local node
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 at 20:38, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 20, 2019 at 07:36:54PM +0800, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > In real product setup, there will be houseeking cpus in each nodes, it
> > is prefer to do housekeeping from local node, fallback to global online
> > cpumask if failed to find houseeking cpu from local node.
> >
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> >  kernel/sched/isolation.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index 123ea07..9eb6805 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -16,9 +16,16 @@ static unsigned int housekeeping_flags;
> >
> >  int housekeeping_any_cpu(enum hk_flags flags)
> >  {
> > +     int cpu;
> > +
> >       if (static_branch_unlikely(&housekeeping_overridden))
> > -             if (housekeeping_flags & flags)
> > -                     return cpumask_any_and(housekeeping_mask, cpu_online_mask);
> > +             if (housekeeping_flags & flags) {
> > +                     cpu = cpumask_any_and(housekeeping_mask, cpu_cpu_mask(smp_processor_id()));
> > +                     if (cpu < nr_cpu_ids)
> > +                             return cpu;
> > +                     else
> > +                             return cpumask_any_and(housekeeping_mask, cpu_online_mask);
> > +             }
> >       return smp_processor_id();
> >  }
> >  EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
>
> Why not something like so? IIRC there's more places that want this, but
> I can't seem to remember quite where.

Good point, do it in v2. Btw, could you have a look this patch?
https://lkml.org/lkml/2019/6/17/1723

Regards,
Wanpeng Li
