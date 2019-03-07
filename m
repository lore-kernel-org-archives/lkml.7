Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B26EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F1520840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfCGHva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:51:30 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:39801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfCGHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:51:30 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1McYTD-1gW1pI21dd-00cwuj; Thu, 07 Mar 2019 08:51:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] page flags: prioritize kasan bits over last-cpuid
Date:   Thu,  7 Mar 2019 08:51:05 +0100
Message-Id: <20190307075124.3424302-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:veH9Knc6kktqy1oegAvldWvaMKGPY1paYlybq/Hp0sKWNk7FLma
 JKa79ay422Mv9MbcoOUDNPHaSLB7jZq+QX818+mOki0oF8NUOm7CgxX5lt/LtD+8jNI1ltM
 Ym6zcNiH3yMmouiTvVBkleWG+2W7c53iCCf4dPAJ/V9MRoJ5X4t6pW9suuKVK09LSjjPh5h
 +9kxEYL/z7zngiJq5sD9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jfZPdugRt4A=:v5VK1smrr5w6HduxLQTC1P
 G/vBUms3YCvASNGSAg3DimYiX8isn4Ux5x4KLOE4F4I26fbfEpJ/tsyCkrHX2EMmyTRXHm1d4
 hkLZS4eJveZUwgohq3Hmn0yBYdgXCgduePN30/0oX52Hsy1vXHcUigfWo0WKk7SjH7AxpihOF
 DxuRw+yIdN9d6jrDUltAK3FxD1lqUMzi0XEDDos6YlrkgcT0ygp9dPUtYmzXgBidKxD5YHOVB
 q8xqOOD7eFodNVfl+EipnlNV9hdnwJq9BreYaMzOvmaEbyoRVNY4SiuSYERJKDfF4x1SyZ8l9
 0zyhnGFzfpRnHGx+PCq/UYfnG/0UqkGn+8UEprRiWgH5p+3uIEinBovAjy0TLQQAh1FwuLBdB
 BgzNgpEfSifeovZyKQ4roCyHxE65V0enmy8Q0wTTfZ86yewWNMt9KfdqKgwvbnr5/071zOLGE
 dWpv//RPTlRTSmO3+JAzKT3y6AEn2VpQQPO7bwT6Kpycv4+9tUCDgQTiQ7h60mw/I6sKltxK3
 +7t7HsOS2a9sz49XIbuCgCzzf/eIc8xH21yEl3URdr5fA6p3lYvLodu+RvallU3Iyf3Xv7iYG
 yEbWgmXQpYe4K6ZkPqLFg/5wf80oY8PNcdPUeyO5oguc54oidPa9isLS4dWoDJyrNKiCgBhtV
 o7uEBrcHSjdkffw2pJ61l4ORYpRchWLKWKviMgV/elZWTBQxhR+HHUuoeKrSDOo0xO6k8zq9Z
 GG43xegM+k4nvuXkDUievmvEZosehzGd1C6ofA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 randdconfig builds regularly run into a build error, especially
when NUMA_BALANCING and SPARSEMEM are enabled but not SPARSEMEM_VMEMMAP:

 #error "KASAN: not enough bits in page flags for tag"

The last-cpuid bits are already contitional on the available space,
so the result of the calculation is a bit random on whether they
were already left out or not.

Adding the kasan tag bits before last-cpuid makes it much more likely
to end up with a successful build here, and should be reliable for
randconfig at least, as long as that does not randomize NR_CPUS
or NODES_SHIFT but uses the defaults.

Fixes: 2813b9c02962 ("kasan, mm, arm64: tag non slab memory allocated via pagealloc")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/page-flags-layout.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 1dda31825ec4..9bc0751e68b2 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -76,21 +76,23 @@
 #define LAST_CPUPID_SHIFT 0
 #endif
 
-#if SECTIONS_WIDTH+ZONES_WIDTH+NODES_SHIFT+LAST_CPUPID_SHIFT <= BITS_PER_LONG - NR_PAGEFLAGS
+#ifdef CONFIG_KASAN_SW_TAGS
+#define KASAN_TAG_WIDTH 8
+#else
+#define KASAN_TAG_WIDTH 0
+#endif
+
+#if SECTIONS_WIDTH+ZONES_WIDTH+NODES_SHIFT+LAST_CPUPID_SHIFT+KASAN_TAG_WIDTH \
+	<= BITS_PER_LONG - NR_PAGEFLAGS
 #define LAST_CPUPID_WIDTH LAST_CPUPID_SHIFT
 #else
 #define LAST_CPUPID_WIDTH 0
 #endif
 
-#ifdef CONFIG_KASAN_SW_TAGS
-#define KASAN_TAG_WIDTH 8
 #if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH+LAST_CPUPID_WIDTH+KASAN_TAG_WIDTH \
 	> BITS_PER_LONG - NR_PAGEFLAGS
 #error "KASAN: not enough bits in page flags for tag"
 #endif
-#else
-#define KASAN_TAG_WIDTH 0
-#endif
 
 /*
  * We are going to use the flags for the page to node mapping if its in
-- 
2.20.0

