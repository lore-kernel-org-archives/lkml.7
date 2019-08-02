Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90783C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5179F20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UqMJY8SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbfHBSz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 14:55:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37200 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfHBSz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 14:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xzoegzhg0qHrxf9KpIRr93ozLxQDGUlgHe1KoJm9dCU=; b=UqMJY8SIKzWNUEm4NsI8lws8U
        car/I4f8aKeWBM6Mlh6SHi5BMiyx+NPHF/2f7VbUMLYBZKPeZKzNOMtef2mlX5JErLtdCfsXAfPqE
        BRyIdrwwGHauLOFtbwxa/yiMB8cvRfA7RlaygMybPV6WWtP3l5y09wnp5YWSr0sDux6BsqfIRDG5V
        HJ2HZl2xjqPsfIr5eu2wSO8hJS5GfeGoIP4024hkZWjI5i008K23FbDOwG14LxTmS0nWz67KdstMa
        8QZt+SBpiIT370PqyQB9UfcmhPFm3atxsOE85GSNZThzqSm00Xm02NBKAv3o03KDXB8wmOW/eeXIr
        qJrATdCCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htchv-0005cr-I9; Fri, 02 Aug 2019 18:55:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50C5F20293161; Fri,  2 Aug 2019 20:55:14 +0200 (CEST)
Date:   Fri, 2 Aug 2019 20:55:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH 5/6] lib/refcount: Improve performance of generic
 REFCOUNT_FULL code
Message-ID: <20190802185514.GE2349@hirez.programming.kicks-ass.net>
References: <20190802101000.12958-1-will@kernel.org>
 <20190802101000.12958-6-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802101000.12958-6-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:09:59AM +0100, Will Deacon wrote:
>  static inline void refcount_add(int i, refcount_t *r)
>  {
> +	int old = atomic_fetch_add_relaxed(i, &r->refs);
> +
> +	WARN_ONCE(!old, "refcount_t: addition on 0; use-after-free.\n");
> +	if (unlikely(old <= 0 || old + i <= 0)) {
> +		refcount_set(r, REFCOUNT_SATURATED);
> +		WARN_ONCE(1, "refcount_t: saturated; leaking memory.\n");
> +	}
>  }

That will trigger both WARNs when !old.
