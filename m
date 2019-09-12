Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FCBC49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEF82085B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxV3cVXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfILCbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:31:18 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:57252 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfILCbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:31:17 -0400
Received: by mail-qt1-f202.google.com with SMTP id m6so25946152qtk.23
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UAihQH4uSn5RAg9F05Rz9nBNcH3iynDYf3mYr8rrHrk=;
        b=dxV3cVXE53/n1Izfi1qmSoph9IuSLiaXaxqFBRHJmANJRLANTHhygEOBautN5vYLCj
         +srTSW3d5IK4BcpNRAwvJc7b1sGCmbqo6ca3DM5wec1k67X5dq6ufUWRvyVj0oeVTVVb
         7LiOgGVm050aCYaOYcAHnzBSOW2a299xVLa5UBWK3S30G4JTPwqaicDk+g6yyesuRzzY
         +hovsva0uSsVmoJDBjRVV9zsYBPq8mDDGWU1fDALy3MjJLHrakk7TzBhN6l1noAYNu9I
         nxPa9xNz4PNTaleaS2NseBdMbaj/J8e8biltj53cK7kDMdmL/HYmZaQeH+WuEPVcRYOX
         kGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UAihQH4uSn5RAg9F05Rz9nBNcH3iynDYf3mYr8rrHrk=;
        b=h3qIBPAQVjsfroIZf+sh1DvWeiJveiq5S+P45nmRRdnoFUMyFNQ8Ecz1TwRy8mpfRh
         OV37ux+0qv8Lw8/NlJ8VhscyuyeZOOcnd6uBcBBABRu/HE5BdrqRSX3OPPtfruZ7Q0Zg
         9X/K5q5jOCEz2KHEs3+WieZ1YvrX5bMlorxwih7/KgZI0OIdhN9KeuSEOIQjqYQEG6jM
         KlKBt6wp1l3DGulrIFcqxo0/wH7i/vKhRKJh8/A8w0RqYAYGl525mSK1oCSyDShPvu92
         cAz7GQEAVKKtCUolC14LIEnPUwfYs15ti0rJPYoYg+k8cV6D2daiI2tlYYQWKCVR/rXZ
         Jqwg==
X-Gm-Message-State: APjAAAWqppyANHSUQA/2RVfFaBCKZAeodNhI0q90OSnVZAiZfsRa0NLK
        8xlK5NuxNjoXXgas03ybWDDSJpvI7q0=
X-Google-Smtp-Source: APXvYqw6hIJan2hXsnpnadFHERmC023740UAU4ylmmV8A0Q1zp8plE7D7Ur2LZ+/xNarODD+17QdVSzAroM=
X-Received: by 2002:ad4:4485:: with SMTP id m5mr17828114qvt.153.1568255475679;
 Wed, 11 Sep 2019 19:31:15 -0700 (PDT)
Date:   Wed, 11 Sep 2019 20:31:09 -0600
In-Reply-To: <20190912023111.219636-1-yuzhao@google.com>
Message-Id: <20190912023111.219636-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20190912004401.jdemtajrspetk3fh@box> <20190912023111.219636-1-yuzhao@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH v2 2/4] mm: clean up validate_slab()
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

The function doesn't need to return any value, and the check can be
done in one pass.

There is a behavior change: before the patch, we stop at the first
invalid free object; after the patch, we stop at the first invalid
object, free or in use. This shouldn't matter because the original
behavior isn't intended anyway.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/slub.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 62053ceb4464..7b7e1ee264ef 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4386,31 +4386,26 @@ static int count_total(struct page *page)
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
2.23.0.162.g0b9fbb3734-goog

