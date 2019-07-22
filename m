Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAE6C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E42218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfGVLz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:55:29 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46629 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbfGVLz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:55:28 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MSbov-1i0IYV27p3-00T06j; Mon, 22 Jul 2019 13:55:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] page flags: prioritize kasan bits over last-cpuid
Date:   Mon, 22 Jul 2019 13:55:13 +0200
Message-Id: <20190722115520.3743282-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HYCKKaWem6pMuWADqfMV+oLPSrN4UO4x5g8SpZTmnBVDkynf91r
 u4QKrrDHUt8/L0iJAYkC0sRQIH8sGZT1eJYIG0RPerjoOSnjqfL1TguSBpVTT8B9g4uHjy2
 ZA7aKQ0OaZsIg/+/qG90Abp81/nRdkOh+m8yzTAL5In48TozJn5YF/lF8b78mymIdIBLg76
 s1Hfb6QgTM1V/YP9cUn6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vBG3mOLaeAU=:guUWUZc8D6eSdeLn+5NxyV
 1FMBdMbh3gfxEpkKl3SogitvEh4ZH7K7U4/jUzUNa/++1/ahkInucQ4Wp76voSBRSmB8m2vNS
 L2gNOH5AwqAfUaCeOXgMOqAt0L6Ntuf/8hgo6yk9Hm453wrU6n+Pm+0KV/G+A1WIh2Xy5jmGf
 R3rgQgHvnEaY1ohRQjKuZCSUjtUc2LY+9JLdN0vISYYZNRGV755z01ENjHpJVM4xt7q+rNxp6
 y+3rts1GL0ouI3sqefSAowCCzvoTch3Y1gRiLlME//e5bhN0JKGVdClvHm/9E9BL80DpB83WC
 iPNxNapVXGRh2uHmpbnOIYW7ZGrdyl6t+0blZdiGIUWPP1H8/FyH8JoIvIe2Jmd8eNfOkCf5E
 S5tMStUvUkq3wtjBtRDONd6duaWXY8FlRO2Qv7LKqCumTzTGdYpoQZB2IN2vxrCgCg46FgSVF
 DSzonEV7wj7LJPopGNJ2J6mJlGnmd3zPZ50rjqjEV15LS+mC02VPFuGgZN7kMCgcfGKeHwR6h
 tIq+LnCkSJc8WHXAIu4MEDfx3H9QP+PdGhMBlu99bqLHDmgI/X/l2e1tuzSs3rtoVR8SMTrXw
 KKx+rC3bRbg9NrHq6BufmAM8d0T2HHOvwja85N+EEYRaV5Ts671eu8BnXKzBtu2pQH6VLxhdh
 h0iiZ/LuZBX7xI2Uk8kJrumpV239WjEPOr088W+bx2TwIuDtPQH1oEWyN17dRXFyYKq5a9iwd
 D/d4aQQNRDHKRk3la1/JZMErAPiRinswvmESMA==
To:     unlisted-recipients:; (no To-header on input)
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

In order for the modified check to not trigger in the x86 vdso32 code
where all constants are wrong (building with -m32), enclose all the
definitions with an #ifdef.

Fixes: 2813b9c02962 ("kasan, mm, arm64: tag non slab memory allocated via pagealloc")
Link: https://lore.kernel.org/lkml/20190618095347.3850490-1-arnd@arndb.de/
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: rework the #error message to make more sense
v2: fix a build regression with vdso32
---
 include/linux/page-flags-layout.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 1dda31825ec4..71283739ffd2 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -32,6 +32,7 @@
 
 #endif /* CONFIG_SPARSEMEM */
 
+#ifndef BUILD_VDSO32_64
 /*
  * page->flags layout:
  *
@@ -76,20 +77,22 @@
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
-#error "KASAN: not enough bits in page flags for tag"
-#endif
-#else
-#define KASAN_TAG_WIDTH 0
+#error "Not enough bits in page flags"
 #endif
 
 /*
@@ -104,4 +107,5 @@
 #define LAST_CPUPID_NOT_IN_PAGE_FLAGS
 #endif
 
+#endif
 #endif /* _LINUX_PAGE_FLAGS_LAYOUT */
-- 
2.20.0

