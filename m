Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67005C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319562053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Omgake2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404583AbfISUEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:04:38 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:36863 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390510AbfISUEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:04:37 -0400
Received: by mail-vk1-f202.google.com with SMTP id p63so1750472vkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VgzUh1n1rberaTXXihsqmsmieopIuBTorRpxm9/WwWg=;
        b=Omgake2bCvusDoi9TS/gj/AqeLx5vELUrVjRQKHqhEkF4Tgs2bPF15on7pAmUpSTf1
         TX75BbMM8sNz9Job3O0OlVylOKu+udFtDc19H3cEPJYtzrrJh+fx3HBKn09ouO2QuOVO
         LDna1cAUm2xmBFMEaH/DIqALGed7Kk1YxGfsKFT30uzvzaxUGN8wxB+/ATzarVrRS3O4
         lQmWEn9MMfzf3QfTpPTL2ItkdgZGZTP8JNf6pBBvXGFxg53nq3c4Svp9beVDZrgaqvgH
         ZFb9gM5KSvjCrEYfeBOOBj2vJcmDAEPvdgAGrngnL7O0IMy4HSGz8ijxnkgA359O6k3c
         2LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VgzUh1n1rberaTXXihsqmsmieopIuBTorRpxm9/WwWg=;
        b=GVT3i5ugIhna+8V0auVgTij6J9tkWHzQUrlcYIXKa+rMiyzKpi+tyjm4AsR4fe2vr0
         0WqX5qrkqouxV8AI6PXnKncEIY9yeFskNig2i06quNRbS0BIiEm72hgmN2Y717SJSK33
         ecWeuDH2Cxb7qn5ksBEEsRFfln7HCybybtnu50AZdxS6Jpts5zSCdryLyZqtslcWQnFx
         QTHMWYUynLDyIr8TXGab0opDTGSGUPQVZMokyzcyDIkk5aqFcoLxvPeKnKLmm5b+1mhl
         sPZ80Vw3PEZMJsWIlUms+xNPpYGyaoUXFuFKvW3V9g0Ms+hxi9+LMI72qbK2K1IhIb/o
         DpSA==
X-Gm-Message-State: APjAAAXXGz9C5+SDp4yn6MgfA0134qboXRdeX526Y7dOaqgJurcZdoUb
        kkH9NvAYRLZlNYVK+QkPk+sE7PI1/NnFCtyTLg==
X-Google-Smtp-Source: APXvYqzyOKasUBwfbVumiUXbU2+j6HGE8tYCxCuoJohu/6zOJWSyZX9I9TiTmOtlhlUuc6NKPZaGSAV3RwMfKd7Djw==
X-Received: by 2002:a1f:19d8:: with SMTP id 207mr5740981vkz.54.1568923476284;
 Thu, 19 Sep 2019 13:04:36 -0700 (PDT)
Date:   Thu, 19 Sep 2019 13:04:27 -0700
In-Reply-To: <20190919200428.188797-1-almasrymina@google.com>
Message-Id: <20190919200428.188797-2-almasrymina@google.com>
Mime-Version: 1.0
References: <20190919200428.188797-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH 1/2] hugetlb: region_chg provides only cache entry
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     almasrymina@google.com, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current behavior is that region_chg provides both a cache entry in
resv->region_cache, AND a placeholder entry in resv->regions. region_add
first tries to use the placeholder, and if it finds that the placeholder
has been deleted by a racing region_del call, it uses the cache entry.

This behavior is completely unnecessary and is removed in this patch for
a couple of reasons:

1. region_add needs to either find a cached file_region entry in
   resv->region_cache, or find an entry in resv->regions to expand. It
   does not need both.
2. region_chg adding a placeholder entry in resv->regions opens up
   a possible race with region_del, where region_chg adds a placeholder
   region in resv->regions, and this region is deleted by a racing call
   to region_del during region_chg execution or before region_add is
   called. Removing the race makes the code easier to reason about and
   maintain.

In addition, a follow up patch in another series that disables region
coalescing, which would be further complicated if the race with
region_del exists.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

---
 mm/hugetlb.c | 63 +++++++++-------------------------------------------
 1 file changed, 11 insertions(+), 52 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6d7296dd11b8..a14f6047fc7e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -246,14 +246,10 @@ struct file_region {

 /*
  * Add the huge page range represented by [f, t) to the reserve
- * map.  In the normal case, existing regions will be expanded
- * to accommodate the specified range.  Sufficient regions should
- * exist for expansion due to the previous call to region_chg
- * with the same range.  However, it is possible that region_del
- * could have been called after region_chg and modifed the map
- * in such a way that no region exists to be expanded.  In this
- * case, pull a region descriptor from the cache associated with
- * the map and use that for the new range.
+ * map.  Existing regions will be expanded to accommodate the specified
+ * range, or a region will be taken from the cache.  Sufficient regions
+ * must exist in the cache due to the previous call to region_chg with
+ * the same range.
  *
  * Return the number of new huge pages added to the map.  This
  * number is greater than or equal to zero.
@@ -272,9 +268,8 @@ static long region_add(struct resv_map *resv, long f, long t)

 	/*
 	 * If no region exists which can be expanded to include the
-	 * specified range, the list must have been modified by an
-	 * interleving call to region_del().  Pull a region descriptor
-	 * from the cache and use it for this range.
+	 * specified range, pull a region descriptor from the cache
+	 * and use it for this range.
 	 */
 	if (&rg->link == head || t < rg->from) {
 		VM_BUG_ON(resv->region_cache_count <= 0);
@@ -339,15 +334,9 @@ static long region_add(struct resv_map *resv, long f, long t)
  * call to region_add that will actually modify the reserve
  * map to add the specified range [f, t).  region_chg does
  * not change the number of huge pages represented by the
- * map.  However, if the existing regions in the map can not
- * be expanded to represent the new range, a new file_region
- * structure is added to the map as a placeholder.  This is
- * so that the subsequent region_add call will have all the
- * regions it needs and will not fail.
- *
- * Upon entry, region_chg will also examine the cache of region descriptors
- * associated with the map.  If there are not enough descriptors cached, one
- * will be allocated for the in progress add operation.
+ * map.  A new file_region structure is added to the cache
+ * as a placeholder, so that the subsequent region_add
+ * call will have all the regions it needs and will not fail.
  *
  * Returns the number of huge pages that need to be added to the existing
  * reservation map for the range [f, t).  This number is greater or equal to
@@ -357,10 +346,9 @@ static long region_add(struct resv_map *resv, long f, long t)
 static long region_chg(struct resv_map *resv, long f, long t)
 {
 	struct list_head *head = &resv->regions;
-	struct file_region *rg, *nrg = NULL;
+	struct file_region *rg;
 	long chg = 0;

-retry:
 	spin_lock(&resv->lock);
 retry_locked:
 	resv->adds_in_progress++;
@@ -378,10 +366,8 @@ static long region_chg(struct resv_map *resv, long f, long t)
 		spin_unlock(&resv->lock);

 		trg = kmalloc(sizeof(*trg), GFP_KERNEL);
-		if (!trg) {
-			kfree(nrg);
+		if (!trg)
 			return -ENOMEM;
-		}

 		spin_lock(&resv->lock);
 		list_add(&trg->link, &resv->region_cache);
@@ -394,28 +380,6 @@ static long region_chg(struct resv_map *resv, long f, long t)
 		if (f <= rg->to)
 			break;

-	/* If we are below the current region then a new region is required.
-	 * Subtle, allocate a new region at the position but make it zero
-	 * size such that we can guarantee to record the reservation. */
-	if (&rg->link == head || t < rg->from) {
-		if (!nrg) {
-			resv->adds_in_progress--;
-			spin_unlock(&resv->lock);
-			nrg = kmalloc(sizeof(*nrg), GFP_KERNEL);
-			if (!nrg)
-				return -ENOMEM;
-
-			nrg->from = f;
-			nrg->to   = f;
-			INIT_LIST_HEAD(&nrg->link);
-			goto retry;
-		}
-
-		list_add(&nrg->link, rg->link.prev);
-		chg = t - f;
-		goto out_nrg;
-	}
-
 	/* Round our left edge to the current segment if it encloses us. */
 	if (f > rg->from)
 		f = rg->from;
@@ -439,11 +403,6 @@ static long region_chg(struct resv_map *resv, long f, long t)
 	}

 out:
-	spin_unlock(&resv->lock);
-	/*  We already know we raced and no longer need the new region */
-	kfree(nrg);
-	return chg;
-out_nrg:
 	spin_unlock(&resv->lock);
 	return chg;
 }
--
2.23.0.351.gc4317032e6-goog
