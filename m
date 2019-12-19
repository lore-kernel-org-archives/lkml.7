Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87293C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593A52467B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="g6TRXLzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfLSRQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:16:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42383 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLSRPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:15:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so6750945wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3GsK7s8K6DIS0JIxs6gZ15L0MgMAbrzcUa2gzsoGKiM=;
        b=g6TRXLzQnGjOPWvH2HyZO/buusAWwoTEGg4ebhf8w94RAYzxtqUm6yVvhCIw8TKnTw
         NIW3bDN4U3M9AHMZEeG7YVVEB8H58W7zaTbFpsPH3MVS8CAqyDOOYTLrKiEYom7AQQI8
         DmfAxe6M0vOJClNDCjPu2QxNK1XF2xDVYE+fJv3uwKyHlB1ODq0Wdi/hQfsOwyRTpSwZ
         sKS8UHmC+O+6E7BLZk2ze+aGJlb2VTxMMKifzz5mSt3y10yxnpSgUhIki9GhbmywIlDh
         jL6sAwvJIxhQ0wgchhfdMoxucMlNFpPt/qryPKpRjRPVFSg+5sU2NZGVgT6RFaMH8nIc
         WSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3GsK7s8K6DIS0JIxs6gZ15L0MgMAbrzcUa2gzsoGKiM=;
        b=PDAKaKR+VpH/H4LuhD/p5iWNTdRPxM8oEVwJmKaO5VbLJdnwjqF/wuVSog2bZDLm/O
         5YdCvbUg7Flhb6nCcaO6EgjO2WU944XFxm1idF6New4xROV7g/HvGn2fPYZWyUCqleEY
         sT7lBMxV/yfwh5fbfa+erHA+Vn90GS5ZFSmO7cKdo7NCvxOjYz/PNRA9drm/GCK4hJqY
         sL3O0+FMRxwKfAh/8W5xlQOX+cqN8oYU8npuIE0q+AQjdUonHv7fGASvWTgvOkXdr4D7
         NVNXWeevOUkZEbidVoZQqVUvBRrlB48y6pU7FVQRq7ddgtpOWygpOLY7eLJxs1KOY+CU
         TsSQ==
X-Gm-Message-State: APjAAAWMv2yJuaAalJZB/SqrQrwTA3ttMo/HqVwoM94ENQzgKzE8iDVl
        WWb8rGybpOgtDT1tTAPg+kuUqw==
X-Google-Smtp-Source: APXvYqxpvJtV3K+218KyMYeyCIIlGfxC5RkmAu0mSlC24RiXlLDUIaN7rxKG11+WOceIDd+3Gez3FQ==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr9974423wrr.32.1576775744375;
        Thu, 19 Dec 2019 09:15:44 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id q6sm7401428wrx.72.2019.12.19.09.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:15:43 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 08/13] kfifo: provide kfifo_is_empty_spinlocked()
Date:   Thu, 19 Dec 2019 18:15:23 +0100
Message-Id: <20191219171528.6348-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191219171528.6348-1-brgl@bgdev.pl>
References: <20191219171528.6348-1-brgl@bgdev.pl>
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

