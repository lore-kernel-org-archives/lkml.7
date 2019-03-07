Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5756C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4484F2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PkYNxo1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfCGR0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:26:08 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50890 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfCGR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zmZYJ14HC3xR/N0nbcdrUP79LPl6Auw13bU4hZ9Su0w=; b=PkYNxo1QhA9NDN/9QuxfN/1/8
        fLR7f10mKtBj7ETzuIdUlecNyqVzi8zghn2weogd5tsXk4EMrZAGB+BJa9Y9glZIsSr7hhr32f1k+
        WlkKHdhteIfULj7bu5+UymR3EhgBSniOKjXDo9K1ESbRONeH7/UwZR0YQZad5zYc34LHkFQGk40VV
        MdnqOODEt68tfkm0/x7GzRHu/qgOSolkIqoXRweBe45O6zCLMgMVcXrdmG9LEXtm4wNiT6SUDjmzI
        04IwolKBOIIAsREj2RpaltdPnk+X5atN1hF0V71rbY0+rkHOlEZjcb7GAP0/8GrOFEd4abr4h4BsU
        isz0fA7+A==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54998)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h1wmD-0007HG-Kb; Thu, 07 Mar 2019 17:25:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h1wm6-00054f-3W; Thu, 07 Mar 2019 17:25:42 +0000
Date:   Thu, 7 Mar 2019 17:25:41 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Joe Perches <joe@perches.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
Message-ID: <20190307172541.2262ccaxjk43twi4@shell.armlinux.org.uk>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <b83ed0ab05b12484a70d5f3db742a7a141718a00.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b83ed0ab05b12484a70d5f3db742a7a141718a00.camel@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:19:04AM -0800, Joe Perches wrote:
> On Thu, 2019-03-07 at 10:14 +0100, Arnd Bergmann wrote:
> > On 32-bit ARM, I got a link failure in futex_init() when building
> > with clang in some random configurations:
> > 
> > kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'
> > 
> > As far as I can tell, the problem is that a branch is over 16MB
> > apart in those configurations, but only if it branches back to
> > the init text.
> > 
> > Marking the futex_detect_cmpxchg() function as noinline and
> > not __init avoids the problem for me.
> 
> Perhaps the __init and __exit #defines should be noinline
> to allow discarding of the code.

How does that help this case?  The problem is futex_detect_cmpxchg()
being placed in .init.text which is too far from .text.fixup.
Whether it is inlined or not is immaterial since both
futex_detect_cmpxchg() and its only caller futex_init() are both __init
functions.

It seems to me to be completely sane to have:

static void __init foo(...)
{
}

static int __init foo_init(...)
{
	foo();
}

and have the expectation that the compiler _can_, if it desires, inline
foo() into foo_init().

Let me re-iterate: the inlining of futex_detect_cmpxchg() into
futex_init() is not the issue here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
