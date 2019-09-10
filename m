Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF3AC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05D521479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568121863;
	bh=pnVHhUoA0bQkP4vAFyAiTnaV2vHizoN7pMNixvUz4Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hoP1/+pgEFWNlbSlp8AuuggC0ROBZ8Fm7WPikmeOd7sTkFghE/KOpq5AYW4XwTIcO
	 d/SCQQfW60ZCJMHis7RFUu8Na9Ci7yJ3UDSVy2TmozmCQZfMBQ+ksXtQDeO8GW3gwl
	 +VAOvBrMXYDtVJSUfK0GxdnIvMQ1ppPodh7ufgik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfIJNYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 09:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfIJNYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 09:24:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A11F2067B;
        Tue, 10 Sep 2019 13:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568121861;
        bh=pnVHhUoA0bQkP4vAFyAiTnaV2vHizoN7pMNixvUz4Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXJGMdSYwg11CHswIYBqj4ts9Z2dVSTLWmih/qgJkikZh0AkTYGXL36ue2YP1eo/3
         WlvCFhAvWd67NqgUkVLu5zZwv/MYLkiz9FQ6f8zpJDob8YMGyJD1W2ZtI1eTJPyN2i
         4J8W+Jn7BKTUvXG3S2Lqz+MxeTJ7EK20sA1gd468=
Date:   Tue, 10 Sep 2019 14:24:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] arm64: fix unreachable code issue with cmpxchg
Message-ID: <20190910132415.4j2ygxhuanihvzhx@willie-the-truck>
References: <20190909202153.144970-1-arnd@arndb.de>
 <20190910074606.45k5m2pkztlpj4nj@willie-the-truck>
 <CAK8P3a0O8bVLgMzyc9bXb8joy6CZevP4CVn5eEwEPVqAOutDEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0O8bVLgMzyc9bXb8joy6CZevP4CVn5eEwEPVqAOutDEw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 10:04:24AM +0200, Arnd Bergmann wrote:
> On Tue, Sep 10, 2019 at 9:46 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Sep 09, 2019 at 10:21:35PM +0200, Arnd Bergmann wrote:
> > > On arm64 build with clang, sometimes the __cmpxchg_mb is not inlined
> > > when CONFIG_OPTIMIZE_INLINING is set.
> >
> > Hmm. Given that CONFIG_OPTIMIZE_INLINING has also been shown to break
> > assignment of local 'register' variables on GCC, perhaps we should just
> > disable that option for arm64 (at least) since we don't have any toolchains
> > that seem to like it very much! I'd certainly prefer that over playing
> > whack-a-mole with __always_inline.
> 
> Right, but I can also see good reasons to keep going:
> 
> - In theory, CONFIG_OPTIMIZE_INLINING is the right thing to do -- the compilers
>   also make some particularly bad decisions around inlining when each inline
>   turns into an __always_inline, as has been the case in Linux for a long time.
>   I think in most cases, we get better object code with CONFIG_OPTIMIZE_INLINING
>   and in the cases where this is worse, it may be better to fix the compiler.
>   The new "asm_inline"  macro should also help with that.

Sure, in theory, but it looks like there isn't a single arm64 compiler out
there which gets it right.

> - The x86 folks have apparently whacked most of the moles already, see this
>   commit from 2008
> 
>    commit 3f9b5cc018566ad9562df0648395649aebdbc5e0
>    Author: Ingo Molnar <mingo@elte.hu>
>    Date:   Fri Jul 18 16:30:05 2008 +0200
> 
>     x86: re-enable OPTIMIZE_INLINING
> 
>     re-enable OPTIMIZE_INLINING more widely. Jeff Dike fixed the remaining
>     outstanding issue in this commit:
> 
>     | commit 4f81c5350b44bcc501ab6f8a089b16d064b4d2f6
>     | Author: Jeff Dike <jdike@addtoit.com>
>     | Date:   Mon Jul 7 13:36:56 2008 -0400
>     |
>     |     [UML] fix gcc ICEs and unresolved externs
>     [...]
>     |    This patch reintroduces unit-at-a-time for gcc >= 4.0,
> bringing back the
>     |    possibility of Uli's crash.  If that happens, we'll debug it.
> 
>     it's still default-off and thus opt-in.

This appears to be fixing an ICE, whereas the issue reported recently for
arm64 gcc was silent miscompilation of atomics in some cases. Unfortunately,
I can't seem to find the thread :/ Mark, you were on that one too, right?

> - The inlining decisions of gcc and clang are already very different, and
>    the bugs we are finding around that are much more common than
>    the difference between CONFIG_OPTIMIZE_INLINING=y/n on a
>    given compiler.

Sorry, not sure that you're getting at here.

Anyway, the second version of your patch looks fine, but I would still
prefer to go the extra mile and disable CONFIG_OPTIMIZE_INLINING altogether
given that I don't think it's a safe option to enable for us.

Will
