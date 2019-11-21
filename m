Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1937C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FB220730
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCjc3mRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKUAO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:14:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40736 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKUAOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:14:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so644349pfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 16:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ImlFiDYuXa0KQVaHR/MVaxrKYj3I/kme/azMWgFls4=;
        b=tCjc3mRvVc0rS1mOPOXNq92GwbZT/UA7uiK1w1r8dIdmr7NXcKUHkcgpfqMFGbRe3c
         ZmJypCVJTWGg2j/+g48u35BTCP8VTjLA6hpkRuXB9vX48GOQ6biC+tFn3wU52mcgwQH/
         7jqiTK0GcdAwd8FH/P9JtD6lMyn8oShEhLijjpTyaFKFc3Vwoxg96GX2AD6vvZtE6/2l
         QLkSWbaRXlnlO5VlZ60ba7C0dexMWNNPYSuZtj7obh/PI6OVTj65qJK7mV+vgo1bByxe
         VwXGbEll2pYoLlfR3bspuiIl6MZEouf2+mgxYpTqrA8yJ9O3JBfI6TPFYMFbvnHTr4ZZ
         rpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ImlFiDYuXa0KQVaHR/MVaxrKYj3I/kme/azMWgFls4=;
        b=jdJMJUgrgpuN0C53ty99kp6V+YUgozN1DrTBy4TWth9VPv+TbBJA7EAJy8PPm9EwYs
         2x513yslEBviJODPCcwZUFJBVpTNBBpe8Un6WMtqTcrowsNObC7pomcReV471CPNffYR
         UYrOGrQR0Lr+UXmAkeVkxtBbp9dfO+gzr75TylP4OQ8E6PMWWNmoFVeITnt6A9C5C8zj
         CLnkZun+zG6Tf2Ce8cn6/29N4u0Nqv0AV9p9KA4q6eItzX/JMY0cS6DSRmAp9lvUaym5
         AzVfHw9qKjledYPxxjNfYFyWeNR1cogB75blnDJ3dGwlvQdCxoC5ua0UR/P2vqKcUvRA
         o6Gw==
X-Gm-Message-State: APjAAAUHrIaYFmhFyBthPg1A6WsbCnRlH0wfyaUHEKeJZeyPkiEXhmHe
        LGSGoR2UAtJtIWwLLM8hb+Q=
X-Google-Smtp-Source: APXvYqxqJx0cV1bUvaJhXlw5evsmxi0N1VSEBrBRYtWu7VH6YZYjCMfhbSvhgIwfDZ6qrS1aAJKDcg==
X-Received: by 2002:a65:6245:: with SMTP id q5mr6286713pgv.347.1574295265089;
        Wed, 20 Nov 2019 16:14:25 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id r4sm565981pfl.61.2019.11.20.16.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:14:24 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 1/3] iommu: match the original algorithm
Date:   Wed, 20 Nov 2019 16:13:46 -0800
Message-Id: <20191121001348.27230-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
References: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOVA cache algorithm implemented in IOMMU code does not
exactly match the original algorithm described in the paper.

Particularly, it doesn't need to free the loaded empty magazine
when trying to put it back to global depot.

This patch makes it exactly match the original algorithm.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 41c605b0058f..92f72a85e62a 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -900,7 +900,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 
 	if (!iova_magazine_full(cpu_rcache->loaded)) {
 		can_insert = true;
-	} else if (!iova_magazine_full(cpu_rcache->prev)) {
+	} else if (iova_magazine_empty(cpu_rcache->prev)) {
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		can_insert = true;
 	} else {
@@ -909,8 +909,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 		if (new_mag) {
 			spin_lock(&rcache->lock);
 			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
-				rcache->depot[rcache->depot_size++] =
-						cpu_rcache->loaded;
+				swap(rcache->depot[rcache->depot_size], cpu_rcache->prev);
+				swap(cpu_rcache->prev, cpu_rcache->loaded);
+				rcache->depot_size++;
 			} else {
 				mag_to_free = cpu_rcache->loaded;
 			}
@@ -963,14 +964,15 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 
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
-- 
2.21.0

