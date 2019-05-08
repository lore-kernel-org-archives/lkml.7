Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B27FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DBA216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wr/ok1Fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfEHTPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:15:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52424 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfEHTPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a8FuqNzzCdRGP7Hv+sEE+t8gtRRCoRvp/IDvJa1VM5A=; b=Wr/ok1Fx8EbTh6jrvfXbYqTie
        /PPcvw1lKmOrlAjMUiA1ApjzWORaQnguo5S+3lAouVaq5rWan6F029KXOA38qE/cgt/XccWv0Mddt
        wb45sh84dIlS27Wnlb0kh4yGutHFgZnER5uAoz7Ol1Hxz9JfPFJM+Z+BYXQ+SJnJrRUjHVKilYBkt
        fTk0QbcS0szJKEGW6inOuzJr5QvtFuXylemC/9ufY/3WAAKKwyf6dRaIEMJBDgs5iNlDa1NhunOOj
        zxK3xSv1VijLavqvgHduFaPTZGrjVTagk+gnbEWX0vopzeecNtDd0nQAKUKzDv+Ryihv2HVtMuD2U
        qJkcB8EmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOS2N-0003d0-Ts; Wed, 08 May 2019 19:15:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04C1798030A; Wed,  8 May 2019 21:15:29 +0200 (CEST)
Date:   Wed, 8 May 2019 21:15:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v8 04/16] sched/core: uclamp: Add system default clamps
Message-ID: <20190508191529.GA26813@worktop.programming.kicks-ass.net>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-5-patrick.bellasi@arm.com>
 <20190508190733.GC32547@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508190733.GC32547@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 09:07:33PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 02, 2019 at 11:41:40AM +0100, Patrick Bellasi wrote:
> > +static inline struct uclamp_se
> > +uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
> > +{
> > +	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
> > +	struct uclamp_se uc_max = uclamp_default[clamp_id];
> > +
> > +	/* System default restrictions always apply */
> > +	if (unlikely(uc_req.value > uc_max.value))
> > +		return uc_max;
> > +
> > +	return uc_req;
> > +}
> > +
> > +static inline unsigned int
> > +uclamp_eff_bucket_id(struct task_struct *p, unsigned int clamp_id)
> > +{
> > +	struct uclamp_se uc_eff;
> > +
> > +	/* Task currently refcounted: use back-annotated (effective) bucket */
> > +	if (p->uclamp[clamp_id].active)
> > +		return p->uclamp[clamp_id].bucket_id;
> > +
> > +	uc_eff = uclamp_eff_get(p, clamp_id);
> > +
> > +	return uc_eff.bucket_id;
> > +}
> > +
> > +unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
> > +{
> > +	struct uclamp_se uc_eff;
> > +
> > +	/* Task currently refcounted: use back-annotated (effective) value */
> > +	if (p->uclamp[clamp_id].active)
> > +		return p->uclamp[clamp_id].value;
> > +
> > +	uc_eff = uclamp_eff_get(p, clamp_id);
> > +
> > +	return uc_eff.value;
> > +}
> 
> This is 'wrong' because:
> 
>   uclamp_eff_value(p,id) := uclamp_eff(p,id).value

Clearly I means to say the above does not hold with the given
implementation, while the naming would suggest it does.

> Which seems to suggest the uclamp_eff_*() functions want another name.
> 
> Also, suppose the above would be true; does GCC really generate better
> code for the LHS compared to the RHS?
