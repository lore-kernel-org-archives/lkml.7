Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085D0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2062082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vvQzmIgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfHSOW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:22:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38706 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHSOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:22:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id e11so1319035pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PfWjNfLJ6k4OXcw3r2VepdtUPQsgg6X90jwMO+m8X1E=;
        b=vvQzmIgNuuyOTVF2FwsTbk73dFiZkUYlcaEPM5KtN9TPYn9mCFQQU35pXRQ+Hz8xcK
         hKoKtoMhDWeKCtTi2u4p9qv8hCwSGuaEv14CcVo2pBU5hK5b4EP8Oma93P3GntTJdrbH
         oZwbrmSbKH02e5fAOqVg0s7QqifoHgXlJE2+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PfWjNfLJ6k4OXcw3r2VepdtUPQsgg6X90jwMO+m8X1E=;
        b=rMe0w7VmFZM+ZBFv6pGhHe5/K2SjC8G8wXhnU+fN4VLnrVDEn9Jho+pRAYMY8Wwomm
         P8ruG2h3mUkR+cUcu++vMgvPAVQ4IGqHIC1eAH5KzRwTDy+htW3DxgpC/uhNc4BLKzRq
         b78afRo2yEx/UdF4pJhgX/mJJgzDSlVeyTza1Okbwh2ehlA6oaVgqguE9MD6O79sDGO5
         YnVSsAtyWymcZq6hIMficPJCtDWGRhGYvs9PiVwdqM/kjoApPPlV/ohEMMCZ9zK87HzV
         JAxxRghvnC+O0xWDztNWQD4EVoA1oHGq3GoIQypA0gtNuc++R6nubANIBDsHhrQYUZoH
         3esQ==
X-Gm-Message-State: APjAAAXrhzuywf23+bFzqQpeyK/W0C9PnPzVvqbgyN05JwxzzDfkXCCG
        K7FKukGoVbJq7/eOPhtrvcE1y12pVE0=
X-Google-Smtp-Source: APXvYqxh8y4zO87ApzLTVVfWArXuUJuku2CCGMkVuZ8BijgP/qZ/kGbsFFCjnf3/j16+LkN0AXLW/A==
X-Received: by 2002:a17:90a:1b0a:: with SMTP id q10mr20852490pjq.91.1566224545547;
        Mon, 19 Aug 2019 07:22:25 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id d2sm8465570pjg.19.2019.08.19.07.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 07:22:24 -0700 (PDT)
Date:   Mon, 19 Aug 2019 10:22:08 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH -rcu dev 3/3] RFC: rcu/tree: Read dynticks_nmi_nesting in
 advance
Message-ID: <20190819142208.GA117378@google.com>
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190816025311.241257-3-joel@joelfernandes.org>
 <20190816162404.GB10481@google.com>
 <20190816165242.GS28441@linux.ibm.com>
 <20190819125907.GD27088@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819125907.GD27088@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 02:59:08PM +0200, Frederic Weisbecker wrote:
> On Fri, Aug 16, 2019 at 09:52:42AM -0700, Paul E. McKenney wrote:
> > On Fri, Aug 16, 2019 at 12:24:04PM -0400, Joel Fernandes wrote:
> > > On Thu, Aug 15, 2019 at 10:53:11PM -0400, Joel Fernandes (Google) wrote:
> > > > I really cannot explain this patch, but without it, the "else if" block
> > > > just doesn't execute thus causing the tick's dep mask to not be set and
> > > > causes the tick to be turned off.
> > > > 
> > > > I tried various _ONCE() macros but the only thing that works is this
> > > > patch.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 856d3c9f1955..ac6bcf7614d7 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -802,6 +802,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> > > >  {
> > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > >  	long incby = 2;
> > > > +	int dnn = rdp->dynticks_nmi_nesting;
> > > 
> > > I believe the accidental sign extension / conversion from long to int was
> > > giving me an illusion since things started working well. Changing the 'int
> > > dnn' to 'long dnn' gives similar behavior as without this patch! At least I
> > > know now. Please feel free to ignore this particular RFC patch while I debug
> > > this more (over the weekend or early next week). The first 2 patches are
> > > good, just ignore this one.
> > 
> > Ah, good point on the type!  So you were ending up with zero due to the
> > low-order 32 bits of DYNTICK_IRQ_NONIDLE being zero, correct?  If so,
> > the "!rdp->dynticks_nmi_nesting" instead needs to be something like
> > "rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE", which sounds like
> > it is actually worse then the earlier comparison against the constant 2.
> > 
> > Sounds like I should revert the -rcu commit 805a16eaefc3 ("rcu: Force
> > nohz_full tick on upon irq enter instead of exit").
> 
> I can't find that patch so all I can say so far is that its title doesn't
> inspire me much. Do you still need that change for some reason?

No we don't need it. Paul's dev branch fixed it by checking DYNTICK_IRQ_NONIDLE:
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=227482fd4f3ede0502b586da28a59971dfbac0b0

thanks,

 - Joel

