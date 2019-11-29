Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC5C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 00:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E8821781
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 00:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7tupLbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfK2AtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 19:49:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44002 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfK2AtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 19:49:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id h14so3646674pfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 16:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PR8QywMOUlein0EdyppPpotpplTPCMqHeye2o9IVQQA=;
        b=I7tupLbF49ytr8XzpyjD19m/9+prtks7AxK5bBuoDxbLOZwpFaMPntKGaxaBxfJFg1
         MbNqlvk5r8McxHt7kVTMRS9GT6+j1tQCo2vE8WGdvZWZi2cTZb7p4STKZTMPAAEZlnb2
         H9bX/+rMQOkhNdp3r8xgH+mLk1+YfLYCbm7ZbYgH93JaJQ7Ztqga9LRbsL4533ChT/2t
         NOl4rYi2+60tvDbxozB5pKBcBeYNXZuqSMp/y9JasWrs6Xhb7L9wSsgtULo8dAjqnlO+
         DBDmTaM/TMfqvfoAFC8gsKpFAwr8LMOzu9V0jbdNLEohcn+Vg9Ju4qhymgk028labXcU
         L+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PR8QywMOUlein0EdyppPpotpplTPCMqHeye2o9IVQQA=;
        b=Hwdup8Ci5jqDoS+AfR5+zKUYVaGNgpEX3cOEHlO49zMQDHLpCIpDLd4XBu9FUs0J4t
         DIPSut3V9PXxMHJPZKMl4CQAu697/htfUCA/RihwDGgshy0w+x9X7cN4NdzReJtYv88w
         h2vIHsXUD1df0HU05ussRmjhisFV9dP4Uqwlem1jWxbm6KdE2aBLnONulbKksbuk5ldw
         1X9jdxCYObpUEKF9MhGF/EFehq2jDeRuFQXRy/ZK5Z4yq3hOFFyijiSL8udG8aEkeQYh
         vDaJEwVrBSA6u9kGmZC47jXL5fTuBFVoh5hWMRxWgz9njQeMtbHJYiKncaHtL0Vuu2ua
         n7lg==
X-Gm-Message-State: APjAAAWL1+3bmoKGO3ITXmX9W7+ZCARVK3N6kV6/z4IBxlQGRkdkHEAD
        //IK8ZFtuud95aa7z1lfo4s=
X-Google-Smtp-Source: APXvYqwhP6ctTo70BI7YPdC+6gWhQb8kGN1VNmnI+MJ+lI3k0QYaFCJPlXmgV+Sk7tqdVu0ct27dgg==
X-Received: by 2002:a63:115c:: with SMTP id 28mr13790143pgr.6.1574988559690;
        Thu, 28 Nov 2019 16:49:19 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id 64sm22418202pfe.147.2019.11.28.16.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 16:49:19 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v2 1/3] iommu: match the original algorithm
Date:   Thu, 28 Nov 2019 16:48:53 -0800
Message-Id: <20191129004855.18506-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOVA cache algorithm implemented in IOMMU code does not
exactly match the original algorithm described in the paper.

Particularly, it doesn't need to free the loaded empty magazine
when trying to put it back to global depot. To make it work, we
have to pre-allocate magazines in the depot and only recycle them
when all of them are full.

Before this patch, rcache->depot[] contains either full or
freed entries, after this patch, it contains either full or
empty (but allocated) entries.

Cc: Joerg Roedel <joro@8bytes.org>
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

