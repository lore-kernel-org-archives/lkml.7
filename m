Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7A7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AE52070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fZbShXf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfHSPq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:46:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36292 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfHSPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:46:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so1393885pfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2elDyP5CP8UUWSk4ZKqOrsu/zDRNWxkhO0IA5jFemb8=;
        b=fZbShXf23ZX9IZben4HxXfRR7Efl20R3m3cEpVuOyxuDLUhKZKXKwVewpxUGAtOFac
         +aYrmAcV12EkyKf97ksDJ/tx5bgtyWZjhTxlDnK4JXKJyQo7eHztyx0ow4khf/fvvEEG
         XNJTJwuRh1uqjKUT1r42R9u4BxWPlS9FfTRzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2elDyP5CP8UUWSk4ZKqOrsu/zDRNWxkhO0IA5jFemb8=;
        b=oOmbL0xZg9BG5yNowFN+w2dcKwP5ne2E9eh32xfJPfY/++DOajhDhlAONPq/9uuvU9
         byvnrPsTi676pdH6V5izsOTyEJzZNRbpL287+nwMQvalnywN47WHnCwmxfTkRsWGS5mK
         MtQTMu41+rxofuvN/Khk43aTblXqAbZkj3Wk7llGcr3G+R6F8sUmYPC865cAtfiftL2k
         Ow+37DtQh8PpjE4gwG1ArBGkiY+xrvvVlonfDVB8EK9agIyFgGtS2mRT4KtVMLWjUQ60
         B+qVUFX2x63F+XsKjfQ+mNKyVfP4C9VFeeHVKTk8Ddc9qnDhc2oVAcmY5Wt/qCbZxx6w
         SBWA==
X-Gm-Message-State: APjAAAV6Urs8QOHsZUuSs2i+rSQi5zuWTcFoll1EJO47qEMK+fjChIQ5
        LoC8PMn42uiVxrMm239FW6+KhPebZvs=
X-Google-Smtp-Source: APXvYqxcySPnC/2XxhgO0+kAfoWmP0gOuQ/PtygXHxopdN83A3u7yznnhOXp7slt9eAIYAG3Su0DUg==
X-Received: by 2002:a17:90a:1aab:: with SMTP id p40mr21262920pjp.7.1566229614339;
        Mon, 19 Aug 2019 08:46:54 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id 65sm23601342pff.148.2019.08.19.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 08:46:53 -0700 (PDT)
Date:   Mon, 19 Aug 2019 11:46:36 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH -rcu dev 3/3] RFC: rcu/tree: Read dynticks_nmi_nesting in
 advance
Message-ID: <20190819154636.GC117548@google.com>
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190816025311.241257-3-joel@joelfernandes.org>
 <20190816162404.GB10481@google.com>
 <20190816165242.GS28441@linux.ibm.com>
 <20190819125907.GD27088@lenoir>
 <20190819142208.GA117378@google.com>
 <20190819144107.GV28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819144107.GV28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 07:41:08AM -0700, Paul E. McKenney wrote:
> On Mon, Aug 19, 2019 at 10:22:08AM -0400, Joel Fernandes wrote:
> > On Mon, Aug 19, 2019 at 02:59:08PM +0200, Frederic Weisbecker wrote:
> > > On Fri, Aug 16, 2019 at 09:52:42AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Aug 16, 2019 at 12:24:04PM -0400, Joel Fernandes wrote:
> > > > > On Thu, Aug 15, 2019 at 10:53:11PM -0400, Joel Fernandes (Google) wrote:
> > > > > > I really cannot explain this patch, but without it, the "else if" block
> > > > > > just doesn't execute thus causing the tick's dep mask to not be set and
> > > > > > causes the tick to be turned off.
> > > > > > 
> > > > > > I tried various _ONCE() macros but the only thing that works is this
> > > > > > patch.
> > > > > > 
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > ---
> > > > > >  kernel/rcu/tree.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index 856d3c9f1955..ac6bcf7614d7 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -802,6 +802,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> > > > > >  {
> > > > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > > > >  	long incby = 2;
> > > > > > +	int dnn = rdp->dynticks_nmi_nesting;
> > > > > 
> > > > > I believe the accidental sign extension / conversion from long to int was
> > > > > giving me an illusion since things started working well. Changing the 'int
> > > > > dnn' to 'long dnn' gives similar behavior as without this patch! At least I
> > > > > know now. Please feel free to ignore this particular RFC patch while I debug
> > > > > this more (over the weekend or early next week). The first 2 patches are
> > > > > good, just ignore this one.
> > > > 
> > > > Ah, good point on the type!  So you were ending up with zero due to the
> > > > low-order 32 bits of DYNTICK_IRQ_NONIDLE being zero, correct?  If so,
> > > > the "!rdp->dynticks_nmi_nesting" instead needs to be something like
> > > > "rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE", which sounds like
> > > > it is actually worse then the earlier comparison against the constant 2.
> > > > 
> > > > Sounds like I should revert the -rcu commit 805a16eaefc3 ("rcu: Force
> > > > nohz_full tick on upon irq enter instead of exit").
> > > 
> > > I can't find that patch so all I can say so far is that its title doesn't
> > > inspire me much. Do you still need that change for some reason?
> > 
> > No we don't need it. Paul's dev branch fixed it by checking DYNTICK_IRQ_NONIDLE:
> > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=227482fd4f3ede0502b586da28a59971dfbac0b0
> 
> Ah, so you have tested reverting this?  If so, thank you very much!

Just tried reverting, and found a bug if done in the reverted way. Sent you
email with a proposed change which is essentially the top of tree:
https://github.com/joelagnel/linux-kernel/commits/rcu/nohz-test-3

Also for Frederick, I wanted to mention why my pure hack above (dnn variable)
seemed to work. The reason was because of long to int conversion of
rdp->dynticks_nmi_nesting which I surprisingly did not get a compiler warning
for. dynticks_nmi_nesting getting converted to int was truncating the
DYNTICK_IRQ_NONIDLE bit (in fact I believe this was due to the cltq
instruction in x86). This caused the "else if" condition to always evaluate
to true and turn off the tick.

Paul, I wanted to see if I can create a repeatable test case for this issue.
Not a full blown RCU torture test, but something that one could run and get a
PASS or FAIL. Do you think this could be useful? And what is the best place
for such a test?
Essentially the test would be:
1. Run a test and dump some traces.
2. Parse the traces and see if things are sane (such as the tick not turning
   off for this issue).
3. Report pass or fail.

The other way instead of parsing traces could be, a kernel module that does
trace_probe_register on various tracepoints and tries to see if the tick
indeed could stay turned on. Then report pass/fail at the end of the module's
execution.

thanks,

 - Joel

