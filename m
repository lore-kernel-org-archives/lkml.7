Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C509DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CA9214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfCKWb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:31:56 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:45922 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfCKWbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:31:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id D995329B43;
        Mon, 11 Mar 2019 18:31:50 -0400 (EDT)
Date:   Tue, 12 Mar 2019 09:31:50 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Andreas Schwab <schwab@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [m68k:master 1174/1174] arch/m68k/include/asm/string.h:72:25:
 warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7]
In-Reply-To: <CAMuHMdXztDOGWDSKyOuaQzK9WxWoDPz-AJFRVyF7PyRiM68ugg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1903120856310.282@nippy.intranet>
References: <201903042049.npxcZzps%fengguang.wu@intel.com> <CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com> <alpine.LNX.2.21.1903051154200.135@nippy.intranet> <alpine.LNX.2.21.1903051357410.135@nippy.intranet>
 <CAMuHMdUuwudbk15GUPPxL+-Gt4zhhSomk-wMAHeTOkoaDOCUAA@mail.gmail.com> <alpine.LNX.2.21.1903051948290.147@nippy.intranet> <mvmh8chzo7j.fsf@linux-m68k.org> <alpine.LNX.2.21.1903071329140.513@nippy.intranet> <CAMuHMdVzLTO-yYJJ=HqVySX6gqes9cnyspungsB5maduzNt0RA@mail.gmail.com>
 <alpine.LNX.2.21.1903080838260.595@nippy.intranet> <CAMuHMdWr-Y7mfH3gFXfK0fWpEhhdoW9VUkOEwf0nFN8kfr4zrg@mail.gmail.com> <mvmo96hvin9.fsf@linux-m68k.org> <CAMuHMdU9gke1=5PfjpJWuUbSBQ=bPQjpEVD3+t3F3tHvh9szWg@mail.gmail.com> <mvmimwpvhv0.fsf@linux-m68k.org>
 <CAMuHMdXztDOGWDSKyOuaQzK9WxWoDPz-AJFRVyF7PyRiM68ugg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019, Geert Uytterhoeven wrote:

> On Mon, Mar 11, 2019 at 11:13 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> > On M?r 11 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Mon, Mar 11, 2019 at 10:56 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> > >> On M?r 11 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >> > On Thu, Mar 7, 2019 at 10:42 PM Finn Thain <fthain@telegraphics.com.au> wrote:
> > >> >> No, the link fails because the compiler still emits some references to
> > >> >> strlen().
> > >> >
> > >> > Despite -ffreestanding?!?
> > >>
> > >> *Because* of -ffreestanding.  Without that, strlen would be recognized
> > >> and turned into __builtin_strlen.
> > >
> > > Now I'm confused: if we have a static inline or #define for strlen(),
> >
> > Do you?
> 
> I don't, but Finn's patch has, IINM.
> 

You're mixing up two separate patches there. One uses a #define and the 
other uses a forced inline function. We were discussing the former patch 
when I answered your question about __HAVE_ARCH_STRLEN (which got 
snipped).

m68k doesn't define __HAVE_ARCH_STRLEN and relies on the strlen() 
implementation in lib/string.c. The former patch doesn't alter this but 
reduces the number of callers because some call sites get optimized away. 
That's how it avoids the warning you raised.

Anyway, I don't like pre-processor kludges. So I did another experiment 
with the latter (forced inline) approach, to see if some optimizations can 
still be used with -ffreestanding.

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b875f80c..25b5bf689018 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -436,6 +436,58 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 	return p;
 }
 
+#else
+
+//__FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
+//{
+//	return __builtin_strncpy(p, q, size);
+//}
+
+__FORTIFY_INLINE char *strcat(char *p, const char *q)
+{
+	return __builtin_strcat(p, q);
+}
+
+__FORTIFY_INLINE __kernel_size_t strlen(const char *p)
+{
+	return __builtin_strlen(p);
+}
+
+__FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
+{
+	return __builtin_strncat(p, q, count);
+}
+
+__FORTIFY_INLINE void *memset(void *p, int c, __kernel_size_t size)
+{
+	return __builtin_memset(p, c, size);
+}
+
+//__FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
+//{
+//	return __builtin_memcpy(p, q, size);
+//}
+
+__FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
+{
+	return __builtin_memmove(p, q, size);
+}
+
+__FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
+{
+	return __builtin_memcmp(p, q, size);
+}
+
+__FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
+{
+	return __builtin_memchr(p, c, size);
+}
+
+__FORTIFY_INLINE char *strcpy(char *p, const char *q)
+{
+	return __builtin_strcpy(p, q);
+}
+
 #endif
 
 /**


The result of this patch really is confusing. It still suppresses the 
warning you raised:

arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' forming
offset 8 is out of the bounds [0, 7] [-Warray-bounds]
    #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
                            ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:456:3: note: in expansion of macro 'memcpy'
      memcpy(dest, src, dest_len);
      ^~~~~~

But it also causes new ones, because of __builtin_memset():

drivers/video/fbdev/core/fbcvt.c: In function 'fb_find_mode_cvt':
drivers/video/fbdev/core/fbcvt.c:312:16: warning: 'cvt.flags' may be used uninit                                                                     ialized in this function [-Wmaybe-uninitialized]
      cvt.flags |= FB_CVT_FLAG_MARGINS;
                ^~

Apparently the compiler doesn't understand that __builtin_memset() has 
the effect of initialization. Weird.

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
