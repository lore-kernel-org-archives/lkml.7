Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC74FC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FEC20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ieVgGoac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfDKARU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:17:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43151 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDKART (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:17:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so2438327pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 17:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yrRwK9cUwCNY+yL4zo069B0QP8XQ3h1nIC4OFqrdMO0=;
        b=ieVgGoacjlJ25s8/AyIeevAbIqcP89f6248JPH9B6LZ97k8+FOrdANGAz8HqrDkkjg
         +tmCkujj7YAKxRdLpSLQkbV7tzdvdjePrZuMIobM9A22d+rynSTBgXGyhYeR7WdhNA6y
         H7eETHeU9FHYOtg9/Yc/tMuiL50kRWUHCs5C8qQpDOJYL3z1C3TrxiSdz4lizMQ9jY7c
         a+A9Wu/gKO/QZQn+BH3qiYIguGeka375PIbhIaguzBR1rSt91s1zlQi/JwTPoVtJNgYI
         5i+0JmiizLeEd16exSKF1nMu46PxuXPt9Ay6MmmktaGQ52qSFwHcXv/nOxdQ2AJj23xp
         JBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=yrRwK9cUwCNY+yL4zo069B0QP8XQ3h1nIC4OFqrdMO0=;
        b=b4YN6XxBDUZtjbubIfj6HCnz937VPKUE5DlGoUAju+Ox3ELz//3xdkTp0Exl5kGYSi
         F+IWkLa24f3MFG8mWC9T1PmmoJdbGkI1bOgoODIh0PnuGNzxZ7Og+QxxHNcoJnY/4gec
         CJtOu9AQBKOCz3pY2GLzxggUfi1WwNSDqaMrlFZBnGE08SRR+J/e+pMRLxbYI2MmDBb6
         vrLSg84g5GSfNbk+aNRdj6SUMrPkNycS3ip+AEN5VOrpVruSsEqoznffXTIcxtI9NoQA
         L3xsdnW7VuyPoDXXH/dJo5Z9fna+hLbJ44LojBdfEDo0br0cnhqRYStps/Tmf0MlFLIR
         jiVg==
X-Gm-Message-State: APjAAAWCsDla6JD/eu6fWtKZpHfHbWX1cSnj1+eeI+AqfaV4GGMK/2Fv
        h6M4zimwqLXe/wNGOPtoE9wuNg==
X-Google-Smtp-Source: APXvYqyXBrJbhcn5P5ZhZ108Qi5mgNPljdjCXbF1+9f2VyMu+f85GcVHBGeESF4/gSES3u9Ay+2RZg==
X-Received: by 2002:a63:450f:: with SMTP id s15mr43274300pga.157.1554941838869;
        Wed, 10 Apr 2019 17:17:18 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id b16sm51013408pfo.168.2019.04.10.17.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 17:17:18 -0700 (PDT)
Date:   Thu, 11 Apr 2019 09:19:42 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [RFC patch 17/41] tracing: Make stack_trace_print() static and
 rename it
Message-ID: <20190411001941.GJ2948@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
References: <20190410102754.387743324@linutronix.de>
 <20190410103645.136887071@linutronix.de>
 <20190410084703.2b702e70@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410084703.2b702e70@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 08:47:03AM -0400, Steven Rostedt wrote:
> On Wed, 10 Apr 2019 12:28:11 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > It's only used in the source file where it is defined and it's using the
> > stack_trace_ namespace. Rename it to free it up for stack trace related
> > functions.
> > 
> 
> Can you put it back to its original name "print_max_stack()" which was
> changed by this commit:
> 
> bb99d8ccec7 ("tracing: Allow arch-specific stack tracer")
> 
> I actually want to do a clean up and remove all "trace_" functions that
> are not a tracepoint. It's getting confusing to see a "trace_..." and
> search for the corresponding TRACE_EVENT() macro and not being able to
> find it.
> 
> Hmm, I'm not sure why Akashi changed that function to be global in the
> first place. It looks like only check_stack() needed to be changed.
> 
> Akashi?

Well, as indicated in the commit log, I implemented arch64-specific
check_stack() and used stack_trace_print() in there. At the end of the day,
however, only the first part of my patch set[1], including 'bb99d8ccec7',
was merged. Since then the said function was never used outside of the file.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/393716.html

Thanks,
-Takahiro Akashi

> -- Steve
> 
> 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > ---
> >  include/linux/ftrace.h     |    1 -
> >  kernel/trace/trace_stack.c |    4 ++--
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -251,7 +251,6 @@ extern unsigned long stack_trace_max_siz
> >  extern arch_spinlock_t stack_trace_max_lock;
> >  
> >  extern int stack_tracer_enabled;
> > -void stack_trace_print(void);
> >  int
> >  stack_trace_sysctl(struct ctl_table *table, int write,
> >  		   void __user *buffer, size_t *lenp,
> > --- a/kernel/trace/trace_stack.c
> > +++ b/kernel/trace/trace_stack.c
> > @@ -41,7 +41,7 @@ static DEFINE_MUTEX(stack_sysctl_mutex);
> >  int stack_tracer_enabled;
> >  static int last_stack_tracer_enabled;
> >  
> > -void stack_trace_print(void)
> > +static void trace_stack_trace_print(void)
> >  {
> >  	long i;
> >  	int size;
> > @@ -179,7 +179,7 @@ check_stack(unsigned long ip, unsigned l
> >  	stack_trace_max.nr_entries = x;
> >  
> >  	if (task_stack_end_corrupted(current)) {
> > -		stack_trace_print();
> > +		trace_stack_trace_print();
> >  		BUG();
> >  	}
> >  
> > 
> 
