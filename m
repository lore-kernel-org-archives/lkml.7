Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25719C0030B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AAC208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uWDzucdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395217AbfIGR2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:28:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39432 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbfIGR23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:28:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id bd8so4649949plb.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VMtjPGOdBDNMSIWoOR2Jy+5ztqnKRKLnJKcdOUQ0Uo0=;
        b=uWDzucdHh9f5dWoXdgiMfCz2PUHCfbUtdDcvcVaEKQDlXsSkmfPsYyGqQGtUbeAmhQ
         3JjecK33Vzk0FEiGc+8cfDTZdh7qjdai+d4NkEB3HGGmkgmjDZLTqhI7CRo195LdLXMC
         mJNKMuPFU6kBARJKbDIMhw+qqhH307aYwgFMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VMtjPGOdBDNMSIWoOR2Jy+5ztqnKRKLnJKcdOUQ0Uo0=;
        b=Ule3y9VeiHIHdfw2TvMgsvEiO0l3ZUG5XVnNiYtz7E+FUlOJvIliRFNvUzZ6oadj1j
         loKLXIjv1nf45PhnSceamxOMZoFFY+GOmx4eLcl0eLQa+qutVFvDy7wyDSgOUDi74Yg9
         lvEDB5Z6nr3RScT3CGxH2j5KUoIsjr6YUbu5BoWQFeoQZBY+t4+/p9MT39PVktatv3TC
         HkmE6ExUyge/tWtlvSAdzgCkAPp/ytSFrOX4juDf4fJpsTvRKc1Jmw4icM9rFsOlJwfw
         QvYxV0NCs/6YlsHefRCffSLoiFxwwt0nXJaM6OqOhhDoXrtHeiSOfVOQEBTJqhJ4mgnX
         rocQ==
X-Gm-Message-State: APjAAAVEbozwlS5kudSIFhKTNE+ED+0Qso/+8Gu3WEU4JAHdmajn5cZ/
        Y0d4pMzsW5322XrA00ks3bknRw==
X-Google-Smtp-Source: APXvYqy+cUdlaLzvn7EWIPj8DLl7PJEY2fbVER0nb3tI22DfVfBIABGAonQc3z2FwhwiTMY9VWU89A==
X-Received: by 2002:a17:902:748b:: with SMTP id h11mr15469399pll.269.1567877308213;
        Sat, 07 Sep 2019 10:28:28 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y192sm14400330pfg.141.2019.09.07.10.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 10:28:27 -0700 (PDT)
Date:   Sat, 7 Sep 2019 13:28:26 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH -rcu dev 1/2] Revert b8c17e6664c4 ("rcu: Maintain special
 bits at bottom of ->dynticks counter")
Message-ID: <20190907172826.GA245761@google.com>
References: <20190904135420.GB240514@google.com>
 <20190904231308.GB4125@linux.ibm.com>
 <20190905153620.GG26466@google.com>
 <20190905164329.GT4125@linux.ibm.com>
 <20190906000137.GA224720@google.com>
 <20190906150806.GA11355@google.com>
 <20190906152144.GF4051@linux.ibm.com>
 <20190906152753.GA18734@linux.ibm.com>
 <20190906165751.GA40876@google.com>
 <20190906171646.GI4051@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906171646.GI4051@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 10:16:47AM -0700, Paul E. McKenney wrote:
> On Fri, Sep 06, 2019 at 12:57:51PM -0400, Joel Fernandes wrote:
> > On Fri, Sep 06, 2019 at 08:27:53AM -0700, Paul E. McKenney wrote:
> > > On Fri, Sep 06, 2019 at 08:21:44AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Sep 06, 2019 at 11:08:06AM -0400, Joel Fernandes wrote:
> > > > > On Thu, Sep 05, 2019 at 08:01:37PM -0400, Joel Fernandes wrote:
> > > > > [snip] 
> > > > > > > > > @@ -3004,7 +3007,7 @@ static int rcu_pending(void)
> > > > > > > > >  		return 0;
> > > > > > > > >  
> > > > > > > > >  	/* Is the RCU core waiting for a quiescent state from this CPU? */
> > > > > > > > > -	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm)
> > > > > > > > > +	if (READ_ONCE(rdp->core_needs_qs) && !rdp->cpu_no_qs.b.norm)
> > > > > > > > >  		return 1;
> > > > > > > > >  
> > > > > > > > >  	/* Does this CPU have callbacks ready to invoke? */
> > > > > > > > > @@ -3244,7 +3247,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
> > > > > > > > >  	rdp->gp_seq = rnp->gp_seq;
> > > > > > > > >  	rdp->gp_seq_needed = rnp->gp_seq;
> > > > > > > > >  	rdp->cpu_no_qs.b.norm = true;
> > > > > > > > > -	rdp->core_needs_qs = false;
> > > > > > > > 
> > > > > > > > How about calling the new hint-clearing function here as well? Just for
> > > > > > > > robustness and consistency purposes?
> > > > > > > 
> > > > > > > This and the next function are both called during a CPU-hotplug online
> > > > > > > operation, so there is little robustness or consistency to be had by
> > > > > > > doing it twice.
> > > > > > 
> > > > > > Ok, sorry I missed you are clearing it below in the next function. That's
> > > > > > fine with me.
> > > > > > 
> > > > > > This patch looks good to me and I am Ok with merging of these changes into
> > > > > > the original patch with my authorship as you mentioned. Or if you wanted to
> > > > > > be author, that's fine too :)
> > > > > 
> > > > > Paul, does it make sense to clear these urgency hints in rcu_qs() as well?
> > > > > After all, we are clearing atleast one urgency hint there: the
> > > > > rcu_read_unlock_special::need_qs bit.
> > 
> > Makes sense.
> > 
> > > > We certainly don't want to turn off the scheduling-clock interrupt until
> > > > after the quiescent state has been reported to the RCU core.  And it might
> > > > still be useful to have a heavy quiescent state because the grace-period
> > > > kthread can detect that.  Just in case the CPU that just called rcu_qs()
> > > > is slow about actually reporting that quiescent state to the RCU core.
> > > 
> > > Hmmm...  Should ->need_qs ever be cleared from FQS to begin with?
> > 
> > I did not see the FQS loop clearing ->need_qs in the rcu_read_unlock_special
> > union after looking for a few minutes. Could you clarify which path this?
> > 
> > Or do you mean ->core_needs_qs? If so, I feel the FQS loop should clear it as
> > I think your patch does, since the FQS loop is essentially doing heavy-weight
> > RCU core processing right?

Took another look, rcu_read_unlock_special::need_qs is not cleared from FQS
loop. It is only set. So I did not follow what you meant. You probably were
concerned with some other hint being cleared in the FQS loop. No urgency on
this but do let me know what you meant (whenever after LPC etc).

> > Also, where does FQS loop clear rdp.cpu_no_qs? Shouldn't it clear that as
> > well for the dyntick-idle CPUs?
> 
> Synchronization?

I think you here you meant that we don't want to acquire rdp's locks so we
can't easily clear cpu_no_qs. But why not use WRITE_ONCE() to clear it, like
we are doing for the other hints?  I just felt idle CPU can't do this
clearing so the FQS loop (GP thread) should do it on its behalf.

Anyway, since you were going to squash the hint clearing with the other patch
as you mentioned in this thread, let me know once you have the squashed patch
for futher review/tracing/testing (after LPC, conferences, whenever. No rush!).

Thanks, Paul!!

 - Joel

