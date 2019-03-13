Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EE5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B9D2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Az3G3EIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfCMONF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:13:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49372 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCMONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nk2rYN8eWAnEFbUZXn1m8vUhGEUJxpzQAU+HdaDk3Tw=; b=Az3G3EIMbw1KH1vF+RLU6038p
        oj0unAwuH5QJXekw6Ke16SBwlkVpPgE/4jG5eK4gr3cLEfhcbRUV47C7SJ++T8HDYARDzVLIUBUAG
        8amqZlfHrvclgO+GCzXxKeSicdh/V8sIvoanEa8ikhndiFCdJ4G9GghiRnY28lUDg/RnXZGyZJmWS
        ax4FPCUBY5LXET6Wr8cE2LiniRhuO7O6u2dqBT+kPbaWENZbFsG/4ERZyw0SYS77jEqBDsPaJM655
        Rqmji7SrEYHO+wFIwwgYfQf7Vh4wrR0BrAwGfiDhiwAmWWepfsWRqip3Nq7Fg/zYd0BtkUBq9vjPF
        PRxF8XKnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h44cp-0003Jj-Eb; Wed, 13 Mar 2019 14:12:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E166E2028B0E8; Wed, 13 Mar 2019 15:12:53 +0100 (CET)
Date:   Wed, 13 Mar 2019 15:12:53 +0100
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
Subject: Re: [PATCH v7 02/15] sched/core: uclamp: Enforce last task UCLAMP_MAX
Message-ID: <20190313141253.GG5922@hirez.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208100554.32196-3-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:05:41AM +0000, Patrick Bellasi wrote:
> +static inline void uclamp_idle_reset(struct rq *rq, unsigned int clamp_id,
> +				     unsigned int clamp_value)
> +{
> +	/* Reset max-clamp retention only on idle exit */
> +	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
> +		return;
> +
> +	WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
> +
> +	/*
> +	 * This function is called for both UCLAMP_MIN (before) and UCLAMP_MAX
> +	 * (after). The idle flag is reset only the second time, when we know
> +	 * that UCLAMP_MIN has been already updated.

Why do we care? That is, what is this comment trying to tell us.

> +	 */
> +	if (clamp_id == UCLAMP_MAX)
> +		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> +}
