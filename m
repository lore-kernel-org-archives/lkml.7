Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB19CC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5542190A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AT02e/v3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfDPOMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:12:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfDPOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SMlaajdVabzXb62ujVbQAkAw8VF8uAmse8LafzeeIHo=; b=AT02e/v37WCSmJIYxvfaTtKEA
        eM0bsq3Go0weX0qDywNJaBrNbfrxSZwPwB9rbLYEyOGR6+qUNd6DDW0g4wRzH4FOvQJ8cz0CuGQyp
        NPAf7aYE7IA1InGpFP4ekpAaMnL07swQ63STPkieBvyMLELMmD1iAV37gns3ENC4tPZdqGeFG3WXo
        S/h6xOGYiMTcwmQb42a48I37vij7H2+NASte5jZuhbSrUIpLp2UXt+1cvQ/YgeBOX/zZ089UzQ10o
        KwtHy9Ke0TEehouoFEuSIwJBrTn1I88aVlHxJjwQLqMS9vu2DE9v5zwg50/xZedaMWpCbi7zGNV3K
        LyKyvGUFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGOoh-0000wn-Vh; Tue, 16 Apr 2019 14:12:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D839129B5EFA7; Tue, 16 Apr 2019 16:12:05 +0200 (CEST)
Date:   Tue, 16 Apr 2019 16:12:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 07/16] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Message-ID: <20190416141205.GK12232@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-8-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-8-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 01:22:50PM -0400, Waiman Long wrote:
> +/*
> + * The typical HZ value is either 250 or 1000. So set the minimum waiting
> + * time to 4ms in the wait queue before initiating the handoff protocol.
> + */
> +#define RWSEM_WAIT_TIMEOUT	(HZ/250)

That seems equally unfortunate. For HZ=100 that results in 0ms, and for
HZ=300 that results in 3 1/3-rd ms.

(and this is not considering Alpha,ARM and MIPS, who all have various
other 'creative' HZ values)

In general aiming for sub 10ms timing using jiffies seems 'optimistic'.
