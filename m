Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAAAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFE8217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554429628;
	bh=Te1kiFSfjsbx6TQmnBwjrSwY8QFJjh4wWUe/ZUKuNWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s9LEXXRN/AWsju9PJWuwVviGGhlLyl311tld13nDTFAeNznmWTLlCNalFa4yAZSNl
	 mhqZAQxJaUJfZAZiHPZMbrfkBjkKhrdzh0goY7EVm4Fz39PuPS6j3vCf7yVLtex5Pn
	 7Ge6HtdtyZvLd3GDduhkkRGB4Z7EUIlllJWUl6do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfDECA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:00:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34887 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbfDECA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:00:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D28B24D66;
        Thu,  4 Apr 2019 22:00:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Apr 2019 22:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=F5wlZTLbeYxNvK8jDdAkPtw7SafqfSrmofrPTK/quZQ=; b=1liXXXo2
        sSNt/PiNhZt6ue+3PMt6qs7OONjY33X+ELGAB8JENgHEFagEf9kBsUoS5tLLZNFJ
        4YNP9+MxkbK5WI/KcjkofMhUUETjNAQSWXIp0iiG23FSn6Y4Mau7fAjuFFGV8/9A
        Xzq4HVIzKxfpXpG1Z7oMQ17uGGbbNNLdLLTQqgyFLnds+qoRJUuW1uTYMYaZr02n
        kagv1fJCUpTpQbcefm2c639e5MPYJ78IL7sXEcrowTZIbmilLhjg8HVgayqv3EtY
        nv1/sJpZnWXTkol6epsbwAuCG2BR3EFzQmLOAiZ0gPhWMiXDF0c0i6orNEnvQxfQ
        l84uCCXSpKVagw==
X-ME-Sender: <xms:ubamXPm91JCYPROOyrnda8H_YeGVT-4FyOltezjWY_Zzywe18tXKvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeigdehtdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudegledruddugedrkeeinecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpeef
X-ME-Proxy: <xmx:ubamXEMw6T4JwFmBcQxkmC4fbz_9skpadVgGY6zYh6zEGJTvSJkN0w>
    <xmx:ubamXO59IH6OibcvpkAs7Pw7hFIS_chi6bFFGj00yD_uhg_-jC4vSg>
    <xmx:ubamXP0oWGRGgRTIEFnU2FxfhNcJyFmSE-fLhEkOAQJVy1ycAUWWZA>
    <xmx:ubamXF87CbuZeDQy8ART-c7eVyuVWwmWMsuAHAipQdhNhmdk-EBM_Q>
Received: from eros.localdomain (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id 666DE10319;
        Thu,  4 Apr 2019 22:00:19 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] lib: Use new kselftest header
Date:   Fri,  5 Apr 2019 12:58:57 +1100
Message-Id: <20190405015859.32755-5-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405015859.32755-1-tobin@kernel.org>
References: <20190405015859.32755-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We just added a new C header file for use with test modules that are
intended to be run with kselftest.  We can reduce code duplication by
using this header.

Use new kselftest header to reduce code duplication in test_printf and
test_bitmap test modules.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/test_bitmap.c | 20 ++++----------------
 lib/test_printf.c | 23 +++++------------------
 2 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6cd7d0740005..792d90608052 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -12,6 +12,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#include "../tools/testing/selftests/kselftest_module.h"
+
 static unsigned total_tests __initdata;
 static unsigned failed_tests __initdata;
 
@@ -361,7 +363,7 @@ static void noinline __init test_mem_optimisations(void)
 	}
 }
 
-static int __init test_bitmap_init(void)
+static void __init selftest(void)
 {
 	test_zero_clear();
 	test_fill_set();
@@ -369,22 +371,8 @@ static int __init test_bitmap_init(void)
 	test_bitmap_arr32();
 	test_bitmap_parselist();
 	test_mem_optimisations();
-
-	if (failed_tests == 0)
-		pr_info("all %u tests passed\n", total_tests);
-	else
-		pr_warn("failed %u out of %u tests\n",
-			failed_tests, total_tests);
-
-	return failed_tests ? -EINVAL : 0;
 }
 
-static void __exit test_bitmap_cleanup(void)
-{
-}
-
-module_init(test_bitmap_init);
-module_exit(test_bitmap_cleanup);
-
+KSTM_MODULE_LOADERS(test_bitmap);
 MODULE_AUTHOR("david decotigny <david.decotigny@googlers.com>");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 601e8519319a..f4fcc1c43739 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -21,6 +21,8 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
 
+#include "../tools/testing/selftests/kselftest_module.h"
+
 #define BUF_SIZE 256
 #define PAD_SIZE 16
 #define FILL_CHAR '$'
@@ -590,12 +592,11 @@ test_pointer(void)
 	flags();
 }
 
-static int __init
-test_printf_init(void)
+static void __init selftest(void)
 {
 	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
 	if (!alloced_buffer)
-		return -ENOMEM;
+		return;
 	test_buffer = alloced_buffer + PAD_SIZE;
 
 	test_basic();
@@ -604,22 +605,8 @@ test_printf_init(void)
 	test_pointer();
 
 	kfree(alloced_buffer);
-
-	if (failed_tests == 0)
-		pr_info("all %u tests passed\n", total_tests);
-	else
-		pr_warn("failed %u out of %u tests\n", failed_tests, total_tests);
-
-	return failed_tests ? -EINVAL : 0;
 }
 
-module_init(test_printf_init);
-
-static void __exit test_printf_exit(void)
-{
-}
-
-module_exit(test_printf_exit);
-
+KSTM_MODULE_LOADERS(test_printf);
 MODULE_AUTHOR("Rasmus Villemoes <linux@rasmusvillemoes.dk>");
 MODULE_LICENSE("GPL");
-- 
2.21.0

