Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFF0ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1774821721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y694wE5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfJILf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:35:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47790 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfJILfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8Yr1FW4On0yNCPPq7f7/xwfMz7g6v57wl9cPrSdGuhk=; b=Y694wE5gb1GeRhhWJDn5psT2x
        ykm82kw/AKTVmZ5KKQ5iGq2+Jw38xGVZBlWe8/6TRZByY18TcJ4IVebGJqRsYo+hOmoOJE9wfufXr
        1vahL7gtUFccf4APavJeU5p/vpccl+mSwOQaajBd5uHseD6RZmDdnD24+rPcSrs59TAZy5vofZsqG
        8sgogZ6PLBSnRZIhxcbIVX3rWtDlIaSz8TQI0/txHb1R4K8HKxHf7UQKm0DK1ZOWVoAB7Bc4hi1Ye
        Gvgj+QIYk+R+NuBtXwKm4x2Z3Ma4R94BCAk4lYmKZAs1F8kkPE03W9cWrDWUDhMTDZoU8nD/C6ltj
        PLIEVQixw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIAFm-0001lm-5E; Wed, 09 Oct 2019 11:35:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD6FB300565;
        Wed,  9 Oct 2019 13:34:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 923D3209EC5F0; Wed,  9 Oct 2019 13:35:35 +0200 (CEST)
Date:   Wed, 9 Oct 2019 13:35:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v3 05/10] lib/refcount: Improve performance of generic
 REFCOUNT_FULL code
Message-ID: <20191009113535.GC2359@hirez.programming.kicks-ass.net>
References: <20191007154703.5574-1-will@kernel.org>
 <20191007154703.5574-6-will@kernel.org>
 <20191009092508.GH2311@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009092508.GH2311@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 11:25:08AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 07, 2019 at 04:46:58PM +0100, Will Deacon wrote:
> >  static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
> >  {
> > +	int old = atomic_fetch_sub_release(i, &r->refs);
> >  
> > +	if (old == i) {
> >  		smp_acquire__after_ctrl_dep();
> >  		return true;
> >  	}
> >  
> > +	if (unlikely(old - i < 0)) {
> > +		refcount_set(r, REFCOUNT_SATURATED);
> > +		WARN_ONCE(1, "refcount_t: underflow; use-after-free.\n");
> > +	}
> 
> I'm failing to see how this preserves REFCOUNT_SATURATED for
> non-underflow. AFAICT this should have:
> 
> 	if (unlikely(old == REFCOUNT_SATURATED || old - i < 0))

Hmm, that is not sufficient, since you can be arbitrarily far away from
it due to all the races (and add/sub really suck as a refcount
interface). The same will make fixing the cmpxchg loops like
dec_not_one() 'interesting'.

It is important though; to keep saturated, otherwise something that can
do INT_MAX+n actual increments will get freed after INT_MAX decrements
and still have n 'proper' references, *whoopsie*.

> 
> > +	return false;
> >  }
> >  
> >  /**
