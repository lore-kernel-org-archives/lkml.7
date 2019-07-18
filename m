Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056C4C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D179E21783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390559AbfGROP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:15:28 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:54615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfGROP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:15:28 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mgw7n-1iMazi13u9-00hP63; Thu, 18 Jul 2019 16:15:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] kasan: push back KASAN_STACK detection to clang-10
Date:   Thu, 18 Jul 2019 16:14:48 +0200
Message-Id: <20190718141503.3258299-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7d7aH5pzgsLc0NYtyZMhGVmPmogcfXriE2+VCWn+jhEselAYSLW
 z2O23ERO6FuNvsUNlGpP3CEjlXH+EQbVEzkmSZwSLgp12ZXVBBvzus7hMQ77cAd0y7y5JTT
 SgfeGviIgrgv8tP58tKUYTziY06HOkMEhfAP8ySM9VlrSTzQYOCwyuXW6Swcz42Wb+cS12A
 PN2bNXEknc0CMqdZa/lsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:78tSFT/0HXw=:PkZ5nkOT4Y7P17Q0AWm6AJ
 VzXKRJ+MNUAhZhrBRWhrg1TwyPvK51VDmYsMtf/UeTg61+KyJu1FRJN7DkPFPWk31Ucbt0/Po
 DUE1ePuCLUGNIWpCy7m3PnDGzsv/t4UGvGckbwSOCEEWxRPAc/TLCSedC9rCGtIe2+DbCKjJ2
 5RSx1hCfLtbu3jJvFDNZwqC2sKqXACTyWvk2VyegaOPypD+3L3Kv4UdtUM7iD5zFrJVEbmsyE
 IbDT5AACjHmlDPrftCYZ10yE0ZwuGJJaAryoNBVmav6/+VAgP+OasifKpoWkDi2/m8/HDzOZE
 Ydv8zf6oRT8ZHZWCnmZtBK7nb1GoHteJz5E9O9zlwLW7hcLZX1+ZXn33kWKU9RV7jwhtBtt34
 stlQRD2YCn1iUdXwfW6GfLXQtJTShPnsRZJg++lZGcDRnQdugFsxCkZggDL5rTqQ6IWWa9XtG
 JJEIgJV86pJt11/2EdrQ43A3ddPrgo2YnhFOWwowWzo2wIkZycPAztQS5ks2UMkM/xTMnpJt9
 bg5ArQaa6vUgeATrAaa+Nq3GHSdSI5ZzznvMUk2ygolEVmbasHbhlTcW8aY7n8oeJsnbZT23m
 JafGDoiWefGU7ryH4TxgiEP0WR2CTeMzgrsQrEwz0YXUOn3cKAE59ni1sZI5oGQRqRk8MlglE
 fv2pDVpHvjJKK3WucUFX8mbpwntAEpg2MqhrUAhReDONDwPJ2Ze310492rDUUMAVj9vk8JBct
 M2B46iPZV9SEI8SCNu/OD4u9KGMgU543H/I5qg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asan-stack mode still uses dangerously large kernel stacks of
tens of kilobytes in some drivers, and it does not seem that anyone
is working on the clang bug.

Let's push this back to clang-10 for now so users don't run into
this by accident, and we can test-build allmodconfig kernels using
clang-9 without drowning in warnings.

Link: https://bugs.llvm.org/show_bug.cgi?id=38809
Fixes: 6baec880d7a5 ("kasan: turn off asan-stack for clang-8 and earlier")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.kasan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 4fafba1a923b..2f260bb63d77 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -106,7 +106,7 @@ endchoice
 
 config KASAN_STACK_ENABLE
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
-	default !(CLANG_VERSION < 90000)
+	default !(CLANG_VERSION < 100000)
 	depends on KASAN
 	help
 	  The LLVM stack address sanitizer has a know problem that
-- 
2.20.0

