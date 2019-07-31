Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB6FC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88121206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iCJMLk+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfGaPah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:30:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfGaPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=txfSN/fF8f35hHNUzsvRfsLyFj8kxwbIYIzNM7C5IfM=; b=iCJMLk+l6ZS8Xq44DdqtR0b9cW
        RfdhxvJrO+2JiQeO/E6CLPfRPZYNhYlDgyHNUot+p69H2HAiSS7HCuC3J17jZSpMKjZlLWC6rYRCy
        sOsZV0cizqVgP2WfHJREKrFdDgt3rXpelqM8O3vH3L3uydmiujZbsfjqxI1eoHXixzGrTPXu5AQc+
        fK4roaoL3u40IxKOrlYi+OMbLMHE81g4wjwwMIhbkAQ34U7GcELbV/0RjfkzuoR8KkeGtkjrUEtW+
        2l6wc53RZzrCwRlP10T7dnbH+9BomDcc2AipFKKojgH5sWnEIkoMcgejtREGGrLu97UsCnL8SZXEy
        Vur5pOoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsqYf-0003EQ-Mx; Wed, 31 Jul 2019 15:30:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93ED12029FD58; Wed, 31 Jul 2019 17:30:27 +0200 (CEST)
Date:   Wed, 31 Jul 2019 17:30:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH 09/14] sched,fair: refactor enqueue/dequeue_entity
Message-ID: <20190731153027.GV31381@hirez.programming.kicks-ass.net>
References: <20190722173348.9241-1-riel@surriel.com>
 <20190722173348.9241-10-riel@surriel.com>
 <20190730093617.GV31398@hirez.programming.kicks-ass.net>
 <20190731093525.GH31425@hirez.programming.kicks-ass.net>
 <461f14cafabb7e6f78556f138b6aa619eff12dee.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <461f14cafabb7e6f78556f138b6aa619eff12dee.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:03:01AM -0400, Rik van Riel wrote:

> I think I understand the problem you are pointing out, but if
> update_load_avg() keeps the load average for the runqueue unchanged
> (because that is rate limited to once a jiffy, and has been like that
> for a while), why would calc_group_shares() result in a different
> value than what it returned the last time?
>=20
> What am I overlooking?

I'm thinking you're thinking (3):

           tg->weight * grq->avg.load_avg
  shares =3D ------------------------------
                 tg->load_avg

Where: tg->load_avg ~=3D \Sum grq->avg.load_avg


Which is the straight forward shares calculation, and purely depends on
the load averages (which haven't been changed etc..)

But what we actually do is (6):

                                    tg->weight * grq->avg.load_avg
  shares =3D --------------------------------------------------------------=
-------------
           tg->load_avg - grq->avg.load_avg + max(grq->load.weight, grq->av=
g.load_avg)

And even if tg->load_avg and grq->avg.load_avg haven't changed,
grq->load.weight most certainly has.


