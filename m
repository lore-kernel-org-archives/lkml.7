Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5419AC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F6420867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570484136;
	bh=bH4A4T+A8pwobqJGpfZKmuyP8qE5tI5iPZzE9cWJRSQ=;
	h=Date:From:To:Subject:List-ID:From;
	b=0H4zmjfuX5dbjn2wnCppoG3GqIbmnxLCGPPEYt0quTH7eNtGlKzB2mDbZMbZ3/nZ5
	 h0j5/NBgrXn10ZMGxrJ/IiX2ffql6iXSc4jdOOWW5KSwqlyN4qGnxcO7/mB70PlRB2
	 5BygSxEtI6VQQnk4EO1iYEsRcdHV6m9lR1i0FFew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfJGVfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbfJGVfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:35:31 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCAE20835;
        Mon,  7 Oct 2019 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570484129;
        bh=bH4A4T+A8pwobqJGpfZKmuyP8qE5tI5iPZzE9cWJRSQ=;
        h=Date:From:To:Subject:From;
        b=aGBODzyv71gWQQRSnHobgRtk2+X35n1WeFvnwMMf3aO4XRnaaRWTcM9nP1orJoScH
         D6NONL+iWRwhkQrv0LhL+uyXF6eWKvAXCxD3AHHRmPV4uFMjZHXGrsRzM5tgQ9i9Kh
         qqOCRLQc+Yr0fbT2sVC/BV4Y+HLN4QHRmOy8Aqqs=
Date:   Mon, 07 Oct 2019 14:35:29 -0700
From:   akpm@linux-foundation.org
To:     mm-commits@vger.kernel.org, uwe@kleine-koenig.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com, pavel@ucw.cz,
        mike.kravetz@oracle.com, linux-kernel@vger.kernel.org,
        joe@perches.com, jani.nikula@linux.intel.com, hughd@google.com,
        corbet@lwn.net, andy.shevchenko@gmail.com, aarcange@redhat.com,
        linux@rasmusvillemoes.dk
Subject:  [to-be-updated]
 printf-add-support-for-printing-symbolic-error-codes.patch removed from -mm
 tree
Message-ID: <20191007213529.Et3zv%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.11
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The patch titled
     Subject: vsprintf: add support for printing symbolic error codes
has been removed from the -mm tree.  Its filename was
     printf-add-support-for-printing-symbolic-error-codes.patch

This patch was dropped because an updated version will be merged

------------------------------------------------------
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: vsprintf: add support for printing symbolic error codes

It has been suggested several times to extend vsnprintf() to be able to
convert the numeric value of ENOSPC to print "ENOSPC".  This is yet
another attempt.  Rather than adding another %p extension, simply teach
plain %p to convert ERR_PTRs.  While the primary use case is

  if (IS_ERR(foo)) {
    pr_err("Sorry, can't do that: %p
", foo);
    return PTR_ERR(foo);
  }

It is also more helpful to get a symbolic error code (or, worst case, a
decimal number) in case an ERR_PTR is accidentally passed to some
%p<something>, rather than the (efault) that check_pointer() would result
in.

With my embedded hat on, I've made it possible to remove this.

I've tested that the #ifdeffery in errcode.c is sufficient to make this
compile on arm, arm64, mips, powerpc, s390, x86 - I'm sure the 0day bot
will tell me which ones I've missed.

The symbols to include have been found by massaging the output of

  find arch include -iname 'errno*.h' | xargs grep -E 'define\s*E'

In the cases where some common aliasing exists (e.g.  EAGAIN=3DEWOULDBLOCK
on all platforms, EDEADLOCK=3DEDEADLK on most), I've moved the more popular
one (in terms of 'git grep -w Efoo | wc) to the bottom so that one takes
precedence.

[akpm@linux-foundation.org: fix typo in comment]
Link: http://lkml.kernel.org/r/20190917065959.5560-1-linux@rasmusvillemoes.=
dk
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/core-api/printk-formats.rst |    8=20
 include/linux/errcode.h                   |   16 +
 lib/Kconfig.debug                         |    8=20
 lib/Makefile                              |    1=20
 lib/errcode.c                             |  212 ++++++++++++++++++++
 lib/test_printf.c                         |   14 +
 lib/vsprintf.c                            |   26 ++
 7 files changed, 285 insertions(+)

--- a/Documentation/core-api/printk-formats.rst~printf-add-support-for-prin=
ting-symbolic-error-codes
+++ a/Documentation/core-api/printk-formats.rst
@@ -66,6 +66,14 @@ might be printed instead of the unreacha
 	(efault) data on invalid address
 	(einval) invalid data on a valid address
=20
+Error pointers, i.e. pointers for which IS_ERR() is true, are handled
+as follows: If CONFIG_SYMBOLIC_ERRCODE is set, an appropriate symbolic
+constant is printed. For example, '"%p", PTR_ERR(-ENOSPC)' results in
+"ENOSPC", while '"%p", PTR_ERR(-EWOULDBLOCK)' results in "EAGAIN"
+(since EAGAIN =3D=3D EWOULDBLOCK, and the former is the most common). If
+CONFIG_SYMBOLIC_ERRCODE is not set, ERR_PTRs are printed as their
+decimal representation ("-28" and "-11" for the two examples).
+
 Plain Pointers
 --------------
=20
--- /dev/null
+++ a/include/linux/errcode.h
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
--- /dev/null
+++ a/lib/errcode.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/build_bug.h>
+#include <linux/errno.h>
+#include <linux/errcode.h>
+#include <linux/kernel.h>
+
+/*
+ * Ensure these tables do not accidentally become gigantic if some
+ * huge errno makes it in. On most architectures, the first table will
+ * only have about 140 entries, but mips and parisc have more sparsely
+ * allocated errnos (with EHWPOISON =3D 257 on parisc, and EDQUOT =3D 1133
+ * on mips), so this wastes a bit of space on those - though we
+ * special case the EDQUOT case.
+ */
+#define E(err) [err + BUILD_BUG_ON_ZERO(err <=3D 0 || err > 300)] =3D #err
+static const char *codes_0[] =3D {
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
+#define E(err) [err - 512 + BUILD_BUG_ON_ZERO(err < 512 || err > 550)] =3D =
#err
+static const char *codes_512[] =3D {
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
+	if (err <=3D 0)
+		return NULL;
+	if (err < ARRAY_SIZE(codes_0))
+		return codes_0[err];
+	if (err >=3D 512 && err - 512 < ARRAY_SIZE(codes_512))
+		return codes_512[err - 512];
+	/* But why? */
+	if (IS_ENABLED(CONFIG_MIPS) && err =3D=3D EDQUOT) /* 1133 */
+		return "EDQUOT";
+	return NULL;
+}
--- a/lib/Kconfig.debug~printf-add-support-for-printing-symbolic-error-codes
+++ a/lib/Kconfig.debug
@@ -164,6 +164,14 @@ config DYNAMIC_DEBUG
 	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
 	  information.
=20
+config SYMBOLIC_ERRCODE
+	bool "Support symbolic error codes in printf"
+	help
+	  If you say Y here, the kernel's printf implementation will
+	  be able to print symbolic errors such as ENOSPC instead of
+	  the number 28. It makes the kernel image slightly larger
+	  (about 3KB), but can make the kernel logs easier to read.
+
 endmenu # "printk and dmesg options"
=20
 menu "Compile-time checks and compiler options"
--- a/lib/Makefile~printf-add-support-for-printing-symbolic-error-codes
+++ a/lib/Makefile
@@ -181,6 +181,7 @@ lib-$(CONFIG_GENERIC_BUG) +=3D bug.o
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) +=3D syscall.o
=20
 obj-$(CONFIG_DYNAMIC_DEBUG) +=3D dynamic_debug.o
+obj-$(CONFIG_SYMBOLIC_ERRCODE) +=3D errcode.o
=20
 obj-$(CONFIG_NLATTR) +=3D nlattr.o
=20
--- a/lib/test_printf.c~printf-add-support-for-printing-symbolic-error-codes
+++ a/lib/test_printf.c
@@ -212,6 +212,7 @@ test_string(void)
 #define PTR_STR "ffff0123456789ab"
 #define PTR_VAL_NO_CRNG "(____ptrval____)"
 #define ZEROS "00000000"	/* hex 32 zero bits */
+#define FFFFS "ffffffff"
=20
 static int __init
 plain_format(void)
@@ -243,6 +244,7 @@ plain_format(void)
 #define PTR_STR "456789ab"
 #define PTR_VAL_NO_CRNG "(ptrval)"
 #define ZEROS ""
+#define FFFFS ""
=20
 static int __init
 plain_format(void)
@@ -594,6 +596,17 @@ flags(void)
 }
=20
 static void __init
+errptr(void)
+{
+	test("-1234", "%p", ERR_PTR(-1234));
+	test(FFFFS "ffffffff " FFFFS "ffffff00", "%px %px", ERR_PTR(-1), ERR_PTR(=
-256));
+#ifdef CONFIG_SYMBOLIC_ERRCODE
+	test("EIO EINVAL ENOSPC", "%p %p %p", ERR_PTR(-EIO), ERR_PTR(-EINVAL), ER=
R_PTR(-ENOSPC));
+	test("EAGAIN EAGAIN", "%p %p", ERR_PTR(-EAGAIN), ERR_PTR(-EWOULDBLOCK));
+#endif
+}
+
+static void __init
 test_pointer(void)
 {
 	plain();
@@ -615,6 +628,7 @@ test_pointer(void)
 	bitmap();
 	netdev_features();
 	flags();
+	errptr();
 }
=20
 static void __init selftest(void)
--- a/lib/vsprintf.c~printf-add-support-for-printing-symbolic-error-codes
+++ a/lib/vsprintf.c
@@ -21,6 +21,7 @@
 #include <linux/build_bug.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/errcode.h>
 #include <linux/module.h>	/* for KSYM_SYMBOL_LEN */
 #include <linux/types.h>
 #include <linux/string.h>
@@ -2120,6 +2121,31 @@ static noinline_for_stack
 char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	      struct printf_spec spec)
 {
+	/*
+	 * If it's an ERR_PTR, try to print its symbolic
+	 * representation, except for %px, where the user explicitly
+	 * wanted the pointer formatted as a hex value.
+	 */
+	if (IS_ERR(ptr) && *fmt !=3D 'x') {
+		int err =3D PTR_ERR(ptr);
+		const char *sym =3D errcode(-err);
+		if (sym)
+			return string_nocheck(buf, end, sym, spec);
+		/*
+		 * Funky, somebody passed ERR_PTR(-1234) or some other
+		 * non-existing Efoo - or more likely
+		 * CONFIG_SYMBOLIC_ERRCODE=3Dn. None of the
+		 * %p<something> extensions can make any sense of an
+		 * ERR_PTR(), and if this was just a plain %p, the
+		 * user is still better off getting the decimal
+		 * representation rather than the hash value that
+		 * ptr_to_id() would generate.
+		 */
+		spec.flags |=3D SIGN;
+		spec.base =3D 10;
+		return number(buf, end, err, spec);
+	}
+
 	switch (*fmt) {
 	case 'F':
 	case 'f':
_

Patches currently in -mm which might be from linux@rasmusvillemoes.dk are


