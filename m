Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE90AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961E520715
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5vbLQU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLREkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 23:40:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33494 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLREkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:40:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13so408157pls.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 20:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ch1xpBs7tWZiDXbLKgnS0zrW6JPy9+Lj1zi5nVSNmf0=;
        b=i5vbLQU4qpVW5MGMSWfK+XMYKjxF2VPs4XfcTcMhcVIKpGJBe7PGcCxZpxAc8P5Fd7
         gZDAGvqSHgS6NKmEEv8zXuUI8q2kkkUODMXUK7FULz2j0p0L3yP7vhw6rVzyE7cfD65l
         rMnAdLpehDb9coTaVHTVJGiLjvVzH0a9p7d1cVlleDRwNq2ky7Jym1FUPjX3U478oWog
         JsJQbZPD870IFKg04kAcMV0Zz5KlumrEOGEm70pkAtq3SAuXbTM4CcCTp8tmPXuiyjkk
         MFfiLf5mosvUWYu6rtu83enHYlAQBLWMpRI5VaqInKHp5sonhQ+1VCbM4TrsVjtrHhLZ
         fzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ch1xpBs7tWZiDXbLKgnS0zrW6JPy9+Lj1zi5nVSNmf0=;
        b=NnDerVJQo9u4owpDekUx5NYjOVZPi03fcdPKEoFAXBOzmRdPhAxpgMX9gylULBLAV4
         7bklr63HNlOvN/KRbxb3Vr5ppb4NQDmnKyN9/cTsTCyEZLf4KBaa6qZWpjUqoEPNqpgx
         e/9juTMJtCvfW/cuQyPi3ZrvHwWnosj0HkADNqdW1bmczteu+NwrEQZN46fhFs1duLq3
         xPi45VB38tXwmqgMCVXTc1xRiSz+qSfm72RX76dCmRJxT1wAAuKRgTYmx2W02mkV/whU
         lhyXyZF163MRY5appYJvn4OE2Bw0Gi2ElDw7caPm5GwCLC0AobVRNXAy0WCOhx3mIKLP
         BNgg==
X-Gm-Message-State: APjAAAXKuDLwkjIenBH8tdirdKKYdDe8ppQYatELHN6U5f0EUiDOaoLU
        drrvROB9YCi4drZAUKqzDso=
X-Google-Smtp-Source: APXvYqy4jD0JjiT4VzPGi+Jz6Zn6cuxjRyWsHALLTYtWmuxVm7k4EjjcyWpARRZpVPPL25gDilrueg==
X-Received: by 2002:a17:902:6a87:: with SMTP id n7mr338770plk.273.1576644018804;
        Tue, 17 Dec 2019 20:40:18 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id j21sm781105pfe.175.2019.12.17.20.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:40:18 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, Cong Wang <xiyou.wangcong@gmail.com>,
        John Garry <john.garry@huawei.com>
Subject: [Patch v3 1/3] iommu: avoid unnecessary magazine allocations
Date:   Tue, 17 Dec 2019 20:39:49 -0800
Message-Id: <20191218043951.10534-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOVA cache algorithm implemented in IOMMU code does not
exactly match the original algorithm described in the paper
"Magazines and Vmem: Extending the Slab Allocator to Many
CPUs and Arbitrary Resources".

Particularly, it doesn't need to free the loaded empty magazine
when trying to put it back to global depot. To make it work, we
have to pre-allocate magazines in the depot and only recycle them
when all of them are full.

Before this patch, rcache->depot[] contains either full or
freed entries, after this patch, it contains either full or
empty (but allocated) entries.

Together with a few other changes to make it exactly match
the pseudo code in the paper.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 45 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 41c605b0058f..cb473ddce4cf 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -862,12 +862,16 @@ static void init_iova_rcaches(struct iova_domain *iovad)
 	struct iova_cpu_rcache *cpu_rcache;
 	struct iova_rcache *rcache;
 	unsigned int cpu;
-	int i;
+	int i, j;
 
 	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
 		spin_lock_init(&rcache->lock);
 		rcache->depot_size = 0;
+		for (j = 0; j < MAX_GLOBAL_MAGS; ++j) {
+			rcache->depot[j] = iova_magazine_alloc(GFP_KERNEL);
+			WARN_ON(!rcache->depot[j]);
+		}
 		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
 		if (WARN_ON(!rcache->cpu_rcaches))
 			continue;
@@ -900,24 +904,30 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 
 	if (!iova_magazine_full(cpu_rcache->loaded)) {
 		can_insert = true;
-	} else if (!iova_magazine_full(cpu_rcache->prev)) {
+	} else if (iova_magazine_empty(cpu_rcache->prev)) {
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		can_insert = true;
 	} else {
-		struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
+		spin_lock(&rcache->lock);
+		if (rcache->depot_size < MAX_GLOBAL_MAGS) {
+			swap(rcache->depot[rcache->depot_size], cpu_rcache->prev);
+			swap(cpu_rcache->prev, cpu_rcache->loaded);
+			rcache->depot_size++;
+			can_insert = true;
+		} else {
+			mag_to_free = cpu_rcache->loaded;
+		}
+		spin_unlock(&rcache->lock);
+
+		if (mag_to_free) {
+			struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
 
-		if (new_mag) {
-			spin_lock(&rcache->lock);
-			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
-				rcache->depot[rcache->depot_size++] =
-						cpu_rcache->loaded;
+			if (new_mag) {
+				cpu_rcache->loaded = new_mag;
+				can_insert = true;
 			} else {
-				mag_to_free = cpu_rcache->loaded;
+				mag_to_free = NULL;
 			}
-			spin_unlock(&rcache->lock);
-
-			cpu_rcache->loaded = new_mag;
-			can_insert = true;
 		}
 	}
 
@@ -963,14 +973,15 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 
 	if (!iova_magazine_empty(cpu_rcache->loaded)) {
 		has_pfn = true;
-	} else if (!iova_magazine_empty(cpu_rcache->prev)) {
+	} else if (iova_magazine_full(cpu_rcache->prev)) {
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		has_pfn = true;
 	} else {
 		spin_lock(&rcache->lock);
 		if (rcache->depot_size > 0) {
-			iova_magazine_free(cpu_rcache->loaded);
-			cpu_rcache->loaded = rcache->depot[--rcache->depot_size];
+			swap(rcache->depot[rcache->depot_size - 1], cpu_rcache->prev);
+			swap(cpu_rcache->prev, cpu_rcache->loaded);
+			rcache->depot_size--;
 			has_pfn = true;
 		}
 		spin_unlock(&rcache->lock);
@@ -1019,7 +1030,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 			iova_magazine_free(cpu_rcache->prev);
 		}
 		free_percpu(rcache->cpu_rcaches);
-		for (j = 0; j < rcache->depot_size; ++j)
+		for (j = 0; j < MAX_GLOBAL_MAGS; ++j)
 			iova_magazine_free(rcache->depot[j]);
 	}
 }
-- 
2.21.0

