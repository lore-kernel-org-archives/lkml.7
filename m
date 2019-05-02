Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917EAC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542F120652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k9zdyIbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEBRhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 13:37:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfEBRhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o99cW773qcjEmGIZO5ggLbo3P9UD9jURPgj3nCcr96Y=; b=k9zdyIbMVJi44PJ9i/cPXeqSc
        nw4sDkixiRpwwPNe9hoA+IWjtIAU27mZIRYnltuOe8kSK8yoAUZJZyjnoKowiK/ANatfxadAVio1S
        +anvLam+433Dzz7jMdOxt4nzbFg9fjKG5IWPPtXj53aGME+ZZwbenfnBuhoEVuIawYMsYhsb20DSU
        PyeZ4XG09X76b1nPUXkFBhzNnB8Tx2puxVKpjXwOjHGmat2y3Tho3MtVsvrMJiF9MgBrWL80QG+PE
        9D87Wqais8PZ+j3O7zqaxRiVXwjj6fEZPDpP7pkwxJXnQR1GmzlUhxi2Dfe4ExXNJpI976HPDmnyb
        EeA7k9vHQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMFe1-0004D2-0M; Thu, 02 May 2019 17:37:17 +0000
Date:   Thu, 2 May 2019 10:37:16 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Alloc refcount increments to fail
Message-ID: <20190502173716.GD18948@bombadil.infradead.org>
References: <20190502152621.GB18948@bombadil.infradead.org>
 <20190502154644.GV23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502154644.GV23075@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 04:46:44PM +0100, Al Viro wrote:
> On Thu, May 02, 2019 at 08:26:21AM -0700, Matthew Wilcox wrote:
> 
> > +/**
> > + * refcount_try_inc - Increment a refcount if it's below INT_MAX
> > + * @r: the refcount to increment
> > + *
> > + * Avoid the counter saturating by declining to increment the counter
> > + * if it is more than halfway to saturation.
> > + */
> > +static inline __must_check bool refcount_try_inc(refcount_t *r)
> > +{
> > +	if (refcount_read(r) < 0)
> > +		return false;
> > +	refcount_inc(r);
> > +	return true;
> > +}
> 
> So two of those in parallel with have zero protection, won't they?

We check that we're only halfway to saturation; sure we might go a
few dozen steps from INT_MAX towards UINT_MAX, but I have a hard time
believing that we'll get preempted for long enough that we'd get all
the way to UINT_MAX by unchecked increments on other CPUs/threads.
