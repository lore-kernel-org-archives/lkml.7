Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35DAC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8972073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AMAi7jzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfLDQEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:04:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41179 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfLDQEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:04:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so81033pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lEczIr05C8TgUB0wYPwYco1Wmd1jSJezldm3cM37UHY=;
        b=AMAi7jzFKieoCU3sOqVAqotUHCS9ex43uM+DvM0+mEr4hLI9aadCiPDB8lqiIOKAPO
         F/6caJmyTcCI08xYiT7KIzIXxNpzKBBkBSkmgCZmyEQor60Vgc026L6xN3//5sEJGT8O
         DSGobBlOoy65xNlVmsBrLvoINtsusHq8oWWHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lEczIr05C8TgUB0wYPwYco1Wmd1jSJezldm3cM37UHY=;
        b=QgDa9ukR5qkuBT+lp/lhB1XK7f0Ahksm5/Gcihhk2c3bBIXXpyIkZjesj7x1QvMxl0
         pq148mk2iLdtyUtlEKYCDonRU2CAY7/6UXFg7iAZptg7gaoe3RGAx0aWU6nYiAhsWSBX
         DTOBok7EGwWoG8h5tuLEgWwpKFBUwObhvi7SedNii9jigFxHHChxW4h2UvxtTZlaE/x8
         bqqAx9TPBYnVmJZszsWvkErcHyTFGYoL7toRcg7UYUnnUSoLpwMX3Dn0kRbBdygiHjIL
         sc2qaUxjK5pB9J/dT/LjeJVWWAtuZC7pLtyVhNN10k2AKtf0cCaE6qPYFZxzhw9fusuE
         pqyA==
X-Gm-Message-State: APjAAAUeMMEGy0g1nJENF9hdERzGXsWWdUwEQNEm2dM1gqjmpDHfJync
        Wi4JLjMJgcvCk8Gc1/qmwU0e2w==
X-Google-Smtp-Source: APXvYqwRVG5ZTFGimiLMObb2aEdXmbfLPt6NGsTwoK7yCqMXlHti7j2qLYudtL7BMdDQ60byUcq7pw==
X-Received: by 2002:a63:c141:: with SMTP id p1mr4375003pgi.326.1575475462437;
        Wed, 04 Dec 2019 08:04:22 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s3sm8081816pgi.31.2019.12.04.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:04:21 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:04:20 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Antonio Borneo <antonio.borneo@st.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] tracing: Fix printing ptrs in preempt/irq enable/disable
 events
Message-ID: <20191204160420.GC17404@google.com>
References: <20191127154428.191095-1-antonio.borneo@st.com>
 <20191204092115.30ef75c9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204092115.30ef75c9@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 09:21:15AM -0500, Steven Rostedt wrote:
> 
> Joel,
> 
> Any comments on this patch?

Just replied, thanks for the ping!

 - Joel

> 
> -- Steve
> 
> On Wed, 27 Nov 2019 16:44:28 +0100
> Antonio Borneo <antonio.borneo@st.com> wrote:
> 
> > This tracing event class is the only instance in kernel that logs
> > in the trace buffer the instruction pointer as offset to _stext,
> > instead of logging the full pointer.
> > This looks like a nice optimization for 64 bits platforms, where a
> > 32 bit offset can take less space than a full 64 bits pointer. But
> > the symbol _stext is incorrectly resolved as zero in the expansion
> > of TP_printk(), which then prints only the hex offset instead of
> > the name of the caller function. Plus, on arm arch the kernel
> > modules are loaded at address lower than _stext, causing the u32
> > offset arithmetics to overflow and wrap at 32 bits.
> > I did not identified a 64 bit arch where the modules are loaded at
> > offset from _stext that exceed u32 range, but I also did not
> > identified any constraint to feel safe with a u32 offset.
> > 
> > Log directly the instruction pointer instead of the offset to
> > _stext.
> > 
> > Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
> > Fixes: d59158162e03 ("tracing: Add support for preempt and irq enable/disable events")
> > ---
> >  include/trace/events/preemptirq.h | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/trace/events/preemptirq.h b/include/trace/events/preemptirq.h
> > index 95fba0471e5b..d548a6aafa18 100644
> > --- a/include/trace/events/preemptirq.h
> > +++ b/include/trace/events/preemptirq.h
> > @@ -18,18 +18,18 @@ DECLARE_EVENT_CLASS(preemptirq_template,
> >  	TP_ARGS(ip, parent_ip),
> >  
> >  	TP_STRUCT__entry(
> > -		__field(u32, caller_offs)
> > -		__field(u32, parent_offs)
> > +		__field(unsigned long, caller_ip)
> > +		__field(unsigned long, parent_ip)
> >  	),
> >  
> >  	TP_fast_assign(
> > -		__entry->caller_offs = (u32)(ip - (unsigned long)_stext);
> > -		__entry->parent_offs = (u32)(parent_ip - (unsigned long)_stext);
> > +		__entry->caller_ip = ip;
> > +		__entry->parent_ip = parent_ip;
> >  	),
> >  
> >  	TP_printk("caller=%pS parent=%pS",
> > -		  (void *)((unsigned long)(_stext) + __entry->caller_offs),
> > -		  (void *)((unsigned long)(_stext) + __entry->parent_offs))
> > +		  (void *)__entry->caller_ip,
> > +		  (void *)__entry->parent_ip)
> >  );
> >  
> >  #ifdef CONFIG_TRACE_IRQFLAGS
> 
