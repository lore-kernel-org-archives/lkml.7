Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B89C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B6122CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gHS5vyos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfIDNYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:24:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46476 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbfIDNYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:24:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so11226531pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Aipic7kZT8U3QOmK6fS5cVJddmjAxbkLMJFp/Z/WmYk=;
        b=gHS5vyosv1QQ0qa7hnIX2wZUmcdWOVwnp7DosWzNsjm6ALC3U8rEN2kG7T7rde5TLA
         bbZnZkhwP/ZcvAxDRzQVXYxjDbptzvTr5oPhUCILohQbKUuyfcPqSpx0846k546TCgyo
         gShuGXqILXzJCZ1TQHcuTZfWWqpu4buWYnvD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Aipic7kZT8U3QOmK6fS5cVJddmjAxbkLMJFp/Z/WmYk=;
        b=EpmWjM5yehJC3HKa5r2hPOh160VHYGGSgUcmV3JRaEieYHUq3vDRaokNO5JCXejMiw
         s348RC8gfT+aTkoxxFfQ0hOiqujSaeUxgDxPH3AdFC1l150M5cwQCXnDoX3KIOFxGKmf
         C0I486IM/Xrvwi3EDA927nk2d46+u8ALbuNnv8wvFbyrpcbFsCIzLwZsidU/Xh553f9q
         60kO75hJsy7O5HgLkkGirvTopz2Pz4k/ZR+/hC2VesvcyhUSRgRNuPHS+fnZUPQ68PF5
         4SrRplO2kFwPxgKGa7Dq4JX89tYtPoKZcvh5o4Bs+KHJbu5JOriDHaERaoVVlpebUMs7
         LBMg==
X-Gm-Message-State: APjAAAX2J+CxZBbxgSNSD5MGRuRnf4JOGjGBQJbku28nHKJWXHT3yp0R
        bR2QcKtn66v5QIeYjNNTQc3ghg==
X-Google-Smtp-Source: APXvYqxOBWyhCwfcL7ptQaTTPWzJ8GBg6AwZpE035nT/ILBjMIRzb+Q+lvaYSONZ2bKrOmwzD8+fGg==
X-Received: by 2002:a63:5c1a:: with SMTP id q26mr18009584pgb.19.1567603459881;
        Wed, 04 Sep 2019 06:24:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f6sm18453162pga.50.2019.09.04.06.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 06:24:19 -0700 (PDT)
Date:   Wed, 4 Sep 2019 09:24:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alessio Balsini <balsini@android.com>, mingo@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, kernel-team@android.com,
        will.deacon@arm.com
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20190904132418.GA237277@google.com>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.397880775@infradead.org>
 <20190802172104.GA134279@google.com>
 <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
 <20190822122949.GA245353@google.com>
 <20190822165125.GW2369@hirez.programming.kicks-ass.net>
 <20190831144117.GA133727@google.com>
 <20190902091623.GQ2349@hirez.programming.kicks-ass.net>
 <20190904061616.25ce79e1@oasis.local.home>
 <20190904113038.GE2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904113038.GE2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 01:30:38PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 04, 2019 at 06:16:16AM -0400, Steven Rostedt wrote:
> > On Mon, 2 Sep 2019 11:16:23 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > in sched_dl_period_handler(). And do:
> > > 
> > > +	preempt_disable();
> > > 	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
> > > 	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;
> > > +	preempt_enable();
> > 
> > Hmm, I'm curious. Doesn't the preempt_disable/enable() also add
> > compiler barriers which would remove the need for the READ_ONCE()s here?
> 
> They do add compiler barriers; but they do not avoid the compiler
> tearing stuff up.

Neither does WRITE_ONCE() on some possibly buggy but currently circulating
compilers :(

As Will said in:
https://lore.kernel.org/lkml/20190821103200.kpufwtviqhpbuv2n@willie-the-truck/

void bar(u64 *x)
{
	*(volatile u64 *)x = 0xabcdef10abcdef10;
}

gives:

bar:
	mov	w1, 61200
	movk	w1, 0xabcd, lsl 16
	str	w1, [x0]
	str	w1, [x0, 4]
	ret

Speaking of which, Will, is there a plan to have compiler folks address this
tearing issue and are bugs filed somewhere? I believe aarch64 gcc is buggy,
and clang is better but is still buggy?

thanks,

 - Joel

