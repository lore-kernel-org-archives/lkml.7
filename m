Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CF7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4613020811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKsWkQeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfCYVIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:08:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34632 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730409AbfCYVIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:08:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so5644197pfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=23+V50N6WAn/6uQttan8JvUAP338C9/jI8+NG3yi1Us=;
        b=rKsWkQeo+Hq6vtEudzMYqCxLP7tbv68zDMryIGFxpXRTHsV+Tz8f6tjQHv0DYbDtjg
         a1QhbOtdpNVLi0L4zyWnMbMee9ceDguBQMHYYeK3LGM6pQAMPedvhObl7pM9Cf1ZkNpO
         3gy+C3H/q9NsuWRZHSGdw+5bfQkYCaDh7G6QzjBvF102HEqFO2+daad7uOKUbkf/1u45
         WchvcSBnjg8OjneX3ohW8n+y40wFXk1sPGmyBm2O64+D0h+06k4gbbUJ4HLx8C3Wb50e
         uUjXoPQvPmW/HiBURdtjn1hJbLwNH8kQF1MfMMyqI9kGj/edtvLYiiRlhaqURIa34dGg
         rm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=23+V50N6WAn/6uQttan8JvUAP338C9/jI8+NG3yi1Us=;
        b=XCttfu3h3l7YWlaSRxUrnmxfQFtBs9OrMA+s3FvJ7hlbM6WiOjZECrDTf/norUxqCe
         NvoW23D6TWsI0aEYCsXmQSNmpSAnHgX5OatwRyvtEQnwwJopVFzbKiRgB1zoRrxDzftj
         07WzwmTixgWDLaCmXQbg4zhohFuFbMbNJvDYC+IIyJvojyOs1ScSGN9XEtsUXReQB3kN
         p6k33vReuqNqF+P3I91fgnUwtSktsX0+OBJbLvFAt5N6691c3z9s39c/R+0GxGYKSlLC
         jviAFj8Uidl4t4dKeU48I7weI2J/Bbglcpngb+OU9+dtINRzO5eaKL6HxYBPX0xmSkUz
         I0zQ==
X-Gm-Message-State: APjAAAUNpRam1CtwJ4+fetGPuXKdTADdcv6HHqpAvrDS4q5anagEAjBc
        SkfoLfh4QuIgHkc5IVYZFgw=
X-Google-Smtp-Source: APXvYqwxSnb0+BmrbNfX2IfeHwtXQTwUH4K0prCiuOEE0cATLzyrBbjO4CO4nsVPIojBNgnhiWdRCQ==
X-Received: by 2002:a65:6203:: with SMTP id d3mr25439307pgv.109.1553548079643;
        Mon, 25 Mar 2019 14:07:59 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id i1sm1145752pgc.63.2019.03.25.14.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:07:59 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] lib/test_bitmap: add testcases for bitmap_parselist
Date:   Tue, 26 Mar 2019 00:07:47 +0300
Message-Id: <20190325210748.6571-6-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325210748.6571-1-ynorov@marvell.com>
References: <20190325210748.6571-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for non-number character, empty regions, integer overflow.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/test_bitmap.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index b06e0fd3811b..709424a788ee 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -224,7 +224,8 @@ static const unsigned long exp[] __initconst = {
 	BITMAP_FROM_U64(0xffffffff),
 	BITMAP_FROM_U64(0xfffffffe),
 	BITMAP_FROM_U64(0x3333333311111111ULL),
-	BITMAP_FROM_U64(0xffffffff77777777ULL)
+	BITMAP_FROM_U64(0xffffffff77777777ULL),
+	BITMAP_FROM_U64(0),
 };
 
 static const unsigned long exp2[] __initconst = {
@@ -247,19 +248,34 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, "1-31:4/4",			&exp[9 * step], 32, 0},
 	{0, "0-31:1/4,32-63:2/4",	&exp[10 * step], 64, 0},
 	{0, "0-31:3/4,32-63:4/4",	&exp[11 * step], 64, 0},
+	{0, "  ,,  0-31:3/4  ,, 32-63:4/4  ,,  ",	&exp[11 * step], 64, 0},
 
 	{0, "0-31:1/4,32-63:2/4,64-95:3/4,96-127:4/4",	exp2, 128, 0},
 
 	{0, "0-2047:128/256", NULL, 2048, PARSE_TIME},
 
+	{0, "",				&exp[12], 8, 0},
+	{0, "\n",			&exp[12], 8, 0},
+	{0, ",,  ,,  , ,  ,",		&exp[12], 8, 0},
+	{0, " ,  ,,  , ,   ",		&exp[12], 8, 0},
+	{0, " ,  ,,  , ,   \n",		&exp[12], 8, 0},
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

