Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C768EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3A8207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3/fEW4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfLPWHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:07:03 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:52789 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfLPWHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:07:00 -0500
Received: by mail-pj1-f74.google.com with SMTP id b6so5263067pjp.19
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 14:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fUKe1Twogj/Ads22pclfJ/w3t8syJGqJvSKjDedrbpw=;
        b=C3/fEW4uN1pnb8OM7dsTafKVdOwQty6te1Is6teEx+xIwPtt6UpyRl370qTrVmfj5L
         9/BoprIuaGbdjzopAOBaLBnODhEBuSztZ4TGCqUoBA35ntTHZw8rJ0hVCmNqlh7gqmBk
         Xqeriez8b1ehXW0pkDHk4T8twh4eN6gwYXUZ4F2+PEA2/3IgYZU6U+AYGJ3Iex5CP/Cu
         yDsF9vPOJyI6Mj89I2VunKR5Cel/PrwoGvu4OZ7OvZKqB1YqDEFdALgjNqxVRMFtupQJ
         JSMzuYn7OFU4NC9tt6Z2wrIi6ApUvk67cxPxWEb/1wvib/qhoJODWNO/JAxxRYMlqI6w
         3hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fUKe1Twogj/Ads22pclfJ/w3t8syJGqJvSKjDedrbpw=;
        b=HvGYS6H5KA6iotyFW+lpg1nSGsLHyt8BiZhTRUuPLdgi0Y6ao4WO8J0PE0o8n+x0LC
         J9H134BuG2wuRWQbYAwdtl+OaqXRPxIH4cOmRdQNyUgTeQiFaeY+LAuHduMD4BVkeDpj
         r43cSUEQ7rznNZNAjStBzGwAqLgMW7N3ZqRZd2BmI6X3fIT8/I55O2YnSFP8jVxy50KD
         AYZQzlYPfnyv9xPrlvx9EAMsXzBopPifGceVpuAwd6DNBool9KACf4y7PwB5sr7Qhn+b
         BkcKEA3lsf875M9dniCG3eCC5hvMxUIxlxh2rnOvf68aevNkufvmXWz6REUTcJtV2S+j
         ITQw==
X-Gm-Message-State: APjAAAWVsCwfS64kFrb0opciatSrPXP9o9ZJrEY9I6y2SLBUGDPit46k
        CV4q/LwECrE7wvZXUHSmmhVCtuvCEi2ujBhBitvPgA==
X-Google-Smtp-Source: APXvYqw/XxbHOc5ekUfzWkfW60wRalC38/w8JdEAkNWydl9vLxaw9Oqdw4NQB9iWg+hS7Jnpm5VUJuMrHggDTgl/y2aI8g==
X-Received: by 2002:a63:ff52:: with SMTP id s18mr21401528pgk.253.1576534019840;
 Mon, 16 Dec 2019 14:06:59 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:05:53 -0800
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
Message-Id: <20191216220555.245089-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [RFC v1 4/6] init: main: add KUnit to kernel init
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove KUnit from init calls entirely, instead call directly from
kernel_init().

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 9 +++++++++
 init/main.c          | 4 ++++
 lib/kunit/executor.c | 4 +---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index c070798ebb765..9da4f2cc1a3fc 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -196,6 +196,15 @@ void kunit_init_test(struct kunit *test, const char *name);
 
 int kunit_run_tests(struct kunit_suite *suite);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+int kunit_executor_init(void);
+#else
+static inline int kunit_executor_init(void)
+{
+	return 0;
+}
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 /**
  * kunit_test_suite() - used to register a &struct kunit_suite with KUnit.
  *
diff --git a/init/main.c b/init/main.c
index 91f6ebb30ef04..b299396a5466b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -103,6 +103,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/initcall.h>
 
+#include <kunit/test.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -1190,6 +1192,8 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
+	kunit_executor_init();
+
 	/* Open the /dev/console on the rootfs, this should never fail */
 	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
 		pr_err("Warning: unable to open an initial console.\n");
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 978086cfd257d..ca880224c0bab 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -32,12 +32,10 @@ static bool kunit_run_all_tests(void)
 	return !has_test_failed;
 }
 
-static int kunit_executor_init(void)
+int kunit_executor_init(void)
 {
 	if (kunit_run_all_tests())
 		return 0;
 	else
 		return -EFAULT;
 }
-
-late_initcall(kunit_executor_init);
-- 
2.24.1.735.g03f4e72817-goog

