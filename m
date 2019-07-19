Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC98C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5786F2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfGSUEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 16:04:06 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:40099 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfGSUEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 16:04:05 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mnqfc-1iCLCN0wWI-00pPiL; Fri, 19 Jul 2019 22:03:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, Mark Brown <broonie@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] kasan: remove clang version check for KASAN_STACK
Date:   Fri, 19 Jul 2019 22:03:31 +0200
Message-Id: <20190719200347.2596375-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:J27HTozIf70i015ShzVyaLK+SKYj6oJakqgt/Py0qVMEmYfLKM9
 j+FkpX8855SdCqSKs2wi92QbC7o3aqLQvNgxq/xx3R4aCeH08w0VqtGpX4T4EbPISZX3OY8
 lSD+dj8qNlT3hfFZ7Ze1B3V3BzTo+QpxirpCVkZFyZHc38Mgnxb3kuu0/Nm4Jl7iwDFYLn9
 qTVJIZwC5u7uUNp+jafJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/juMIMxIzxg=:iBIGzTzUSBL3xedoNlYaaG
 r5RefbUKXEHUEznMmsDzgDixJeDDy8cqrsL8mAg3tcJcc3zh6+dXKofFk3QOuXU4WNhIDkpfA
 HCJNRAiZKQM/Mjt9Vtag9p/URnIYCexJFgDYI1A111rD2WWRZqF2CyEfmixCGkRLHJZ2f6Sly
 +VFbLt/cQWHNholtFUY2zfUJFgfgohkx0QNniwURsZyx2y5pjvYiL6NFzXG3sbcP11U6nSpya
 31MqUYh4A90SOiuyIZsyt9U8s+eMvlN8XgwjYXRwnHRXfjZIAWnBK/mr7NrDdjfkqqbmLp7OV
 tyNpGhwzjQfL9iRO6D1fD2dGRWSkTFhHisONWCazKwYNvsSD+9k7aY4QOWu/S0C+75Gks/hxY
 eAAdofAgm2J1FCmaPV7LBsQTmUDl9C/DKAMhQYIVkHvBaSQ7NhQ4vmzxDhome5y3B8AyvKrB6
 wcyYzIwUCwBFSG0QCXRdrBi81uAAf6bkO1lkLmeQjVS7qQIMNSTelqOCeFRtmda1pI76nMJR7
 +84sLsqgphb/1NyJOxpCD9Dr+BnM9MyvCob2rKhm9Eg9/N8U2WVU7FraS8mlJUI9XLBNC6Pos
 4ABN9E13YYMcPfoBnVSzuUXhBXJTb2xdUwqJqtrVMUhEb40S/exUSunDA7c+R45pd6t/m108q
 naN/0db8NEDKpWK//bMM/+x8kNKCnq0uMXTVBi/0FNrRUNzVe9GW9kyucdWlu0JUZVbkRvUj8
 +KsUe3idCPE7mg6SMPa1lCVGzx9N1L9faXM6kw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asan-stack mode still uses dangerously large kernel stacks of
tens of kilobytes in some drivers, and it does not seem that anyone
is working on the clang bug.

Turn it off for all clang versions to prevent users from
accidentally enabling it once they update to clang-9, and
to help automated build testing with clang-9.

Link: https://bugs.llvm.org/show_bug.cgi?id=38809
Fixes: 6baec880d7a5 ("kasan: turn off asan-stack for clang-8 and earlier")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: disable the feature for all clang versions, not just 9 and below.
---
 lib/Kconfig.kasan | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 4fafba1a923b..7fa97a8b5717 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -106,7 +106,6 @@ endchoice
 
 config KASAN_STACK_ENABLE
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
-	default !(CLANG_VERSION < 90000)
 	depends on KASAN
 	help
 	  The LLVM stack address sanitizer has a know problem that
@@ -115,11 +114,11 @@ config KASAN_STACK_ENABLE
 	  Disabling asan-stack makes it safe to run kernels build
 	  with clang-8 with KASAN enabled, though it loses some of
 	  the functionality.
-	  This feature is always disabled when compile-testing with clang-8
-	  or earlier to avoid cluttering the output in stack overflow
-	  warnings, but clang-8 users can still enable it for builds without
-	  CONFIG_COMPILE_TEST.  On gcc and later clang versions it is
-	  assumed to always be safe to use and enabled by default.
+	  This feature is always disabled when compile-testing with clang
+	  to avoid cluttering the output in stack overflow warnings,
+	  but clang users can still enable it for builds without
+	  CONFIG_COMPILE_TEST.	On gcc it is assumed to always be safe
+	  to use and enabled by default.
 
 config KASAN_STACK
 	int
-- 
2.20.0

