Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905A3C49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6260320678
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POAOLSgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfILCbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:31:15 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34306 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfILCbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:31:15 -0400
Received: by mail-pf1-f201.google.com with SMTP id v6so5445712pfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 19:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M01d621+jXOeVOtLJvHlUCtiCRQEegusNaDlr2i35Sc=;
        b=POAOLSgRgwPfDzOISo1MKH/2QLeqTomKY/wS1QotRgVb+fnKfk6pEqTsN/5no3Yb3S
         Q5gAVgxxV+ZQKy+l3JYU/B1KiQJSM9FrAz+2rSwbmQm+8ozbJxvc6yf9QD2AWui2kVQF
         IHnCKQWi3MGZhSBAFzveRDOPGWpx/LU/lf39HC0SpCVhsnAg+l9peNmmIjSehuOq1RVW
         M/MRonGRnTVovm/fmrHgANDs4dtA5VQw1clG8EniSSFxLN36ZtbuwWeoVt164qoMELUZ
         X/rjZ1tQSHJA/LTXAUcXSM2SQMofSmH/P5odvUxHBR6hhvJsflCDHFpxxx5hCHaSOMcp
         tEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M01d621+jXOeVOtLJvHlUCtiCRQEegusNaDlr2i35Sc=;
        b=qw7otLg1auK9i3A/R8KCt8pK2/w8K9e4m6jcPWc/zP66/1GsVA1svMTDHwW729G2iu
         HvPPVhnAskmudd3PfLO52YvW2cmcyK7WuxQlqhXeWKMmb1l8AIuRJfmb6lcMg8ZJs+iq
         Q4/wRG49ZatPukFCqaekt4p8l5HCcprjBklszP1KJS7D1QTCTkb4wtGCYdUpJ1hLTFZW
         Pgct6F49o8i9Sy0yi2/N079I6EjmyAeKA4Ot1e4FLHFSyvnNbgQSLfDWmM4sYl4la0zv
         OkIdK4TWaoGOMeTGSMw/O7VV2Q+8KPqvpFRKLFIyHwWuas8Xn3/tzOwUc0r+nuJkxoTd
         XoDw==
X-Gm-Message-State: APjAAAWuXuk+Ofx795K3NEAhe4UgdN+1gUHyQQz3YxVsy/8cSYWmd9RB
        6i0D1u1ZgfS5ThKVmJ7ponIKskF+DdU=
X-Google-Smtp-Source: APXvYqyWlP3NAwE+jBFawlowdpRiaR5zP9SQNymsUcqOg03NykdEEjCnMCVUr+qahjil0jS9sKtiPxp+PvI=
X-Received: by 2002:a65:6546:: with SMTP id a6mr36882579pgw.220.1568255474084;
 Wed, 11 Sep 2019 19:31:14 -0700 (PDT)
Date:   Wed, 11 Sep 2019 20:31:08 -0600
In-Reply-To: <20190912004401.jdemtajrspetk3fh@box>
Message-Id: <20190912023111.219636-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20190912004401.jdemtajrspetk3fh@box>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH v2 1/4] mm: correct mask size for slub page->objects
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

