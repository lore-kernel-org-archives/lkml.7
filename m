Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8236ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 22:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2B52067B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 22:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfJ0WDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 18:03:43 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:54591 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726881AbfJ0WDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 18:03:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2396345DA;
        Sun, 27 Oct 2019 22:03:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: map19_775f4b485eb16
X-Filterd-Recvd-Size: 5943
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun, 27 Oct 2019 22:03:40 +0000 (UTC)
Message-ID: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
Subject: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Date:   Sun, 27 Oct 2019 15:03:34 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid macro name collisions and improve portability use a
double underscore prefix and suffix on all __attribute__ #defines.

Before this patch, 33 of 56 #defines used a form like:

	'#define __<type> __attribute__((__<attribute_name>__))'

Now all __attribute__ #defines use that form.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/linux/compiler-clang.h |  2 +-
 include/linux/compiler-gcc.h   | 10 +++++-----
 include/linux/compiler_types.h | 34 +++++++++++++++++-----------------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 333a66..26d655f 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -19,7 +19,7 @@
 /* emulate gcc's __SANITIZE_ADDRESS__ flag */
 #define __SANITIZE_ADDRESS__
 #define __no_sanitize_address \
-		__attribute__((no_sanitize("address", "hwaddress")))
+		__attribute__((__no_sanitize__("address", "hwaddress")))
 #else
 #define __no_sanitize_address
 #endif
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d7ee4c..7a2dee 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -76,7 +76,7 @@
 #define __compiletime_error(message) __attribute__((__error__(message)))
 
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
-#define __latent_entropy __attribute__((latent_entropy))
+#define __latent_entropy __attribute__((__latent_entropy__))
 #endif
 
 /*
@@ -101,8 +101,8 @@
 	} while (0)
 
 #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
-#define __randomize_layout __attribute__((randomize_layout))
-#define __no_randomize_layout __attribute__((no_randomize_layout))
+#define __randomize_layout __attribute__((__randomize_layout__))
+#define __no_randomize_layout __attribute__((__no_randomize_layout__))
 /* This anon struct can add padding, so only enable it under randstruct. */
 #define randomized_struct_fields_start	struct {
 #define randomized_struct_fields_end	} __randomize_layout;
@@ -140,7 +140,7 @@
 #endif
 
 #if __has_attribute(__no_sanitize_address__)
-#define __no_sanitize_address __attribute__((no_sanitize_address))
+#define __no_sanitize_address __attribute__((__no_sanitize_address__))
 #else
 #define __no_sanitize_address
 #endif
@@ -171,4 +171,4 @@
 #define __diag_GCC_8(s)
 #endif
 
-#define __no_fgcse __attribute__((optimize("-fno-gcse")))
+#define __no_fgcse __attribute__((__optimize__("-fno-gcse")))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 72393a..b8c2145 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -5,27 +5,27 @@
 #ifndef __ASSEMBLY__
 
 #ifdef __CHECKER__
-# define __user		__attribute__((noderef, address_space(1)))
-# define __kernel	__attribute__((address_space(0)))
-# define __safe		__attribute__((safe))
-# define __force	__attribute__((force))
-# define __nocast	__attribute__((nocast))
-# define __iomem	__attribute__((noderef, address_space(2)))
-# define __must_hold(x)	__attribute__((context(x,1,1)))
-# define __acquires(x)	__attribute__((context(x,0,1)))
-# define __releases(x)	__attribute__((context(x,1,0)))
-# define __acquire(x)	__context__(x,1)
-# define __release(x)	__context__(x,-1)
+# define __user		__attribute__((__noderef__, __address_space__(1)))
+# define __kernel	__attribute__((__address_space__(0)))
+# define __safe		__attribute__((__safe__))
+# define __force	__attribute__((__force__))
+# define __nocast	__attribute__((__nocast__))
+# define __iomem	__attribute__((__noderef__, __address_space__(2)))
+# define __must_hold(x)	__attribute__((__context__(x, 1, 1)))
+# define __acquires(x)	__attribute__((__context__(x, 0, 1)))
+# define __releases(x)	__attribute__((__context__(x, 1, 0)))
+# define __acquire(x)	__context__(x, 1)
+# define __release(x)	__context__(x, -1)
 # define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
-# define __percpu	__attribute__((noderef, address_space(3)))
-# define __rcu		__attribute__((noderef, address_space(4)))
-# define __private	__attribute__((noderef))
+# define __percpu	__attribute__((__noderef__, __address_space__(3)))
+# define __rcu		__attribute__((__noderef__, __address_space__(4)))
+# define __private	__attribute__((__noderef__))
 extern void __chk_user_ptr(const volatile void __user *);
 extern void __chk_io_ptr(const volatile void __iomem *);
 # define ACCESS_PRIVATE(p, member) (*((typeof((p)->member) __force *) &(p)->member))
 #else /* __CHECKER__ */
 # ifdef STRUCTLEAK_PLUGIN
-#  define __user __attribute__((user))
+#  define __user __attribute__((__user__))
 # else
 #  define __user
 # endif
@@ -111,9 +111,9 @@ struct ftrace_likely_data {
 #endif
 
 #if defined(CC_USING_HOTPATCH)
-#define notrace			__attribute__((hotpatch(0, 0)))
+#define notrace			__attribute__((__hotpatch__(0, 0)))
 #elif defined(CC_USING_PATCHABLE_FUNCTION_ENTRY)
-#define notrace			__attribute__((patchable_function_entry(0, 0)))
+#define notrace			__attribute__((__patchable_function_entry__(0, 0)))
 #else
 #define notrace			__attribute__((__no_instrument_function__))
 #endif


