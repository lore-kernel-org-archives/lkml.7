Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7E5C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3AB206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfFRJyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:54:11 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42735 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRJyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:54:10 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Ma1kC-1i95I60lue-00W10Y; Tue, 18 Jun 2019 11:54:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] page flags: prioritize kasan bits over last-cpuid
Date:   Tue, 18 Jun 2019 11:53:27 +0200
Message-Id: <20190618095347.3850490-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bUJwQclvqm/katzhhzycV3+/zOxa7NbjGOKFIqH4EXPNW02vwyN
 lRoCJ9pDU+WbEFJZSH5TpY8rP8VBIOStIKLRBqcBtosxCv5LlrE/rA1pQcShjiptjGdXGMx
 y9Yby5nkzWG9VqIi84t+aokD+Qbu9EaMbAUpG7WpjvuQIBC7Yyl1HNU0eFDofbbcqLY2YTW
 O5MFfR4770dZqo2qlu0aQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iIwUq5FcHw4=:EB3SY0U94Oo+TOTWQB9G2D
 PP+nddwoiOQnZ5tkbYk2Lh2TJIc6E+ObTe4LhKccCu1IcrQZOlkZn7KXdl6ZxelHoT4M9EZml
 IDZINoYBhyPor35Ghp0KLV9mzYSYx3vcijpLUUfWcw29jPzNpEVGfaOBKG2VYtAIqvyNA7n95
 nd/aMvU71fn6g9czQwP46IEaIpNTliHYKbqzxuMg/s7U8XTi0LVY56wnsQ0562+KqvoBroqfn
 LwUrik8VyfQ7qcg9vU9KSSKdUaaB744scxeMfp2X/LmyqDsQFb31u0xxf9MkgE9x4sseIEgdY
 tkUDn3azX/IOlZqJOenTjDAc6LyPGbJhgje5/4VyU2M/tgniMR/nivygYSXnAa5FGC3TQr9CK
 mFh7hpTVejfntAP3mziLcPtwJzxx+gF6nhf8Dqeqpv8vcApz51ybXO/JAl8Jjb5YYQA09oXIL
 M4NIcymsuiB6gGIYAGZgiQYFz4wZFfpUl9tnGaYECOUnnDo2MIMdMSPsASgkJ+7/ykwTsm4CK
 PNMcnQvhY/4r0oVL7obwyKN6+N07+L8fmRFkggm8Q6KHWFhHqjjIczLtP05jjiLJzVihadbZz
 QRxQa3jPCD2YHzmIS5qtobDTEM1ixuOl5ENcbORlp06BlPucfyOBj+m+6gGMXlvmMOo1L/LPF
 pwAZsa4fYFeY5Wjj6AYkesP8CdrFlMuQ9Jt1lgOI6adRwOldxtK/0CiT3LI8dPOJp1Be5giSt
 hNB6ySTYYupaUPbKZG3WZvwGdnRbzjmbIetlKQ==
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
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Submitted v1 in March and never followed up on the build regression,
which is fixed in this version.
---
 include/linux/page-flags-layout.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 1dda31825ec4..7d794a629822 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -32,6 +32,7 @@
 
 #endif /* CONFIG_SPARSEMEM */
 
+#ifndef BUILD_VDSO32_64
 /*
  * page->flags layout:
  *
@@ -76,21 +77,23 @@
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
@@ -104,4 +107,5 @@
 #define LAST_CPUPID_NOT_IN_PAGE_FLAGS
 #endif
 
+#endif
 #endif /* _LINUX_PAGE_FLAGS_LAYOUT */
-- 
2.20.0

