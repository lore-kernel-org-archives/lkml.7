Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6E4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD422184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dfru4UH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfCTMZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:25:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50206 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfCTMZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=smgpF9UKcmBfA9N5X/DOY2q9U2CSoD48XaQLEORD2dI=; b=Dfru4UH0ntTrplb6Ke5efLEJE
        rkznrgnYBSKt6cUgqtBbkSVef9olE7JcagcMs64PgwoMsT95Sq2cdBE/axhYpDQiEYbPKGeCuFNmY
        NXZwcLn1vLAzKhx3jV0vghnWzuK0JjsVWuHMiGAXxZiIKh06a9BjatNep27D8fjIWKXmlTv/9L/ny
        HYUJ4DrWW55x4O4A6Z40e0hOSDkUpPDpkIPAFAorWgRQJ+KH+fQQlBkwJXqaJ9NPabukcFeSs4M58
        sCvSOT7kXAYLXQV89FKckicNVUg7xpI8m/TyLUYa/DN9ip2G5R2BkNxCe+ssHPcYecBYlyxDd0zFk
        Igw9mSZBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6aHU-0002cC-GI; Wed, 20 Mar 2019 12:25:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3C5923EA30BA; Wed, 20 Mar 2019 13:25:14 +0100 (CET)
Date:   Wed, 20 Mar 2019 13:25:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [RFC][PATCH 6/8] perf/x86: Clear ->event_constraint[] on put
Message-ID: <20190320122514.GF6058@hirez.programming.kicks-ass.net>
References: <20190314130113.919278615@infradead.org>
 <20190314130705.956098225@infradead.org>
 <CABPqkBReEzMKUDJVAUArwbzxtL5KTNRot2coW4MUOvy0qzgC-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBReEzMKUDJVAUArwbzxtL5KTNRot2coW4MUOvy0qzgC-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 02:50:21PM -0700, Stephane Eranian wrote:
> On Thu, Mar 14, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > The current code unconditionally clears cpuc->event_constraint[i]
> > before calling get_event_constraints(.idx=i). The only site that cares
> > is intel_get_event_constraints() where the c1 load will always be
> > NULL.
> >
> > However, always calling get_event_constraints() on all events is
> > wastefull, most times it will return the exact same result. Therefore
> > retain the logic in intel_get_event_constraints() and change the
> > generic code to only clear the constraint on put.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I thought there was caching of the constraint in case it was static
> (or unconstrained)

Yeah, I was under the same impression :-/

> to avoid walking the constraint table each time between invocations
> on the same group_sched_in() call. But the way the c1 vs. c2 logic
> is written I don't see it. In which case, this could be another opportunity.

Right, the next patch attempts this.
