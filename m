Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD08C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5040821897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IiLrl/my"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfH3KqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 06:46:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfH3KqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XpOSWVv5MIjsvjdITOaF2Izy/2lODiaJy1k6aXV31Ug=; b=IiLrl/my/vL52+8b/w7HXMxLj
        UauvgCqe2GF46jO6YJVakvOuVJZrBW8h3zL5R33dV9Lmf1ac9C3UvrRCdDkJTsu4g/bfkiUoSe9Po
        GBRkni+moxsliDA3k8kRV5u/n9uJwPqB7ML1nPiPENYBfOHsVbmDuySy/XnFamODMyqALJWwLPxGk
        baiuIxSIIG1qdXNsmaFCaVXNXXhUiq1oqyTzH7ul9XYst7EubQINc8d2FyfCYQwnFEwgFHavdNetL
        UVTQOq5QqCmV9H/uRkIycTc/7bHl/YvC3RpqS+o9ipr6MhryJDnQe/LJDD36iy/906WXmXEGFUn91
        jw7/QhlmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3ePv-0003Q9-7f; Fri, 30 Aug 2019 10:46:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC354303E02;
        Fri, 30 Aug 2019 12:45:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FA3C200AB64F; Fri, 30 Aug 2019 12:46:04 +0200 (CEST)
Date:   Fri, 30 Aug 2019 12:46:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] [semaphore] Removed redundant code from semaphore's
 down family of function
Message-ID: <20190830104604.GC2369@hirez.programming.kicks-ass.net>
References: <20190826142557.GM2386@hirez.programming.kicks-ass.net>
 <20190830104011.15568-1-sst2005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830104011.15568-1-sst2005@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 04:10:10PM +0530, Satendra Singh Thakur wrote:

> > +static inline long schedule_timeout(long timeout)
> > +{
> > +	if (__builtin_constant_p(timeout) && timeout == MAX_SCHEDULE_TIMEOUT) {
> > +		schedule();
> > +		return timeout;
> > +	}
> > +
> > +	return __schedule_timeout(timeout);
> > +}

> > +	if (timeout == MAX_SCHEDULE_TIMEOUT) {
> > 		schedule();
> > -		goto out;
> Hi Mr Peter,
> I have a suggestion here:
> The condition timeout == MAX_SCHEDULE_TIMEOUT is already handled in
> schedule_timeout function

Only if it is a compile time constant; otherwise it will end up here.

> and  same conditon is handled again in __schedule_timeout.
> Currently, no other function calls __schedule_timeout except schedule_timeout.
> Therefore, it seems this condition will never become true.

Please read more careful.

