Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5970C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52061206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sdf.org header.i=@sdf.org header.b="S6NzVGSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfC2EeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:34:10 -0400
Received: from mx.sdf.org ([205.166.94.20]:59125 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfC2EeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:34:10 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2T4VqZU005980
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Fri, 29 Mar 2019 04:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdf.org; s=default;
        t=1553833921; bh=MSlrUev1tWLvZ+5hN9M4dKFNaBlpRQgRF66IHzEREIg=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc;
        b=S6NzVGSn86KRcTDxLvasrhx8kZzwOEj53Y16+v/C8y8nVvaE0tkHgiYNiJSI/s/60
         cqzkDGsm2U1isXiTmztXQHNp+sf+UQzK1OMia2hGGTXg4gK02cdbXBHQ39szMwCpUR
         yfO8ToZP3oo8l5EzWpbMCEV3MB7wNPq7I0u5PD1E=
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2T4Vq5A024120;
        Fri, 29 Mar 2019 04:31:52 GMT
Date:   Fri, 29 Mar 2019 04:31:52 GMT
Message-Id: <201903290431.x2T4Vq5A024120@sdf.org>
In-Reply-To: <f63c410e0ff76009c9b58e01027e751ff7fdb749.1552704200.git.lkml@sdf.org>
References: <f63c410e0ff76009c9b58e01027e751ff7fdb749.1552704200.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Subject: [PATCH 6/5] lib/list_sort: Fix GCC warning
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        George Spelvin <lkml@sdf.org>,
        Andrey Abramov <st5pub@yandex.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that GCC 4.9, 7.3, and 8.1 ignore the __pure
attribute on function pointers and (with the standard kernel
compile flags) emit a warning about it.

Even though it accurately describes a comparison function
(the compiler need not reload cached pointers across the call),
it doesn't actually help GCC 8.3's code generation, so just
omit it.

Signed-off-by: George Spelvin <lkml@sdf.org>
Fixes: 820c81be5237 ("lib/list_sort: simplify and remove MAX_LIST_LENGTH_BITS")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 lib/list_sort.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/list_sort.c b/lib/list_sort.c
index 623a9158ac8a..b1b492e20f1d 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -8,12 +8,16 @@
 #include <linux/list.h>
 
 /*
- * By declaring the compare function with the __pure attribute, we give
- * the compiler more opportunity to optimize.  Ideally, we'd use this in
- * the prototype of list_sort(), but that would involve a lot of churn
- * at all call sites, so just cast the function pointer passed in.
+ * A more accurate type for comparison functions.  Ideally, we'd use
+ * this in the prototype of list_sort(), but that would involve a lot of
+ * churn at all call sites, so just cast the function pointer passed in.
+ *
+ * This could also include __pure to give the compiler more opportunity
+ * to optimize, but that elicits an "attribute ignored" warning on
+ * GCC <= 8.1, and doesn't change GCC 8.3's code generation at all,
+ * so it's omitted.
  */
-typedef int __pure __attribute__((nonnull(2,3))) (*cmp_func)(void *,
+typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
 		struct list_head const *, struct list_head const *);
 
 /*
-- 
2.20.1

