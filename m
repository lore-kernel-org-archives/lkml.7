Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E079C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ED920726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0ZtOPNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfLJLPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:15:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44951 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJLPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:15:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so9370728oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 03:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNhRxJlAjN3xnQc/fMGRg0A/etp8RV9aaSfVxAhWsao=;
        b=Q0ZtOPNPOVKkuZZudKRECjtmEEFoDIef6uPbZaARD1XDkMSH7VDUjB9WZYo2cztA2u
         xAIltoiVEvRYiavrKDsys9yboQyIZsGec4/QTUUTReA8JHMw6Xjir1RaLZu3Ybu/Cssz
         d4epGO1yJgUMMpzCEpEA1192txMvGn7eWVECOH0kyQFu7OtxcxbAjkflnkYm7+Wg0L9Z
         caLcGEn/F19fHj6i4o58HZSMs+jlM8kxoIYOxlzi7U06EZpSopW3bdBYtp8HRxp2+iGC
         q34z/JyKn7zAU8HsY0hGo6t3blNaNBGz9ndIkJDiLBuO7GtoyDF34yhNBzI7gQvjlz2w
         q9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNhRxJlAjN3xnQc/fMGRg0A/etp8RV9aaSfVxAhWsao=;
        b=antuKlGr8LUM8qXrGaW5aAD4ZE/nUGqCHKFvj71CsURccbRlaRVr1B8JlORjVc4/sv
         qWuqNcOl7/vIc9g88dngh1W5cwNhRadGofAebJ2m7ropv1uKlXoqKyPhbtEmyP3YENZL
         qxeof/H2VDzKen4+FB1KD3FFZFPLhLj+R+tNTWDFhPpv2o5XE0ckNgEddTsARGD901AC
         d+wkMs0BioRl+rVtQb1+GjfhmcD6yCzzQUfolwlr87u3BlxrTtbjirx1QWFkeO654v2H
         LXQCYdjE3rht55XluOnl/7S4Z9RspO7z2zkjSDkYMRFBLPziugyJuItbOqW1Eo+g49bW
         58/w==
X-Gm-Message-State: APjAAAW3yTfmuL9V7IF61FLlvnOPfApkA7bIkAgSWYFJHfPVBdiqIHDA
        xKDseXsAODyVq7l4EATkQw1qn9tcjSxPzZ+3qAk=
X-Google-Smtp-Source: APXvYqxkA54+09GzU1WsLmL8FENBaCnD6NOzsqCTKdb2yJN/hf00wioJMzaernbbDqBlzxLUQf2uegog+4jFVo8nABQ=
X-Received: by 2002:aca:f305:: with SMTP id r5mr3604601oih.174.1575976545814;
 Tue, 10 Dec 2019 03:15:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1561523542.git.viresh.kumar@linaro.org> <CANRm+Cytg1hDjxM6oxNyTNWztQdCSpaCoUy7KO8zmrv-muABLw@mail.gmail.com>
 <20191210063303.pubbpu77ah2veuj7@vireshk-i7>
In-Reply-To: <20191210063303.pubbpu77ah2veuj7@vireshk-i7>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Tue, 10 Dec 2019 19:15:34 +0800
Message-ID: <CANRm+Czph-WDBm+L8+ykq4FZahsX3fWFV=n8_NwQJQwHoUHoWg@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] sched/fair: Fallback to sched-idle CPU in absence
 of idle CPUs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, subhra.mazumdar@oracle.com,
        songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 at 14:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 09-12-19, 11:50, Wanpeng Li wrote:
> > On Wed, 26 Jun 2019 at 13:07, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > We try to find an idle CPU to run the next task, but in case we don't
> > > find an idle CPU it is better to pick a CPU which will run the task the
> > > soonest, for performance reason.
> > >
> > > A CPU which isn't idle but has only SCHED_IDLE activity queued on it
> > > should be a good target based on this criteria as any normal fair task
> > > will most likely preempt the currently running SCHED_IDLE task
> > > immediately. In fact, choosing a SCHED_IDLE CPU over a fully idle one
> > > shall give better results as it should be able to run the task sooner
> > > than an idle CPU (which requires to be woken up from an idle state).
> > >
> > > This patchset updates both fast and slow paths with this optimization.
> > >
> > > Testing is done with the help of rt-app currently and here are the
> > > details:
> > >
> > > - Tested on Octacore Hikey platform (all CPUs change frequency
> > >   together).
> > >
> > > - rt-app json [1] creates few tasks and we monitor the scheduling
> > >   latency for them by looking at "wu_lat" field (usec).
> > >
> > > - The histograms are created using
> > >   https://github.com/adkein/textogram: textogram -a 0 -z 1000 -n 10
> > >
> > > - the stats are accumulated using: https://github.com/nferraz/st
> >
> > Hi Viresh,
> >
> > Thanks for the great work! Could you give the whole commad-line for us testing?
>
> The rt-app json [1] can be run using:
>
> $ rt-app sched-idle.json
>
> This will create couple of files named rt-app-cfs_thread-*.log and
> rt-app-idle_thread-*.log. I looked mostly at the cfs files here as that's what
> we were looking for. We will be interested only in the last column of these
> files, which says "wu_lat". Remove everything apart from that column (and remove
> the first row as well, which has field names) from all cfs files (or write a
> sed/awk command to do it for you.
>
> After that I you can generate the numbers (mean/max/min/etc) using:
>
> $ st rt-app-cfs_thread-*.log

Thanks for pointing out this.

    Wanpeng
