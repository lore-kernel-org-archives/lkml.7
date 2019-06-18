Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F80C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1A82084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9Kme+Vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfFRHrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:47:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40668 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfFRHrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:47:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so7154085pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m9kWU4Wyh0nUtIn5ZBz57UUg5pTNFygG2evwRUANN1M=;
        b=i9Kme+VbcXRi1zjpBD7iIzvpMagzeVyhTd4n/VvOx4aaVfkgJh/bzhahGNYtAwCCOA
         DwDF6m7/Xucseh1RMtbpnynAOM8o9ukJePgNWNAQUcgS8sx7k5GKF/vLxGQSpmAXwV4f
         buEqIn1OqmfOGJh63tAffQ0Uw8DnWuzX3ATtRm54T2N8DhTzeTVct40nlRbLaFlWoDH+
         JLZ0k8dG8L5EZ/Rjv1GHyAWDooqo06Om6s2QGClxw4rE5HWBOu4U1L1Wr8JsKxWMrLTI
         cMSmddzuJYIidMUaGNAajZOVOPx0GEN2iNuZJMDjksiomojZf3DDcYdxC7Bi53cp4P/P
         KK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m9kWU4Wyh0nUtIn5ZBz57UUg5pTNFygG2evwRUANN1M=;
        b=Kqmy+onl1W3qHwY1chxnqU+TmViTwwai8mBb61vflXo37vWEMJM6jKzyYN+LT24vhX
         vmI78Lm9FA7lfETm1987XH3tSwrDA9MUbSzbqkv28GHcxtcV8BhnpftqRHpZJVtcTqM0
         bZxnSHn249q/27WarMAXwRCF01pDuQ+qryedXX0Xo6vlafrUFOrZGwsk1pl+dXa+3hMO
         UV+fMY58Bb4kPhaWae+asiPq+9oZreTTe2j8faNbH96Tinqo/EXFrTFaRaFFJkg/Wq/3
         ogUCXLiwGuTvFFH0GScutStyIXSlLavR52QZLQ8SsmU48zcCSo9/YkZx0lzfzuIfiT5U
         i58g==
X-Gm-Message-State: APjAAAU5WRQgvSN7VXu1J8GATIyT4IJOPNeceqhAynetrCHssLfg72P5
        zmVNBaSNyDxbM82oDvpdS7fyUg==
X-Google-Smtp-Source: APXvYqzoZrCGfiZDIky+YWcabe0Ihtb/5V8EZ1kNy9BbFLukJBpuUb2/MKlZVKIwOuQqI7eyR0AS8w==
X-Received: by 2002:a63:1d10:: with SMTP id d16mr1416444pgd.446.1560844051594;
        Tue, 18 Jun 2019 00:47:31 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id ci15sm2914468pjb.12.2019.06.18.00.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 00:47:30 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:17:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
Message-ID: <20190618074728.gf6wugkbndhhcqql@vireshk-i7>
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
 <20190605091644.w3g7hc7r3eiscz4f@queper01-lin>
 <20190606025204.qe5v7j6fysjkgxc6@vireshk-i7>
 <20190617150204.GG3436@hirez.programming.kicks-ass.net>
 <20190618031217.63md32da5pzydqia@vireshk-i7>
 <CAJZ5v0g4shiz+Hq+0fS1GQjQX7tK5EyLiX-SOpDoTm4xswV8bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g4shiz+Hq+0fS1GQjQX7tK5EyLiX-SOpDoTm4xswV8bg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-19, 09:26, Rafael J. Wysocki wrote:
> On Tue, Jun 18, 2019 at 5:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > +Rafael
> >
> > On 17-06-19, 17:02, Peter Zijlstra wrote:
> > > On Thu, Jun 06, 2019 at 08:22:04AM +0530, Viresh Kumar wrote:
> > > > Hmm, even if the values are same currently I am not sure if we want
> > > > the same for ever. I will write a patch for it though, if Peter/Rafael
> > > > feel the same as you.
> > >
> > > Is it really the same variable or just two numbers that happen to be the
> > > same?
> >
> > In both cases we are trying to keep the load under 80% of what can be supported.
> > But I am not sure of the answer to your question.
> >
> > Maybe Rafael knows :)
> 
> Which variable?

Schedutil multiplies the target frequency by 1.25 (20% more capacity eventually)
to get enough room for more load and similar thing is done in fair.c at several
places to see if the new task can fit in a runqueue without overloading it.

Quentin suggested to use common code for this calculation and that is what is
getting discussed here.

-- 
viresh
