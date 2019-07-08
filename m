Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C380C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BD521479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOdsIHVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390439AbfGHRJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:09:00 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:51899 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfGHRI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:08:58 -0400
Received: by mail-qk1-f201.google.com with SMTP id s25so16913281qkj.18
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hwhk1enE9nNmmHHJ9NMKEqUFLaBrzoJTEH+x5otTjag=;
        b=wOdsIHVMZamkOSYuWNiQFHyAqqlxUMC9zzgAfqihPagHPuNYqfImiffF9t9yl+cgN2
         FPO8yjuPBzh/cfI4a1HrVyKbDJNfD4KrSCxvHyuvK/AbBqouiF1uRJTO1HwPpEuIyFcx
         AJc3IVdMD8Qt8q5nf8e66WhTsJDBCW1aZOkRPP2tLJs1xVqhzSoOWpFmRPQrjzjwxWtM
         H/HV/bEP6ByYcFCoS52/X+xSXFdBum+Qdxno/6mk/WKN618Yc9OPo5Asuos1EpFJb+oD
         oIN2XuhitBq1hb5zsTPK1rUZes7bC8iFz/W3aHiaBjRlbpeJjT9aX2btjK5cntLk6L6g
         GJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hwhk1enE9nNmmHHJ9NMKEqUFLaBrzoJTEH+x5otTjag=;
        b=LJddC2pmayN4NnjIOp2JSgP7H+Lx9fVXHQXq0J4yHpFZaSB9YDIhrFBx4DFV3mRT57
         kyKN4ZoqnpqZRnuGMX50+PksyIZXFit6Duz2JZY9KFL2Wew7z6bHR0t6OmZO/MrOWZJS
         5YDTvEt1OQMDy6qGrWzVscTwlTmHbP1/p28X0+kkE2fS5+LPcBBpy2jCOIM3WYzipD6M
         Ho8RqKgrKuWlo3jCbuFwFxXLp7rF2F9V9bnX5IgUJ3+qAh58I2R9Rrk0/Ee2WKcXCbOb
         artYYmFxDHB5wuwlO0dkqlBnUpXL/HBY6H2b4wQ4JH5ff2sHQxQ2oWxefW712jfYWBZC
         5SNw==
X-Gm-Message-State: APjAAAX59PTrq0jX3AvZxBCKzY/94+FM4F+cy3oIyiwt3aNLtKjzJeNR
        vCR9Uf6OGsVYnq91e8ZK5Gq3kPR5gw==
X-Google-Smtp-Source: APXvYqzqzU+7VOFTLnajYW2WtzqGbE36eBpzdkyAewvRtPAu/83hx5E2taIq76Yx29VuC7PM2wMXFbOWfQ==
X-Received: by 2002:ac8:32c8:: with SMTP id a8mr10978860qtb.47.1562605737784;
 Mon, 08 Jul 2019 10:08:57 -0700 (PDT)
Date:   Mon,  8 Jul 2019 19:07:03 +0200
In-Reply-To: <20190708170706.174189-1-elver@google.com>
Message-Id: <20190708170706.174189-2-elver@google.com>
Mime-Version: 1.0
References: <20190708170706.174189-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 1/5] mm/kasan: Introduce __kasan_check_{read,write}
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
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
Acked-by: Mark Rutland <mark.rutland@arm.com>
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
Cc: Qian Cai <cai@lca.pw>
Cc: kasan-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
v5:
* Use #define for kasan_check_* in the __SANITIZE_ADDRESS__ case, as the
  inline functions conflict with the __no_sanitize_address attribute.
  Reported-by: kbuild test robot <lkp@intel.com>

v3:
* Fix Formatting and split introduction of __kasan_check_* and returning
  bool into 2 patches.
---
 include/linux/kasan-checks.h | 25 ++++++++++++++++++++++---
 mm/kasan/common.c            | 10 ++++------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
index a61dc075e2ce..221f05fbddd7 100644
--- a/include/linux/kasan-checks.h
+++ b/include/linux/kasan-checks.h
@@ -2,9 +2,28 @@
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
+#define kasan_check_read __kasan_check_read
+#define kasan_check_write __kasan_check_write
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

