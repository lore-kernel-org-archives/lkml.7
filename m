Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C897C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9352073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R89rRBdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfDPGiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:38:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37560 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDPGiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:38:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so9824199pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 23:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NaqF5nri+uM/Z7PdWzLBy5sLBZpzRLF+ZQiF2dS6/U=;
        b=R89rRBdXKadbr+eg8z21CCGws3OhXnTFiZ0qa5/qKCwDx6ffjJU5aa+TCCOKMKPiN1
         a62udR9B9ulkIfz5yMSBVTFkh01XwmHGr2TCdQQ5OHSeN0ly5VNUbPEdxnL9vyhL+7MC
         BnKJvO3cI2HSl5oLqlHkdZUUypTnCdmj//OU3PskWBjHekNI393kduiNnkbqnBc3WJ2C
         gEXMF0vvrUL/N98WXJr52APi8hMV1W4QogpMaLoOZu6mGD7fJxduFDleUiavELA2eITm
         BPpqMWMRHmoEm7L5sGKPNML7LRlH89Qvr4j58xjBVzhKl/I0gu7vycAQTMm6T7ca/xQM
         6AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NaqF5nri+uM/Z7PdWzLBy5sLBZpzRLF+ZQiF2dS6/U=;
        b=DhYAPwOVI6TJ5Ptf+ZQ/Z6/Ji31qgoT45xuXvkYx6X9iQUKCpAmbsL4xmpT1rAO6WG
         lgbZAHSLkv5+sj0DU255IrGBpCZ7669z80unmXcvSrCCcEuIxEO7iDX+2gbjeIcURyNw
         B3E3N1/VVJrgh2MZu12NNNrYZKdPUElRRy5hZR9gposZVd4yVs3UF1gD9S45LAWCTc1K
         nncNacgrtKcc+RrtL7H2tHe8/sG34Ipu3b0O9nh6oU4lA1NIAsIJbI5dUr2bT0+t/Zt4
         6jonLtwSlQbQ9ah2Vo2K5AjESZ7qtVEmKcmjadLPXGXT/RG6iTLibRe3S4Tyj/xODpm/
         IcKQ==
X-Gm-Message-State: APjAAAXgxk7wIHwOnPF3FkRb919BZKmufzLzsRgq477dHQD960zLHuiR
        4SMkykt6kJ2DPnpFIHpv/1Y=
X-Google-Smtp-Source: APXvYqxFUmVzuuKeq+wp3o4z1MZWxet+FU7eqxLPJOIlE7UtdlXOuRN3YKdy60iRhtltroEoeaaYwg==
X-Received: by 2002:a62:ac08:: with SMTP id v8mr79667632pfe.42.1555396687637;
        Mon, 15 Apr 2019 23:38:07 -0700 (PDT)
Received: from localhost ([2601:648:8303:5c60:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id 6sm40197080pfp.143.2019.04.15.23.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 23:38:07 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] lib: make bitmap_parselist_user() a wrapper on bitmap_parselist()
Date:   Mon, 15 Apr 2019 23:37:57 -0700
Message-Id: <20190416063801.20134-2-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416063801.20134-1-ynorov@marvell.com>
References: <20190416063801.20134-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <ynorov@marvell.com>

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
index 3f3b8051f342..c63ddd06a5da 100644
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

