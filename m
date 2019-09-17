Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E22C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAAE21670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Nrte7E7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404424AbfIQHAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:00:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37971 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404312AbfIQHAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:00:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so2312324ljn.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 00:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p0XkG8nd7X2PnoIhGYnIdqQ4Ifm3karptgTvNoP3BIw=;
        b=Nrte7E7aeOWTsPfoqkEWVKTFvCSe0MNIlmGiie5/2pmr5kw1c3sqTyWs92QunlYUU3
         jhjvfrxsV7jeTwVjnO/7EY8SjmFMyUUJcPePSq4XR/43rY5+VqFG+yYKGjtNBSh0pmIc
         cMQ6OGeEFeVEnPxsBHN4eMInxLZ/a965a7kR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0XkG8nd7X2PnoIhGYnIdqQ4Ifm3karptgTvNoP3BIw=;
        b=IP64QshRkmY59Pba7QON878NGvrglyYGeXXHZrFIwlfLkn2dihKxtydaTtYgJJAaWV
         FGA1ORpMy11e4MMzYUv2QWWOtSbYFPkyTJuFm7ATo8DmEbSofY85KmUmaNNnUut+tK5H
         WLUcixDRapRN8jQg2es/q5v4r19MfvjHNHTiCfT5j0dZcNybNb6TjIgPCiChEBh9aEBb
         vP6pec56B6c5z/GJ7rLcGisiU+Qu6ynv8pjUh9GJqAeqOr4lTA9MnofUGwZz2liMUOOq
         bh0/L4XMpwU6wzGsx1FL/Yaw61yzvkPhxJPIplxI8IInxyDGX6QpCSUwEFjaq5t5nBb6
         AnKw==
X-Gm-Message-State: APjAAAWk360i9ibwIcqjoNb3sLlgc6q4bu5Rgehuqx7C6I4zLl1JzAsD
        m8DHVgvBOrNEKVe1NqT8Zb7D6A==
X-Google-Smtp-Source: APXvYqwk45/n6i9bkMvGS6Ca4dpGq/VzlAWl+9BMLki3wmfwo8xUHi+TkSnT9tQXCBxiDNrPuEDiJw==
X-Received: by 2002:a2e:9241:: with SMTP id v1mr971976ljg.148.1568703608933;
        Tue, 17 Sep 2019 00:00:08 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 6sm246719lfa.24.2019.09.17.00.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 00:00:08 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        linux-doc@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v3] printf: add support for printing symbolic error codes
Date:   Tue, 17 Sep 2019 08:59:59 +0200
Message-Id: <20190917065959.5560-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909203826.22263-1-linux@rasmusvillemoes.dk>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been suggested several times to extend vsnprintf() to be able
to convert the numeric value of ENOSPC to print "ENOSPC". This is yet
another attempt. Rather than adding another %p extension, simply teach
plain %p to convert ERR_PTRs. While the primary use case is

  if (IS_ERR(foo)) {
    pr_err("Sorry, can't do that: %p\n", foo);
    return PTR_ERR(foo);
  }

it is also more helpful to get a symbolic error code (or, worst case,
a decimal number) in case an ERR_PTR is accidentally passed to some
%p<something>, rather than the (efault) that check_pointer() would
result in.

With my embedded hat on, I've made it possible to remove this.

I've tested that the #ifdeffery in errcode.c is sufficient to make
this compile on arm, arm64, mips, powerpc, s390, x86 - I'm sure the
0day bot will tell me which ones I've missed.

The symbols to include have been found by massaging the output of

  find arch include -iname 'errno*.h' | xargs grep -E 'define\s*E'

In the cases where some common aliasing exists
(e.g. EAGAIN=EWOULDBLOCK on all platforms, EDEADLOCK=EDEADLK on most),
I've moved the more popular one (in terms of 'git grep -w Efoo | wc)
to the bottom so that one takes precedence.

Acked-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

Andrew: please consider picking this up, even if we're already in the
merge window. Quite a few people have said they'd like to see
something like this, it's a debug improvement in its own right (the
"ERR_PTR accidentally passed to printf" case), the printf tests pass,
and it's much easier to start adding (and testing) users around the
tree once this is in master.

v3:
- only accept positive errno values in errcode()
- change type of err variable in pointer() from long to int
v2:
- add #include <linux/stddef.h> to errcode.h (0day)
- keep 'x' handling in switch() (Andy)
- add paragraph to Documentation/core-api/printk-formats.rst
- add ack from Uwe

 Documentation/core-api/printk-formats.rst |   8 +
 include/linux/errcode.h                   |  16 ++
 lib/Kconfig.debug                         |   8 +
 lib/Makefile                              |   1 +
 lib/errcode.c                             | 212 ++++++++++++++++++++++
 lib/test_printf.c                         |  14 ++
 lib/vsprintf.c                            |  26 +++
 7 files changed, 285 insertions(+)
 create mode 100644 include/linux/errcode.h
 create mode 100644 lib/errcode.c

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index c6224d039bcb..7d3bf3cb207b 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -66,6 +66,14 @@ might be printed instead of the unreachable information::
 	(efault) data on invalid address
 	(einval) invalid data on a valid address
 
+Error pointers, i.e. pointers for which IS_ERR() is true, are handled
+as follows: If CONFIG_SYMBOLIC_ERRCODE is set, an appropriate symbolic
+constant is printed. For example, '"%p", PTR_ERR(-ENOSPC)' results in
+"ENOSPC", while '"%p", PTR_ERR(-EWOULDBLOCK)' results in "EAGAIN"
+(since EAGAIN == EWOULDBLOCK, and the former is the most common). If
+CONFIG_SYMBOLIC_ERRCODE is not set, ERR_PTRs are printed as their
+decimal representation ("-28" and "-11" for the two examples).
+
 Plain Pointers
 --------------
 
diff --git a/include/linux/errcode.h b/include/linux/errcode.h
new file mode 100644
index 000000000000..c6a4c1b04f9c
--- /dev/null
+++ b/include/linux/errcode.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ERRCODE_H
+#define _LINUX_ERRCODE_H
+
+#include <linux/stddef.h>
+
+#ifdef CONFIG_SYMBOLIC_ERRCODE
+const char *errcode(int err);
+#else
+static inline const char *errcode(int err)
+{
+	return NULL;
+}
+#endif
+
+#endif /* _LINUX_ERRCODE_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5960e2980a8a..dc1b20872774 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -164,6 +164,14 @@ config DYNAMIC_DEBUG
 	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
 	  information.
 
+config SYMBOLIC_ERRCODE
+	bool "Support symbolic error codes in printf"
+	help
+	  If you say Y here, the kernel's printf implementation will
+	  be able to print symbolic errors such as ENOSPC instead of
+	  the number 28. It makes the kernel image slightly larger
+	  (about 3KB), but can make the kernel logs easier to read.
+
 endmenu # "printk and dmesg options"
 
 menu "Compile-time checks and compiler options"
diff --git a/lib/Makefile b/lib/Makefile
index c5892807e06f..9f14edc7ef63 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -181,6 +181,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
 
 obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
+obj-$(CONFIG_SYMBOLIC_ERRCODE) += errcode.o
 
 obj-$(CONFIG_NLATTR) += nlattr.o
 
diff --git a/lib/errcode.c b/lib/errcode.c
new file mode 100644
index 000000000000..3e519b13245e
--- /dev/null
+++ b/lib/errcode.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/build_bug.h>
+#include <linux/errno.h>
+#include <linux/errcode.h>
+#include <linux/kernel.h>
+
+/*
+ * Ensure these tables to not accidentally become gigantic if some
+ * huge errno makes it in. On most architectures, the first table will
+ * only have about 140 entries, but mips and parisc have more sparsely
+ * allocated errnos (with EHWPOISON = 257 on parisc, and EDQUOT = 1133
+ * on mips), so this wastes a bit of space on those - though we
+ * special case the EDQUOT case.
+ */
+#define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = #err
+static const char *codes_0[] = {
+	E(E2BIG),
+	E(EACCES),
+	E(EADDRINUSE),
+	E(EADDRNOTAVAIL),
+	E(EADV),
+	E(EAFNOSUPPORT),
+	E(EALREADY),
+	E(EBADE),
+	E(EBADF),
+	E(EBADFD),
+	E(EBADMSG),
+	E(EBADR),
+	E(EBADRQC),
+	E(EBADSLT),
+	E(EBFONT),
+	E(EBUSY),
+#ifdef ECANCELLED
+	E(ECANCELLED),
+#endif
+	E(ECHILD),
+	E(ECHRNG),
+	E(ECOMM),
+	E(ECONNABORTED),
+	E(ECONNRESET),
+	E(EDEADLOCK),
+	E(EDESTADDRREQ),
+	E(EDOM),
+	E(EDOTDOT),
+#ifndef CONFIG_MIPS
+	E(EDQUOT),
+#endif
+	E(EEXIST),
+	E(EFAULT),
+	E(EFBIG),
+	E(EHOSTDOWN),
+	E(EHOSTUNREACH),
+	E(EHWPOISON),
+	E(EIDRM),
+	E(EILSEQ),
+#ifdef EINIT
+	E(EINIT),
+#endif
+	E(EINPROGRESS),
+	E(EINTR),
+	E(EINVAL),
+	E(EIO),
+	E(EISCONN),
+	E(EISDIR),
+	E(EISNAM),
+	E(EKEYEXPIRED),
+	E(EKEYREJECTED),
+	E(EKEYREVOKED),
+	E(EL2HLT),
+	E(EL2NSYNC),
+	E(EL3HLT),
+	E(EL3RST),
+	E(ELIBACC),
+	E(ELIBBAD),
+	E(ELIBEXEC),
+	E(ELIBMAX),
+	E(ELIBSCN),
+	E(ELNRNG),
+	E(ELOOP),
+	E(EMEDIUMTYPE),
+	E(EMFILE),
+	E(EMLINK),
+	E(EMSGSIZE),
+	E(EMULTIHOP),
+	E(ENAMETOOLONG),
+	E(ENAVAIL),
+	E(ENETDOWN),
+	E(ENETRESET),
+	E(ENETUNREACH),
+	E(ENFILE),
+	E(ENOANO),
+	E(ENOBUFS),
+	E(ENOCSI),
+	E(ENODATA),
+	E(ENODEV),
+	E(ENOENT),
+	E(ENOEXEC),
+	E(ENOKEY),
+	E(ENOLCK),
+	E(ENOLINK),
+	E(ENOMEDIUM),
+	E(ENOMEM),
+	E(ENOMSG),
+	E(ENONET),
+	E(ENOPKG),
+	E(ENOPROTOOPT),
+	E(ENOSPC),
+	E(ENOSR),
+	E(ENOSTR),
+#ifdef ENOSYM
+	E(ENOSYM),
+#endif
+	E(ENOSYS),
+	E(ENOTBLK),
+	E(ENOTCONN),
+	E(ENOTDIR),
+	E(ENOTEMPTY),
+	E(ENOTNAM),
+	E(ENOTRECOVERABLE),
+	E(ENOTSOCK),
+	E(ENOTTY),
+	E(ENOTUNIQ),
+	E(ENXIO),
+	E(EOPNOTSUPP),
+	E(EOVERFLOW),
+	E(EOWNERDEAD),
+	E(EPERM),
+	E(EPFNOSUPPORT),
+	E(EPIPE),
+#ifdef EPROCLIM
+	E(EPROCLIM),
+#endif
+	E(EPROTO),
+	E(EPROTONOSUPPORT),
+	E(EPROTOTYPE),
+	E(ERANGE),
+	E(EREMCHG),
+#ifdef EREMDEV
+	E(EREMDEV),
+#endif
+	E(EREMOTE),
+	E(EREMOTEIO),
+#ifdef EREMOTERELEASE
+	E(EREMOTERELEASE),
+#endif
+	E(ERESTART),
+	E(ERFKILL),
+	E(EROFS),
+#ifdef ERREMOTE
+	E(ERREMOTE),
+#endif
+	E(ESHUTDOWN),
+	E(ESOCKTNOSUPPORT),
+	E(ESPIPE),
+	E(ESRCH),
+	E(ESRMNT),
+	E(ESTALE),
+	E(ESTRPIPE),
+	E(ETIME),
+	E(ETIMEDOUT),
+	E(ETOOMANYREFS),
+	E(ETXTBSY),
+	E(EUCLEAN),
+	E(EUNATCH),
+	E(EUSERS),
+	E(EXDEV),
+	E(EXFULL),
+
+	E(ECANCELED),
+	E(EAGAIN), /* EWOULDBLOCK */
+	E(ECONNREFUSED), /* EREFUSED */
+	E(EDEADLK), /* EDEADLK */
+};
+#undef E
+
+#define E(err) [err - 512 + BUILD_BUG_ON_ZERO(err < 512 || err > 550)] = #err
+static const char *codes_512[] = {
+	E(ERESTARTSYS),
+	E(ERESTARTNOINTR),
+	E(ERESTARTNOHAND),
+	E(ENOIOCTLCMD),
+	E(ERESTART_RESTARTBLOCK),
+	E(EPROBE_DEFER),
+	E(EOPENSTALE),
+	E(ENOPARAM),
+
+	E(EBADHANDLE),
+	E(ENOTSYNC),
+	E(EBADCOOKIE),
+	E(ENOTSUPP),
+	E(ETOOSMALL),
+	E(ESERVERFAULT),
+	E(EBADTYPE),
+	E(EJUKEBOX),
+	E(EIOCBQUEUED),
+	E(ERECALLCONFLICT),
+};
+#undef E
+
+const char *errcode(int err)
+{
+	if (err <= 0)
+		return NULL;
+	if (err < ARRAY_SIZE(codes_0))
+		return codes_0[err];
+	if (err >= 512 && err - 512 < ARRAY_SIZE(codes_512))
+		return codes_512[err - 512];
+	/* But why? */
+	if (IS_ENABLED(CONFIG_MIPS) && err == EDQUOT) /* 1133 */
+		return "EDQUOT";
+	return NULL;
+}
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 944eb50f3862..0401a2341245 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -212,6 +212,7 @@ test_string(void)
 #define PTR_STR "ffff0123456789ab"
 #define PTR_VAL_NO_CRNG "(____ptrval____)"
 #define ZEROS "00000000"	/* hex 32 zero bits */
+#define FFFFS "ffffffff"
 
 static int __init
 plain_format(void)
@@ -243,6 +244,7 @@ plain_format(void)
 #define PTR_STR "456789ab"
 #define PTR_VAL_NO_CRNG "(ptrval)"
 #define ZEROS ""
+#define FFFFS ""
 
 static int __init
 plain_format(void)
@@ -588,6 +590,17 @@ flags(void)
 	kfree(cmp_buffer);
 }
 
+static void __init
+errptr(void)
+{
+	test("-1234", "%p", ERR_PTR(-1234));
+	test(FFFFS "ffffffff " FFFFS "ffffff00", "%px %px", ERR_PTR(-1), ERR_PTR(-256));
+#ifdef CONFIG_SYMBOLIC_ERRCODE
+	test("EIO EINVAL ENOSPC", "%p %p %p", ERR_PTR(-EIO), ERR_PTR(-EINVAL), ERR_PTR(-ENOSPC));
+	test("EAGAIN EAGAIN", "%p %p", ERR_PTR(-EAGAIN), ERR_PTR(-EWOULDBLOCK));
+#endif
+}
+
 static void __init
 test_pointer(void)
 {
@@ -610,6 +623,7 @@ test_pointer(void)
 	bitmap();
 	netdev_features();
 	flags();
+	errptr();
 }
 
 static void __init selftest(void)
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b0967cf17137..299fce317eb3 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -21,6 +21,7 @@
 #include <linux/build_bug.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/errcode.h>
 #include <linux/module.h>	/* for KSYM_SYMBOL_LEN */
 #include <linux/types.h>
 #include <linux/string.h>
@@ -2111,6 +2112,31 @@ static noinline_for_stack
 char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	      struct printf_spec spec)
 {
+	/*
+	 * If it's an ERR_PTR, try to print its symbolic
+	 * representation, except for %px, where the user explicitly
+	 * wanted the pointer formatted as a hex value.
+	 */
+	if (IS_ERR(ptr) && *fmt != 'x') {
+		int err = PTR_ERR(ptr);
+		const char *sym = errcode(-err);
+		if (sym)
+			return string_nocheck(buf, end, sym, spec);
+		/*
+		 * Funky, somebody passed ERR_PTR(-1234) or some other
+		 * non-existing Efoo - or more likely
+		 * CONFIG_SYMBOLIC_ERRCODE=n. None of the
+		 * %p<something> extensions can make any sense of an
+		 * ERR_PTR(), and if this was just a plain %p, the
+		 * user is still better off getting the decimal
+		 * representation rather than the hash value that
+		 * ptr_to_id() would generate.
+		 */
+		spec.flags |= SIGN;
+		spec.base = 10;
+		return number(buf, end, err, spec);
+	}
+
 	switch (*fmt) {
 	case 'F':
 	case 'f':
-- 
2.20.1

