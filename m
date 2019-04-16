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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4147C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EE92086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/BJVvB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfDPGiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:38:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35244 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfDPGiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:38:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so9886532pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 23:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hXYGx1mgEuhuT52norCb+BcbXfvZgVSWApsnetv/ixc=;
        b=X/BJVvB9Zo7aPTH3uFGGKUNcW30/AR2paFVnBiLXaicn131DUSc8DLOwt4aG4rKhu0
         nmNGUCQnXUEoay1RIITwesN/YpUvYkp5AlgWZcKao4YLTajbQBM6m28nWqUFa8Kss6F+
         VZXjOVUgtuylUD05w496bcSEtfD57eMTCwlcgRz6rwJ8TEKG2Y5UGfwhGHK5SzdPg6P/
         wmXvJM0jVJwGtxKgbU4jOQHaWNXp8LqwJm6iSGxttN8nf937PL1ZNwIk0UPFohSTIA/G
         ivBMANdeG9bI6iyr3KeCgDAdA3pMICUwSCN0yZmEKI8sp/2OzkcKAn3F0yprP25AQMy6
         RWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hXYGx1mgEuhuT52norCb+BcbXfvZgVSWApsnetv/ixc=;
        b=ADajax+gOCjDDbkm6l9m2KKDK8vLJQ714FZEiaDHhEAxMX6G0ChBGi7bKR5FLXiSre
         QH0dMo4jWAT4AJ/taRa/igguHcbLqBs7EMI1m/WwV3WGtqN14/PwzDgKca6kKodcY00e
         GPrQVcBjNT/1Rk/Fw3av8c47MwXndiF3ZprgM76Jxw4bXhqEojuCfKx+5L0pyi46lKjn
         qpu0a6pXcjbFsRq/T3DDK0z85O8V8XpN+ciz/uRxwm0QmQ0yyxh8YPmITok3olW4VVno
         flFSnoTcq5rrLu53q8Vmbna2I0LuQgX+A5cY+T5nBqtS3QD6hKLys5aQIxx4AvJd7l+I
         A8rw==
X-Gm-Message-State: APjAAAU5IS5AO17C5CCJ66dKDs/TEuOuRymdFvIh3oNlxBgmmge2BeLk
        NalKmwEI3n7OeDsalNlRipg=
X-Google-Smtp-Source: APXvYqwtxX7hh89+ove4jMmq6RAVEkwoBSA7x8PuXkOCOl0Z8QFZDZjpskpkH0dwNdyWg+VNpVFRow==
X-Received: by 2002:a63:100e:: with SMTP id f14mr40994353pgl.192.1555396692354;
        Mon, 15 Apr 2019 23:38:12 -0700 (PDT)
Received: from localhost ([2601:648:8303:5c60:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id 13sm63910290pfi.172.2019.04.15.23.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 23:38:11 -0700 (PDT)
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
Subject: [PATCH 4/5] lib/test_bitmap: add testcases for bitmap_parselist
Date:   Mon, 15 Apr 2019 23:38:00 -0700
Message-Id: <20190416063801.20134-5-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416063801.20134-1-ynorov@marvell.com>
References: <20190416063801.20134-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <ynorov@marvell.com>

Add tests for non-number character, empty regions, integer overflow.

Signed-off-by: Yury Norov <ynorov@marvell.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_bitmap.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 63d4a21955f0..6640a82ad44b 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -226,7 +226,8 @@ static const unsigned long exp[] __initconst = {
 	BITMAP_FROM_U64(0xffffffff),
 	BITMAP_FROM_U64(0xfffffffe),
 	BITMAP_FROM_U64(0x3333333311111111ULL),
-	BITMAP_FROM_U64(0xffffffff77777777ULL)
+	BITMAP_FROM_U64(0xffffffff77777777ULL),
+	BITMAP_FROM_U64(0),
 };
 
 static const unsigned long exp2[] __initconst = {
@@ -249,19 +250,34 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, "1-31:4/4",			&exp[9 * step], 32, 0},
 	{0, "0-31:1/4,32-63:2/4",	&exp[10 * step], 64, 0},
 	{0, "0-31:3/4,32-63:4/4",	&exp[11 * step], 64, 0},
+	{0, "  ,,  0-31:3/4  ,, 32-63:4/4  ,,  ",	&exp[11 * step], 64, 0},
 
 	{0, "0-31:1/4,32-63:2/4,64-95:3/4,96-127:4/4",	exp2, 128, 0},
 
 	{0, "0-2047:128/256", NULL, 2048, PARSE_TIME},
 
+	{0, "",				&exp[12 * step], 8, 0},
+	{0, "\n",			&exp[12 * step], 8, 0},
+	{0, ",,  ,,  , ,  ,",		&exp[12 * step], 8, 0},
+	{0, " ,  ,,  , ,   ",		&exp[12 * step], 8, 0},
+	{0, " ,  ,,  , ,   \n",		&exp[12 * step], 8, 0},
+
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
 	{-EINVAL, "0-31:", NULL, 8, 0},
 	{-EINVAL, "0-31:0", NULL, 8, 0},
+	{-EINVAL, "0-31:0/", NULL, 8, 0},
 	{-EINVAL, "0-31:0/0", NULL, 8, 0},
 	{-EINVAL, "0-31:1/0", NULL, 8, 0},
 	{-EINVAL, "0-31:10/1", NULL, 8, 0},
+	{-EOVERFLOW, "0-98765432123456789:10/1", NULL, 8, 0},
+
+	{-EINVAL, "a-31", NULL, 8, 0},
+	{-EINVAL, "0-a1", NULL, 8, 0},
+	{-EINVAL, "a-31:10/1", NULL, 8, 0},
+	{-EINVAL, "0-31:a/1", NULL, 8, 0},
+	{-EINVAL, "0-\n", NULL, 8, 0},
 };
 
 static void __init test_bitmap_parselist(void)
-- 
2.17.1

