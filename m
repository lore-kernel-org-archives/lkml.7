Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BC8CA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1105921D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSszYDUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504113AbfJRGTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:19:44 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36380 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392129AbfJRGTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:19:44 -0400
Received: by mail-il1-f194.google.com with SMTP id z2so4506563ilb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 23:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/mQKvVwLLAE61imom7nF77bK1zYmMOG/3Rkh5BT1ls=;
        b=hSszYDUVkuQAt1pGlYFANvFjl+tUF7d1ZjTeR1xTH9SeiJMBgfVtdbwNt0tKzMhxx1
         ukXWXRBG36Ft5U8BIwrQW27SBg6hTOs7fQvJqvCSDW0vcyt5Mhifbx46Cr/ka2+vSRqK
         ADp96aKgeZCgCej6Le23jtbm0UMbzJU1lh+04v1rs65B+tpf0mQFfZjxsGDGmfbd5q3h
         KLMhB0DZn2v/hHaBWLZAeplxNwJxoWYl02VF4OIPjyo4llVOiE6zIrofXVb915CLjTLX
         3XXKQBLosXIocmrFHJHEZI6xETFJYAYetMAVDr+5HpJIF1EBcThDe00dK4IGrPdUY35x
         E2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/mQKvVwLLAE61imom7nF77bK1zYmMOG/3Rkh5BT1ls=;
        b=c0Z+lMbROg1QpN5C3nE906Rf5QHdpJostIrRSJWu56eXZ/hK01oyzfMFzpbTZxGURN
         mzCDoSm/BD6MCrHq5WBG1sDUy4qS1DXcSK3rqyOUFDxYBcPzq3SH1WGHhFOfEay9mTHk
         F1hwpLZSGeqp3gP+sqwCiRDTjbeGkVz9TzcQ97aSfsIWnFs1HuqJUpLlbZX6h/sRiBi6
         67pPrTqoOsqJtiy/MaTycLlm0HExaxY7OIcrma8HEPQhXZGqLoPJpgqjA3qgiG64TGwh
         dbnlhitnZuzmf/L33iAjGlJmEogm5H4+dRtC6byeuAmfcgiSGCx7iwXPLBT8gN8/1e98
         W2Gg==
X-Gm-Message-State: APjAAAUZTNZR+pJI34B7EBIcdNS1eKJbVTxnKU/U5PYEw/M4h6vKPaD2
        l/dTVOUx8MYR+v1u2GjVl1W/6VHEBImQZ/abqC3gVrmM74I=
X-Google-Smtp-Source: APXvYqxgdUna+bn3Aoqkntmv001/sdK6mcw2YC4S9oZlS9O8UwimklndWiYw0QxWnnbS+v52f5L9Tu34vFcFcWf3GZw=
X-Received: by 2002:a92:1d5c:: with SMTP id d89mr8102448ild.94.1571379582698;
 Thu, 17 Oct 2019 23:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191018002746.149200-1-eranian@google.com> <7B6B74DF-53E0-42DA-97D6-3F04E84D688B@fb.com>
In-Reply-To: <7B6B74DF-53E0-42DA-97D6-3F04E84D688B@fb.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 17 Oct 2019 23:19:30 -0700
Message-ID: <CABPqkBT40-wVWq7K93QJc1r_1=R0WQuoa_SHebWApPEstCWeNg@mail.gmail.com>
Subject: Re: [PATCH] perf/core: fix multiplexing event scheduling issue
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@elte.hu" <mingo@elte.hu>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "kan.liang@intel.com" <kan.liang@intel.com>,
        "irogers@google.com" <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:13 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Oct 17, 2019, at 5:27 PM, Stephane Eranian <eranian@google.com> wrote:
> >
> > This patch complements the following commit:
> > 7fa343b7fdc4 ("perf/core: Fix corner case in perf_rotate_context()")
> >
> > The fix from Song addresses the consequences of the problem but
> > not the cause. This patch fixes the causes and can sit on top of
> > Song's patch.
> >
> > This patch fixes a scheduling problem in the core functions of
> > perf_events. Under certain conditions, some events would not be
> > scheduled even though many counters would be available. This
> > is related to multiplexing and is architecture agnostic and
> > PMU agnostic (i.e., core or uncore).
> >
> > This problem can easily be reproduced when you have two perf
> > stat sessions. The first session does not cause multiplexing,
> > let's say it is measuring 1 event, E1. While it is measuring,
> > a second session starts and causes multiplexing. Let's say it
> > adds 6 events, B1-B6. Now, 7 events compete and are multiplexed.
> > When the second session terminates, all 6 (B1-B6) events are
> > removed. Normally, you'd expect the E1 event to continue to run
> > with no multiplexing. However, the problem is that depending on
> > the state Of E1 when B1-B6 are removed, it may never be scheduled
> > again. If E1 was inactive at the time of removal, despite the
> > multiplexing hrtimer still firing, it will not find any active
> > events and will not try to reschedule. This is what Song's patch
> > fixes. It forces the multiplexing code to consider non-active events.
>
> Good analysis! I kinda knew the example I had (with pinned event)
> was not the only way to trigger this issue. But I didn't think
> about event remove path.
>
I was pursuing this bug without knowledged of your patch. Your patch
makes it harder to see. Clearly in my test case, it disappears, but it is
just because of the multiplexing interval. If we get to the rotate code
and we have no active events yet some inactive, there is something
wrong because we are wasting counters. When I tracked the bug,
I started from the remove_context code, then realized there was also
the disable case. I fixed both and they I discovered your patch which
is fixing it at the receiving end. Hopefully, there aren't any code path
that can lead to this situation.


> > However, the cause is not addressed. The kernel should not rely on
> > the multiplexing hrtimer to unblock inactive events. That timer
> > can have abitrary duration in the milliseconds. Until the timer
> > fires, counters are available, but no measurable events are using
> > them. We do not want to introduce blind spots of arbitrary durations.
> >
> > This patch addresses the cause of the problem, by checking that,
> > when an event is disabled or removed and the context was multiplexing
> > events, inactive events gets immediately a chance to be scheduled by
> > calling ctx_resched(). The rescheduling is done on  event of equal
> > or lower priority types.  With that in place, as soon as a counter
> > is freed, schedulable inactive events may run, thereby eliminating
> > a blind spot.
> >
> > This can be illustrated as follows using Skylake uncore CHA here:
> >
> > $ perf stat --no-merge -a -I 1000 -C 28 -e uncore_cha_0/event=0x0/
> >    42.007856531      2,000,291,322      uncore_cha_0/event=0x0/
> >    43.008062166      2,000,399,526      uncore_cha_0/event=0x0/
> >    44.008293244      2,000,473,720      uncore_cha_0/event=0x0/
> >    45.008501847      2,000,423,420      uncore_cha_0/event=0x0/
> >    46.008706558      2,000,411,132      uncore_cha_0/event=0x0/
> >    47.008928543      2,000,441,660      uncore_cha_0/event=0x0/
> >
> > Adding second sessiont with 4 events for 4s
> >
> > $ perf stat -a -I 1000 -C 28 --no-merge -e uncore_cha_0/event=0x0/,uncore_cha_0/event=0x0/,uncore_cha_0/event=0x0/,uncore_cha_0/event=0x0/ sleep 4
> >    48.009114643      1,983,129,830      uncore_cha_0/event=0x0/                                       (99.71%)
> >    49.009279616      1,976,067,751      uncore_cha_0/event=0x0/                                       (99.30%)
> >    50.009428660      1,974,448,006      uncore_cha_0/event=0x0/                                       (98.92%)
> >    51.009524309      1,973,083,237      uncore_cha_0/event=0x0/                                       (98.55%)
> >    52.009673467      1,972,097,678      uncore_cha_0/event=0x0/                                       (97.11%)
> >
> > End of 4s, second session is removed. But the first event does not schedule and never will
> > unless new events force multiplexing again.
> >
> >    53.009815999      <not counted>      uncore_cha_0/event=0x0/                                       (95.28%)
> >    54.009961809      <not counted>      uncore_cha_0/event=0x0/                                       (93.52%)
> >    55.010110972      <not counted>      uncore_cha_0/event=0x0/                                       (91.82%)
> >    56.010217579      <not counted>      uncore_cha_0/event=0x0/                                       (90.18%)
>
> Does this still happen after my patch? I was not able to repro this.
>
> > Signed-off-by: Stephane Eranian <eranian@google.com>
>
> Maybe add:
> Fixes: 8d5bce0c37fa ("perf/core: Optimize perf_rotate_context() event scheduling")
>
It does not really fix your patch, I think we can keep it as a double
precaution. It fixes
the causes. I think it is useful to check beyond the active in the
rotate code as well.



> Thanks,
> Song
