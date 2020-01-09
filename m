Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91345C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680C22072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="IUydl7ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAILuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:50:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39748 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbgAILuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:50:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so2496003wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 03:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3tKF/sG1li0TNgHDm/zaOCBiB+0gN/tDFvNC2uEQ+I=;
        b=IUydl7ieb63aKu0H6OVdv3+gq3v7WRcPs+PdO5mFjO839+2j2g5nzXZGAgp0/IhAwH
         3WzAetM4872rR+oQ3wwS3NkRG51R7Ql58C+cECONQ0AOPIv2QyCHhPfMIKHsOt6Io1hH
         Y63VNvr/vkaI5xRSVBhciLmDAnGV4ZnmIcC0R/N0wmwcLvpGWwHwgGfLFcTyWEbbObtx
         s9ghNw/7P8ENmaO0BrTT7Y4i9afKweD3TVLjJukc45Ynbnh/s+Oj6u8SEB4oeBQPHSaG
         RalIe6f9PFPvyzJ4NuNHmhRIpZeymqOq+ATy1EuY0Gxpbyhn4QV+L0/3GGl2AoKYYzy8
         2FSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3tKF/sG1li0TNgHDm/zaOCBiB+0gN/tDFvNC2uEQ+I=;
        b=UvHK1wJPFW7XKD4yR8PR9eo+/rSICsEvWVpJSrAK6AMW2Zukf34uXK4IgATZMrJaw3
         bdxI+8lG5MyHAEil+7e63tUF2GsDEvAHXzLYfu5+oF29VPRBgTVig4ov3QrUi3ven6R+
         6D4b/upJJIOB7TQy8zh51N4cgI7TUzET55n6fvLGvl9CfYDaDrYscKz0lRhbRpe3OvxK
         iDeZ3yAm40MIHigKFPZznzFD6OYH3x9pdtdk3wcQWbijo3ZBkVgT3DQerR6jh62B0zsK
         6s+AMHg4zoJjwD0lv3vE6ntLmDytMB42rH5EgDHqLpShWC/K33SVe2Ed+FamNb5dYKmB
         zG3g==
X-Gm-Message-State: APjAAAXxlmTaPJvH9jt1gIeNjpvUMArQuha024V/h+0IdXxpGaR8e8oL
        2lwRZa6KPr7jgIXvB8hv3Tx8bCPhx2c=
X-Google-Smtp-Source: APXvYqx+GlN8Xwu7uMYnTs5RrXzdxVWJr0Qi4werEpwiVPjE6cBrrDzbMwqdXBP1dUigjbBije1L0A==
X-Received: by 2002:a1c:498a:: with SMTP id w132mr4149313wma.10.1578570616488;
        Thu, 09 Jan 2020 03:50:16 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u16sm2574979wmj.41.2020.01.09.03.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 03:50:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 1/7] kfifo: provide noirqsave variants of spinlocked in and out helpers
Date:   Thu,  9 Jan 2020 12:50:04 +0100
Message-Id: <20200109115010.27814-2-brgl@bgdev.pl>
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

