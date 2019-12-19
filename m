Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC3FC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8372467B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yvCbBMgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfLSRPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:15:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34629 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfLSRPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:15:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id f4so7505098wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3tKF/sG1li0TNgHDm/zaOCBiB+0gN/tDFvNC2uEQ+I=;
        b=yvCbBMgsXygGH3FpIEPNHsa/VXxazpj/KKkweqXvtiwPAGQGvioH+U4zhS4FEmBe2J
         3bcwHbePdFYkv53xANQ07yko9f1EpaEr06XKEiGQfmhzVB+KP/bm5qc4/qMY36kFNMa/
         An7xjv4KBFJgqalgay1+pIpHbpovJVofNQK1nUAzV4DChKHO1sOyRvVge6MdEKhIav9J
         XfBN1rrrif8DB15FRkaW/sYyvboMW6CIm5xx65HaoItIainM6I0Z6HuYLXsb90I8IJTM
         znXgVy2wze2oBNhtr70aExe9Z6UEqj/ha8WrO3msi1bx41fkBu68d2pgssY4yX8VGKA0
         RKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3tKF/sG1li0TNgHDm/zaOCBiB+0gN/tDFvNC2uEQ+I=;
        b=dnFGl7KtkA12pZ/RNG1TLPjwyBofB1mQy+sVExsbHlLH0+lnoT99ASkXQMsZGSFi+X
         pTf30jHgIcSRgtbUzW7srbMLrXsEnDrqMOZ6plLuzad3xq78QgH+2f8ZsNx4hVwQ/DU5
         fBq9fHv0T1JrKWYgwR/6SgCsK+4lw97sIkZKYVPnwbxyGS8SLmOrJkFZvc1Uh0Fi5GkV
         4EMb/HtqMVkWXor5YI4yn6d+TnOZ/RgAaYjnLTkCdG7qlUJNWdWOJuWpsZUOTwq0lbTT
         tqSqno2AdjNpDBMOkza1sB3/RvxOEZDKdrqZI/fX6+nEadIoGmSeK6abJAVwyTMpzbSD
         SA+A==
X-Gm-Message-State: APjAAAXFYfXvgRKHQphFXsiNrOcXkzlRIFjvtlPc+odXZ64+mUoiQzyZ
        dHoPa0Dkpm1t1zaoYPjqRm5lJg==
X-Google-Smtp-Source: APXvYqzi/6ikWTdHrJtfEWndoMXEyahi/G3Kdtq/Ybn6ZO7teucGMeyvx1jbrI/xqlhXvEYWp5KGVw==
X-Received: by 2002:a05:600c:2050:: with SMTP id p16mr10682400wmg.176.1576775743241;
        Thu, 19 Dec 2019 09:15:43 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id q6sm7401428wrx.72.2019.12.19.09.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:15:42 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 07/13] kfifo: provide noirqsave variants of spinlocked in and out helpers
Date:   Thu, 19 Dec 2019 18:15:22 +0100
Message-Id: <20191219171528.6348-8-brgl@bgdev.pl>
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

