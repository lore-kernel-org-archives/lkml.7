Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756B9C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ABE214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G+X2quMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbfHFORb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:17:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbfHFORa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hrnXr7yGnyArLiHfQ0lWFY8+UrvOf+p4SAkiuT8O4f8=; b=G+X2quMB8Z2eErXJFz4pRAT1y
        lM/5+AV4U5RAUlKVfPe7vxvFDZbgGyc7DnMqdugkQZKK6H+9/Hq7pFAq8FWVgIeOvkmjQ7zMrsZHW
        4MMV8Qb05NYgYWBBHRW3q8EKNRw8Kw9zva1N7DSdFN+r+50u5ittTCpfPduyTrjtjrtHn244DLLIP
        SFhn60qZinbI+wSPKDtaSFcXB/Of9BU2UGoDyCv4m9PQ05sYxoqeS24oE86XPpl4ritIfhJUCdogg
        KBFZ9ghwSHOenD9sdO2D+pk4Fj3jyKlNIQ4I8h79Z5hCXKa9rMJfb+O1CRFWmg62oOnnXG+CfvySo
        9rcZ7qkPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv0HC-00084U-E0; Tue, 06 Aug 2019 14:17:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9D49307145;
        Tue,  6 Aug 2019 16:16:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11467201B4BAA; Tue,  6 Aug 2019 16:17:20 +0200 (CEST)
Date:   Tue, 6 Aug 2019 16:17:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] core vruntime comparison
Message-ID: <20190806141720.GS2332@hirez.programming.kicks-ass.net>
References: <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190725143248.GC992@aaronlu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725143248.GC992@aaronlu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:32:49PM +0800, Aaron Lu wrote:
> +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> +{
> +	struct sched_entity *sea = &a->se;
> +	struct sched_entity *seb = &b->se;
> +	bool samecpu = task_cpu(a) == task_cpu(b);
> +	struct task_struct *p;
> +	s64 delta;
> +
> +	if (samecpu) {
> +		/* vruntime is per cfs_rq */
> +		while (!is_same_group(sea, seb)) {
> +			int sea_depth = sea->depth;
> +			int seb_depth = seb->depth;
> +
> +			if (sea_depth >= seb_depth)
> +				sea = parent_entity(sea);
> +			if (sea_depth <= seb_depth)
> +				seb = parent_entity(seb);
> +		}
> +
> +		delta = (s64)(sea->vruntime - seb->vruntime);
> +		goto out;
> +	}
> +
> +	/* crosscpu: compare root level se's vruntime to decide priority */
> +	while (sea->parent)
> +		sea = sea->parent;
> +	while (seb->parent)
> +		seb = seb->parent;
> +	delta = (s64)(sea->vruntime - seb->vruntime);
> +
> +out:
> +	p = delta > 0 ? b : a;
> +	trace_printk("picked %s/%d %s: %Ld %Ld %Ld\n", p->comm, p->pid,
> +			samecpu ? "samecpu" : "crosscpu",
> +			sea->vruntime, seb->vruntime, delta);
> +
> +	return delta > 0;
>  }

Heh.. I suppose the good news is that Rik is trying very hard to kill
the nested runqueues, which would make this _much_ easier again.
