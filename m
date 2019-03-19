Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF966C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985B5206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9XPx7xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfCSP45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:56:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37124 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfCSP45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:56:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so8520288wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 08:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SOQxtWZluM0zB/t804SFdGxNJjdiQd1JWY1QDZ7KEQw=;
        b=y9XPx7xp3a7ajzl7yN3Q3asH9S9T3mzOB/+lz2g4zp7yW4Zi7O11BzIOnYgV4Mw2CC
         Ou2OUvGOpVw2opCyb7VXUkYQEzCCTJIqR6KUZdHyg6eb+7m+2w0FycpBDcmSr7BzkhV7
         yijUrrrLulTwgY+MWFjC/KR0kcYBVzLptK2uWeaoxEH2zSlR7IYEzMWeATm5Fnme2xRC
         c8/sXHNHTPAn+ZSqqN6gtl98wHR9QRJYikqc4qAxAr2HTe9C6LZW7So03SLcd/Munhs6
         qUsqzK9FWzGDuuuTlmpI6qnqsEBIlYmZ1cPQshKuNxjNBjO2vSAqDaf+7cWVsMo2xk21
         ml/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SOQxtWZluM0zB/t804SFdGxNJjdiQd1JWY1QDZ7KEQw=;
        b=sR+VD4nZtSObsegKK65fCqEkUGSyDqlPQCrE2ix3BlR5EmWm5gQWltY6vtUiFOaf6q
         t0B58m4CCDopqsKZ2a3Fj7YKEAzIjZAfOTYb0nTJKc1gn80RG5pbiWq4nuVhFRkeR2LP
         rkJ1rkdxmakvVltiG1Zm5YmfTCxdbxXEXoMJKOaom+bKRvaq8DQi+EczlaPdMEo8Ia1U
         sQuTlJIB4Tn9MKGVnLyU8R4dKJ2THyoYEzD1c7p5XfzTBRSw69Lcclwk7sivoauxxdhW
         I9UgVnQX/xoDOhsJRBw66I9d/qpBUtxWigXLhniw0MII+dMxjhtViVN8lq+Mr8zB054x
         ahJQ==
X-Gm-Message-State: APjAAAXwYwxTz1bwhTANLJdWuuQetHpG66VcL8bej7SHQVaf5SaWBzVi
        ly9bucqOr8P5hbw+jR0lhUSCEg==
X-Google-Smtp-Source: APXvYqwSdTV7x8tVBpOXmtwE2fr0EiZBaBBDGRjiy0c5JOtiFLTRYxJAX0FB3IWLvzX0Ye4BxtBqLA==
X-Received: by 2002:a1c:c68e:: with SMTP id w136mr4172378wmf.111.1553011015086;
        Tue, 19 Mar 2019 08:56:55 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c6sm8099357wru.73.2019.03.19.08.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 08:56:54 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:56:52 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] tracing: Add trace_total_entries() /
 trace_total_entries_cpu()
Message-ID: <20190319155652.xssfwjfeitas6udd@holly.lan>
References: <20190318204741.116550-1-dianders@chromium.org>
 <20190318204741.116550-2-dianders@chromium.org>
 <20190319112537.5yi7gelkk4ixswmu@holly.lan>
 <CAD=FV=UJNED79Oc3ge3_JXZdJcADm_B9N-asymGrwZvKew2Wzw@mail.gmail.com>
 <20190319105525.7686763b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319105525.7686763b@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:55:25AM -0400, Steven Rostedt wrote:
> On Tue, 19 Mar 2019 07:45:38 -0700
> Doug Anderson <dianders@chromium.org> wrote:
> 
> > > > +unsigned long trace_total_entries_cpu(struct trace_array *tr, int cpu)
> > > > +{
> > > > +     unsigned long total, entries;
> > > > +
> > > > +     if (!tr)
> > > > +             tr = &global_trace;  
> > >
> > > This function is only ever called with tr set to NULL which means tr is
> > > an argument looking for a user.
> > >
> > > I wouldn't mind except if this was following copying prior art to keep
> > > the API feel the same but I can't find any other trace function where
> > > the trace_array can be substituted for NULL. AFAICT all the existing
> > > sites where global_trace is used will use it unconditionally.  
> 
> I'm in the process of making everything work better with tracing
> instances. Which means, making all the APIs use the tr pointer (which is
> the descriptor for the instance).
> 
> All new APIs added to the tracing infrastructure should reference a "tr"
> pointer, and not use the global_trace directly. We can default it if tr
> is NULL.
> 
> There are currently lots of cases in the code that do so, but I'm
> trying to get rid of them.

I see. So this API style will align with the rest of the family when
that works lands.

Fine for me.


Daniel.
