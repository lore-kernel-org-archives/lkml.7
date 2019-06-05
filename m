Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0060CC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81DA2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sM7L0sYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfFENXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:23:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFENXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EBye9IQss/6e+KpbaIme182zs8H9AxKpNDEy2cQ7wwQ=; b=sM7L0sYGt9i59fciZ7LdXWou1x
        eqWvpZ+yjqcy/4dRro3oD94M1AYNcf7455Qa/CHqn109eJdyVDDOTCGl6vBpRGqGUMzOyi+CFbUSs
        3iykZt4fBE7KaaV9st7vf/f1ZckQ00VXR4zwnlJaaI4FaWW+ZPhXPpRKBLVRxJlc5aFdCTiqdwD24
        QhnkgTvVUkjaMH1e+7GQ6cVGD8gl297b3i1Z34LTjtVnIBa4kweGOnG4Go35djgw7kTZelRnULUxz
        8mWbTEMz9zWhjikjiqFKxnsBi48boBIzxVnYX4cxuN6/OXA4ovrmMSKheU2vYx42xqaxE4fh5ER4J
        m2epsw9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsL-0004qe-23; Wed, 05 Jun 2019 13:22:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A39AC20757B48; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131945.373256296@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:08:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 14/15] static_call: Simple self-test module
References: <20190605130753.327195108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/Kconfig.debug      |    8 ++++++++
 lib/Makefile           |    1 +
 lib/test_static_call.c |   41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1955,6 +1955,14 @@ config TEST_STATIC_KEYS
 
 	  If unsure, say N.
 
+config TEST_STATIC_CALL
+	tristate "Test static call"
+	depends on m
+	help
+	  Test the static call interfaces.
+
+	  If unsure, say N.
+
 config TEST_KMOD
 	tristate "kmod stress tester"
 	depends on m
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
+obj-$(CONFIG_TEST_STATIC_CALL) += test_static_call.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
--- /dev/null
+++ b/lib/test_static_call.c
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/module.h>
+#include <linux/static_call.h>
+#include <asm/bug.h>
+
+static int foo_a(int x)
+{
+	return x+1;
+}
+
+static int foo_b(int x)
+{
+	return x*2;
+}
+
+DEFINE_STATIC_CALL(foo, foo_a);
+
+static int __init test_static_call_init(void)
+{
+	WARN_ON(static_call(foo, 2) != 3);
+
+	static_call_update(foo, foo_b);
+
+	WARN_ON(static_call(foo, 2) != 4);
+
+	static_call_update(foo, foo_a);
+
+	WARN_ON(static_call(foo, 2) != 3);
+
+	return 0;
+}
+module_init(test_static_call_init);
+
+static void __exit test_static_call_exit(void)
+{
+}
+module_exit(test_static_call_exit);
+
+MODULE_AUTHOR("Peter Zijlstra <peterz@infradead.org>");
+MODULE_LICENSE("GPL");


