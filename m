Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97785C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6939C20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOzSZwPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfLJGdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:33:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45323 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLJGdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:33:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so6865331plz.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 22:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ycNvfQPH1L0ONIJ32HDqFsXCJ/C+GYrXwSG41opf3A8=;
        b=GOzSZwPlwMNaLCSBaKebi36rGoYOzI04CPZwDHiE40JfMnGq4azJ7eP1GaPz6XHBPT
         6ajhl+Pjvrr6dJcKMpzkmWczUS5jJUY5qwetplQHAFDvnglFLoUjvT3Xocj2bgDal4Ri
         CjDEhY9NVGy4SLXeGhap/8Gz6x64coUTjhb+7bZJhy5K0xPUwYaV0kJCQU26lqQ6APVA
         RWQ5kmoa4AIzqn3TlcpDkXWNV5kkHHLNQbrLhZI+EkG5DxsuimPOdiNimEeUbRQ1GSAE
         3MPnHlshZHrZcFXMVyE73rwie74W7RakF8/0gmSBlH62UWHD57VutXmOQH8XPe4t+BgQ
         gcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ycNvfQPH1L0ONIJ32HDqFsXCJ/C+GYrXwSG41opf3A8=;
        b=rg4TR5cNl7JJI52ezjYF22nI/Cks/NX2vqMb9iWeLI05bH2g/Xj/W+NlvBf5ueXYSu
         4HtbGYTFRljIVehOJqE52xjjNdyOhukC6Z4RPTbb4Nc+qdUew2GRHNrMC04mUHAlUEEy
         sfkTeJI+rD8TvUcHx7BjFfs7mnTcmFITXjtt84j5SN2bREVmOj7CQOk8b5Dj8RGLMUSv
         0xnjuKdM20fgZeRrZCb01EJH4aNeQwhpvRR3/RFPRUgGkByv78OEZoiTs4SZS6rMfQFQ
         wd9Sc14tfIqpBIxM9Rzm/JONcceizzNOBd2XXzKSlHeOiqdS/aKfWKvCSW5i1O/YrAmL
         4THg==
X-Gm-Message-State: APjAAAVSvga4TBQPeCDD516oYZSFc8qj26V38MEvIFh6Uhk3jY7nHvLL
        +SDi5U/Hh4lJNhlpDDgeFocdhg==
X-Google-Smtp-Source: APXvYqy31nX6TTevNIuqTdnk4Udo25BNW0hqmYiKRlPRyZNmCioHuVdPaybaDiRhFYSHXIFWHz3wpg==
X-Received: by 2002:a17:90a:26ab:: with SMTP id m40mr3750766pje.42.1575959585827;
        Mon, 09 Dec 2019 22:33:05 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id z1sm1661967pfk.61.2019.12.09.22.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 22:33:04 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:03:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, subhra.mazumdar@oracle.com,
        songliubraving@fb.com
Subject: Re: [PATCH V3 0/2] sched/fair: Fallback to sched-idle CPU in absence
 of idle CPUs
Message-ID: <20191210063303.pubbpu77ah2veuj7@vireshk-i7>
References: <cover.1561523542.git.viresh.kumar@linaro.org>
 <CANRm+Cytg1hDjxM6oxNyTNWztQdCSpaCoUy7KO8zmrv-muABLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+Cytg1hDjxM6oxNyTNWztQdCSpaCoUy7KO8zmrv-muABLw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-19, 11:50, Wanpeng Li wrote:
> On Wed, 26 Jun 2019 at 13:07, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Hi,
> >
> > We try to find an idle CPU to run the next task, but in case we don't
> > find an idle CPU it is better to pick a CPU which will run the task the
> > soonest, for performance reason.
> >
> > A CPU which isn't idle but has only SCHED_IDLE activity queued on it
> > should be a good target based on this criteria as any normal fair task
> > will most likely preempt the currently running SCHED_IDLE task
> > immediately. In fact, choosing a SCHED_IDLE CPU over a fully idle one
> > shall give better results as it should be able to run the task sooner
> > than an idle CPU (which requires to be woken up from an idle state).
> >
> > This patchset updates both fast and slow paths with this optimization.
> >
> > Testing is done with the help of rt-app currently and here are the
> > details:
> >
> > - Tested on Octacore Hikey platform (all CPUs change frequency
> >   together).
> >
> > - rt-app json [1] creates few tasks and we monitor the scheduling
> >   latency for them by looking at "wu_lat" field (usec).
> >
> > - The histograms are created using
> >   https://github.com/adkein/textogram: textogram -a 0 -z 1000 -n 10
> >
> > - the stats are accumulated using: https://github.com/nferraz/st
> 
> Hi Viresh,
> 
> Thanks for the great work! Could you give the whole commad-line for us testing?

The rt-app json [1] can be run using:

$ rt-app sched-idle.json

This will create couple of files named rt-app-cfs_thread-*.log and
rt-app-idle_thread-*.log. I looked mostly at the cfs files here as that's what
we were looking for. We will be interested only in the last column of these
files, which says "wu_lat". Remove everything apart from that column (and remove
the first row as well, which has field names) from all cfs files (or write a
sed/awk command to do it for you.

After that I you can generate the numbers (mean/max/min/etc) using:

$ st rt-app-cfs_thread-*.log

-- 
viresh

[1] https://pastebin.com/TMHGGBxD
