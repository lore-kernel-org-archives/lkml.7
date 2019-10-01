Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBE7C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE6E20842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbfJAPbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:31:00 -0400
Received: from foss.arm.com ([217.140.110.172]:52396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388916AbfJAPbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:31:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756F81000;
        Tue,  1 Oct 2019 08:30:59 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 728FE3F71A;
        Tue,  1 Oct 2019 08:30:58 -0700 (PDT)
Date:   Tue, 1 Oct 2019 16:30:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        tglx@linutronix.de
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
Message-ID: <20191001153056.GO41399@arrakis.emea.arm.com>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-2-vincenzo.frascino@arm.com>
 <20191001131420.y3fsydlo7pg6ykfs@willie-the-truck>
 <20191001132731.GG41399@arrakis.emea.arm.com>
 <ed7d1465-2d7b-d57c-c1b1-215af1ba7a6f@arm.com>
 <20191001142038.ptwyfbesfrz3kkoz@willie-the-truck>
 <7558914c-fc2d-d05a-ccbe-76ef451670ae@arm.com>
 <20191001144353.5rn3bkcc6eyfclh7@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001144353.5rn3bkcc6eyfclh7@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 03:43:54PM +0100, Will Deacon wrote:
> > >>>> On Thu, Sep 26, 2019 at 10:43:38PM +0100, Vincenzo Frascino wrote:
> > >>>>> +config COMPATCC_IS_ARM_GCC
> > >>>>> +	def_bool $(success,$(COMPATCC) --version | head -n 1 | grep -q "arm-.*-gcc")
[...]
> My point was that we don't attempt to sanitise the compiler passed via
> CROSS_COMPILE, so I don't think we should do anything special for COMPATCC
> either.

What I really want from kbuild with this patch is:

1. Not to warn me that I don't have a CROSS_COMPILE_COMPAT set

2. Not to give me a compilation error if the makefile made up a COMPATCC
   that doesn't work

Since we dropped the Kconfig option for the compat gcc prefix (which I
didn't like anyway), COMPATCC is now initialised to
(CROSS_COMPILE_COMPAT)gcc. This means that it is valid compiler (and
it's an aarch64 compiler on my machine). The COMPATCC_IS_ARM_GCC
silently disables the compat vDSO for this case rather than giving me a
build error if we don't have such checks.

In the long run, I wouldn't mandate CROSS_COMPILE_COMPAT to always be
set for the compat vDSO since with clang we could use the same compiler
binary for both native and compat (with different flags). That's once we
cleaned up the headers.

So, I think the best option for the time being is to check that the
compat compiler is an "arm*-gcc", otherwise disable the compat vDSO.

-- 
Catalin
