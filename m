Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37689C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A6A20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551908626;
	bh=ANGsouGFsJaPvozqj6cq4m68vyNh/iepzoiDqL768ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GQgDDeMZBKpSg/ai5QY4d+AlrSebztJqxyom7V1a1UsQChesLCJWCs5L7l8cqxFvQ
	 z0QD+v3kKdkoPSP3+Z759WQNSpQwaQ3isdjPBLfjTD7iOY98wLBYa7+x8sly3EA//I
	 H+znCt8MCY+Gk6nAee4IushEvA6GkAAs8RkjvVdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCFVno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:43:44 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50995 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbfCFVnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:43:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C7FD722112;
        Wed,  6 Mar 2019 16:43:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 06 Mar 2019 16:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=pY5C2BvwLhKNzDpMpFyQW07oy97QWwWMcD8aq9oxvU4=; b=WIhH4N8b
        QpXg7HmB8c7mRgr3K5V6edQUNp12uSGz4ZyEGRDtahciRyEvMlSXwI6lukXOiPv4
        LFqbieAN1aNFXqbTBGnRGzFRcaZkqcCSeXomTA2zRzd8clZW7SKRriu+d3uuwW1V
        hL2HyxMFalSzDtITJQIKYn+VShxwXzqOrSyTvf9P2shu8LVeYp1/a0x6yUM9y4xL
        sl/xHhffT9xRfcocE7dC6t2Izbp4+mmDWwJE0Ey2MYzaddQfND/Lfi7A2MStHA+8
        L8zFBKkk34syGlgDPNaTLREUshc10TrcNQabajsgLXTGrLkgczmJqF0DXQuzJTsh
        jpGLYeT4X7n/lw==
X-ME-Sender: <xms:Dj-AXDoJdrJBHtnKYifNGBWqJpwnjS4gPBBnAkVV3c9TcSiqIcpxPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepge
X-ME-Proxy: <xmx:Dj-AXHzb1Dh1yFJLvUAFoK_z33fkZbOo5-Bf4k5KZ7ULNJsDKeRrDA>
    <xmx:Dj-AXFNldWD8dfhyEjOpB2c-tZISLg0VJzGl5ZHei8A9KnZ4d3a06A>
    <xmx:Dj-AXLDBzfSiQWloHGEvj-VAFB1G70xnXbAtqhOoN8UnbOt8EI821A>
    <xmx:Dj-AXK49Qf8voNUfDKadUf87flmK3nJLPzh5slzD4iucMZf5lQ6ykg>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 28091E4240;
        Wed,  6 Mar 2019 16:43:36 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
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
Subject: [PATCH v3 5/7] lib: Use new kselftest header
Date:   Thu,  7 Mar 2019 08:42:24 +1100
Message-Id: <20190306214226.14598-6-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306214226.14598-1-tobin@kernel.org>
References: <20190306214226.14598-1-tobin@kernel.org>
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
2.20.1

