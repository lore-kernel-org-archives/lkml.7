Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAB2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C3020663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfCGC7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:59:20 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33066 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfCGC7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:59:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 6250929E5B;
        Wed,  6 Mar 2019 21:59:16 -0500 (EST)
Date:   Thu, 7 Mar 2019 13:59:33 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Andreas Schwab <schwab@linux-m68k.org>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [m68k:master 1174/1174] arch/m68k/include/asm/string.h:72:25:
 warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7]
In-Reply-To: <mvmh8chzo7j.fsf@linux-m68k.org>
Message-ID: <alpine.LNX.2.21.1903071329140.513@nippy.intranet>
References: <201903042049.npxcZzps%fengguang.wu@intel.com>        <CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com>        <alpine.LNX.2.21.1903051154200.135@nippy.intranet>        <alpine.LNX.2.21.1903051357410.135@nippy.intranet>      
  <CAMuHMdUuwudbk15GUPPxL+-Gt4zhhSomk-wMAHeTOkoaDOCUAA@mail.gmail.com>        <alpine.LNX.2.21.1903051948290.147@nippy.intranet> <mvmh8chzo7j.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019, Andreas Schwab wrote:

> On Mar 05 2019, Finn Thain <fthain@telegraphics.com.au> wrote:
> 
> > interesting that the kernel's strlen implementation in 
> > include/linux/string.h can't achieve this.
> 
> This implementation is only available if ARCH_HAS_FORTIFY_SOURCE.
> 

I see. Perhaps we could add another definition to that file:

#if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
...
#else
__FORTIFY_INLINE __kernel_size_t strlen(const char *p)
{
	return __builtin_strlen(p);
}
#endif

I didn't test that. But the following patch seems to work...

diff --git a/arch/m68k/include/asm/string.h b/arch/m68k/include/asm/string.h
index f759d944c449..3cff6b128ed3 100644
--- a/arch/m68k/include/asm/string.h
+++ b/arch/m68k/include/asm/string.h
@@ -71,4 +71,6 @@ extern void *memset(void *, int, __kernel_size_t);
 extern void *memcpy(void *, const void *, __kernel_size_t);
 #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
 
+#define strlen(s) __builtin_strlen(s)
+
 #endif /* _M68K_STRING_H_ */
diff --git a/lib/string.c b/lib/string.c
index 38e4ca08e757..fe970f2160e5 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -472,6 +472,7 @@ char *strim(char *s)
 EXPORT_SYMBOL(strim);
 
 #ifndef __HAVE_ARCH_STRLEN
+#undef strlen
 /**
  * strlen - Find the length of a string
  * @s: The string to be sized

-- 

> Andreas.
> 
> 
