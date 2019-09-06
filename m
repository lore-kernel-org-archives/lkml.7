Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D994C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED14C2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VLvmoojX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405695AbfIFPIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:08:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44274 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405678AbfIFPIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:08:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id k1so3270953pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oVHfTdbxKLJ5v5N1xW6pGtg6rMnkx2Mfh0JbO5nAoq0=;
        b=VLvmoojXoWu+ExmbEtPLQnb9eZcNChHfR8Sa4u3CvPNycWWiB++Bfn6EWnNjpPViXE
         TTi6/FeLfR6W0WHN6i2x7778P/7i8Eex1Dx8ZiF2WNzi7hSrGAJfVG/h3bhKMtwIbzGJ
         pFpo4oB6laCOO2rk92ednevhKDYFWLvrAGyiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oVHfTdbxKLJ5v5N1xW6pGtg6rMnkx2Mfh0JbO5nAoq0=;
        b=A3Url6xlC14xWQNbI+G7Ee6fmxx8UO3xLBMZxRxjoH2yzFCZX+o5vrNVrCVM7GRcN0
         Ub+U/Fq5WPxi7zhMwmX7ak2iezjaCTG+sk5tI7AJqu8haGo0S9recaz8KdceiSEKGhOJ
         Fsc1wSjPA088fJUKIBmC4XNnUrIvQIcJwOo3mf1ir+0rFjAr9JdE9ogtTZH+9D+pCwb7
         s+AIZ+WOWEWj2hMAg5ugC4EnyQyWXj8QfkX1+mDQp1QBbjg+VT4qt84C4tctbjbJlwe+
         CCZPDOjsyhgCjh99ZjVxBJtIr+t167wUBukJEhY2AlJiTZxpXlyit+MnmlsL9S1RtFCj
         eQgg==
X-Gm-Message-State: APjAAAUDrMtpnBD+VQjEYaHkWzI9IK2VtfXiz9cfE1lbRS0VKLWdUX/n
        a/mZiEv4/uniONlmBYNUyYYeMg==
X-Google-Smtp-Source: APXvYqyEIYgxl07/EE/D/mWfxa4+GpZlwXt4yAIpcq3VJaOPWzjxgVUg6dHAQLA8NPgxdi1DeTs9Kg==
X-Received: by 2002:a17:902:7792:: with SMTP id o18mr9158609pll.73.1567782488192;
        Fri, 06 Sep 2019 08:08:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b126sm7611169pfb.110.2019.09.06.08.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 08:08:07 -0700 (PDT)
Date:   Fri, 6 Sep 2019 11:08:06 -0400
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
Message-ID: <20190906150806.GA11355@google.com>
References: <20190830162348.192303-1-joel@joelfernandes.org>
 <20190903200249.GD4125@linux.ibm.com>
 <20190904045910.GC144846@google.com>
 <20190904101210.GM4125@linux.ibm.com>
 <20190904135420.GB240514@google.com>
 <20190904231308.GB4125@linux.ibm.com>
 <20190905153620.GG26466@google.com>
 <20190905164329.GT4125@linux.ibm.com>
 <20190906000137.GA224720@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906000137.GA224720@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 08:01:37PM -0400, Joel Fernandes wrote:
[snip] 
> > > > @@ -3004,7 +3007,7 @@ static int rcu_pending(void)
> > > >  		return 0;
> > > >  
> > > >  	/* Is the RCU core waiting for a quiescent state from this CPU? */
> > > > -	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm)
> > > > +	if (READ_ONCE(rdp->core_needs_qs) && !rdp->cpu_no_qs.b.norm)
> > > >  		return 1;
> > > >  
> > > >  	/* Does this CPU have callbacks ready to invoke? */
> > > > @@ -3244,7 +3247,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
> > > >  	rdp->gp_seq = rnp->gp_seq;
> > > >  	rdp->gp_seq_needed = rnp->gp_seq;
> > > >  	rdp->cpu_no_qs.b.norm = true;
> > > > -	rdp->core_needs_qs = false;
> > > 
> > > How about calling the new hint-clearing function here as well? Just for
> > > robustness and consistency purposes?
> > 
> > This and the next function are both called during a CPU-hotplug online
> > operation, so there is little robustness or consistency to be had by
> > doing it twice.
> 
> Ok, sorry I missed you are clearing it below in the next function. That's
> fine with me.
> 
> This patch looks good to me and I am Ok with merging of these changes into
> the original patch with my authorship as you mentioned. Or if you wanted to
> be author, that's fine too :)

Paul, does it make sense to clear these urgency hints in rcu_qs() as well?
After all, we are clearing atleast one urgency hint there: the
rcu_read_unlock_special::need_qs bit.

thanks,

 - Joel

