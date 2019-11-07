Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98458C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5C52178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKiaOjQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbfKGPpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:45:21 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39605 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387487AbfKGPpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:45:21 -0500
Received: by mail-yb1-f194.google.com with SMTP id q18so1095564ybq.6;
        Thu, 07 Nov 2019 07:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBmDW367ezY0BrZwRlImNYpPUfZdn90ATxc3j+zJm30=;
        b=JKiaOjQ8TzP09p3M2cZAk6u6sBMOJTVhK+SFIoX2eblEYJN7ISl31fVJEjhyKCqgts
         WeYUc/O2s0kTmLaGomztgYsXen3MSvpTZhqh0UpzkQlRLm9/vRgya1Ez/otNM/yCMpeB
         QBeimtb23jgePWPyTIOUBBVJljio9xk8q9xdsQx6+UHuEBULlKIT6HoDPhyOWQVFUahc
         ll1bKe6DiFW3P0sc2QVRxqmNKR/4h9/U4YxL8VF3GDj/h3Ns1nPdJ9CR40tA6fzMhbuS
         GmtkmdoS4IWu8ztNMOEOCZMzqqhabCVqnKPY4lOpm6ebaXKJOpjhuAzUZd+kSNup310M
         zYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBmDW367ezY0BrZwRlImNYpPUfZdn90ATxc3j+zJm30=;
        b=GcrTBPgoLVo0NlEv3bPLZFA7uKFcopixlIOjUg+G4crS/OC3T8eTDCSylrYZulxbDX
         U5mcogYlCAsXE5OwaLXo3VrwIt/wYH/Bky0ca3+MAPHsYwvqTqL2EeqKtokxF6kItwDE
         XeeAg1pHWO30lLAJT2yiSTHMLcsCF0kz9rEPc/fviGTniX+HwLd3Afnaw05GNDY+FvKL
         fP1CyOVDNg4mn3JQ5GCQEx5pO+JvAhQ73rguUD1TATdNKFom6pzGsWn0REbRQ1nbv81A
         P7fsbshhqoadVf4JVYLz5VNhc1+p1QNY6cb69FTdDoJ88PMmreHxiG+sYN7V5vY4NRxt
         Q+eA==
X-Gm-Message-State: APjAAAWbdAVhGHdwex23WbRe5yctKMq8dlemJVbqNYe7agUJ3GjW2vfu
        C6atNu0XUGWO5xXILjXdaMCL2pQi0MivaYwfK4M=
X-Google-Smtp-Source: APXvYqwyubiCYdkp0wkVQciI245UgQvGVkHbhs94SRmToAzx6pJzULhB7lalNs2zsag4B/pA0r3B5sVmCmSB1I7uRqw=
X-Received: by 2002:a25:c781:: with SMTP id w123mr3986907ybe.509.1573141518579;
 Thu, 07 Nov 2019 07:45:18 -0800 (PST)
MIME-Version: 1.0
References: <1573002091-9744-1-git-send-email-gkulkarni@marvell.com>
 <1573002091-9744-2-git-send-email-gkulkarni@marvell.com> <20191106112810.GA50610@lakrids.cambridge.arm.com>
 <CAKTKpr6U8gUp4C9muN2cL4wn33o2LAa5QnTO2MSmfnBz8oUc=Q@mail.gmail.com> <20191107145213.GB6888@lakrids.cambridge.arm.com>
In-Reply-To: <20191107145213.GB6888@lakrids.cambridge.arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Thu, 7 Nov 2019 07:45:07 -0800
Message-ID: <CAKTKpr70=hFdwq43SBM-1jmbNxc1suyn3XouQhsj2m4tM+jeUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/core: Adding capability to disable PMUs event multiplexing
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 6:52 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Nov 06, 2019 at 03:28:46PM -0800, Ganapatrao Kulkarni wrote:
> > Hi Peter, Mark,
> >
> > On Wed, Nov 6, 2019 at 3:28 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Wed, Nov 06, 2019 at 01:01:40AM +0000, Ganapatrao Prabhakerrao Kulkarni wrote:
> > > > When PMUs are registered, perf core enables event multiplexing
> > > > support by default. There is no provision for PMUs to disable
> > > > event multiplexing, if PMUs want to disable due to unavoidable
> > > > circumstances like hardware errata etc.
> > > >
> > > > Adding PMU capability flag PERF_PMU_CAP_NO_MUX_EVENTS and support
> > > > to allow PMUs to explicitly disable event multiplexing.
> > >
> > > Even without multiplexing, this PMU activity can happen when switching
> > > tasks, or when creating/destroying events, so as-is I don't think this
> > > makes much sense.
> > >
> > > If there's an erratum whereby heavy access to the PMU can lockup the
> > > core, and it's possible to workaround that by minimzing accesses, that
> > > should be done in the back-end PMU driver.
> >
> > As said in errata,  If there are heavy access to memory like stream
> > application running and along with that if PMU control registers are
> > also accessed frequently, then CPU lockup is seen.
>
> Ok. So the issue is the frequency of access to those registers.
>
> Which registers does that apply to?

The control register which are used to start, stop the counter and the
register which is used to set the event type.
>
> Is this the case for only reads, only writes, or both?

It is write  issue, the h/w block has limited write buffers and
overflow getting hardware in weird state, when memory transactions are
high.

>
> Does the frequency of access actually matter, or is is just more likely
> that we see the issue with a greater number of accesses? i.e the
> increased frequency increases the probability of hitting the issue.

This is one scenario.
Any higher access to PMU register, when memory is busy needs to be controlled.

>
> I'd really like a better description of the HW issue here.
>
> > I ran perf stat with 4 events of thuderx2 PMU as well as with 6 events
> > for stream application.
> > For 4 events run, there is no event multiplexing, where as for 6
> > events run the events are multiplexed.
> >
> > For 4 event run:
> > No of times pmu->add is called: 10
> > No of times pmu->del is called: 10
> > No of times pmu->read is called: 310
> >
> > For 6 events run:
> > No of times pmu->add is called: 5216
> > No of times pmu->del is called: 5216
> > No of times pmu->read is called: 5216
> >
> > Issue happens when the add and del are called too many times as seen
> > with 6 event case.
>
> Sure, but I can achieve similar by creating/destroying events in a loop.
> Multiplexing is _one_ way to cause this behaviour, but it's not the
> _only_ way.

I agree, there may be other use cases also, however i am trying to fix
the common use case.

>
> > The PMU hardware control registers are programmed when add and del
> > functions are called.
> > For pmu->read no issues since no h/w issue with the data path.
>
> As above, can you please describe the hardware conditions more
> thoroughly?
>
> > This is UNCORE driver, not sure context switch has any influence on this?
>
> I believe that today it's possible for this to happen for cgroup events,
> as non-sensical as it may be to have a cgroup-bound uncore PMU event.
>
> > Please suggest me, how can we fix this in back-end PMU driver without
> > any perf core help?
>
> In order to do so, I need a better explanation of the underlying
> hardware issue.

I will try to put more explanation to erratum, however please let me
know, if you have any specific questions.

>
> Thanks,
> Mark.

Thanks,
Ganapat
