Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51208C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A8020811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBwxO0lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfCYVIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:08:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45829 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYVH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:07:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so7153950pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AfSasF4ESmaNxEnBAphRt12g8m4mIXQ+iB7utXewbsY=;
        b=QBwxO0lhzjblZU4xfLFjKAtbqazVfIlsQ4DtJoXrQIOc7KHvyfq1pno1xCvGWkiUId
         o0Zu4kteSy0mjhqnt8XX2it17PgAHbjMBVPQ2iZNLKZB21Bn7NFnnst3891mj7Uo3xxi
         6tpZVEEGE+gy2geQVBISLWtKclJBz+dntfa0/Pl9Q7WYNczzVJmDXSa2qRI0t8oTFqsn
         uY0D80eVNZVNOs71tMtgLwdO9uW/qJFtWX2IGNgy3/+lG24pMHu8PiDvlUTG53AfDAL+
         pAS4UesuKKOJ5kSjy+w7Sfd0+O7lUVU+6d/1sf3SOOrW+cnVUuGpuHXxcjM2NF/xDGst
         ZZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AfSasF4ESmaNxEnBAphRt12g8m4mIXQ+iB7utXewbsY=;
        b=VUFp5bFcrBpopbWvetM/Tagq7sRoPlVNh+g2LWzhTTBdoZZBGsYehyxxXcNEdwdEG5
         1fiG7m1N9To6tG77/oIXJjytf5lEyZ/ohDajo3w/ERjOzrQxwUz5rBbOnrBCi8iLXUIG
         5J4JWskCbXMReiUCjHmFTLekE0bxkYOJ0HoPNUNrdmP7oSex+3o7H+Rgv+Dgqft5CvIO
         f34Bqt5DiMHRld3Rm9vOglyO1Qvdgd2+sHibn/U7YC9LIyuxTvFvea6t9pDEnT0bVEI1
         QKD6zNd6CXYjv8MwrKeo9Gchqbd0l2z/Xskcjv8oJa53/sF42AEzebwif2C5MAtUSAy6
         sMaA==
X-Gm-Message-State: APjAAAWDwVDH03IqaM44RO6wRq6bY+IlkK9obQ5b0bGTN/AxF4z9kVoj
        dhhmbbou1B9/7yGCSz5dcZk=
X-Google-Smtp-Source: APXvYqxnBNsqdRJiZykkGIs3cgWyDak+h3R2fXqFFV28geAunuEqqBmQ4gRcN6S5089pDwA5mRA0Wg==
X-Received: by 2002:a62:ee03:: with SMTP id e3mr26493491pfi.241.1553548078215;
        Mon, 25 Mar 2019 14:07:58 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id l64sm26550983pfj.179.2019.03.25.14.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:07:57 -0700 (PDT)
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
Subject: [PATCH 4/6] lib/test_bitmap: switch test_bitmap_parselist to ktime_get()
Date:   Tue, 26 Mar 2019 00:07:46 +0300
Message-Id: <20190325210748.6571-5-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325210748.6571-1-ynorov@marvell.com>
References: <20190325210748.6571-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_bitmap_parselist uses get_cycles(). Only arm, arm64, openrisc,
riscv and sparc64 implement get_cycles() and others take a stub from
include/asm-generic/timex.h.

So, switch to more generic ktime_get().

Fixes: 6df0d464dbcc1a55 (lib/test_bitmap.c: add test for bitmap_parselist())
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

