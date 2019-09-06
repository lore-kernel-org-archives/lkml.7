Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FCFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C32220842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567777389;
	bh=oCPboVcwffP05i6iQZQMdy+rs6Ty1lZheJJRNHQOumQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZvlRrRjdhzx4gSRoTLSjls0Jupb3cDm/hWspWpFzb3ndr9I0eP71qBRDOOgwCzAzD
	 ZKV4BZ4jEwcGJJWsDvfKap4Z3Jz8khrEtHutnVNNIdqD88aYhIfPSWdGMO9py4GiRS
	 8HFldxdC6dSFcUi7EQ8HW5Ei3WztEE6cG+mSJjIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393364AbfIFNnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbfIFNnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:43:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AFB22082C;
        Fri,  6 Sep 2019 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567777387;
        bh=oCPboVcwffP05i6iQZQMdy+rs6Ty1lZheJJRNHQOumQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddu2kyb3uipFRZElcO970RXPZdXLSSouiS+scvoCoaSsiXtIN+Fhu9PM9dqtpLE2R
         p/gqFkJMWiSICPiQX4rA7qT404Zug3oumpORGw/ttZeghuFndMKdoav3BOEt6DW2Rj
         +jp2vhgrvytTRg+fqAezdMqm0ns4/oyBslcWfdK0=
Date:   Fri, 6 Sep 2019 14:43:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v2 0/6] Rework REFCOUNT_FULL using atomic_fetch_*
 operations
Message-ID: <20190906134302.ie7wbdojkzsmrle7@willie-the-truck>
References: <20190827163204.29903-1-will@kernel.org>
 <20190828073052.GL2332@hirez.programming.kicks-ass.net>
 <20190828141439.sqnpm5ff4tgyn66r@willie-the-truck>
 <201908281353.0EFD0776@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908281353.0EFD0776@keescook>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 02:03:37PM -0700, Kees Cook wrote:
> On Wed, Aug 28, 2019 at 03:14:40PM +0100, Will Deacon wrote:
> > On Wed, Aug 28, 2019 at 09:30:52AM +0200, Peter Zijlstra wrote:
> > > On Tue, Aug 27, 2019 at 05:31:58PM +0100, Will Deacon wrote:
> > > > Will Deacon (6):
> > > >   lib/refcount: Define constants for saturation and max refcount values
> > > >   lib/refcount: Ensure integer operands are treated as signed
> > > >   lib/refcount: Remove unused refcount_*_checked() variants
> > > >   lib/refcount: Move bulk of REFCOUNT_FULL implementation into header
> > > >   lib/refcount: Improve performance of generic REFCOUNT_FULL code
> > > >   lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions
> 
> BTW, can you repeat the timing details into the "Improve performance of
> generic REFCOUNT_FULL code" patch?

Of course.

> > > So I'm not a fan; I itch at the whole racy nature of this thing and I
> > > find the code less than obvious. Yet, I have to agree it is exceedingly
> > > unlikely the race will ever actually happen, I just don't want to be the
> > > one having to debug it.
> > 
> > FWIW, I think much the same about the version under arch/x86 ;)
> > 
> > > I've not looked at the implementation much; does it do all the same
> > > checks the FULL one does? The x86-asm one misses a few iirc, so if this
> > > is similarly fast but has all the checks, it is in fact better.
> > 
> > Yes, it passes all of the REFCOUNT_* tests in lkdtm [1] so I agree that
> > it's an improvement over the asm version.
> > 
> > > Can't we make this a default !FULL implementation?
> > 
> > My concern with doing that is I think it would make the FULL implementation
> > entirely pointless. I can't see anybody using it, and it would only exist
> > as an academic exercise in handling the theoretical races. That's a change
> > from the current situation where it genuinely handles cases which the
> > x86-specific code does not and, judging by the Kconfig text, that's the
> > only reason for its existence.
> 
> Looking at timing details, the new implementation is close enough to the
> x86 asm version that I would be fine to drop the x86-specific case
> entirely as long as we could drop "FULL" entirely too -- we'd have _one_
> refcount_t implementation: it would be both complete and fast.

That works for me; I'll spin a new version of this series so you can see
what it looks like.

> However, I do think a defconfig image size comparison should be done as
> part of that too. I think this implementation will be larger than the
> x86 asm one (but not by any amount that I think is a problem).

I've managed to get it down to +0.5% when comparing an x86_64 defconfig
before these changes, to one afterwards with REFCOUNT_FULL enabled:

	Total: Before=14762076, After=14835497, chg +0.50%

Will
