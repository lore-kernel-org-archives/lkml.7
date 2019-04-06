Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5DBC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 00:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9665B21871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 00:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjJ5zVg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDFAt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 20:49:28 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44745 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfDFAt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 20:49:28 -0400
Received: by mail-vk1-f194.google.com with SMTP id q189so1838156vkq.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 17:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hml97b0NmWYMZJBuaShZ+PWX2gT4x6nYAZjr3fyQFIQ=;
        b=gjJ5zVg/l2BWPd2W+Xtyt96po8PpdCFUXwXRGnx18P2di66dvkkcG12/yFXy4xEka8
         6C7R+jfG9PtMby+86vrV27iqQg4D881Hic5o/gZPDAIChqElZkvFCow04y+WQCRjNx9H
         FBK1tvx4bkzltFOOYt2TVBHs2hJXEv/CJAbaDCxiTEzBwp55pHyTqTxnbcJCvMDZkYlS
         X0z6u2SZH+oT3aT1Ffwef3OeR64im9CLzuErzfsR9f6TdCnZX17ILtWhgVHJGs34Zs8E
         aOiVC8Pa6UD/nydvd7wZmXo5FFc05uezRJP8JZ9uQbMtfJDELekQP5+qkzjmoUylOKIo
         pX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hml97b0NmWYMZJBuaShZ+PWX2gT4x6nYAZjr3fyQFIQ=;
        b=S01zgj1jT33SWM4jQG7Fmi6t+8Om1MWypqMY/njpeXuLlx9DxzUHRgUT/vbamW27UW
         82ioeWlLn7n6EpeKZ4BIxypkOk9iDmu9gWNHrpupuYwiZgn3CdMC/Wa0QH+kjfmYi7tX
         vJ/Po0zJqpXpum2WGHEyN3pEBf/dcNrtYsaAV4H+RomrYXIIB8yCZV3Vs6QxfuYBPiiM
         MoM7z5iajVLoanpab3Gjd+pgtWIpOc26ZgOzDYjN42IgvdJUOTePKqx3byQtWQBZmq5/
         2r8J0oSzDa7Qpae2NWESJC9/7f0R4IoV05rlaE0UIdCcq5zDnKVznPevIs5LNoHsdsNG
         KXrA==
X-Gm-Message-State: APjAAAUbqGCa2ZZUSZ28XKeEDcsRJR9OmkR1psOXcmE++Fyeq0rPes4f
        tlRVs7oD3DKGGApGEHXQKEkTY65eYmMHjWUKbcgF4Q==
X-Google-Smtp-Source: APXvYqxgobIb2ffeR1zF9FVXfYKuZAIph45xh0ZBHpENxcVhzovUWYjS9gVtTtLYGOne4FMSn4ulaAa4/vgSMRQeU+Q=
X-Received: by 2002:a1f:9d87:: with SMTP id g129mr9864147vke.56.1554511766979;
 Fri, 05 Apr 2019 17:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190404183219.125083-1-eranian@google.com> <20190404183219.125083-4-eranian@google.com>
 <20190405071333.GB4038@hirez.programming.kicks-ass.net> <CABPqkBTzBYSN_k6FV=iOmmBfZWmG2N9fYHke_MdiCCgO=KFeUw@mail.gmail.com>
 <20190405202620.GG4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190405202620.GG4038@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 5 Apr 2019 17:49:15 -0700
Message-ID: <CABPqkBT3mzjZSt2C3gJjRrDppf1dBh7eVELQLmMva6dmwcfYrg@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf/x86/intel: force resched when TFA sysctl is modified
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, mingo@elte.hu,
        nelson.dsouza@intel.com, Jiri Olsa <jolsa@redhat.com>,
        tonyj@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 1:26 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 05, 2019 at 10:00:03AM -0700, Stephane Eranian wrote:
>
> > > > +static void update_tfa_sched(void *ignored)
> > > > +{
> > > > +     struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > > > +     struct pmu *pmu = x86_get_pmu();
> > > > +     struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
> > > > +     struct perf_event_context *task_ctx = cpuctx->task_ctx;
> > > > +
> > > > +     /* prevent any changes to the two contexts */
> > > > +     perf_ctx_lock(cpuctx, task_ctx);
> > > > +
> > > > +     /*
> > > > +      * check if PMC3 is used
> > > > +      * and if so force schedule out for all event types all contexts
> > > > +      */
> > > > +     if (test_bit(3, cpuc->active_mask))
> > > > +             perf_ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
> > > > +
> > > > +     perf_ctx_unlock(cpuctx, task_ctx);
> > >
> > > I'm not particularly happy with exporting all that. Can't we create this
> > > new perf_ctx_resched() to include the locking and everything. Then the
> > > above reduces to:
> > >
> > >         if (test_bit(3, cpuc->active_mask))
> > >                 perf_ctx_resched(cpuctx);
> > >
> > > And we don't get to export the tricky bits.
> > >
> > The only reason I exported the locking is to protect
> > cpuc->active_mask. But if you
> > think there is no race, then sure,  we can just export a new
> > perf_ctx_resched() that
> > does the locking and invokes the ctx_resched() function.
>
> It doesn't matter if it races, if it was used and isn't anymore, it's
> a pointless reschedule, if it isn't used and we don't reschedule, it
> cannot be used because we've already set the flag.

True. I will post V2 shortly.
