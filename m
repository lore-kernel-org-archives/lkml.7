Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A00C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5242072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I6txfwI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgAILuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:50:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40084 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgAILuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:50:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so2485272wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 03:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3GsK7s8K6DIS0JIxs6gZ15L0MgMAbrzcUa2gzsoGKiM=;
        b=I6txfwI90sjMIg0dqiroXeL928Rj7hB3V/5JvOX+/OemCDH/T9a/dtcEgv+mmoShkD
         53jia1JCu5R9USQKUXjzn+pU9TZt4E/6qBvTLLpAal8g2aJZ9bBcZYxH3F7Gh3sidxqF
         iySg7DW+gdoVxk8JAn3o3HwQ3fUN7/p8C7/VXwElL7u1PAvYJtNw6UMxP4KlneZMq5qX
         8RWeWoa0hSkk4y7OSduZySI+UvOFnFmEbwQZ92j5OmnXIXIwtPvK0Hp1/n8fKyX0W0E0
         3HqAINB4wMAZJb0hCtyPAVz2VDWGKXYiVqQcowx6qJNkfr2HUokLO4vdamJ38q9UqJq5
         pGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3GsK7s8K6DIS0JIxs6gZ15L0MgMAbrzcUa2gzsoGKiM=;
        b=bwI5WVDEIlra6dKSp4pzxdQVvA9quIyfNLg5uClxc9Q1cbeHJeP26vIIBeppaq8/bA
         kKU5FWsWg5Z66eQ/IgkloJX9rofksngsmuKusFEZB1TuABK5+0+9KBDcYxxGcOZA/GGG
         5Cbi9jVelX+qwUO7p+yV5Ug27G5xmbkfGZTn4sUzItFIuzmcWETd1FR5GAyuTXRn/pHH
         AlGRnHsj+rHE2N9v0du9nRWJcZ+gPgVCsU7DtQclWCKXlXMRf7mscSZ17IaFp4oHPDwU
         E1o2CNyiXbEWhGEXNWc1t6Dk9eDkVKxXA8ttX152wYR18yl49lr1gY+Vv4Spp2hFPPp4
         dwWQ==
X-Gm-Message-State: APjAAAVAaz5RSAQmOpB7aDrJZVwXUAq/K/VryCVung38tcIDf1VlFUTL
        +gDobaeK1l8kZ6dxukIIMAi99+v0uSI=
X-Google-Smtp-Source: APXvYqzNkYXAmDxnxKgTQKco5PlOQHcCMYerJYTlTTJNn7H+Ku5b6ZFIjSHuE6PVA/Iy81wD8KK/nA==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr4555286wmc.9.1578570617472;
        Thu, 09 Jan 2020 03:50:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u16sm2574979wmj.41.2020.01.09.03.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 03:50:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 2/7] kfifo: provide kfifo_is_empty_spinlocked()
Date:   Thu,  9 Jan 2020 12:50:05 +0100
Message-Id: <20200109115010.27814-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200109115010.27814-1-brgl@bgdev.pl>
References: <20200109115010.27814-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide two spinlocked versions of kfifo_is_empty() to be used with
spinlocked variants of kfifo_in() and kfifo_out().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/kfifo.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 123c200ed7cb..86249476b57f 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -246,6 +246,37 @@ __kfifo_int_must_check_helper(int val)
 	__tmpq->kfifo.in == __tmpq->kfifo.out; \
 })
 
+/**
+ * kfifo_is_empty_spinlocked - returns true if the fifo is empty using
+ * a spinlock for locking
+ * @fifo: address of the fifo to be used
+ * @lock: spinlock to be used for locking
+ */
+#define kfifo_is_empty_spinlocked(fifo, lock) \
+({ \
+	unsigned long __flags; \
+	bool __ret; \
+	spin_lock_irqsave(lock, __flags); \
+	__ret = kfifo_is_empty(fifo); \
+	spin_unlock_irqrestore(lock, __flags); \
+	__ret; \
+})
+
+/**
+ * kfifo_is_empty_spinlocked_noirqsave  - returns true if the fifo is empty
+ * using a spinlock for locking, doesn't disable interrupts
+ * @fifo: address of the fifo to be used
+ * @lock: spinlock to be used for locking
+ */
+#define kfifo_is_empty_spinlocked_noirqsave(fifo, lock) \
+({ \
+	bool __ret; \
+	spin_lock(lock); \
+	__ret = kfifo_is_empty(fifo); \
+	spin_unlock(lock); \
+	__ret; \
+})
+
 /**
  * kfifo_is_full - returns true if the fifo is full
  * @fifo: address of the fifo to be used
-- 
2.23.0

