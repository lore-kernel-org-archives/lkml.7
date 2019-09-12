Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725C9ECDE20
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 00:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C1A2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 00:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emTzcJuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfILA3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 20:29:36 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:32947 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfILA3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 20:29:36 -0400
Received: by mail-pf1-f202.google.com with SMTP id z23so16989648pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 17:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M01d621+jXOeVOtLJvHlUCtiCRQEegusNaDlr2i35Sc=;
        b=emTzcJuXyc5nXp177ZHSHM8HRgJfjg3AKpTSMVLcZPdalmHovft+I1D/7rzfw7VwOh
         TlZYaA9+3FzgumZ+RmUsufI0V/n9gzRG3pZXqutN06yAcgJt/SV7SPgcD1uHe1bapO8t
         pcRbfp5fwduu7biTVNP4wRAtinetu06gIfYvCWzh2pfRxUg7mw2sWs5fnqof+qga3iIm
         Or/iDBDSWjDF+sv/XzgUN4QNq3Pw2/2ZKSs8PySJ2YSsGIJb+LAN/tFQRABq8+lH/lGv
         x4yNOaqzuMJa5G2QTcYWyZrq5ba+nKdHTZubsrpCMU3gPreVF2x1MyXKdSdRssDqBoRT
         rkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M01d621+jXOeVOtLJvHlUCtiCRQEegusNaDlr2i35Sc=;
        b=qHf31UJBXBxoNLjFiU+ENoJyvGh7RXHL9fBh3pgVMxouyot6V8QCXcY0iaLtObzNRy
         nvJRcjpDuxHa622P7j960fomIm7cV6rSI5V/ZE91+ppckAyXaBpROmv0/G6Pe8XoyA4q
         yssPUrZV1uyLByJ05P5yyY8N6Tv2ZKWNUuT7GrZoAc/X/eBZeH6LOg/9I+luevp77VpW
         BBmDRtGHS/RLn9dIm50zujvWF97sg4tlg7G4XerIx8pqaJq38g0slYbfKFYT87/7QNFr
         GUx+3wTb7qbxxr7cmZdqBjbGnDgFIZoTff+MWAkbZG6XXqdR1POkwvVCp7UHG8cUPAS5
         Bn4Q==
X-Gm-Message-State: APjAAAUl/jg5t+eBz/0KYtV8j9s9x4/nhftbyU59K2+1LDE2dGLujvTR
        5v2nKgXWppRhL+Gpadaex2gRY1JtHes=
X-Google-Smtp-Source: APXvYqxShYmRyX+l6llhto+SBqnYvELJgOERr5ICSUVl9FZCgvwep6WW53CesQ7KOZtdnfKF0jdq059FEGo=
X-Received: by 2002:a63:3009:: with SMTP id w9mr36922043pgw.260.1568248173618;
 Wed, 11 Sep 2019 17:29:33 -0700 (PDT)
Date:   Wed, 11 Sep 2019 18:29:27 -0600
In-Reply-To: <20190911071331.770ecddff6a085330bf2b5f2@linux-foundation.org>
Message-Id: <20190912002929.78873-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20190911071331.770ecddff6a085330bf2b5f2@linux-foundation.org>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH 1/3] mm: correct mask size for slub page->objects
From:   Yu Zhao <yuzhao@google.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mask of slub objects per page shouldn't be larger than what
page->objects can hold.

It requires more than 2^15 objects to hit the problem, and I don't
think anybody would. It'd be nice to have the mask fixed, but not
really worth cc'ing the stable.

Fixes: 50d5c41cd151 ("slub: Do not use frozen page flag but a bit in the page counters")
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/slub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8834563cdb4b..62053ceb4464 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -187,7 +187,7 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
  */
 #define DEBUG_METADATA_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
 
-#define OO_SHIFT	16
+#define OO_SHIFT	15
 #define OO_MASK		((1 << OO_SHIFT) - 1)
 #define MAX_OBJS_PER_PAGE	32767 /* since page.objects is u15 */
 
@@ -343,6 +343,8 @@ static inline unsigned int oo_order(struct kmem_cache_order_objects x)
 
 static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 {
+	BUILD_BUG_ON(OO_MASK > MAX_OBJS_PER_PAGE);
+
 	return x.x & OO_MASK;
 }
 
-- 
2.23.0.162.g0b9fbb3734-goog

