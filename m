Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA3DC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 23:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB1A21D79
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 23:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMOZiPNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfIJXcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 19:32:05 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45410 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfIJXcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 19:32:03 -0400
Received: by mail-pl1-f201.google.com with SMTP id c14so10770371plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ODTMmjbqtoxEKi34baxNJygt9lpaiMOerFU7Mw0jshU=;
        b=vMOZiPNAv7ItrUa1K3ts4oHTt0Qd2x78j9q9ufarkfAW9e23mArs1VYG+ReegFlk4n
         Ip2k6TaaEMJtWIdbUktWPWcnVG1fLfXXb5PlO2UEf0/HlCoDqRiXJAM7S9wvYSWDBlvn
         kTp74/6BRIYH1NbFfGKsyM7GddJlcY1QU+dEwDOZQrsiY9Vk0Jv+1mQB9Q4VsRXemJYT
         so1KsSKcFMJkGW9pjuc/Q7+LxxK6UtXaO0XNFMBH4HStwRF07rxNd4JIOS0xihHnVqCT
         wth/nSCIeH1mXYYnx6ACXTReukJDSyfsOHXxT7eUSxPJLBqR2KhCmMj6U2uxLlwKOU9j
         YOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ODTMmjbqtoxEKi34baxNJygt9lpaiMOerFU7Mw0jshU=;
        b=pkWwSlZVeyyOqyEKa+L9siCd3Kz5vtuOmSnU6QFVQ8PwISsqH4xHHWhJOTFtcq4NEh
         p49b+22BowY0ghzc13BSLJT9cLmfWI+PWDveVT6IsKNGQ8DR8XXcIp00IeDp+dYYeKlO
         Z0TaxeySRemRmPYbHCaEKn6d3+SKjLsrrTj+9Ko72XE1tdJqdpPVS4vmc72wPFAIOQ5h
         ekdBfan7gRnKo+gh+Yk2aFEwQHZKo9SB+PkM+MnwWVDIjWShbU+R8wrJYbJDguVooLRd
         pP8Sm1QOym1RZgCuTTY/YUPwVpIVlIGFLTIAAqGVQVRZthxnDTlg65sCZ8XxBjwBKEd1
         oW8w==
X-Gm-Message-State: APjAAAVSc+HZD1VifL/5kbrin3yT/Lf2l3LTWMCdUEy92fdEEwGqA90u
        ytr6Vp0ZuaOzlLT2kzZdcPaLw3uvNAmFPZTEbA==
X-Google-Smtp-Source: APXvYqyreNBSHyVUkVveUvnZM5ngstsJRB440F38+CtML0M/XRUNx8ZvBpKMj7k+a3NOw1sAfBtYC8TNDN4VQFOc9A==
X-Received: by 2002:a63:f505:: with SMTP id w5mr29937168pgh.217.1568158320583;
 Tue, 10 Sep 2019 16:32:00 -0700 (PDT)
Date:   Tue, 10 Sep 2019 16:31:41 -0700
In-Reply-To: <20190910233146.206080-1-almasrymina@google.com>
Message-Id: <20190910233146.206080-5-almasrymina@google.com>
Mime-Version: 1.0
References: <20190910233146.206080-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH v4 4/9] hugetlb: region_chg provides only cache entry
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
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

In addition, a follow up patch in this series disables region
coalescing, which would be further complicated if the race with
region_del exists.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 mm/hugetlb.c | 63 +++++++++-------------------------------------------
 1 file changed, 11 insertions(+), 52 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fbd7c52e17348..bea51ae422f63 100644
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
2.23.0.162.g0b9fbb3734-goog
