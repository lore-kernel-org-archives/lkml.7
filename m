Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B95C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9412173E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gFk3SbTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfGAOkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:40:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35790 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfGAOkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gy9trNaeRO8Sfc06lKqxrcigtnZWNPvY30p1SECBOi4=; b=gFk3SbTw4Qj/LLUCbtp4D7iHZ
        p3+JMSb8Q7g/zMP2sfCS1xCjgopYpWimLLt2tgWcwQFlkEBIHreJgoyXWqB+JPloQlOBCqLLRydo6
        oHib19a4FcNkOw9P0b0ZP27oenx7DB1FCtk6hFpR6gWDYFx3VG62mOUjo4wqlef8qiaZ6/v/e48fB
        HlpN8H0yGuIk/mLKE6r4t9YxPHWCyoUhqOMllQJsr1uORReJBuJsG4zCtE5E9GbwWMd59caZueMm1
        tGafd3rZfc6hLj/JWbEh+Ny58tho2YXkYKSuXnfy7NFFLO5/w6efpgnlOjmu9lDpaKJH5L32TJPAr
        QKnqCPCNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhxTo-00006F-IP; Mon, 01 Jul 2019 14:40:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F23CE20A18938; Mon,  1 Jul 2019 16:40:26 +0200 (CEST)
Date:   Mon, 1 Jul 2019 16:40:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] augmented rbtree: rework the RB_DECLARE_CALLBACKS
 macro definition
Message-ID: <20190701144026.GF3463@hirez.programming.kicks-ass.net>
References: <20190629004952.6611-1-walken@google.com>
 <20190629004952.6611-3-walken@google.com>
 <20190701074630.GM3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701074630.GM3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 09:46:30AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 28, 2019 at 05:49:52PM -0700, Michel Lespinasse wrote:

> > The motivation for this change is that I want to introduce augmented rbtree
> > uses where the augmented data for the subtree is a struct instead of a scalar.

> Can't we have a helper macro that converts an old (scalar) style compute
> into a new style compute and avoid this unfortunate and error prone
> copy/pasta ?

Or add a RBEQUAL argument that does:

-		if (node->RBAUGMENTED == augmented)
+		if (RBEQUAL(&node->RBAUGMENTED, &augmented))

With a bit of foo you can even provide a default implementation that
does: *a == *b.

See GEN_UNARY_RMWcc() for how to do that.
