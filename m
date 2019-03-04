Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D62C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594202082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfCDGrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:47:03 -0500
Received: from trent.utfs.org ([94.185.90.103]:39526 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfCDGrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:47:03 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id A47336410D;
        Mon,  4 Mar 2019 07:47:00 +0100 (CET)
Date:   Sun, 3 Mar 2019 22:47:00 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Joe Perches <joe@perches.com>
cc:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/uaccess: Remove unused __addr_ok() macro
In-Reply-To: <4c48dea49377612eb85a699de8a52ee12eef3de3.camel@perches.com>
Message-ID: <alpine.DEB.2.21.999.1903032242440.4505@trent.utfs.org>
References: <20190225191109.7671-1-bp@alien8.de>         <CAHk-=wjOtNqb98XxYks0PMdhqgNiu97_hDxqOKG8Sz3F8H=VcQ@mail.gmail.com>         <20190225194203.GI26145@zn.tnic> <4c48dea49377612eb85a699de8a52ee12eef3de3.camel@perches.com>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019, Joe Perches wrote:
> Looks like it's not used in several arches
> 
> $ git grep -w __addr_ok
> arch/arm/include/asm/uaccess.h:#define __addr_ok(addr)          ((void)(addr), 1)
> arch/csky/include/asm/uaccess.h:#define __addr_ok(addr) (access_ok(addr, 0))
> arch/openrisc/include/asm/uaccess.h:#define __addr_ok(addr) ((unsigned long) addr < get_fs())
> arch/sh/include/asm/uaccess.h:#define __addr_ok(addr) \
> arch/sh/include/asm/uaccess.h:  __ao_end >= __ao_a && __addr_ok(__ao_end); })
> arch/x86/include/asm/uaccess.h:#define __addr_ok(addr)  \

If so, would simly removing it do the trick or is there more magic 
involved? I don't have that many cross-compilers though and it's not even 
build-tested:


commit f899653c64cce05fde426d0298cd67670f8ab8e2
Author: Christian Kujau <lists@nerdbynature.de>
Date:   Sun Mar 3 22:43:09 2019 -0800

    Remove unused __addr_ok() macro.
    
     arch/arm/include/asm/uaccess.h      | 1 -
     arch/csky/include/asm/uaccess.h     | 2 --
     arch/openrisc/include/asm/uaccess.h | 3 ---
     arch/sh/include/asm/uaccess.h       | 5 +----
     arch/x86/include/asm/uaccess.h      | 2 --
     5 files changed, 1 insertion(+), 12 deletions(-)
    
    Signed-off-by: Christian Kujau <lists@nerdbynature.de>

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 42aa4a22803c..16411c76076d 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -266,7 +266,6 @@ extern int __put_user_8(void *, unsigned long long);
 #define USER_DS			KERNEL_DS
 
 #define segment_eq(a, b)		(1)
-#define __addr_ok(addr)		((void)(addr), 1)
 #define __range_ok(addr, size)	((void)(addr), 0)
 #define get_fs()		(KERNEL_DS)
 
diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
index eaa1c3403a42..c02b243fecaa 100644
--- a/arch/csky/include/asm/uaccess.h
+++ b/arch/csky/include/asm/uaccess.h
@@ -24,8 +24,6 @@ static inline int access_ok(const void *addr, unsigned long size)
 		((unsigned long)(addr + size) < limit));
 }
 
-#define __addr_ok(addr) (access_ok(addr, 0))
-
 extern int __put_user_bad(void);
 
 /*
diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index a44682c8adc3..9198371e30c2 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -55,9 +55,6 @@
  */
 #define __range_ok(addr, size) (size <= get_fs() && addr <= (get_fs()-size))
 
-/* Ensure that addr is below task's addr_limit */
-#define __addr_ok(addr) ((unsigned long) addr < get_fs())
-
 #define access_ok(addr, size)						\
 ({ 									\
 	unsigned long __ao_addr = (unsigned long)(addr);		\
diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
index 5fe751ad7582..b41f6a011474 100644
--- a/arch/sh/include/asm/uaccess.h
+++ b/arch/sh/include/asm/uaccess.h
@@ -5,9 +5,6 @@
 #include <asm/segment.h>
 #include <asm/extable.h>
 
-#define __addr_ok(addr) \
-	((unsigned long __force)(addr) < current_thread_info()->addr_limit.seg)
-
 /*
  * __access_ok: Check if address with size is OK or not.
  *
@@ -19,7 +16,7 @@
 #define __access_ok(addr, size)	({				\
 	unsigned long __ao_a = (addr), __ao_b = (size);		\
 	unsigned long __ao_end = __ao_a + __ao_b - !!__ao_b;	\
-	__ao_end >= __ao_a && __addr_ok(__ao_end); })
+	__ao_end >= __ao_a; })
 
 #define access_ok(addr, size)	\
 	(__chk_user_ptr(addr),		\
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c1334aaaa78d..d630978738dc 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -37,8 +37,6 @@ static inline void set_fs(mm_segment_t fs)
 #define segment_eq(a, b)	((a).seg == (b).seg)
 
 #define user_addr_max() (current->thread.addr_limit.seg)
-#define __addr_ok(addr) 	\
-	((unsigned long __force)(addr) < user_addr_max())
 
 /*
  * Test whether a block of memory is a valid user space address.


-- 
BOFH excuse #123:

user to computer ratio too high.
