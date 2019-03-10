Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E994DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73B92084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="T+4lyfii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCJQ4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:56:46 -0400
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:60301 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbfCJQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:56:44 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 7CD4E2069B;
        Sun, 10 Mar 2019 19:56:40 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id BIIXBp1nUd-ueW40Fep;
        Sun, 10 Mar 2019 19:56:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1552237000; bh=cWwnaZifogQ8+dqQ8xaVodcgZn1rgOE4bl1WAa0IYWg=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=T+4lyfiiGbGihnCduaNXE1MclAkhS+7ZkNsLvZK4Ae+CjbfbOQR3rDh66UxdpTD2z
         hXVi4yT/fUUtQjJOPxSV6guNuNkNKDUykm1ZpdtdLphZDL9aqNbOuoW5hgAxBiIPS+
         gkhwxTz03htDUKkLLW6aptdcaL+dy8OeZ+YfTzfY=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net [2a02:6b8:0:827::1:35])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id HRSf24QCl8-uedik3uo;
        Sun, 10 Mar 2019 19:56:40 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v1 6/6] lib: scanf: add test module
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Sun, 10 Mar 2019 19:56:40 +0300
Message-ID: <155223699991.4075.11620357476898584557.stgit@buzz>
In-Reply-To: <155223448227.4075.6846910559654700796.stgit@buzz>
References: <155223448227.4075.6846910559654700796.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module is under config option CONFIG_TEST_SCANF. This is just basic cases,
complete coverage isn't that easy for such complicated function.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 lib/Kconfig.debug |    3 +
 lib/Makefile      |    1 
 lib/test_scanf.c  |  252 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+)
 create mode 100644 lib/test_scanf.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 91ed81250fb3..b50ac3c81961 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1806,6 +1806,9 @@ config TEST_STRING_HELPERS
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
 
+config TEST_SCANF
+	tristate "Test scanf() family of functions at runtime"
+
 config TEST_PRINTF
 	tristate "Test printf() family of functions at runtime"
 
diff --git a/lib/Makefile b/lib/Makefile
index 647517940b29..b1d538d7180e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
+obj-$(CONFIG_TEST_SCANF) += test_scanf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 obj-$(CONFIG_TEST_BITFIELD) += test_bitfield.o
 obj-$(CONFIG_TEST_UUID) += test_uuid.o
diff --git a/lib/test_scanf.c b/lib/test_scanf.c
new file mode 100644
index 000000000000..1a4f8f145a46
--- /dev/null
+++ b/lib/test_scanf.c
@@ -0,0 +1,252 @@
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#ifndef KERN_EOT
+#define KERN_EOT ""
+#define SCANF_MORE 0
+#endif
+
+#define TEST_ONE(str, fmt, type, type_fmt, ret, val)	\
+	do {						\
+		type _neg = (type)~(type)(val);		\
+		type _val = _neg;			\
+		int _ret = sscanf(str, fmt, &_val);	\
+		WARN(_ret != (ret), "scanf(\"%s\", \"%s\", ...) returned %d, expected %d", str, fmt, _ret, ret);	\
+		WARN(ret && _ret && _val != (type)(val), "scanf(\"%s\", \"%s\", ...) matched value " type_fmt ", expected " type_fmt, str, fmt, _val, (type)(val));	\
+		WARN(!_ret && _val != _neg, "scanf(\"%s\", \"%s\", ...) unmached value overwritten with " type_fmt, str, fmt, _val);	\
+	} while (0);
+
+#define TEST_STR(str, fmt, len, ret, val)		\
+	do {						\
+		char _val[len + 1] = {0,};		\
+		int _ret = sscanf(str, fmt, _val);	\
+		WARN(_ret != (ret), "scanf(\"%s\", \"%s\", ...) returned %d, expected %d", str, fmt, _ret, ret);	\
+		WARN(ret && _ret && strncmp(_val, val, len), "scanf(\"%s\", \"%s\", ...) matched value \"%.*s\", expected \"%.*s\"", str, fmt, len + 1, _val, len + 1, val);	\
+		WARN(!_ret && _val[0], "scanf(\"%s\", \"%s\", ...) unmached value overwritten with \"%.*s\"", str, fmt, len + 1, _val);	\
+	} while (0);
+
+#define TEST_VA(str, fmt, ret, ...)			\
+	do {						\
+		int _ret = sscanf(str, fmt, ##__VA_ARGS__);	\
+		WARN(_ret != (ret), "scanf(\"%s\", \"%s\", ...) returned %d, expected %d", str, fmt, _ret, ret);	\
+	} while (0);
+
+#define TEST_SC(str, fmt, ret, val)	TEST_ONE(str, fmt, signed char, "%d", ret, val)
+#define TEST_UC(str, fmt, ret, val)	TEST_ONE(str, fmt, unsigned char, "%u", ret, val)
+#define TEST_SS(str, fmt, ret, val)	TEST_ONE(str, fmt, short, "%d", ret, val)
+#define TEST_US(str, fmt, ret, val)	TEST_ONE(str, fmt, unsigned short, "%u", ret, val)
+#define TEST_SI(str, fmt, ret, val)	TEST_ONE(str, fmt, int, "%d", ret, val)
+#define TEST_UI(str, fmt, ret, val)	TEST_ONE(str, fmt, unsigned int, "%u", ret, val)
+#define TEST_SL(str, fmt, ret, val)	TEST_ONE(str, fmt, long, "%ld", ret, val)
+#define TEST_UL(str, fmt, ret, val)	TEST_ONE(str, fmt, unsigned long, "%lu", ret, val)
+#define TEST_SQ(str, fmt, ret, val)	TEST_ONE(str, fmt, long long, "%llu", ret, val)
+#define TEST_UQ(str, fmt, ret, val)	TEST_ONE(str, fmt, unsigned long long, "%llu", ret, val)
+
+static void __init test_base(void)
+{
+	TEST_UI("10", "%u", 1, 10);
+	TEST_SI("10", "%d", 1, 10);
+	TEST_UI("10", "%o", 1, 8);
+	TEST_UI("10", "%x", 1, 16);
+	TEST_SI("10", "%i", 1, 10);
+	TEST_SI("010", "%i", 1, 8);
+	TEST_SI("0x10", "%i", 1, 16);
+
+	TEST_UI("9a", "%u", 1, 9);
+	TEST_SI("9a", "%d", 1, 9);
+	TEST_UI("78", "%o", 1, 7);
+	TEST_UI("fg", "%x", 1, 15);
+	TEST_SI("9a", "%i", 1, 9);
+	TEST_SI("078", "%i", 1, 7);
+	TEST_SI("0xfg", "%i", 1, 15);
+
+	TEST_UI("a", "%u", 0, 0);
+	TEST_SI("a", "%d", 0, 0);
+	TEST_UI("8", "%o", 0, 0);
+	TEST_UI("g", "%x", 0, 0);
+	TEST_SI("a", "%i", 0, 0);
+}
+
+static void __init test_sign(void)
+{
+	TEST_UI("+0", "%u", 0, 0);
+	TEST_UI("-0", "%u", 0, 0);
+	TEST_UI("+1", "%u", 0, 0);
+	TEST_UI("-1", "%u", 0, 0);
+	TEST_UI("++1", "%u", 0, 0);
+	TEST_UI("--1", "%u", 0, 0);
+	TEST_UI("+-1", "%u", 0, 0);
+	TEST_UI("-+1", "%u", 0, 0);
+	TEST_UI("+", "%u", 0, 0);
+	TEST_UI("-", "%u", 0, 0);
+
+	TEST_SI("+0", "%d", 1, 0);
+	TEST_SI("-0", "%d", 1, 0);
+	TEST_SI("+1", "%d", 1, 1);
+	TEST_SI("-1", "%d", 1, -1);
+	TEST_SI("++1", "%d", 0, 0);
+	TEST_SI("--1", "%d", 0, 0);
+	TEST_SI("+-1", "%d", 0, 0);
+	TEST_SI("-+1", "%d", 0, 0);
+	TEST_SI("+", "%d", 0, 0);
+	TEST_SI("-", "%d", 0, 0);
+}
+
+static void __init test_range(void)
+{
+	TEST_UC("255", "%hhu", 1, 255);
+	TEST_US("65535", "%hu", 1, 65535);
+	TEST_UI("4294967295", "%u", 1, 4294967295);
+	TEST_UL("4294967295", "%lu", 1, 4294967295);
+#if BITS_PER_LONG == 32
+	TEST_UL("18446744073709551615", "%lu", 0, 0);
+#else
+	TEST_UL("18446744073709551615", "%lu", 1, 18446744073709551615ull);
+#endif
+	TEST_UQ("18446744073709551615", "%llu", 1, 18446744073709551615ull);
+
+
+	TEST_SC("-128", "%hhd", 1, -128);
+	TEST_SC("127", "%hhd", 1, 127);
+	TEST_SS("-32768", "%hd", 1, -32768);
+	TEST_SS("32767", "%hd", 1, 32767);
+	TEST_SI("-2147483648", "%d", 1, -2147483648);
+	TEST_SI("2147483647", "%d", 1, 2147483647);
+	TEST_SL("-2147483648", "%ld", 1, -2147483648);
+	TEST_SL("2147483647", "%ld", 1, 2147483647);
+#if BITS_PER_LONG == 32
+	TEST_SL("-9223372036854775808", "%ld", 0, 0);
+	TEST_SL("9223372036854775807", "%ld", 0, 0);
+#else
+	TEST_SL("-9223372036854775808", "%ld", 1, -9223372036854775808ull);
+	TEST_SL("9223372036854775807", "%ld", 1, 9223372036854775807ll);
+#endif
+	TEST_SQ("-9223372036854775808", "%lld", 1, -9223372036854775808ull);
+	TEST_SQ("9223372036854775807", "%lld", 1, 9223372036854775807ll);
+
+
+	TEST_UC("256", "%hhu", 0, 0);
+	TEST_US("65536", "%hu", 0, 0);
+	TEST_UI("4294967296", "%u", 0, 0);
+#if BITS_PER_LONG == 32
+	TEST_UL("4294967296", "%lu", 0, 0);
+#else
+	TEST_UL("4294967296", "%lu", 1, 4294967296);
+#endif
+	TEST_UL("18446744073709551616", "%lu", 0, 0);
+	TEST_UQ("18446744073709551616", "%llu", 0, 0);
+
+	TEST_SC("-129", "%hhd", 0, 0);
+	TEST_SC("128", "%hhd", 0, 0);
+	TEST_SS("-32769", "%hd", 0, 0);
+	TEST_SS("32768", "%hd", 0, 0);
+	TEST_SI("-2147483649", "%d", 0, 0);
+	TEST_SI("2147483648", "%d", 0, 0);
+#if BITS_PER_LONG == 32
+	TEST_SL("-2147483649", "%ld", 0, 0);
+	TEST_SL("2147483648", "%ld", 0, 0);
+#else
+	TEST_SL("-2147483649", "%ld", 1, -2147483649);
+	TEST_SL("2147483648", "%ld", 1, 2147483648);
+#endif
+	TEST_SL("-9223372036854775809", "%ld", 0, 0);
+	TEST_SL("9223372036854775808", "%ld", 0, 0);
+	TEST_SQ("-9223372036854775809", "%lld", 0, 0);
+	TEST_SQ("9223372036854775808", "%lld", 0, 0);
+}
+
+static void __init test_eot(void)
+{
+	TEST_UI("123", "%u" KERN_EOT, 1, 123);
+	TEST_UI("123 ", "%u" KERN_EOT, 1 | SCANF_MORE, 123);
+	TEST_UI("123 ", "%u " KERN_EOT, 1, 123);
+	TEST_UI("123 \t\n", "%u " KERN_EOT, 1, 123);
+	TEST_UI("123z ", "%u " KERN_EOT, 1 | SCANF_MORE, 123);
+
+	TEST_SI("1M", "%d", 1, 1);
+	TEST_SI("1M", "%d" KERN_EOT, 1 | SCANF_MORE, 1);
+
+	TEST_SI("1\n", "%d" KERN_EOT, 1 | SCANF_MORE, 1);
+	TEST_SI("1\n", "%d " KERN_EOT, 1, 1);
+}
+
+static void __init test_set(void)
+{
+	// TODO it would be nice to make field width mandatory here
+	TEST_STR("abc", "%s", 3, 1, "abc");
+
+	TEST_STR("abc", "%3s", 3, 1, "abc");
+	TEST_STR("abc", "%2s", 3, 1, "ab");
+	TEST_STR("abc", "%1s", 3, 1, "a");
+
+	TEST_STR(" a\n", "%3s", 3, 1, "a");
+
+	TEST_STR("abc", "%3c", 3, 1, "abc");
+	TEST_STR(" a\n", "%3c", 3, 1, " a\n");
+
+	TEST_STR("abc", "%[a-z]", 3, 0, "");	// no width
+
+	TEST_STR("abc", "%3[abc]", 3, 1, "abc");
+	TEST_STR("abc", "%3[^abc]", 3, 0, "");
+
+	TEST_STR("abc", "%3[xyz]", 3, 0, "");
+	TEST_STR("abc", "%3[^xyz]", 3, 1, "abc");
+
+	TEST_STR(" a", "%3[a]", 3, 0, "");
+	TEST_STR(" a", "%3[ a]", 3, 1, " a");
+
+	TEST_STR("abcd", "%5[a-c]", 5, 1, "abc");
+	TEST_STR("abc", "%3[^a-b]", 3, 0, "");
+
+	TEST_STR("bd", "%3[a-c]", 3, 1, "b");
+	TEST_STR("db", "%3[^a-c]", 3, 1, "d");
+
+	TEST_STR("q1w2e3", "%8[a-z0-9]", 8, 1, "q1w2e3");
+	TEST_STR("q1w2e3", "%8[^a-z0-9]", 8, 0, "");
+
+	TEST_STR("a-", "%3[a-b]", 3, 1, "a");
+	TEST_STR("a-", "%3[a-]", 3, 1, "a-");
+	TEST_STR("a-", "%3[^a-]", 3, 0, "");
+
+	TEST_STR("-", "%3[-]", 3, 1, "-");
+	TEST_STR("-", "%3[^-]", 3, 0, "");
+
+	TEST_STR("]ab", "%3[]]", 3, 1, "]");
+	TEST_STR("a]b", "%3[^]]", 3, 1, "a");
+
+	TEST_STR("]-abc", "%3[]-]", 3, 1, "]-");
+	TEST_STR("abc]-", "%3[^]-]", 3, 1, "abc");
+}
+
+static void __init test_va(void)
+{
+	int x, y, z;
+	char a, b, c;
+
+	TEST_VA(" 1 ", "%d%d", 1, &x, &y);
+	TEST_VA(" 1 2 ", "%d%d", 2, &x, &y);
+	TEST_VA(" 1 2 3 ", "%d%d%d", 3, &x, &y, &z);
+	TEST_VA(" 1 2 3 ", "%d%d", 2, &x, &y);
+
+	TEST_VA(" 1x 2 ", "%d%d", 1, &x, &y);
+
+	TEST_VA("1", "%d%c", 1, &x, &a);
+	TEST_VA("1 ", "%d%c", 2, &x, &a);
+	TEST_VA("1 ", "%d %c", 1, &x, &a);
+
+	TEST_VA(" \t\n", "%c%c%c", 3, &a, &b, &c);
+}
+
+static int __init test_scanf_init(void)
+{
+	test_base();
+	test_sign();
+	test_range();
+	test_eot();
+	test_set();
+	test_va();
+	return -EINVAL;
+}
+module_init(test_scanf_init);
+MODULE_LICENSE("GPL");

