Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2742C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D04A2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sRiNA6dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfCMUSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:18:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54466 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfCMUSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+pFdgk6cbWEGojWdjJukIB3td/DgSUtUvsYCQXOeuRM=; b=sRiNA6ddWTnpXZHKSTOeg4m+B
        vu/tyNQS3DRHHa4kDJwgLDTQ+4dGTv459Wf1EhSFHyb/0oD7MbC14sdKAUU+7ntJaOaDUV7JDZ2Jq
        0pDiUVM94DWbPjuYueWpA/4zsIL9bFPs59+MrFL5pVyZ5EJvuzKhC4mxB9UvC0gR4Hmo0BQ9qRI+e
        CeXbzjRj6pQZu1Z2r953wPVcopyRbxFbQp9OrulOR+bbgZERFOGn9ajjb9lup3/Wz8hO1o5MtLHjS
        Gbp3EQdaYnsppiIBCReZ2x23nVeOgotA5/kvf9Sqax5oeWYH8qX3iTsaYMMs4l020WP9H3aorWwWb
        Y9aMuSDjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4AKU-0008SI-Tg; Wed, 13 Mar 2019 20:18:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 313AB9826C0; Wed, 13 Mar 2019 21:18:21 +0100 (CET)
Date:   Wed, 13 Mar 2019 21:18:21 +0100
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
Subject: Re: [PATCH v7 03/15] sched/core: uclamp: Add system default clamps
Message-ID: <20190313201821.GW2482@worktop.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208100554.32196-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:05:42AM +0000, Patrick Bellasi wrote:
> +static void uclamp_fork(struct task_struct *p)
> +{
> +	unsigned int clamp_id;
> +
> +	if (unlikely(!p->sched_class->uclamp_enabled))
> +		return;
> +
> +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
> +		p->uclamp[clamp_id].active = false;
> +}

Because in that case .active == false, and copy_process() will have done
thr right thing?
