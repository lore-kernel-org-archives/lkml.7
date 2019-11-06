Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12657C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EC22187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SusUVAst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfKFQ5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:57:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfKFQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W/jgvGvtlOT33baRLN2nmwKV1/9KU4FO13RDpfuZP1w=; b=SusUVAstNuToStTW3xMVgBKPL
        L593P0GytU+ai7zW4p4x4eAe57s7aN0WvU42L2RK13FpPrvODwCO2Gul7aD6UT1zdk7UziOcyi8EI
        56yLui1bzCNrMBImu9kLnZOXGwJ+P3IX94rMJ7a+l/Fczbc3z1Zioce8JaiQ35rnYsmQgl+DSK6de
        i9cIQOzSOwR2YAwgKC4PY05dE9capBgdV0//9PZXWy3vY8OUsMLIHgL0p0IF3BDxeJxfHV5nlIDf9
        Ogx8YZ0ctueyo0G8u29sQk1fJFZfkX69aNBU9Yd3rvPzx48nTHtcQNjwGBO5vUI+Avc4zxhwBozdT
        pX+6LVGJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSOch-0001Fi-8M; Wed, 06 Nov 2019 16:57:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 17366301A79;
        Wed,  6 Nov 2019 17:56:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 24B742025EDA7; Wed,  6 Nov 2019 17:57:33 +0100 (CET)
Date:   Wed, 6 Nov 2019 17:57:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Quentin Perret <qperret@google.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191106165733.GY4114@hirez.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <20191106130838.GL5671@hirez.programming.kicks-ass.net>
 <20191106150450.fa5ppdejiggsb46a@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106150450.fa5ppdejiggsb46a@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 03:04:50PM +0000, Qais Yousef wrote:
> On 11/06/19 14:08, Peter Zijlstra wrote:
> > On Wed, Nov 06, 2019 at 01:05:25PM +0100, Peter Zijlstra wrote:

> > > The only thing I'm now considering is if we shouldn't be setting
> > > ->on_cpu=2 _before_ calling put_prev_task(). I'll go audit the RT/DL
> > > cases.
> > 
> > So I think it all works, but that's more by accident than anything else.
> > I'll move the ->on_cpu=2 assignment earlier. That clearly avoids calling
> > put_prev_task() while we're in put_prev_task().
> 
> Did you mean avoids calling *set_next_task()* while we're in put_prev_task()?

Either, really. The change pattern does put_prev_task() first, and then
restores state by calling set_next_task(). And it can do that while
we're in put_prev_task(), unless we're setting ->on_cpu=2.

> So what you're saying is that put_prev_task_{rt,dl}() could drop the rq_lock()
> too and the race could happen while we're inside these functions, correct? Or
> is it a different reason?

Indeed, except it looks like that actually works (mostly by accident).

> By the way, is all reads/writes to ->on_cpu happen when a lock is held? Ie: we
> don't need to use any smp read/write barriers?

Yes, ->on_cpu is fully serialized by rq->lock. We use
smp_store_release() in finish_task() due to ttwu spin-waiting on it
(which reminds me, riel was seeing lots of that).
