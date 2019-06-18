Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9718C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD51B2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560845462;
	bh=Bwuz1jz3NpU9TY+ZYcwRD292nhZomipixuLcO9OcUYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xv05tuRwRopE98hS34mezk/dDsay1oMCpTT9AyMAHDezF8T4T7LB0FkNfzGadlyIP
	 SP9M7063P3gemADukivTlU6Bx969lWVNNy3AwxldBkBTy+ye5+4x1PBbF2uDG7AZry
	 SKb9Q42Ntb8cxBbf5I6GDCH68D4mI3KKbze2yml8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfFRILB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:11:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36178 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfFRILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:11:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id r6so13085624oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 01:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bwuz1jz3NpU9TY+ZYcwRD292nhZomipixuLcO9OcUYk=;
        b=A6Fx1Gfd8ygspt+euNqRqm4/acd2zaDknIUBOqlRMuhQ9q9IG6g92SQPF/ycESuvFL
         6SoL5AnGYB+71sPXlrgU5x2ee8Qm4KhLep0I6KGhiQSIk298hQak9YU7w04qEVnko/1m
         X6fqkgrBomShGKRZYjL1SkwVfDRHpngIvhDTJwjBpIsA4z/35i7m8bc/B0imfIyn5q+T
         u08dA8jjo5XCkPTXJSu64MUZUC8tG0xkEyPuCeyLA9QbNi9PwhlSQLLSHyAXvqu0urgi
         xI8b+HfVwCQcjCaB6koAe3c1ypgDJvEP3pUtFfAlRWwENKcSYWxoEDBFV7ahMVomYMeb
         jwqg==
X-Gm-Message-State: APjAAAVL2tpxxYUkK+I7xRJ0J3xL6FNNVgY3JXf6iZUav/9XtIP3WXLf
        7um1UBxSzdAXkPpFYP8dSMuVSh2URpF2XUNtsgU=
X-Google-Smtp-Source: APXvYqyMfu3cevie5KNlJHBNTww4uWAmNnzEeheUBgDWx9rOxitup1viHffG60AaozmxbYFoQtP5qmaAmYoRCSKLKzk=
X-Received: by 2002:a9d:5e99:: with SMTP id f25mr34870526otl.262.1560845459845;
 Tue, 18 Jun 2019 01:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
 <20190605091644.w3g7hc7r3eiscz4f@queper01-lin> <20190606025204.qe5v7j6fysjkgxc6@vireshk-i7>
 <20190617150204.GG3436@hirez.programming.kicks-ass.net> <20190618031217.63md32da5pzydqia@vireshk-i7>
 <CAJZ5v0g4shiz+Hq+0fS1GQjQX7tK5EyLiX-SOpDoTm4xswV8bg@mail.gmail.com> <20190618074728.gf6wugkbndhhcqql@vireshk-i7>
In-Reply-To: <20190618074728.gf6wugkbndhhcqql@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Jun 2019 10:10:48 +0200
Message-ID: <CAJZ5v0hi_zXPWqMS_VFnrbs8=BZbhcQRzm6B7fNZYWTXQhA3Mw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 9:47 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-06-19, 09:26, Rafael J. Wysocki wrote:
> > On Tue, Jun 18, 2019 at 5:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > +Rafael
> > >
> > > On 17-06-19, 17:02, Peter Zijlstra wrote:
> > > > On Thu, Jun 06, 2019 at 08:22:04AM +0530, Viresh Kumar wrote:
> > > > > Hmm, even if the values are same currently I am not sure if we want
> > > > > the same for ever. I will write a patch for it though, if Peter/Rafael
> > > > > feel the same as you.
> > > >
> > > > Is it really the same variable or just two numbers that happen to be the
> > > > same?
> > >
> > > In both cases we are trying to keep the load under 80% of what can be supported.
> > > But I am not sure of the answer to your question.
> > >
> > > Maybe Rafael knows :)
> >
> > Which variable?
>
> Schedutil multiplies the target frequency by 1.25 (20% more capacity eventually)
> to get enough room for more load and similar thing is done in fair.c at several
> places to see if the new task can fit in a runqueue without overloading it.

For the schedutil part, see the changelog of the commit that introduced it:

9bdcb44e391d cpufreq: schedutil: New governor based on scheduler
utilization data

As for the other places, I don't know about the exact reasoning.

> Quentin suggested to use common code for this calculation and that is what is
> getting discussed here.

I guess if the rationale for the formula is the same in all cases, it
would be good to consolidate that code and document the rationale
while at it.

Otherwise, I'm not sure.
