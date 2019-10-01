Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BA6ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8844C2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948427;
	bh=JJ7gDG/KutG+i9qf0bFYfM+IUFqtjNVsTgvgalBoxf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LrySwXPmbJudWXcWoRQmxKjf5RBNYJin25l2g+jb1LRzbfYXLP5QtAgbPXbfg+B1F
	 50CqftEYWOesQRl6/66D/LhiqUWetEv6ZJ58hymzAUgMZU/736AMw28dQHnT+Ynf6u
	 Y2k8Kyecl/Pn0K8mw/zn2NHyPYmqAxJlKL5H04Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbfJAQrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfJAQrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:47:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A536F20659;
        Tue,  1 Oct 2019 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948423;
        bh=JJ7gDG/KutG+i9qf0bFYfM+IUFqtjNVsTgvgalBoxf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+MevooD/Y954ryuPnnAl+0+Zq2uKrhxzZTbolBu/i9o/zKOEX4H36Tuu0z4eyDn/
         Y5ggKuu+7ovuOJw2z3rF9yTMrRzgSbmPal9VvuzLj/i95/F+lUfVA1Prs+gaE+EAWk
         Ei+64VscEu5RoGOeA3OeGSVNOgveAV1TdLXEBsQg=
Date:   Tue, 1 Oct 2019 17:46:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        tglx@linutronix.de
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
Message-ID: <20191001164657.l2wz3ghq6icm3lim@willie-the-truck>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-2-vincenzo.frascino@arm.com>
 <20191001131420.y3fsydlo7pg6ykfs@willie-the-truck>
 <20191001132731.GG41399@arrakis.emea.arm.com>
 <ed7d1465-2d7b-d57c-c1b1-215af1ba7a6f@arm.com>
 <20191001142038.ptwyfbesfrz3kkoz@willie-the-truck>
 <7558914c-fc2d-d05a-ccbe-76ef451670ae@arm.com>
 <20191001144353.5rn3bkcc6eyfclh7@willie-the-truck>
 <20191001153056.GO41399@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001153056.GO41399@arrakis.emea.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 04:30:56PM +0100, Catalin Marinas wrote:
> On Tue, Oct 01, 2019 at 03:43:54PM +0100, Will Deacon wrote:
> > > >>>> On Thu, Sep 26, 2019 at 10:43:38PM +0100, Vincenzo Frascino wrote:
> > > >>>>> +config COMPATCC_IS_ARM_GCC
> > > >>>>> +	def_bool $(success,$(COMPATCC) --version | head -n 1 | grep -q "arm-.*-gcc")
> [...]
> > My point was that we don't attempt to sanitise the compiler passed via
> > CROSS_COMPILE, so I don't think we should do anything special for COMPATCC
> > either.
> 
> What I really want from kbuild with this patch is:
> 
> 1. Not to warn me that I don't have a CROSS_COMPILE_COMPAT set
> 
> 2. Not to give me a compilation error if the makefile made up a COMPATCC
>    that doesn't work
> 
> Since we dropped the Kconfig option for the compat gcc prefix (which I
> didn't like anyway), COMPATCC is now initialised to
> (CROSS_COMPILE_COMPAT)gcc. This means that it is valid compiler (and
> it's an aarch64 compiler on my machine). The COMPATCC_IS_ARM_GCC
> silently disables the compat vDSO for this case rather than giving me a
> build error if we don't have such checks.
> 
> In the long run, I wouldn't mandate CROSS_COMPILE_COMPAT to always be
> set for the compat vDSO since with clang we could use the same compiler
> binary for both native and compat (with different flags). That's once we
> cleaned up the headers.

But we'll still need it even with clang so that the relevant triple can be
passed to the --target option. The top-level Makefile already does this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile#n544

so I think we should do the same thing for the compat vdso as well, which
would allow us to remove this complexity by requiring that
CROSS_COMPILE_COMPAT identifies the cross-compiler to use in exactly the
same way as CROSS_COMPILE does.

Am I missing something here?

Will
