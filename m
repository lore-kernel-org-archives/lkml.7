Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF865C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2C4206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="g9lElHhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfLXMHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:07:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39136 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfLXMH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:07:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so19654862wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 04:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3tKF/sG1li0TNgHDm/zaOCBiB+0gN/tDFvNC2uEQ+I=;
        b=g9lElHhRIBO+8JEjfNQMA2XVSiVQ30Ri7z2hJTRPm/j76Zx+jJmIIj5Xk1TO2WTEgS
         JcPqP0HQePpxXiyH++hJanMAX+vXYghttAmn6yYEdiN25cuFwAXOeIX1q5Pe0oIAwcBh
         42iR7XTlVPGTIJwvBP6pxkEOCSLU0meQVw9ZuvwFC4zdFig7tW2Ozy0cx5W+ZyXQdrZb
         rh4daaHeRMx2uAe5Mg0ug7aXbCnNSOd0hCK6SmGf2O5Wum2RjliPZyRwGfZrlObGe8lz
         qlIxQNUjMKFU+3s9zbZGimAfru7gT2n+4SEHBbpFfvht7MRLthOreQqSC9/YTbj58JOq
         q+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3tKF/sG1li0TNgHDm/zaOCBiB+0gN/tDFvNC2uEQ+I=;
        b=aOhbi7s7qdqikHYcbBeKhzHMz2wZ7r62QCsWm2B9owYV/gx0cxFNbn0CAi9GVRmVlO
         s5M8IitBC+Dao2PntmJwxRx/u9D+z33siioHAKhnZ8p5B+Sn/HfF6IdmYzMNX3VkWV8R
         EKoLfcFJTrllIzCh5ETWU0bPfEPG4JsFT5fn4jCacLNBbwi1DX+b5eURtdhJEXKGjPPQ
         gib+p1NHooEis8K7ucc+IHDQ8FurzbCo1J5zjl6DTfjosMFD8286dWnEWSxOs2WKLZkO
         nb6CcWHo5SCHpBsDY5aBJBfhUSDNgwl7Gw8h5nDcRnaZcK4Z/t8/ConBkI+bHVD6UbNn
         1UdQ==
X-Gm-Message-State: APjAAAUiIhsxtnpiWPL6XYicHnBQNo0wvJG2dH+X6FsXf73awb0fYulU
        LcPqXD88AxR/yfN4pj9RkHMUag==
X-Google-Smtp-Source: APXvYqzl4dthlgxAbEzxEkPONj4TiKBr71Sgs3FieyhYDXLXvuH07TMky9rTBxWiG9PFPeEE6pMnSQ==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr33840026wrr.252.1577189244487;
        Tue, 24 Dec 2019 04:07:24 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s10sm23829210wrw.12.2019.12.24.04.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 04:07:24 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 07/13] kfifo: provide noirqsave variants of spinlocked in and out helpers
Date:   Tue, 24 Dec 2019 13:07:03 +0100
Message-Id: <20191224120709.18247-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191224120709.18247-1-brgl@bgdev.pl>
References: <20191224120709.18247-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide variants of spinlocked kfifo_in() and kfifo_out() routines which
don't disable interrupts.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/kfifo.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index fc4b0b10210f..123c200ed7cb 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -517,6 +517,26 @@ __kfifo_uint_must_check_helper( \
 	__ret; \
 })
 
+/**
+ * kfifo_in_spinlocked_noirqsave - put data into fifo using a spinlock for
+ * locking, don't disable interrupts
+ * @fifo: address of the fifo to be used
+ * @buf: the data to be added
+ * @n: number of elements to be added
+ * @lock: pointer to the spinlock to use for locking
+ *
+ * This is a variant of kfifo_in_spinlocked() but uses spin_lock/unlock()
+ * for locking and doesn't disable interrupts.
+ */
+#define kfifo_in_spinlocked_noirqsave(fifo, buf, n, lock) \
+({ \
+	unsigned int __ret; \
+	spin_lock(lock); \
+	__ret = kfifo_in(fifo, buf, n); \
+	spin_unlock(lock); \
+	__ret; \
+})
+
 /* alias for kfifo_in_spinlocked, will be removed in a future release */
 #define kfifo_in_locked(fifo, buf, n, lock) \
 		kfifo_in_spinlocked(fifo, buf, n, lock)
@@ -569,6 +589,28 @@ __kfifo_uint_must_check_helper( \
 }) \
 )
 
+/**
+ * kfifo_out_spinlocked_noirqsave - get data from the fifo using a spinlock
+ * for locking, don't disable interrupts
+ * @fifo: address of the fifo to be used
+ * @buf: pointer to the storage buffer
+ * @n: max. number of elements to get
+ * @lock: pointer to the spinlock to use for locking
+ *
+ * This is a variant of kfifo_out_spinlocked() which uses spin_lock/unlock()
+ * for locking and doesn't disable interrupts.
+ */
+#define kfifo_out_spinlocked_noirqsave(fifo, buf, n, lock) \
+__kfifo_uint_must_check_helper( \
+({ \
+	unsigned int __ret; \
+	spin_lock(lock); \
+	__ret = kfifo_out(fifo, buf, n); \
+	spin_unlock(lock); \
+	__ret; \
+}) \
+)
+
 /* alias for kfifo_out_spinlocked, will be removed in a future release */
 #define kfifo_out_locked(fifo, buf, n, lock) \
 		kfifo_out_spinlocked(fifo, buf, n, lock)
-- 
2.23.0

