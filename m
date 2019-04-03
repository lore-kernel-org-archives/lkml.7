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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C19C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1602084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhbZ5oG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfDCEqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:46:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34424 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfDCEq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:46:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so7676908pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ieZaSsrV/WeKWZta4n3OTgkHAop3JCEPGBBBuAwt6D4=;
        b=RhbZ5oG8DettYsmOD1A5Soa7I/Co7oJRDKsLsgC8LVj36Kga6l5B2e9iFbs+e7VCfJ
         S3t4AWqbgQv9kWm3zxWYlPdc8YhNOp7kFEN9JmHAhpxJlzj13JQL4gUL2ddJ0kNerHiQ
         9w6saHCbFY6Iky+HGTwUA41z5EZllvWUftJW8Yx44Xh2RBroIGFWacvILmoaq1ksmWGx
         W5bO5YTTGOFrTzdd8OJASZmhLZD6dKqy36U37fX7SzyBIRRh6+D70Tu5XPNGqI9kH/LR
         niFPNC75Bzrz6vvY96f2Buqu6ex0WacezFEpEv+odMuf8IadqtvnE/Ma7gmpkCoqk2Rt
         Xs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ieZaSsrV/WeKWZta4n3OTgkHAop3JCEPGBBBuAwt6D4=;
        b=CZcnkThqEjgy39/PeV6JNROcAbgdiZHRl+D9CR7pji7uSxmDXgrJ6hNjEL/LvwUeJd
         Djj586TbmI+deaKKvVHSgLtTkzEvhabxl+l+5vMWnQuiLX8GtbxXdoaZB6cqFmJMuf9u
         j+pa/qmhDU1CKgfi8RrDeyQrFU8rxnYXVnj017hZkMEkGKh1T9A9WMBhE4uBuQgx4/A3
         Xbq5iYE/pKKt31NBC/dBjlBQzBikD4u/9sGcYKdkVT+uy1lGZV+FMyfukDHGrO7FBqnb
         kJ5x+PXdgc+v0LjPFJTGLX0n1zWEiMNeZ0nlg5ekGgw/+DpRO4prIzk7TwEn226Yl9p9
         goNg==
X-Gm-Message-State: APjAAAXSeYYDFIMHHFufFADIqqpxUnaR7zvMQfEqjQVTkgdpCscWdC4h
        bqvKViD+jh6ODgqB95OgS4g=
X-Google-Smtp-Source: APXvYqw4P3cl4ndyDqZFgg6yITqSPrjc+jgkoF53aUng3PqVdPrhIyxWbx1iySNiXRMcdaDxTqDz8w==
X-Received: by 2002:a62:b602:: with SMTP id j2mr59927525pff.68.1554266787782;
        Tue, 02 Apr 2019 21:46:27 -0700 (PDT)
Received: from localhost (c-71-202-79-220.hsd1.ca.comcast.net. [71.202.79.220])
        by smtp.gmail.com with ESMTPSA id q86sm35577407pfi.171.2019.04.02.21.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:46:27 -0700 (PDT)
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
Subject: [PATCH 3/5] lib/test_bitmap: switch test_bitmap_parselist to ktime_get()
Date:   Wed,  3 Apr 2019 07:45:38 +0300
Message-Id: <20190403044540.16322-4-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403044540.16322-1-ynorov@marvell.com>
References: <20190403044540.16322-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_bitmap_parselist currently uses get_cycles which is not
implemented on some platforms, so use ktime_get() instead.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/test_bitmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6cd7d0740005..b06e0fd3811b 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -266,15 +266,15 @@ static void __init test_bitmap_parselist(void)
 {
 	int i;
 	int err;
-	cycles_t cycles;
+	ktime_t time;
 	DECLARE_BITMAP(bmap, 2048);
 
 	for (i = 0; i < ARRAY_SIZE(parselist_tests); i++) {
 #define ptest parselist_tests[i]
 
-		cycles = get_cycles();
+		time = ktime_get();
 		err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
-		cycles = get_cycles() - cycles;
+		time = ktime_get() - time;
 
 		if (err != ptest.errno) {
 			pr_err("test %d: input is %s, errno is %d, expected %d\n",
@@ -291,8 +291,7 @@ static void __init test_bitmap_parselist(void)
 
 		if (ptest.flags & PARSE_TIME)
 			pr_err("test %d: input is '%s' OK, Time: %llu\n",
-					i, ptest.in,
-					(unsigned long long)cycles);
+					i, ptest.in, time);
 	}
 }
 
-- 
2.17.1

