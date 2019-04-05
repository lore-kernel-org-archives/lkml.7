Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC81DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B76420651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPLqQhFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbfDERcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:32:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37468 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbfDERcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:32:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so3652737pfr.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DnkdoCv7Hr0cJCeFe7z0xPyqrGSuU3Fy6/IQeMTIbdw=;
        b=TPLqQhFgcwLbx/V6ZtDU4AJsExwWequMfv9JUiyRWaERtqt8v9wh6pUIrPcwXkvtiJ
         0mJb1C3m0V+xImyTXa8PURspEXa0lru3mkfkqgMFnzfKQ87i/YoToeOuzddeF3bohaOr
         5459lkQQuDFxmjwXsQnjMOJiU/wvaYcdjxR1LZmtYneuP/2OasSPKZFBP3jSV0CHbQ8g
         PYA699uxBC0zzgEv5cNfJUXKTWYZxrZquWOga87PXyiqpMWWhYkxzt4NRzC98xC7P1zL
         TrmTmsM1ycrKHNet0aoKSgMhey/nLpLN5/q5Fp4Nbi7o8IXlTcl/ll4PFqGGy8dEeCoC
         yBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DnkdoCv7Hr0cJCeFe7z0xPyqrGSuU3Fy6/IQeMTIbdw=;
        b=PuQg0cEQkrkAbTgnvgsplJUiohuQVF7bu/pDiRTHTQBjrKfnXufMSNVqdnRtSy6uDo
         BChV8tao7T99RvOwzCQIXhsLnZpXH4GQy1DWPi6q0Rb1JpGOW8OFOk6dzdZDy5cnFD9l
         IwzUIDKVvNaZWUipJ2j4YuuhoIPoXJn8eTNAJBL9jIa25Qq7YnrRcxlgurbHdz7BlvCz
         +JbP2CN32RUAQy7j4WpRkJTclVEsE9F2yyACwoKiwAE9/IssUMazzRbhSTB4yiPKwCRL
         WT2QaC5IFN57zWL/MBtvpxgHYiyv4pP44Nsi+tRpf32uxlA70fAdVQz4dF7Dac95kirt
         vFLA==
X-Gm-Message-State: APjAAAWnxdcOk4GSJZwcMdQQ+GX4bBLtI+MqTVh+VZfUMRIXYIjV81Bp
        gIp7jurmHQ8PnDxr2Z10FPhA69cF
X-Google-Smtp-Source: APXvYqzihtKeyimThNn0Qn4IyZovGkPAkdYD2znk60991hTOoajWvIJFM3XYYBfp2yruEfIuR3z8yg==
X-Received: by 2002:a62:1c13:: with SMTP id c19mr13765471pfc.11.1554485537958;
        Fri, 05 Apr 2019 10:32:17 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id 66sm43430774pfr.44.2019.04.05.10.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:32:17 -0700 (PDT)
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
Date:   Fri,  5 Apr 2019 20:32:07 +0300
Message-Id: <20190405173211.11373-2-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405173211.11373-1-ynorov@marvell.com>
References: <20190405173211.11373-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we parse user data byte after byte which leads to
overcomplification of parsing algorithm. The only user of
bitmap_parselist_user() is not performance-critical, and so we
can duplicate user data to kernel buffer and simply call
bitmap_parselist(). This rework lets us unify and simplify
bitmap_parselist() and bitmap_parselist_user(), which is done
in the following patch.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 98872e9025da..79ed5538617b 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -632,19 +632,22 @@ EXPORT_SYMBOL(bitmap_parselist);
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
+	buf = memdup_user_nul(ubuf, ulen);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = bitmap_parselist(buf, maskp, nmaskbits);
+
+	kfree(buf);
+	return ret;
 }
 EXPORT_SYMBOL(bitmap_parselist_user);
 
-- 
2.17.1

