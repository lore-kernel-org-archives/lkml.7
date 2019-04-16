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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF45C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4A92086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IldO9Sf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfDPGi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:38:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41576 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfDPGiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:38:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so9869288pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 23:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pRnfcxxF0jHSMVn1cI2h6p5u4B1/Qp7ZEUiQb3IP4N8=;
        b=IldO9Sf2gqvOSJpttM174k/AU0g3FJCl/jzWlikMspbRM9oUC+M3iqPg11MScFEvh6
         MyaIgJgY354EyXwtIZB8GsGDFDvleouT6+HNjc9Wcr1FGZOBW0x63gDLT9IwChHuimp7
         g4bAWg3EB9z+6PEWXWqvbVXRk/91hjtlwhfdC6NkOqkTdt82X2Yf6wXFX1DDJu5JUr6t
         HLmFH6x4Z3QIvjXVASOg+GZFCdIMZIGIiA1UuwrKZH4s3L6/NRi3/kxwtFPpJwdG6LG9
         3boQt/HxOnMv6oCIarE/8Q4oPMtmb7Ba5Pimp1vCN1dP/Th60Rig9owkmb485XizIMuP
         7Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pRnfcxxF0jHSMVn1cI2h6p5u4B1/Qp7ZEUiQb3IP4N8=;
        b=M5qO48KCf3bcZpJ+Q5r1KwMiDEcn4Kf1WuxbfmKfv94Y2YIEP1DU2M3wKC6YiabOF3
         d8DnzdXQSwNaerN/PXZqgSqgT59jD37en/z+SB1uVmcGTqLKDhqdwlL4QvPBJOrNnQ3H
         jXMNUh+xp7ObNDdVUsB3BVL1bdhlqvm4F9/bSilBjoHYjRWdwG/IDPRzumzPP8Oj47id
         E7MpcIztg/ATC+v1JFUI2/i4L9992WaFwmG90qAxAvJRA6nhTM+J23gtRdjv624Bl8L8
         vn6b8Ye7oBrETy93qmsOJkEMZPEABAzU9EpZmSuc0B2nQmMDoXNjoQVBIkJLetHnojaC
         uK7Q==
X-Gm-Message-State: APjAAAUsnfdhS6Qq/Fq0+A5e1lwVGvUW3DV2OZqZTv9WbIyqi19ZXJoQ
        OD+caNsk40rSqYbIStAnVZ0=
X-Google-Smtp-Source: APXvYqxpcPQ6v0supFxmpQnl9spvdYjlqKeTpygjMk+tRcfrQcvY8zYXpDoLk+V8jSu2kT4VQxLtkQ==
X-Received: by 2002:a63:5b4d:: with SMTP id l13mr71347994pgm.160.1555396690705;
        Mon, 15 Apr 2019 23:38:10 -0700 (PDT)
Received: from localhost ([2601:648:8303:5c60:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id c17sm75365649pfd.76.2019.04.15.23.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 23:38:10 -0700 (PDT)
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
Subject: [PATCH 3/5] lib/test_bitmap: switch test_bitmap_parselist to ktime_get()
Date:   Mon, 15 Apr 2019 23:37:59 -0700
Message-Id: <20190416063801.20134-4-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416063801.20134-1-ynorov@marvell.com>
References: <20190416063801.20134-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <ynorov@marvell.com>

test_bitmap_parselist currently uses get_cycles which is not
implemented on some platforms, so use ktime_get() instead.

Signed-off-by: Yury Norov <ynorov@marvell.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_bitmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 792d90608052..63d4a21955f0 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -268,15 +268,15 @@ static void __init test_bitmap_parselist(void)
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
@@ -293,8 +293,7 @@ static void __init test_bitmap_parselist(void)
 
 		if (ptest.flags & PARSE_TIME)
 			pr_err("test %d: input is '%s' OK, Time: %llu\n",
-					i, ptest.in,
-					(unsigned long long)cycles);
+					i, ptest.in, time);
 	}
 }
 
-- 
2.17.1

