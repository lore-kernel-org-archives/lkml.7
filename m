Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65236C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4142C20863
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbfIJOVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:21:24 -0400
Received: from foss.arm.com ([217.140.110.172]:36004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730779AbfIJOVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:21:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9925828;
        Tue, 10 Sep 2019 07:21:23 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10C1E3F71F;
        Tue, 10 Sep 2019 07:21:22 -0700 (PDT)
Date:   Tue, 10 Sep 2019 15:21:21 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: fix unreachable code issue with cmpxchg
Message-ID: <20190910142120.GM9720@e119886-lin.cambridge.arm.com>
References: <20190909202153.144970-1-arnd@arndb.de>
 <20190910074606.45k5m2pkztlpj4nj@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910074606.45k5m2pkztlpj4nj@willie-the-truck>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 08:46:07AM +0100, Will Deacon wrote:
> On Mon, Sep 09, 2019 at 10:21:35PM +0200, Arnd Bergmann wrote:
> > On arm64 build with clang, sometimes the __cmpxchg_mb is not inlined
> > when CONFIG_OPTIMIZE_INLINING is set.
> 
> Hmm. Given that CONFIG_OPTIMIZE_INLINING has also been shown to break
> assignment of local 'register' variables on GCC, perhaps we should just
> disable that option for arm64 (at least) since we don't have any toolchains
> that seem to like it very much! I'd certainly prefer that over playing
> whack-a-mole with __always_inline.

I assume we're referring to stuff such as the following?

https://www.spinics.net/lists/arm-kernel/msg730329.html

Are these breakages limited to the out-of-line hacks made for LL/SC
atomics, or were there other breakages elsewhere?

Now that the out-of-line hacks have gone, I wonder if this is actually
still a problem anymore. In any case isn't the right thing to do there
to add the __always_inline to functions that use the register keyword
in a function currently annotated inline?

I'm happy to look into this if there is likely to be some benefit in
turning on CONFIG_OPTIMIZE_INLINING.

Thanks,

Andrew Murray

> 
> Will
