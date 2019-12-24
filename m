Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13466C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF056206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="f86ZQuCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfLXKBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 05:01:40 -0500
Received: from mout01.posteo.de ([185.67.36.65]:57232 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfLXKBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 05:01:39 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 7C694160066
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 11:01:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1577181695; bh=y/0eB+P/HM8JllnIK/xIajMqq2tyxId8DnWHVfKJaT4=;
        h=Subject:From:To:Cc:Date:From;
        b=f86ZQuCicfvx6j+f1TNB4PD2uD/yjEXJHCHvNO8TQ6HnZmJWrr0KdH7xjtap/TM8Q
         m3zsHOFaou9UEyCRX5QULbA2Rkb+kGj2Ts/+EdQizngounDTYwLOTvFhymLr8ETIPe
         j3RfrRAstPrXWI6dR5nmrMmHR5iKOj4VFQPycj8in2JsJqlV5gPB+CdlVM/RNqIuBW
         G2APoNtXHH3pIoWES0VfO6QYWAfG2sOe5+9661/jF9+8PhJd5AdvUM7qWVft30g81X
         l+D3YAlNcJR2j1X+xBKfdclzzITtRHjYQJB0axC5g5t06+uO1hOq5CFTyyVlp/lDr1
         yTBWw7wLtnGVA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 47hsF907ZKz6tm7;
        Tue, 24 Dec 2019 11:01:32 +0100 (CET)
Message-ID: <1a322df842e0dc5646ef1198ea0bbe668d94646e.camel@posteo.de>
Subject: Re: SCHED_DEADLINE with CPU affinity
From:   Philipp Stanner <stanner@posteo.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Hagen Pfeifer <hagen@jauu.net>,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Date:   Tue, 24 Dec 2019 11:03:29 +0100
In-Reply-To: <20191120085024.GB23227@localhost.localdomain>
References: <1574202052.1931.17.camel@posteo.de>
         <20191120085024.GB23227@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20.11.2019, 09:50 +0100 Juri Lelli wrote:
> Hi Philipp,

Hey Juri,

thanks so far; we indeed could make it work with exclusive CPU-sets.

On 19/11/19 23:20, Philipp Stanner wrote:
> 
> > from implementing our intended architecture.
> > 
> > Now, the questions we're having are:
> > 
> >    1. Why does the kernel do this, what is the problem with
> > scheduling with
> >       SCHED_DEADLINE on a certain core? In contrast, how is it
> > handled when
> >       you have single core systems etc.? Why this artificial
> > limitation?
> 
> Please have also a look (you only mentioned manpage so, in case you
> missed it) at
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/scheduler/sched-deadline.rst#L667
> 
> and the document in general should hopefully give you the answer
> about
> why we need admission control and current limitations regarding
> affinities.
> 
> >    2. How can we possibly implement this? We don't want to use
> > SCHED_FIFO,
> >       because out-of-control tasks would freeze the entire
> > container.
> 
> I experimented myself a bit with this kind of setup in the past and I
> think I made it work by pre-configuring exclusive cpusets (similarly
> as
> what detailed in the doc above) and then starting containers inside
> such
> exclusive sets with podman run --cgroup-parent option.
> 
> I don't have proper instructions yet for how to do this (plan to put
> them together soon-ish), but please see if you can make it work with
> this hint.

I fear I have not understood quite well yet why this
"workaround" leads to (presumably) the same results as set_affinity
would. From what I have read, I understand it as follows: For
sched_dead, admission control tries to guarantee that the requested
policy can be executed. To do so, it analyzes the current workload
situation, taking especially the number of cores into account.

Now, with a pre-configured set, the kernel knows which tasks will run
on which core, therefore it's able to judge wether a process can be
deadline scheduled or not. But when using the default way, you could
start your processes as SCHED_OTHER, set SCHED_DEADLINE as policy and
later many of them could suddenly call set_affinity, desiring to run on
the same core, therefore provoking collisions.

Is my understanding of the situation correct?

Merry Christmas,
P.

