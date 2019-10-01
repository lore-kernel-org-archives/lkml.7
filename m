Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D63ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6681221A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569950060;
	bh=BMjXR4T+qkoSlH2Amx5Z9s9cKJvcuI0C+ADO/cAk58g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RxUZ8sSejN4FyG2wVSGGiGVZujkN3Mw/8dROLrNDnLvtDlXcroik/qk3zjOF1nqN+
	 bQMFNJCQI+mAUPUu/loCrA8aNVV0TpBjWtCscNt0EHyDaD6ZP7xpyTLRafq5y5Q3/J
	 Oh4DfhKX6bMEz/5fJhxkfJDBSAECbSSiKAeOJjCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfJAROT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbfJAROS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:14:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF4412086A;
        Tue,  1 Oct 2019 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569950058;
        bh=BMjXR4T+qkoSlH2Amx5Z9s9cKJvcuI0C+ADO/cAk58g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asouqCp7zIPE1TNjf/pN7/BLGNttFAYePIXHMrZuxZYhn4M/UVbKW7LLoKXgDD+qm
         zEq8vYsUusPtOZlINj3C8pwNGBkgHiUHhOGncoI/YuHHVBdh0t0lb036fSiI3BUofZ
         4l+Pz/VI2abPe1Jhyhz0fyc3AezIdu87tBB1TmrA=
Date:   Tue, 1 Oct 2019 18:14:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
Message-ID: <20191001171413.2idy6t7c3bi7rb5l@willie-the-truck>
References: <20191001132731.GG41399@arrakis.emea.arm.com>
 <ed7d1465-2d7b-d57c-c1b1-215af1ba7a6f@arm.com>
 <20191001142038.ptwyfbesfrz3kkoz@willie-the-truck>
 <7558914c-fc2d-d05a-ccbe-76ef451670ae@arm.com>
 <20191001144353.5rn3bkcc6eyfclh7@willie-the-truck>
 <20191001153056.GO41399@arrakis.emea.arm.com>
 <20191001164657.l2wz3ghq6icm3lim@willie-the-truck>
 <CAKwvOd=+-PEQXOZBG6rprWdOzHfcQq9ojkGo+Q28vfC4AU=Hwg@mail.gmail.com>
 <20191001170753.sqmfqt7zf33jgzns@willie-the-truck>
 <CAKwvOdm3E=Gp1XYfs6tcNObkJXA+VwvtLZt81mQ-mbo2gtyTaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm3E=Gp1XYfs6tcNObkJXA+VwvtLZt81mQ-mbo2gtyTaw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 10:12:59AM -0700, Nick Desaulniers wrote:
> On Tue, Oct 1, 2019 at 10:08 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Oct 01, 2019 at 09:59:43AM -0700, Nick Desaulniers wrote:
> > > On Tue, Oct 1, 2019 at 9:47 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Tue, Oct 01, 2019 at 04:30:56PM +0100, Catalin Marinas wrote:
> > > > > In the long run, I wouldn't mandate CROSS_COMPILE_COMPAT to always be
> > > > > set for the compat vDSO since with clang we could use the same compiler
> > > > > binary for both native and compat (with different flags). That's once we
> > > > > cleaned up the headers.
> > > >
> > > > But we'll still need it even with clang so that the relevant triple can be
> > > > passed to the --target option. The top-level Makefile already does this:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile#n544
> > >
> > > That's not pulling the cross compiler out of a *config* (as this patch
> > > is proposing); rather from an env var.
> >
> > CROSS_COMPILE_COMPAT is the environment variable, right? If not, then I have
> > my terminology mixed up.
> 
> Ah, sorry, I'm the one misreading the patch.  I thought the commit
> message was showing what the new process would be. I see now that it's
> describing the issue pre-patch.  My mistake.

Thanks. Thought I was losing the plot for a moment there!

Will
