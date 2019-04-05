Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7595C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7445520651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmMVaJJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfDERc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:32:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45735 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbfDERc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:32:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so3370483plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=evedRVgS+vwtuTFr7sX60VxPgfQvswCxIvhW7D/q2hQ=;
        b=AmMVaJJY9zQlddkwfaEZnkTEbL9YdXjT0r6nWdApXaFiPTsD0/n1xAdeUeKLkY60IG
         c8t6P5LFXS+bTShJuu8WZJetAYzBflK9e1gs16ck1/g2NTWE10FGjVOrRCETct/MS7iW
         eyh32093CRpKdGrhaObdWSI3o9rnJGWEdW2kGPPFwkNYI09RHz95BBuuI/FTOVDU+5xE
         e6OT9+sJBfPnOk/PGw4DwCVCaCnfnuLlpRw3zIwGZ1ZDVQ2hsmBLyJBlt2SIw2z0rqJe
         f6djFmb09iF1DX/xvwqRwrbmIs1rRrf0S/6qNrYzfroUfo6YxGT/dAFI/oNYfHogUNha
         yeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=evedRVgS+vwtuTFr7sX60VxPgfQvswCxIvhW7D/q2hQ=;
        b=dATTVxdXETe2W3aN6osM2hqShscaXRDIea+4q/EIDF+Ea4CDDHJX3kFJHWajoc+ToX
         q6STxeStc5uFdmSBG26qPWEGsPymCTP39Vt9Hk8uefiRh9Nx/KHUHei+xm+lh5JAr2di
         OPam7cQ+1wyjmaaAUwGv/Y9z4uJKQ7nwn1JZILitQ+nQfGjQQtdlqJF82ZL7Xzys3z4n
         nrlePhp9HPJhtT7fpVg97PsEdJduvEbzeZ69ns/oOlB4ryH1Yus9Pzd4UPwHRp20oNg+
         y5m9z7pyKV21ApEXCj/YygIoFsOe2BLbf5+lG4klqJpFfq5A09SI7VsfLpJdv9mUiDll
         KdJg==
X-Gm-Message-State: APjAAAUACcJDpik7rDGl7Rv56Ji1QEZXwx8T65R1SRCLoiUeElyGERr0
        JKUyEej1AIC+6oUgn/9jd5U=
X-Google-Smtp-Source: APXvYqxr5qiIuSpushvPESAOY7WuEN+Qx+5/XaKVZ41/HI0fvCs3923Pi+3kGhFfvIAXTjmvlqaYew==
X-Received: by 2002:a17:902:2bab:: with SMTP id l40mr14247372plb.273.1554485546431;
        Fri, 05 Apr 2019 10:32:26 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id u13sm47734276pfa.169.2019.04.05.10.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:32:25 -0700 (PDT)
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
Subject: [PATCH 4/5] lib/test_bitmap: add testcases for bitmap_parselist
Date:   Fri,  5 Apr 2019 20:32:10 +0300
Message-Id: <20190405173211.11373-5-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405173211.11373-1-ynorov@marvell.com>
References: <20190405173211.11373-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for non-number character, empty regions, integer overflow.

Signed-off-by: Yury Norov <ynorov@marvell.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

