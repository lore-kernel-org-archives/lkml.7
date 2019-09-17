Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B846C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D2A206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ffqeEeFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391707AbfIQBjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 21:39:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfIQBjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l06pF4QmTGm8Z0wtnduZp7SspwQsLR636hx0HhBVDLw=; b=ffqeEeFsO8YLn7tM6OZkJE5Uj
        H/Z2CQKX/3h/jkuMWf+ZuKZOZt72cD/jz/rLN98OY/hztym/iEzUB5lMZ8xMUBX402ofomGTN/e4X
        mNu+3rbTyhZhb3BeH7mvzVAV6LKGFdliFBjEde136NosbcgqlCMbq0DHgm9YMe57TSanjVyZSazaH
        b0bUic2v8duqXCXtQRlZ4RzQBvLT2XH/WME7e84SHf48X1eVeJm6DIfuht5DTO8hTRKZTWfK+kl+Q
        4pIT0FHE7a3g26Bq9TPvmG5fRNbP2IKgIYr0U+v6zW4ZyvyPnEBW6wcitOUZWtwtGzeullf4f2tUy
        ma3cLbB0g==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA2T3-0006tr-0y; Tue, 17 Sep 2019 01:39:45 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/microblaze: support get_user() of size 8 bytes
Message-ID: <71b1822c-c63f-4c92-ae4a-5e220714f995@infradead.org>
Date:   Mon, 16 Sep 2019 18:39:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

arch/microblaze/ is missing support for get_user() of size 8 bytes,
so add it by using __copy_from_user().

While there, also drop a lot of the code duplication.

Fixes these build errors:
   drivers/infiniband/core/uverbs_main.o: In function `ib_uverbs_write':
   drivers/infiniband/core/.tmp_gl_uverbs_main.o:(.text+0x13a4): undefined reference to `__user_bad'
   drivers/android/binder.o: In function `binder_thread_write':
   drivers/android/.tmp_gl_binder.o:(.text+0xda6c): undefined reference to `__user_bad'
   drivers/android/.tmp_gl_binder.o:(.text+0xda98): undefined reference to `__user_bad'
   drivers/android/.tmp_gl_binder.o:(.text+0xdf10): undefined reference to `__user_bad'
   drivers/android/.tmp_gl_binder.o:(.text+0xe498): undefined reference to `__user_bad'
   drivers/android/binder.o:drivers/android/.tmp_gl_binder.o:(.text+0xea78): more undefined references to `__user_bad' follow

'make allmodconfig' now builds successfully for arch/microblaze/.

Fixes: 538722ca3b76 ("microblaze: fix get_user/put_user side-effects")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven J. Magnani <steve@digidescorp.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Doug Ledford <dledford@redhat.com>
---
v4: drop code duplication (Linus).


 arch/microblaze/include/asm/uaccess.h |   42 +++++-------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

--- lnx-53.orig/arch/microblaze/include/asm/uaccess.h
+++ lnx-53/arch/microblaze/include/asm/uaccess.h
@@ -163,44 +163,15 @@ extern long __user_bad(void);
  * Returns zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
-#define get_user(x, ptr)						\
-	__get_user_check((x), (ptr), sizeof(*(ptr)))
-
-#define __get_user_check(x, ptr, size)					\
-({									\
-	unsigned long __gu_val = 0;					\
-	const typeof(*(ptr)) __user *__gu_addr = (ptr);			\
-	int __gu_err = 0;						\
-									\
-	if (access_ok(__gu_addr, size)) {			\
-		switch (size) {						\
-		case 1:							\
-			__get_user_asm("lbu", __gu_addr, __gu_val,	\
-				       __gu_err);			\
-			break;						\
-		case 2:							\
-			__get_user_asm("lhu", __gu_addr, __gu_val,	\
-				       __gu_err);			\
-			break;						\
-		case 4:							\
-			__get_user_asm("lw", __gu_addr, __gu_val,	\
-				       __gu_err);			\
-			break;						\
-		default:						\
-			__gu_err = __user_bad();			\
-			break;						\
-		}							\
-	} else {							\
-		__gu_err = -EFAULT;					\
-	}								\
-	x = (__force typeof(*(ptr)))__gu_val;				\
-	__gu_err;							\
+#define get_user(x, ptr) ({				\
+	const typeof(*(ptr)) __user *__gu_ptr = (ptr);	\
+	access_ok(__gu_ptr, sizeof(*__gu_ptr)) ?	\
+		__get_user(x, __gu_ptr) : -EFAULT;	\
 })
 
 #define __get_user(x, ptr)						\
 ({									\
 	unsigned long __gu_val = 0;					\
-	/*unsigned long __gu_ptr = (unsigned long)(ptr);*/		\
 	long __gu_err;							\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
@@ -212,6 +183,11 @@ extern long __user_bad(void);
 	case 4:								\
 		__get_user_asm("lw", (ptr), __gu_val, __gu_err);	\
 		break;							\
+	case 8:								\
+		__gu_err = __copy_from_user(&__gu_val, ptr, 8);		\
+		if (__gu_err)						\
+			__gu_err = -EFAULT;				\
+		break;							\
 	default:							\
 		/* __gu_val = 0; __gu_err = -EINVAL;*/ __gu_err = __user_bad();\
 	}								\


