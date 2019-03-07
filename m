Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0424C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDDC2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfCGVmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:42:51 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48800 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCGVmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:42:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 8058222C02;
        Thu,  7 Mar 2019 16:42:46 -0500 (EST)
Date:   Fri, 8 Mar 2019 08:43:04 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Andreas Schwab <schwab@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [m68k:master 1174/1174] arch/m68k/include/asm/string.h:72:25:
 warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7]
In-Reply-To: <CAMuHMdVzLTO-yYJJ=HqVySX6gqes9cnyspungsB5maduzNt0RA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1903080838260.595@nippy.intranet>
References: <201903042049.npxcZzps%fengguang.wu@intel.com> <CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com> <alpine.LNX.2.21.1903051154200.135@nippy.intranet> <alpine.LNX.2.21.1903051357410.135@nippy.intranet>
 <CAMuHMdUuwudbk15GUPPxL+-Gt4zhhSomk-wMAHeTOkoaDOCUAA@mail.gmail.com> <alpine.LNX.2.21.1903051948290.147@nippy.intranet> <mvmh8chzo7j.fsf@linux-m68k.org> <alpine.LNX.2.21.1903071329140.513@nippy.intranet>
 <CAMuHMdVzLTO-yYJJ=HqVySX6gqes9cnyspungsB5maduzNt0RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019, Geert Uytterhoeven wrote:

> On Thu, Mar 7, 2019 at 3:59 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > On Tue, 5 Mar 2019, Andreas Schwab wrote:
> > > On Mar 05 2019, Finn Thain <fthain@telegraphics.com.au> wrote:
> > >
> > > > interesting that the kernel's strlen implementation in
> > > > include/linux/string.h can't achieve this.
> > >
> > > This implementation is only available if ARCH_HAS_FORTIFY_SOURCE.
> > >
> >
> > I see. Perhaps we could add another definition to that file:
> >
> > #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
> > ...
> > #else
> > __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
> > {
> >         return __builtin_strlen(p);
> > }
> > #endif
> >
> > I didn't test that.

I've tested it now, it works too. This may be a better solution than 
defining a strlen macro.

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b875f80c..ec9c0a206bd3 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -436,6 +436,13 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 	return p;
 }
 
+#else
+
+__FORTIFY_INLINE __kernel_size_t strlen(const char *p)
+{
+	return __builtin_strlen(p);
+}
+
 #endif
 
 /**

> But the following patch seems to work...
> >
> > diff --git a/arch/m68k/include/asm/string.h b/arch/m68k/include/asm/string.h
> > index f759d944c449..3cff6b128ed3 100644
> > --- a/arch/m68k/include/asm/string.h
> > +++ b/arch/m68k/include/asm/string.h
> > @@ -71,4 +71,6 @@ extern void *memset(void *, int, __kernel_size_t);
> >  extern void *memcpy(void *, const void *, __kernel_size_t);
> >  #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
> >
> > +#define strlen(s) __builtin_strlen(s)
> 
> Shouldn't you add
> 
>     #define __HAVE_ARCH_STRLEN
> 
> here...
> 

No, the link fails because the compiler still emits some references to 
strlen().

-- 

> > +
> >  #endif /* _M68K_STRING_H_ */
> > diff --git a/lib/string.c b/lib/string.c
> > index 38e4ca08e757..fe970f2160e5 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -472,6 +472,7 @@ char *strim(char *s)
> >  EXPORT_SYMBOL(strim);
> >
> >  #ifndef __HAVE_ARCH_STRLEN
> > +#undef strlen
> 
> ... so you can drop this change?
> 
> >  /**
> >   * strlen - Find the length of a string
> >   * @s: The string to be sized
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
