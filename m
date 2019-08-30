Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31DEC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1D92343A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="hG1haDmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfH3VrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:47:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35067 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbfH3VrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:47:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id t50so9580841edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XB8eO8NP40T2U/H4tlInfL8pefKAz3321c/1LuS7aE=;
        b=hG1haDmqJULbyzkEJSQQAPCI+Trmi1Dix51p208iXg9kWYFykfKT7wESNV8mosbbDM
         JC0vP8M5ByCFEmnhJWR2u5QCAwEXPYuu8NPs786DPjHAUvgL4vJtr2I0ijWB6MKiANxN
         jo9HAil2knJn7wgdw79v5ceXnYq6IMHkWtCus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XB8eO8NP40T2U/H4tlInfL8pefKAz3321c/1LuS7aE=;
        b=jQ9sF0kZMjNI8uhI7R+DN9/nQx/RG86AIgS+gF2eOOx0xegn9DPBLqopW2SE2PEf+1
         77RSu8G4OOzVU8zd6iW3GgJRjQJ+ihNpBEM3LqyoYPsojHEXkMjWYkBHS303R3Wf0tP2
         ggsf2zwzODH+nLlcRwQLOqw5fWQTofukSV+RnnpxGnfBu/8912qsSCs1+aWBMt5LJKAO
         j2VCGYXxRANNCpJPv7VOYKw6m9Bag7TkTmkW1bXDoG5wwoPwNYSgSa2eSAr9dnF1o5ix
         HRR950EadWfqUWhjQvDf65LTF+eFtJJpsBCFz1FAVaFPxzHke56h+tnx232B3ZyBLKZA
         GZqA==
X-Gm-Message-State: APjAAAX9VHAv+Dy2lKPfwe6mdxkZWvWUQ/d95OdipFhBrCxhjGQN/HaX
        ulFc+zKocIotYBwEnjTshq+hcQ==
X-Google-Smtp-Source: APXvYqy96qsf4EkzPBtni+U8/IIhhVF+sjLiIlJTi2COc9l1aTmjsz8Je0Myfn9vwy986QY+NCWv4Q==
X-Received: by 2002:a05:6402:17eb:: with SMTP id t11mr315895edy.107.1567201618326;
        Fri, 30 Aug 2019 14:46:58 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id b36sm562201edc.53.2019.08.30.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 14:46:57 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] printf: add support for printing symbolic error codes
Date:   Fri, 30 Aug 2019 23:46:55 +0200
Message-Id: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/errcode.h |  14 +++
 lib/Kconfig.debug       |   8 ++
 lib/Makefile            |   1 +
 lib/errcode.c           | 215 ++++++++++++++++++++++++++++++++++++++++
 lib/test_printf.c       |  14 +++
 lib/vsprintf.c          |  28 +++++-
 6 files changed, 278 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/errcode.h
 create mode 100644 lib/errcode.c

diff --git a/include/linux/errcode.h b/include/linux/errcode.h
new file mode 100644
index 000000000000..9dc4cfaa37ab
--- /dev/null
+++ b/include/linux/errcode.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ERRCODE_H
+#define _LINUX_ERRCODE_H
+
+#ifdef CONFIG_SYMBOLIC_ERRCODE
+const char *errcode(int code);
+#else
+static inline const char *errcode(int code)
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
index 29c02a924973..664ecf10ee2a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -185,6 +185,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
 
 obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
+obj-$(CONFIG_SYMBOLIC_ERRCODE) += errcode.o
 
 obj-$(CONFIG_NLATTR) += nlattr.o
 
diff --git a/lib/errcode.c b/lib/errcode.c
new file mode 100644
index 000000000000..7dcf97d5307f
--- /dev/null
+++ b/lib/errcode.c
@@ -0,0 +1,215 @@
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
+	/* Might as well accept both -EIO and EIO. */
+	if (err < 0)
+		err = -err;
+	if (err <= 0) /* INT_MIN or 0 */
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
index b0967cf17137..4b67fc23f3f2 100644
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
+	/* %px means the user explicitly wanted the pointer formatted as a hex value. */
+	if (*fmt == 'x')
+		return pointer_string(buf, end, ptr, spec);
+
+	/* If it's an ERR_PTR, try to print its symbolic representation. */
+	if (IS_ERR(ptr)) {
+		long err = PTR_ERR(ptr);
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
@@ -2178,8 +2204,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return flags_string(buf, end, ptr, spec, fmt);
 	case 'O':
 		return kobject_string(buf, end, ptr, spec, fmt);
-	case 'x':
-		return pointer_string(buf, end, ptr, spec);
 	}
 
 	/* default is to _not_ leak addresses, hash before printing */
-- 
2.20.1

