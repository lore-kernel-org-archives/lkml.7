Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F16C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 03:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AAE217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 03:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UbDeFUbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfE2DOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 23:14:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39504 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfE2DOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 23:14:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so635862pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 20:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hD/eJ0/FJOjJOhuFxohI1wWz9d45OVxi6wPvvITBEzk=;
        b=UbDeFUbn6+H+7cDeCBdyyk2/pkbuQGRbapGZgpbw+YvfBTA69qzhmj6RalY4Z1GmAJ
         96gemqkCUdIvOuPoweAspuOAY/TgWjSYW8thxTPbEyg0REegsCxLL/vRjdYCZ+4dgKoR
         WaUwQmow4vMUmd9h3WSp7QzvesPGtAe6Cm8Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hD/eJ0/FJOjJOhuFxohI1wWz9d45OVxi6wPvvITBEzk=;
        b=JDvwiVbMcevl0r3TLr68PDF3U1PzBYX0dt+J97RaqIt/WJd8V/vFeuoXLwJvB4x23d
         ttc+NaystphABhj4mroLJqYYJcbGTJ4bbfAPYMJKFGnbvOlAL75J+XniQv/iiU9c+lLt
         Je/7igARiYmCla5Zq/9UoN/tYaAaJq6htFztprLxxb4eJ6k8tU7hJPvhEfB05I7Cxc6K
         Wa/Q+bmqn1K/8IFU1iE4D2eVcUKPnsvl4lbLHBB2ZR/74xjCa5smAO/91OxKX3vqIqZ3
         FHmeeV20v1TChu63wt+jqc0x7xJrwbbAQEdx8g/mGVer10P7ZwYiaZXv4LsDBGYqo3aM
         AelA==
X-Gm-Message-State: APjAAAXG83d8mlplvhxCUFc0/thqU8GXm39OlqsE5UMVKOCWXSIf7CK+
        7q1yhTgH3KDTdFxHJd4iDyUfKQ==
X-Google-Smtp-Source: APXvYqxmJv/VPGnK416S7vhHeM+oice+FG61M0S6FIzZnz8d3dcshEcT5b2j0z0QEcuNWcvK8NcenA==
X-Received: by 2002:aa7:99dd:: with SMTP id v29mr147185661pfi.252.1559099675572;
        Tue, 28 May 2019 20:14:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h123sm17558075pfe.80.2019.05.28.20.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 20:14:34 -0700 (PDT)
Date:   Tue, 28 May 2019 20:14:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] lib: test_overflow: Avoid tainting the kernel and fix
 wrap size
Message-ID: <201905282012.0A8767E24@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds __GFP_NOWARN to the kmalloc()-portions of the overflow test to
avoid tainting the kernel. Additionally fixes up the math on wrap size
to be architecture and page size agnostic.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Fixes: ca90800a91ba ("test_overflow: Add memory allocation overflow tests")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: fix leftover __GFP_NOWARN (joe)
---
 lib/test_overflow.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index fc680562d8b6..7a4b6f6c5473 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -486,16 +486,17 @@ static int __init test_overflow_shift(void)
  * Deal with the various forms of allocator arguments. See comments above
  * the DEFINE_TEST_ALLOC() instances for mapping of the "bits".
  */
-#define alloc010(alloc, arg, sz) alloc(sz, GFP_KERNEL)
-#define alloc011(alloc, arg, sz) alloc(sz, GFP_KERNEL, NUMA_NO_NODE)
+#define alloc_GFP		 (GFP_KERNEL | __GFP_NOWARN)
+#define alloc010(alloc, arg, sz) alloc(sz, alloc_GFP)
+#define alloc011(alloc, arg, sz) alloc(sz, alloc_GFP, NUMA_NO_NODE)
 #define alloc000(alloc, arg, sz) alloc(sz)
 #define alloc001(alloc, arg, sz) alloc(sz, NUMA_NO_NODE)
-#define alloc110(alloc, arg, sz) alloc(arg, sz, GFP_KERNEL)
+#define alloc110(alloc, arg, sz) alloc(arg, sz, alloc_GFP)
 #define free0(free, arg, ptr)	 free(ptr)
 #define free1(free, arg, ptr)	 free(arg, ptr)
 
-/* Wrap around to 8K */
-#define TEST_SIZE		(9 << PAGE_SHIFT)
+/* Wrap around to 16K */
+#define TEST_SIZE		(5 * 4096)
 
 #define DEFINE_TEST_ALLOC(func, free_func, want_arg, want_gfp, want_node)\
 static int __init test_ ## func (void *arg)				\
-- 
2.17.1


-- 
Kees Cook
