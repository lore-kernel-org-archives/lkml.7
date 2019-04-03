Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C861C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD582146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBBWQQvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfDCEq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:46:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38117 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfDCEqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:46:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so7662081pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BpQ5JnHFhm/XOtfo9JCD7gouq+byLriEfEIfrkae1uk=;
        b=NBBWQQvT0ybh3NIMpdWHunwoGcZ2bkAfk6a+qERcan3JC1Y9A0CP+ylB+lki9YB4j4
         K06vdRbFWd/fU1sfKWlkBXm1JLghQcqD1Gfr5H0poOorNHJYT4ZlXM1SRCLoRl/wm9UV
         +6p3olK+qwrt8lpWmiNDgcJX8uTkIlYV/SebA+CFXDPU5HGnBhp/+7xJFozdRx628/Nu
         VWhhYGXx5/FeqPJXR2Apu05HX+aKrhPIXJKCSbT9ttigHXWEaH0diibiZW2xyJ+BkUWY
         qO5qWzACHF7pkIA39vAV8cHpwgnjLULwjRYDqo0oBi3fmLfILK8cYw0UgV82dRI/H3DK
         JUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BpQ5JnHFhm/XOtfo9JCD7gouq+byLriEfEIfrkae1uk=;
        b=sEYuydQ5+4JpAGxJGsvuXwuOo0Tg3deNkFykDBqKH6gaOKnVeJnzMdaUQwIe+mQpdT
         BoSSaXDVfSpMyKsiweo0w/DigI8q0CzFGFkdwsaOZXByplYjQIKcIuCsGtzdNLGOXfwv
         G5TpTMgztKjV6OOAvu3AEqyn4Vkypodncz9V4ZZzKEzo8vswc+WGY3syQGziPO8BgJ0P
         12fviEFFN719dTn5JssfmZftUKpiBLGc9aWlXDv4TsbVgzvumEKm05Q1ft85v2tQ91e3
         Q2tQ3QhIrr9e8Lsr4ooeLNPPQMm0h+ZWb/h9TVzIynwvrZPXDNLaEWiL0xMNd13Fzod3
         qLmw==
X-Gm-Message-State: APjAAAUrURRXsNo0tgr85hCp7U5u7HHzy4RT7KR2vWU8tnKG1p0UYcnZ
        UAekBPSLY2msVhSNH2mWV1Q=
X-Google-Smtp-Source: APXvYqyeg2o/cCQS+4wqSJ8mHGFAGLF/n7b7N4rBGdL2VB/GYnh2NZHc0IwndHZ07E2+dB5F+OYEkw==
X-Received: by 2002:a63:2b03:: with SMTP id r3mr23372693pgr.105.1554266784147;
        Tue, 02 Apr 2019 21:46:24 -0700 (PDT)
Received: from localhost (c-71-202-79-220.hsd1.ca.comcast.net. [71.202.79.220])
        by smtp.gmail.com with ESMTPSA id o67sm18759490pga.55.2019.04.02.21.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:46:23 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] lib: make bitmap_parselist_user() a wrapper on bitmap_parselist()
Date:   Wed,  3 Apr 2019 07:45:36 +0300
Message-Id: <20190403044540.16322-2-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403044540.16322-1-ynorov@marvell.com>
References: <20190403044540.16322-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we parse user data byte after byte which leads to
overcomplification of parsing algorithm. The only user of
bitmap_parselist_user() is not performance-critical, and so we
can copy user data to kernel buffer and simply call
bitmap_parselist(). This rework lets us unify and simplify
bitmap_parselist() and bitmap_parselist_user(), which is done
in the following patch.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 98872e9025da..ce9ea804d06d 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -632,19 +632,30 @@ EXPORT_SYMBOL(bitmap_parselist);
  * @nmaskbits: size of bitmap, in bits.
  *
  * Wrapper for bitmap_parselist(), providing it with user buffer.
- *
- * We cannot have this as an inline function in bitmap.h because it needs
- * linux/uaccess.h to get the access_ok() declaration and this causes
- * cyclic dependencies.
  */
 int bitmap_parselist_user(const char __user *ubuf,
 			unsigned int ulen, unsigned long *maskp,
 			int nmaskbits)
 {
-	if (!access_ok(ubuf, ulen))
-		return -EFAULT;
-	return __bitmap_parselist((const char __force *)ubuf,
-					ulen, 1, maskp, nmaskbits);
+	char *buf;
+	int ret;
+
+	buf = kmalloc(ulen + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[ulen] = 0;
+
+	ret = copy_from_user(buf, ubuf, ulen);
+	if (ret)
+		goto out;
+
+	ret = bitmap_parselist(buf, maskp, nmaskbits);
+
+out:
+	kfree(buf);
+
+	return ret;
 }
 EXPORT_SYMBOL(bitmap_parselist_user);
 
-- 
2.17.1

