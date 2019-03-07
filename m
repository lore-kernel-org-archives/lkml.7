Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A09A20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zZnOTmnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCGXtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:49:19 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55154 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfCGXtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fNN6eajNaTJ8SgJrVM+PEBr9uc/iJQPWs0J51MBsxeQ=; b=zZnOTmnt8jCCtjK0oroO2JFZr
        L2Hv8eLwSi2K+nfg+xSTnV7hmtoy867ijmIhE5/zOnWtc3iINHroM6qek69Eu8yOi1ud6ejLNcCuy
        ho81ETKFworqh+3YpdspGNyfiVl65InYkWr8rFDQSjaw0kZAQ+eDxJ9M5d63gHNxFdF0cSFEWROIW
        0yAbIR51rzaAsaHKvWBYtDVS623wvYt3uiKR6A5QNtEmmnSmTB3d2b9qZcvRAYXNj+7l/M2gb35Qa
        hwi7BG+dIXClTWQxq76ZC+nV8rJFbq9C+FU7gdVV2YPvv6wAKkuJhfxnwGgDcRz8R7DP070Id9x6V
        92BKPfTaA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55006)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h22l3-0000RU-2X; Thu, 07 Mar 2019 23:49:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h22ks-0005Hh-Ty; Thu, 07 Mar 2019 23:48:50 +0000
Date:   Thu, 7 Mar 2019 23:48:50 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Mikael Pettersson <mikpe@it.uu.se>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
Message-ID: <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:39:08AM -0800, Nick Desaulniers wrote:
> On Thu, Mar 7, 2019 at 1:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Passing registers containing zero as both the address (NULL pointer)
> > and data into cmpxchg_futex_value_locked() leads clang to assign
> > the same register for both inputs on ARM, which triggers a warning
> > explaining that this instruction has unpredictable behavior on ARMv5.
> >
> > /tmp/futex-7e740e.s: Assembler messages:
> > /tmp/futex-7e740e.s:12713: Warning: source register same as write-back base
> >
> > This patch was suggested by Mikael Pettersson back in 2011 (!) with gcc-4.4,
> > as Mikael wrote:
> >  "One way of fixing this is to make uaddr an input/output register, since
> >  "that prevents it from overlapping any other input or output."
> >
> > but then withdrawn as the warning was determined to be harmless, and it
> > apparently never showed up again with later gcc versions.
> >
> > Now the same problem is back when compiling with clang, and we are trying
> > to get clang to build the kernel without warnings, as gcc normally does.
> >
> > Cc: Mikael Pettersson <mikpe@it.uu.se>
> > Cc: Mikael Pettersson <mikpelinux@gmail.com>
> > Cc: Dave Martin <Dave.Martin@arm.com>
> > Link: https://lore.kernel.org/linux-arm-kernel/20009.45690.158286.161591@pilspetsen.it.uu.se/
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm/include/asm/futex.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
> > index 0a46676b4245..79790912974e 100644
> > --- a/arch/arm/include/asm/futex.h
> > +++ b/arch/arm/include/asm/futex.h
> > @@ -110,13 +110,13 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> >         preempt_disable();
> >         __ua_flags = uaccess_save_and_enable();
> >         __asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
> > -       "1:     " TUSER(ldr) "  %1, [%4]\n"
> > -       "       teq     %1, %2\n"
> > +       "1:     " TUSER(ldr) "  %1, [%2]\n"
> > +       "       teq     %1, %3\n"
> >         "       it      eq      @ explicit IT needed for the 2b label\n"
> > -       "2:     " TUSER(streq) "        %3, [%4]\n"
> > +       "2:     " TUSER(streq) "        %4, [%2]\n"
> >         __futex_atomic_ex_table("%5")
> > -       : "+r" (ret), "=&r" (val)
> > -       : "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
> > +       : "+&r" (ret), "=&r" (val), "+&r" (uaddr)
> > +       : "r" (oldval), "r" (newval), "Ir" (-EFAULT)
> >         : "cc", "memory");
> >         uaccess_restore(__ua_flags);
> 
> Underspecification of constraints to extended inline assembly is a
> common issue exposed by other compilers (and possibly but in-effect
> infrequently compiler upgrades).
> So the reordering of the constraints means the in the assembly (notes
> for other reviewers):
> %2 -> %3
> %3 -> %4
> %4 -> %2
> Yep, looks good to me, thanks for finding this old patch and resending, Arnd!

I don't see what is "underspecified" in the original constraints.
Please explain.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
