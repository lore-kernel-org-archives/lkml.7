Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFD1C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FCE20651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDIow5I8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfDERc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:32:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37505 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbfDERcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:32:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id w23so3389319ply.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dv3Jl+lJgTqBCARBRY0dLvW5VQs/r+eyL62vgooV/OA=;
        b=cDIow5I8gfsD0AWjfhvSU4Ln5TzE2ftDciWdcr8E6DXe1JZWgFI5Jvy8FPNnFGZGVt
         J4c1fdmlUjV1tUDJMB/cD8wwWGO4at1/GKIwVqNLyASIJ6PJE4W9A0mxOizsZbm6wUd7
         D64OD/VbwaBhd/TRujDa5FNpCLdGqnhVSXK9btkVB0hDYipo0W+bI7KskPb1bZthHpso
         s23LznY1JnJfBx+6N5rN+WiP6w38JiTTHuusrxNe4G4h0zKd64/i+jnzBc4OiuYJ5NOP
         u2/cvIpZgqzjW5A8iw8wJyOCO/wkQHGN7lHyThj3WVHb6gGFOBU0jwUE1OcfsjIVLhx1
         9B2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dv3Jl+lJgTqBCARBRY0dLvW5VQs/r+eyL62vgooV/OA=;
        b=L8zpcT7o8pstY0wX7QmIVk7ePXmU4yVSU4/IBkI3XHEuFSIvhgNq1NtENjB5D0YRzz
         lVfqUjHb67JcxDtbHLNMISsU6IygPbHpzQxz/JLVCpctBoB8SqsMDb6eVYlAt12jXRBo
         vfxyX1GrzSYv60x3SG4aW5Jjz5gHYPcxB4pwXnRl0Dadvn0xiHm5iykVtztve0g/shKx
         wSX1sTerg5eUx7jMd8UmVAGUSULzWPPL2kYm1/jjBkpHxvsZvpBC2oXASNp8uRblf9q0
         Xfx/DfUJjLxpnHBjyFz/2tLRx2jR3RvilBrWQRkulg13n56Gm+KEmO4eiC9EX21oFihb
         ISgw==
X-Gm-Message-State: APjAAAXPdDv3ruTiudSgN2M1MDI2Bl7unr0cEDCJsEqHYdajvYB3l7z9
        pNvyQ42v1Zq7aq9qP1IRk+0=
X-Google-Smtp-Source: APXvYqyf3V+LcDOH9xnut41/s/d/201fkSmXOM9XOqQlFTsQPOW/ARGRNcHlcgiTKabZVyjI7EQiMQ==
X-Received: by 2002:a17:902:b94a:: with SMTP id h10mr14382132pls.82.1554485543172;
        Fri, 05 Apr 2019 10:32:23 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id j14sm20590757pfa.57.2019.04.05.10.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:32:22 -0700 (PDT)
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
Date:   Fri,  5 Apr 2019 20:32:09 +0300
Message-Id: <20190405173211.11373-4-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405173211.11373-1-ynorov@marvell.com>
References: <20190405173211.11373-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_bitmap_parselist currently uses get_cycles which is not
implemented on some platforms, so use ktime_get() instead.

Signed-off-by: Yury Norov <ynorov@marvell.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

