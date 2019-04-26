Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7698C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBC2206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A2Ovcpju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfDZOCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:02:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ngzfdohvXqSUVZnRL5smiig+x3FdhK7oHwWhG+cjpGA=; b=A2OvcpjuZlnGx8SM9RnopTxWZ
        6op1Z0KKtOzcNSIOLl1ULOMy0oTEjWC9hNw/TuGeKteeud+h7tpBX9v0VafcMajkOFr1eXk7hpPhi
        XF40UcNDY6ke5PwBB4HOS43E8icf4hNgQjz01v9m6I+vcq0vA7CYY5PPA+iHI1FvPzTmDDW4znjtf
        4L3ISCoJ7xHPFAusgYsE0o2HO+KC3J/vEbKN0cUAbmEsKhH5cpYrXiGt3inB0gvQkAM3iA8rYwQUq
        +FmJ1GrzhltCUK+D7//8Zmpd0P58nuAtBEvABfgZ1KMKsPzuZr26yOGvtUJ4+0SGwZkcpPx+8dGh3
        oOpjJlKQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK1QZ-0007V3-1q; Fri, 26 Apr 2019 14:02:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3FCB5286B7D80; Fri, 26 Apr 2019 16:02:09 +0200 (CEST)
Date:   Fri, 26 Apr 2019 16:02:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 09/17] sched: Introduce sched_class::pick_task()
Message-ID: <20190426140209.GA2623@hirez.programming.kicks-ass.net>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <e2f1d30b0b3bb62c01824f422badf159147982d7.1556025155.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2f1d30b0b3bb62c01824f422badf159147982d7.1556025155.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:18:14PM +0000, Vineeth Remanan Pillai wrote:
> +static struct task_struct *
> +pick_task_fair(struct rq *rq)
> +{
> +	struct cfs_rq *cfs_rq = &rq->cfs;
> +	struct sched_entity *se;
> +
> +	if (!cfs_rq->nr_running)
> +		return NULL;
> +
> +	do {
> +		struct sched_entity *curr = cfs_rq->curr;
> +
> +		se = pick_next_entity(cfs_rq, NULL);
> +
> +		if (!(se || curr))
> +			return NULL;

I didn't get around to reading the original discussion here, but how can
that possibly be?

I can see !se, in that case curr is still selected.

I can also see !curr, in that case curr is put.

But I cannot see !se && !curr, per the above check we know
cfs_rq->nr_running != 0, so there must be a cfs task to find. This means
either curr or se must exist.

> +
> +		if (curr) {
> +			if (se && curr->on_rq)
> +				update_curr(cfs_rq);
> +
> +			if (!se || entity_before(curr, se))
> +				se = curr;
> +		}
> +
> +		cfs_rq = group_cfs_rq(se);
> +	} while (cfs_rq);
> +
> +	return task_of(se);
> +}
