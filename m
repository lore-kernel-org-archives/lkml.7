Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962C4C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB182168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569949680;
	bh=+7NPqfF0AL8UQWDtO4pLPhJnj5AiFgDnAWO65lSZPoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pMlPUYrLZAnW5Jmt33ibkuKctAVLEnACag03pVRMspq76x0JHXTLzwCbVnO/nyC2l
	 UFrvSIaaYc3G2tk1X8DJj02frbhpqhDL4s9o4VUVf79FeV69RRbmcIJLPro60ZFSzC
	 LRnUsvv/JUr+nywRm0hxKPJcF2kmgGk5ArTB3PUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfJARIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbfJARH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:07:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FB702086A;
        Tue,  1 Oct 2019 17:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569949678;
        bh=+7NPqfF0AL8UQWDtO4pLPhJnj5AiFgDnAWO65lSZPoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkZdnRG3bI+dVB+2pqePndAjg2iozbh+wyK1MCJEIt2uePTa35+wNQ1BxWCjrqNJe
         7QcoGWCoAKbO0rVskGi8AomqGXuJiFhUNkLH/e58UVpUktGYrP0Rey/SXcOJtSkGTJ
         PiSAaCZkM7j3B0+psd91J58E0kLKYWm/uvrVJrfA=
Date:   Tue, 1 Oct 2019 18:07:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
Message-ID: <20191001170753.sqmfqt7zf33jgzns@willie-the-truck>
References: <20190926214342.34608-2-vincenzo.frascino@arm.com>
 <20191001131420.y3fsydlo7pg6ykfs@willie-the-truck>
 <20191001132731.GG41399@arrakis.emea.arm.com>
 <ed7d1465-2d7b-d57c-c1b1-215af1ba7a6f@arm.com>
 <20191001142038.ptwyfbesfrz3kkoz@willie-the-truck>
 <7558914c-fc2d-d05a-ccbe-76ef451670ae@arm.com>
 <20191001144353.5rn3bkcc6eyfclh7@willie-the-truck>
 <20191001153056.GO41399@arrakis.emea.arm.com>
 <20191001164657.l2wz3ghq6icm3lim@willie-the-truck>
 <CAKwvOd=+-PEQXOZBG6rprWdOzHfcQq9ojkGo+Q28vfC4AU=Hwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=+-PEQXOZBG6rprWdOzHfcQq9ojkGo+Q28vfC4AU=Hwg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 09:59:43AM -0700, Nick Desaulniers wrote:
> On Tue, Oct 1, 2019 at 9:47 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Oct 01, 2019 at 04:30:56PM +0100, Catalin Marinas wrote:
> > > In the long run, I wouldn't mandate CROSS_COMPILE_COMPAT to always be
> > > set for the compat vDSO since with clang we could use the same compiler
> > > binary for both native and compat (with different flags). That's once we
> > > cleaned up the headers.
> >
> > But we'll still need it even with clang so that the relevant triple can be
> > passed to the --target option. The top-level Makefile already does this:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile#n544
> 
> That's not pulling the cross compiler out of a *config* (as this patch
> is proposing); rather from an env var.

CROSS_COMPILE_COMPAT is the environment variable, right? If not, then I have
my terminology mixed up.

> > so I think we should do the same thing for the compat vdso as well, which
> > would allow us to remove this complexity by requiring that
> > CROSS_COMPILE_COMPAT identifies the cross-compiler to use in exactly the
> > same way as CROSS_COMPILE does.
> >
> > Am I missing something here?
> 
> I think the second paragraph you wrote shows we're all in agreement,
> but I suspect you may be conflating *how* the toplevel Makefile knows
> we're doing a cross compile.  It doesn't read a config, this patch
> would make it so a cross compiler is specified via config, Catalin
> asked "please no," I agree with Catalin (and I suspect you do too).

Yes, I'm saying let's have an environment variable only and drop the
CONFIG stuff completely. I think this means that the environment variable
must always be specified if you want the compat vDSO, but I don't see that
as a problem.

Will
