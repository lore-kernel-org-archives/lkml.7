Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5DDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FD520684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vA5fQHXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfCGKmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:42:08 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37567 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfCGKmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:42:07 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so13043519iop.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNzxaUBFCuWMw4UYu3dTOexqnAYkS2Ak/v1V9Gxnfr4=;
        b=vA5fQHXmekAPkeudw1zG3Qx0NgzpPHqfMvl0ya58rTCkJXuZaugYscnPWXeMQ1sqzH
         z/wvrnSN/EsejLbIGxk2HNBq+Fs25MdHgf/BLTRAyNW0YQGhcamnkRvxx//RDDSUetEK
         pAlBbQbBqnu7PVEB6G7obFiKNElcV9ZiIF5E/2bRNh6mWiHRRPA1odHFqlkMVuzPE6H2
         b8VCB2oROWUWju46vhopniWB8O0Q9eTTV2i8PRycTmUmX9CLeD1zK1hUtycHz2kciqwR
         mQdWAzpvKZkNLu8twIbD+g8a+0UfGVlhmrCW+YB9skUtQRErh2gDNBrBNDl0+U2KuyDB
         vc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNzxaUBFCuWMw4UYu3dTOexqnAYkS2Ak/v1V9Gxnfr4=;
        b=iW1IPu+lAODYxLXw9ZrwRxWfK5E88EZ70mVRlMocbmory8z56y6o1TLoyQB6WUwusw
         GQOKnAwQlB+4wWyetpESs8B2iyyu50f7GBYbMUsheOLBTzXSzH5lhMrOfwryCghjleNW
         IzA9s2i9P4milmS+VkPRFJxRKDSOtDYKNb8+daBA1JJHLJfao4tZcFGyRGT1YU61Qb5r
         V9j5AfFqy2ApaetiHUVtSx9O3eTub6fqC02OXjiAmWYijBrjfa6Yo9Qbt6t3Gnm8KYrF
         W0yp4nW7/zzsTwetL1y1jyAKbPbc+bfEEU8okB8dKdhvQ/+XOuqr1Y30QtPEPXPSrtlu
         sp2w==
X-Gm-Message-State: APjAAAXVU/qD6FJMep/FeL8+QIx2iTk8cquUifd09NssOzKkveGlU7l9
        8QnShJ5s2kIvNoWS82pG/RzjNufSTFhxlKbI8yl/KA==
X-Google-Smtp-Source: APXvYqyMqrnpUEcaBmld9G1kd8PxHHk7UuyM/RNzEpRleWnI14EGEGi5xEspd4pSLdDH5iRuwE2yPeLXio8X6KmLjsk=
X-Received: by 2002:a6b:5802:: with SMTP id m2mr5504295iob.142.1551955326595;
 Thu, 07 Mar 2019 02:42:06 -0800 (PST)
MIME-Version: 1.0
References: <1551861826-12592-1-git-send-email-laoar.shao@gmail.com>
 <20190306100907.GT32477@hirez.programming.kicks-ass.net> <CALOAHbC1zqzU8-ikcLOUMKY5cbyuW_B6MK5rz7G6rTK-SoyMTQ@mail.gmail.com>
 <20190306112707.GU32477@hirez.programming.kicks-ass.net> <CALOAHbB7EZ83R3gHcGa9oZWq=7CEgBkL2cXav_7N13u4U44+uA@mail.gmail.com>
 <20190306123834.GW32494@hirez.programming.kicks-ass.net> <CALOAHbBDArxamap+TsWXy227N-UOsKVDA-HkGVF1M0O2Fk8qEg@mail.gmail.com>
 <CALOAHbAC-aev3s_n+byWMyeoBo8knFdbKUcXUjsbM3D8iFRWOQ@mail.gmail.com> <20190307095503.GB32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190307095503.GB32477@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 7 Mar 2019 18:41:30 +0800
Message-ID: <CALOAHbA1ZfAiR3O0XSOi80fOBcayDOBbYf0bvPiLnTXFPCiyuQ@mail.gmail.com>
Subject: Re: [PATCH] sched: fair: fix missed CONFIG_SCHEDSTATS
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 5:55 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 07, 2019 at 03:49:58PM +0800, Yafang Shao wrote:
> > What about your opinon ?
> >
> >
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index 9a4bdfa..a0291f2 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -336,6 +336,7 @@ static inline long __trace_sched_switch_state(bool
> > preempt, struct task_struct *
> >                   __entry->pid, __entry->old_pid)
> >  );
> >
> > +#ifdef CONFIG_SCHEDSTATS
> >  /*
> >   * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
> >   *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
> > @@ -394,6 +395,14 @@ static inline long
> > __trace_sched_switch_state(bool preempt, struct task_struct *
> >  DEFINE_EVENT(sched_stat_template, sched_stat_blocked,
> >              TP_PROTO(struct task_struct *tsk, u64 delay),
> >              TP_ARGS(tsk, delay));
> > +#else
> > +
> > +#define trace_sched_stat_wait(...) do {} while (0)
> > +#define trace_sched_stat_sleep(...) do {} while (0)
> > +#define trace_sched_stat_iowait(...) do {} while (0)
> > +#define trace_sched_stat_blocked(...) do {} while (0)
>
> Make those inline functions that take proper arguments.
>

Sure.
Will change it.

Thanks
Yafang
