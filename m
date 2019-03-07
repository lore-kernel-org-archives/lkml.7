Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BD7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E5420854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rEJZHtLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCGSIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:08:19 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51396 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCGSIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bbL4KWYI/bioyC16biKECIQd78u2BNwuK4rNrJxv//o=; b=rEJZHtLrpeTtQncz5UdU+yU6d
        ETWl63KJxYK6Z/wRGhfovF1oAxkxgOv9XBPE1eTQ/8d2lKWjZDqce/XlpF71DD8L4kVx48beKfpU7
        EhTo8esLs0mi1zmsTVQtIQwolj4z0fHm0PdTp3SNaqfPA3K85GzGjrLCj9RfPn9eiWykLNs2OPmSj
        mViLB6lKdH8G7vqTpSkXoIK2GAsmYHTjqnaKZQdGxG+X/SKQDwV0wwTUnRtIyP/Z/6w1LY3LG/Sqm
        Obxjf0Lwl0BCxQunTUQwLi+EaJDpphwSFv1+zPeTHkTLZdKU/swywb6LDUV1VCYibbV7YmAYclT2i
        RUhqKTkCQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51646)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h1xR5-0007TG-2w; Thu, 07 Mar 2019 18:08:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h1xQy-00055n-RV; Thu, 07 Mar 2019 18:07:56 +0000
Date:   Thu, 7 Mar 2019 18:07:56 +0000
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
Message-ID: <20190307180756.z2omra6hhwobhwcc@shell.armlinux.org.uk>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <b83ed0ab05b12484a70d5f3db742a7a141718a00.camel@perches.com>
 <20190307172541.2262ccaxjk43twi4@shell.armlinux.org.uk>
 <1ad70fe88b2d22b2064c4ada53d3fb0bdacf6b66.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad70fe88b2d22b2064c4ada53d3fb0bdacf6b66.camel@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:42:40AM -0800, Joe Perches wrote:
> On Thu, 2019-03-07 at 17:25 +0000, Russell King - ARM Linux admin wrote:
> > On Thu, Mar 07, 2019 at 09:19:04AM -0800, Joe Perches wrote:
> > > On Thu, 2019-03-07 at 10:14 +0100, Arnd Bergmann wrote:
> > > > On 32-bit ARM, I got a link failure in futex_init() when building
> > > > with clang in some random configurations:
> > > > 
> > > > kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'
> > > > 
> > > > As far as I can tell, the problem is that a branch is over 16MB
> > > > apart in those configurations, but only if it branches back to
> > > > the init text.
> > > > 
> > > > Marking the futex_detect_cmpxchg() function as noinline and
> > > > not __init avoids the problem for me.
> > > 
> > > Perhaps the __init and __exit #defines should be noinline
> > > to allow discarding of the code.
> > 
> > How does that help this case?
> 
> It doesn't particularly.
> It does help any other case that might arise.

Please describe what "any other case" you are thinking of - as already
stated, your patch would have no beneficial effect for the observed
issue.

In fact, it _could_ do exactly the opposite.  Where functions can be
inlined, they may become smaller due to no need for function prologue
and epilogue, and other optimisations.  Forcing the compiler to avoid
inlining them could result in larger code, which means a higher chance
of triggering the "relocation truncated to fit" problem.

The converse is also a possibility too - it all depends on the inlining
behaviour of the compiler towards static functions, and the resulting
size of the code.

What may be right for one architecture and compiler may not be right
for another.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
