Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8BBC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B07F2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565364875;
	bh=tcXpi4UbUgiEGL0mjU1zBAFwbIaCq0tPKBnKGqNELqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ti4PwVJWZpaMQGeZw5teCAb84YWKR3ZD7AqHOKaNcANT86oYR4z+wYFXWiJ3CT4Nn
	 vSxHCEZgDRS95VladQXlT2qvqojK0psI20EG+5hOj+6fZzihDvoLNAguywbhkYRm9f
	 uXwmc8xwbmSGtXZ71I8rH1m0qVU3K4zAkd38dk1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407394AbfHIPed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406607AbfHIPed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:34:33 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 130B92086A;
        Fri,  9 Aug 2019 15:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565364872;
        bh=tcXpi4UbUgiEGL0mjU1zBAFwbIaCq0tPKBnKGqNELqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XH6h+fPf/SxjoWX4E4TDbk5HDaPGb7t70USLcbyctO9JehJEtv6O5xbVG+gH7vyzP
         CIlXdqhsDEJXRwvdiBvgYDRkzs5j5pNn0OJ5Xa6DOHqg+ApPh+socxsT9Kom3gQxao
         i7i9poYVvnajEvD1UvueErs0lllYYVeqJ7+FOYpo=
Date:   Fri, 9 Aug 2019 16:34:28 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH 0/6] Rework REFCOUNT_FULL using atomic_fetch_* operations
Message-ID: <20190809153427.7dsds3u5j2gegp7z@willie-the-truck>
References: <20190802101000.12958-1-will@kernel.org>
 <20190802184947.GC2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802184947.GC2349@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:49:47PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 02, 2019 at 11:09:54AM +0100, Will Deacon wrote:
> 
> > Although the revised implementation passes all of the lkdtm REFCOUNT
> > tests, there is a race condition introduced by the deferred saturation
> > whereby if INT_MIN + 2 tasks take a reference on a refcount at
> > REFCOUNT_MAX and are each preempted between detecting overflow and
> > writing the saturated value without being rescheduled, then another task
> > may end up erroneously freeing the object when it drops the refcount and
> > sees zero. It doesn't feel like a particularly realistic case to me, but
> > I thought I should mention it in case somebody else knows better.
> 
> So my OCD has always found that hole objectionable. Also I suppose the
> cmpxchg ones are simpler to understand.
> 
> Maybe make this fancy stuff depend on !FULL ?

Hmm.

Right now, arm64 selects REFCOUNT_FULL, since I think it's important for
us to have this hardening enabled given the sorts of places we find
ourselves deployed. If the race above is a viable attack vector, then I'd
stick with the status quo, however Kees previously wrote this off as
"unrealistic":

https://lkml.kernel.org/r/CAGXu5jLXFA4=X5mC9ph9dZ0ZJaVkGXd2p1Vh8jH_EE15kVL6Hw@mail.gmail.com

and I'm inclined to agree with him given the conditions involved.

My understanding is that the current !FULL implementation (x86 only)
simply doesn't detect certain cases such as increment-from-zero, which
I think is different from being exposed to a theoretical race condition
involving billions of tasks each preempting each other one-by-one within
a handful of instructions. Even then, we'll still WARN!

Will
