Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3278AFC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC8D206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFRLU+l6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbfKHTkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:40:08 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:35451 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbfKHTkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:40:07 -0500
Received: by mail-yw1-f73.google.com with SMTP id g69so5558183ywb.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 11:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BUf7DlC8KOjDmfM/44KHetV3OBL2X58EJCpCC2vw9nk=;
        b=iFRLU+l6PnDC17hmhg0Gxuom3QmP9xuyBKqzPyhgnEee0gxT6vS9VaLO0uTYBr5J+G
         8FieMoMq9P/S5ScK1GvTz9tgwgQGrORgv7R1AS71uwUXTR2DasFAcL+fFJ0Ks7mm3nh1
         +0lw+vrgSNG84YQBfESvfqwzWsbqwapSVMtvkunGWlCwqmix0FGrESR8kCXJtWmfTA8S
         D+hM+/zx61vleziG/noNo5S2GuHZW7qyj8/o7QayZXklR1g0ULuLpr0O4lRXtHZpN3Fb
         FB7ix9eDvKUDa+gNz3DFiGqY5qTYdFiX2rZlZKuv8Tvw4Sqsv2gt+l9Q7UDUhuplJwVD
         o2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BUf7DlC8KOjDmfM/44KHetV3OBL2X58EJCpCC2vw9nk=;
        b=L8wKVkKMrcD/SYBRy5PpKxY3MHRGXawXvt7bMM/SbMequclVZddnzhiOFmQf5Ic7/C
         qr2SucRi3EllWMWjIjcpNVjvspEVk7aeUVQIo/c0qE/+c/xN2eoTX7mAUrkSAIT4HLPz
         SrK5zY2Z/Yu5zed+cUWDpgAqNj/xXYp3xwuotArjExDy14mkoT/v+p+qTYKC3zsmtcpr
         xAD2B5D57HQxa+9N/hhKOEvoUdOWS3K+THVlhZRS7J68KMFUv2hN6P/oDThTzHyEworp
         Q0Q+bcCHOg8zhsvXJorUXMK0mxUcBU+3UNIJHZV+8Bi9JKaLK06a8A2YTNk85j1RVBUC
         udtg==
X-Gm-Message-State: APjAAAXWNFQQTBkNGj4Jqt98+uZVZyg9Z/w9OiiyIa0pv/4mdVJLslxB
        h5Xfo6xP5SlPmASLc3nWX3EY9U6/fEI=
X-Google-Smtp-Source: APXvYqxDhhSALbA0LlJj0Z/4/mxS3E7lafXisg2ns+Gwu/FRwdEjbH3L/S19fN6+uPqqkLWHuzjq/Q9Iqf0=
X-Received: by 2002:a81:5557:: with SMTP id j84mr8618451ywb.392.1573242006431;
 Fri, 08 Nov 2019 11:40:06 -0800 (PST)
Date:   Fri,  8 Nov 2019 12:39:57 -0700
In-Reply-To: <20190914000743.182739-1-yuzhao@google.com>
Message-Id: <20191108193958.205102-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20190914000743.182739-1-yuzhao@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 1/2] mm: clean up validate_slab()
From:   Yu Zhao <yuzhao@google.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function doesn't need to return any value, and the check can be
done in one pass.

There is a behavior change: before the patch, we stop at the first
invalid free object; after the patch, we stop at the first invalid
object, free or in use. This shouldn't matter because the original
behavior isn't intended anyway.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/slub.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b25c807a111f..6930c3febad7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4404,31 +4404,26 @@ static int count_total(struct page *page)
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
-static int validate_slab(struct kmem_cache *s, struct page *page,
+static void validate_slab(struct kmem_cache *s, struct page *page,
 						unsigned long *map)
 {
 	void *p;
 	void *addr = page_address(page);
 
-	if (!check_slab(s, page) ||
-			!on_freelist(s, page, NULL))
-		return 0;
+	if (!check_slab(s, page) || !on_freelist(s, page, NULL))
+		return;
 
 	/* Now we know that a valid freelist exists */
 	bitmap_zero(map, page->objects);
 
 	get_map(s, page, map);
 	for_each_object(p, s, addr, page->objects) {
-		if (test_bit(slab_index(p, s, addr), map))
-			if (!check_object(s, page, p, SLUB_RED_INACTIVE))
-				return 0;
-	}
+		u8 val = test_bit(slab_index(p, s, addr), map) ?
+			 SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;
 
-	for_each_object(p, s, addr, page->objects)
-		if (!test_bit(slab_index(p, s, addr), map))
-			if (!check_object(s, page, p, SLUB_RED_ACTIVE))
-				return 0;
-	return 1;
+		if (!check_object(s, page, p, val))
+			break;
+	}
 }
 
 static void validate_slab_slab(struct kmem_cache *s, struct page *page,
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

