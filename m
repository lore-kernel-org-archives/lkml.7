Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D41C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A287C20843
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTAP9e+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfF0JpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:45:09 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:54386 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0JpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:45:07 -0400
Received: by mail-yb1-f201.google.com with SMTP id v6so3217427ybq.21
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M/VKnz1BZ+rvrIeSdLI9RxXAlLGL/xX/aFhsrhXW1SI=;
        b=dTAP9e+5cBvv1Fo1c9oAD6aT20tqv+ChITGWRAF6HBiV5h0A+cO/d3KW6e6bRHVLvG
         erLpdzNSnYBWnXbAlgOzQFymT1RWKDmLZwiJCIyx5PA/T5+1nmvNYgry/XQOnex69Uea
         jLWyToIrNx+PALPXS8zNvel0xSO6hmvfK2MHgRt7K1Dg/Km/TDLdJyfh4ZuBoL8aesNf
         rP3byfY8etaRRTUkuV1C1fUePUu4HjWIwxb3m+dYD8C+9D8ehGOQgMUHAYSQ4UddPvSk
         X3I0Blgf/z4Y6ytZeUMR5341999h9I4nU/8ggy7lRN8zBnWCOozRTxNtCa9uC6mOwamd
         m3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M/VKnz1BZ+rvrIeSdLI9RxXAlLGL/xX/aFhsrhXW1SI=;
        b=T1o2clf6wgK41r9365N47D6aSN9b8y/ApIPmg+E5nYFMPu7inO+h8xl/muH1vdxL2T
         mAL2Aj+J8VhejsLCFs/vsfh158XyCmpMK+2/svEyeSqcd4xOfgkSWwZ5IYSrbtuDILIO
         YHkxI9+/ydgm39/Dik12IaAWbAJb0P2zrd1P6eZosQD7v06bWfN6crf1F8akfif2YnMt
         djti4qhJcVZu4Zu4rFJau7XZi8kMKfQbfSTbNV7F9Khi0f2g85M3ACj2sgDl3sk7IGbb
         lCA99Fy8BNsQ4ovgIYlMIGiDe4C57sfTpROrbaQs5il7MTGTV5oSknw7IyX6Z/saaCzu
         9XUg==
X-Gm-Message-State: APjAAAWvL5IfJyBvfAFPA2xvcEaHg28TCrDWBLdmT0tgHFW9smSBZs+n
        RE39H20dK01nvXsyWj7t2KptuU7vLw==
X-Google-Smtp-Source: APXvYqyrysKf0nY6MA4eBDonEeUr1VDkNdQueTw63xxmxnWHB5Hteblcrv3Ft6+bD+my9MMcpuiIIfeGYQ==
X-Received: by 2002:a25:c4c4:: with SMTP id u187mr1928035ybf.185.1561628707099;
 Thu, 27 Jun 2019 02:45:07 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:44:41 +0200
In-Reply-To: <20190627094445.216365-1-elver@google.com>
Message-Id: <20190627094445.216365-2-elver@google.com>
Mime-Version: 1.0
References: <20190627094445.216365-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 1/5] mm/kasan: Introduce __kasan_check_{read,write}
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces __kasan_check_{read,write}. __kasan_check functions may
be used from anywhere, even compilation units that disable
instrumentation selectively.

This change eliminates the need for the __KASAN_INTERNAL definition.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
v3:
* Fix Formatting and split introduction of __kasan_check_* and returning
  bool into 2 patches.
---
 include/linux/kasan-checks.h | 31 ++++++++++++++++++++++++++++---
 mm/kasan/common.c            | 10 ++++------
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
index a61dc075e2ce..19a0175d2452 100644
--- a/include/linux/kasan-checks.h
+++ b/include/linux/kasan-checks.h
@@ -2,9 +2,34 @@
 #ifndef _LINUX_KASAN_CHECKS_H
 #define _LINUX_KASAN_CHECKS_H
 
-#if defined(__SANITIZE_ADDRESS__) || defined(__KASAN_INTERNAL)
-void kasan_check_read(const volatile void *p, unsigned int size);
-void kasan_check_write(const volatile void *p, unsigned int size);
+/*
+ * __kasan_check_*: Always available when KASAN is enabled. This may be used
+ * even in compilation units that selectively disable KASAN, but must use KASAN
+ * to validate access to an address.   Never use these in header files!
+ */
+#ifdef CONFIG_KASAN
+void __kasan_check_read(const volatile void *p, unsigned int size);
+void __kasan_check_write(const volatile void *p, unsigned int size);
+#else
+static inline void __kasan_check_read(const volatile void *p, unsigned int size)
+{ }
+static inline void __kasan_check_write(const volatile void *p, unsigned int size)
+{ }
+#endif
+
+/*
+ * kasan_check_*: Only available when the particular compilation unit has KASAN
+ * instrumentation enabled. May be used in header files.
+ */
+#ifdef __SANITIZE_ADDRESS__
+static inline void kasan_check_read(const volatile void *p, unsigned int size)
+{
+	__kasan_check_read(p, size);
+}
+static inline void kasan_check_write(const volatile void *p, unsigned int size)
+{
+	__kasan_check_read(p, size);
+}
 #else
 static inline void kasan_check_read(const volatile void *p, unsigned int size)
 { }
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 242fdc01aaa9..6bada42cc152 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -14,8 +14,6 @@
  *
  */
 
-#define __KASAN_INTERNAL
-
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -89,17 +87,17 @@ void kasan_disable_current(void)
 	current->kasan_depth--;
 }
 
-void kasan_check_read(const volatile void *p, unsigned int size)
+void __kasan_check_read(const volatile void *p, unsigned int size)
 {
 	check_memory_region((unsigned long)p, size, false, _RET_IP_);
 }
-EXPORT_SYMBOL(kasan_check_read);
+EXPORT_SYMBOL(__kasan_check_read);
 
-void kasan_check_write(const volatile void *p, unsigned int size)
+void __kasan_check_write(const volatile void *p, unsigned int size)
 {
 	check_memory_region((unsigned long)p, size, true, _RET_IP_);
 }
-EXPORT_SYMBOL(kasan_check_write);
+EXPORT_SYMBOL(__kasan_check_write);
 
 #undef memset
 void *memset(void *addr, int c, size_t len)
-- 
2.22.0.410.gd8fdbe21b5-goog

