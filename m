Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6BBC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B176B20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iByqbewt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389026AbfHAVCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:02:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHAVCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KMsX1I067RvRNUYw9CJeoatbWY3fZE8/7XDE1PlmR2w=; b=iByqbewtRsPhUGqwkOEFRueyc
        c/ljbQS9LNGQMnqHzuUVNSToD7VLmVQ+d8aI/jd6Z/TkMqgRdgqB6VGDOC/3+7KWBsukkQpWPH+IW
        XqojjWdP9qCHbFJykGd7cJHLi/x9GyTITewzQZtW9c00zQHezQBs55D7moSmpG2dZKC4a1foT/AMw
        iqf0oAyGnzMpUXIwha/L0o/6tjKVzZzc/ENN8h/JxhriPPtsO7cyBCaX74pBuZ6Sk2xkupXr28el9
        gb4fukq8iIzY3ip5ObMzpX0IHAAc8UjJLlzZmY2ACy0F0MdeqaA7FA5WlNrXPeSUgbqx/aIIeF5fX
        biVlyw5fA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htID8-0007uY-2f; Thu, 01 Aug 2019 21:02:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE5BF2029F4C9; Thu,  1 Aug 2019 23:02:03 +0200 (CEST)
Date:   Thu, 1 Aug 2019 23:02:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/5] sched/pci: Reduce psimon FIFO priority
Message-ID: <20190801210203.GA3578@hirez.programming.kicks-ass.net>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.685367413@infradead.org>
 <20190801174907.GA16554@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801174907.GA16554@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 01:49:07PM -0400, Johannes Weiner wrote:
> On Thu, Aug 01, 2019 at 01:13:49PM +0200, Peter Zijlstra wrote:
> > PSI defaults to a FIFO-99 thread, reduce this to FIFO-1.
> > 
> > FIFO-99 is the very highest priority available to SCHED_FIFO and
> > it not a suitable default; it would indicate the psi work is the
> > most important work on the machine.
> > 
> > Since Real-Time tasks will have pre-allocated memory and locked it in
> > place, Real-Time tasks do not care about PSI. All it needs is to be
> > above OTHER.
> > 
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!

> Subject should be s/pci/psi/

Yeah, already fixed that.. obviously one sees such typoes only after
sending ;-)
