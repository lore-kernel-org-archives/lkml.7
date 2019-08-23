Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62623C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382592166E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDrSWemF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbfHWKoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:44:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38010 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389475AbfHWKn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:43:59 -0400
Received: by mail-io1-f67.google.com with SMTP id p12so19047787iog.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LguLqmbBWbPdKueS6f8s+iff5p51lzL0SO42xI76Zlw=;
        b=fDrSWemFkny3Xi2K12jcJc98rev4rMqe2wMpCQgAviDgObYJUXPWHc9Yt9XpjBwBUz
         STREfMnY1KZSW+oPJqgSP0pmfhebOHzlqyROP42H77xNprtAiNhkslCM08eb9WfpHPfU
         OP73A2HkgHa2tyuE7RPtgdPBAr32STFtxJVKq8KbuLpuORKWF4m/xE7G58iYTo+syOQ5
         zN7LbjEq+AsHG9ki0on2TW23QGAhO8wRxsQK3uFbgDby06D6+aWt61ER/wSVRJ5RzlZX
         7TK531VydE+W5sTS16+Vak0h0OMVJSysg4J/iTAC3ql6WjwY+zJ1rOeFBj97zij8s4U5
         Za6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LguLqmbBWbPdKueS6f8s+iff5p51lzL0SO42xI76Zlw=;
        b=Hidm3s52Td6OzvpuLs56LDjHjYvU3PR6f1+0AVnkVdW/IFtNAVJY3LW0t+0A6aSZrW
         Znpu6yCi2rSrQVL15Dpe7JRTqhS0BEC+l9aFVBRrQC1Hyaf+YNEWPBTwXOM66Yoj2WUk
         knTf7Fy5t1PkIQERFxn6/yddl32ByWB/gty5HIzV6NIYmDiKUEUmw7QTC6EbajMEDqPj
         I5EnjkY5faR78rEKF1l7jonsezSwOv34AECX6JNkW2B98Q/4ygwCDPJbEv/Z0C4w1Axi
         1oV0HuwmJ+bd9yzKun3U83SC6pYvL2vavRBfqVj7zfy3aT6vLE249SC+r5rkf5WzA9jq
         /pXQ==
X-Gm-Message-State: APjAAAWcQaa6OPUdCzThrnxTvS46OLZCvZEB087cAB23nZcidvIeh4tc
        k9j27mAYgfDhaNQFRyrUHCV6/1YuQKGSZn/0smQ=
X-Google-Smtp-Source: APXvYqwvE5etieJ+BSLkV7jGzhBvKdUSHisPxx0L/1Ko14iO5GUnhe+tuipbm3da27eeCtegwyLCvgYIrY4rnnu0IDc=
X-Received: by 2002:a6b:6a15:: with SMTP id x21mr5790479iog.40.1566557038542;
 Fri, 23 Aug 2019 03:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190601082722.44543-1-irogers@google.com> <20190621082422.GH3436@hirez.programming.kicks-ass.net>
 <CAP-5=fW7sMjQEHm+1e=cdAi+ZyP53UyU7xhAbnouMApuxYqrhw@mail.gmail.com>
 <20190624075520.GC3436@hirez.programming.kicks-ass.net> <CAP-5=fU=xbP39b6WZV4h92g6Ub_w4tH2JdApw5t6DTyZqxShUQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU=xbP39b6WZV4h92g6Ub_w4tH2JdApw5t6DTyZqxShUQ@mail.gmail.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Fri, 23 Aug 2019 16:13:46 +0530
Message-ID: <CAKTKpr6m7YzqJ7U2icNHq7ZwoG0pw8ws_EHcLR+-T6ZeEfe15Q@mail.gmail.com>
Subject: Re: [PATCH] perf cgroups: Don't rotate events for cgroups unnecessarily
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are seeing regression with our uncore perf driver(Marvell's
ThunderX2, ARM64 server platform) on 5.3-Rc1.
After bisecting, it turned out to be this patch causing the issue.

Test case:
Load module and run perf for more than 4 events( we have 4 counters,
event multiplexing takes place for more than 4 events), then unload
module.
With this sequence of testing, the system hangs(soft lockup) after 2
or 3 iterations. Same test runs for hours on 5.2.

while [ 1 ]
do
        rmmod thunderx2_pmu
        modprobe thunderx2_pmu
        perf stat -a -e \
        uncore_dmc_0/cnt_cycles/,\
        uncore_dmc_0/data_transfers/,\
        uncore_dmc_0/read_txns/,\
        uncore_dmc_0/config=0xE/,\
        uncore_dmc_0/write_txns/ sleep 1
        sleep 2
done

Is this patch tested adequately?

On Fri, Jun 28, 2019 at 3:18 AM Ian Rogers <irogers@google.com> wrote:
>
> group_index On Mon, Jun 24, 2019 at 12:55 AM Peter Zijlstra
> <peterz@infradead.org> wrote:
> >
> > On Fri, Jun 21, 2019 at 11:01:29AM -0700, Ian Rogers wrote:
> > > On Fri, Jun 21, 2019 at 1:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Sat, Jun 01, 2019 at 01:27:22AM -0700, Ian Rogers wrote:
> > > > > @@ -3325,6 +3331,15 @@ static int flexible_sched_in(struct perf_event *event, void *data)
> > > > >                       sid->can_add_hw = 0;
> > > > >       }
> > > > >
> > > > > +     /*
> > > > > +      * If the group wasn't scheduled then set that multiplexing is necessary
> > > > > +      * for the context. Note, this won't be set if the event wasn't
> > > > > +      * scheduled due to event_filter_match failing due to the earlier
> > > > > +      * return.
> > > > > +      */
> > > > > +     if (event->state == PERF_EVENT_STATE_INACTIVE)
> > > > > +             sid->ctx->rotate_necessary = 1;
> > > > > +
> > > > >       return 0;
> > > > >  }
> > > >
> > > > That looked odd; which had me look harder at this function which
> > > > resulted in the below. Should we not terminate the context interation
> > > > the moment one flexible thingy fails to schedule?
> > >
> > > If we knew all the events were hardware events then this would be
> > > true, as there may be software events that always schedule then the
> > > continued iteration is necessary.
> >
> > But this is the 'old' code, where this is guaranteed by the context.
> > That is, if this is a hardware context; there wil only be software
> > events due to them being in a group with hardware events.
> >
> > If this is a software group, then we'll never fail to schedule and we'll
> > not get in this branch to begin with.
> >
> > Or am I now confused for having been staring at two different code-bases
> > at the same time?
>
> I believe you're right and I'd overlooked this. I think there is a
> more efficient version of this code possible that I can follow up
> with. There are 3 perf_event_contexts, potentially a sw and hw context
> within the task_struct and one per-CPU in perf_cpu_context. With this
> change I'm focussed on improving rotation of cgroup events that appear
> system wide within the per-CPU context. Without cgroup events the
> system wide events don't need to be iterated over during scheduling
> in. The branch that can set rotate_necessary will only be necessary
> for the task hardware events. For system wide events, considered with
> cgroup mode scheduling in, the branch is necessary as rotation may be
> necessary. It'd be possible to have variants of flexible_sched_in that
> behave differently in the task software event context, and the system
> wide and task hardware contexts.
>
> I have a series of patches related to Kan Liang's cgroup
> perf_event_groups improvements. I'll mail these out and see if I can
> avoid the branch in the task software event context case.
>
> Thanks,
> Ian

Thanks,
Ganapat
