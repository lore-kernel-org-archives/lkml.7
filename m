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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB104C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B283020885
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tuogm33j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKUAO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:14:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39208 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfKUAO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:14:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id b126so592768pga.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 16:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kfKghOlAVdXJ9nfsLtttD5S8horVMD6tIcv1KXk7i6Q=;
        b=Tuogm33jDXPZQJ6ZKv8LQJplcWUWjzjl/wA4KFiUV6FkZILpe6RA/EdesM14ALY1os
         WOnWk1+8B5hfeWjVJALL5VfKIsj16534gZhMaHenObMJALz0oYmbwg7yp78AZI7X3G3l
         ce0j6/xZ8KXvWd+ZPwrXVFYcwQEp1PNAJXfPheQLIyK11RURr7QVckyBMTvPqa37ndW+
         dBEa8IDAbs2NgXYL39nJQ09HvVGTTzseBzjfST0gQi+OAeyuKxKF/MhNHrbmJfKf+gJc
         KWLn1l7qxEm7K/l7P0BzyiTbV7l8VsTAH9c6Tm8v3UX4HG9s1DXRTq52zcCOCCz3vXOL
         H52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kfKghOlAVdXJ9nfsLtttD5S8horVMD6tIcv1KXk7i6Q=;
        b=ocZOPfLjBHRWBjRr/8srR/5a8c5a8c5k27Y1GmKgWCOccVtVS59xWR7FvEoEz+/Y1f
         sTd1ewln9oVDqxANdCwrKXH4BBc8QWJzjhms0CgZ7nFvtqUHwOVmw3xNLOwlIQq2Ffol
         31wnW4kpOxndta3pEzRF5jnydVg/hI/pQQY5+84Y9T1agepy0Ay/y7Uui+Rntsq/NiVO
         XBxCfF0hn3Mm8PypbvPiE4B67WjL1Eb4B8vM9yqTJC14Nl4hu4iTIynm6dLACp5GXpaK
         zkRhgrhmx4/a9/mne4gY0YdTpxkgmPJmYzPhnFLjN2UT3LGxxP0lLN8Vw302VOsFxZiz
         bqVQ==
X-Gm-Message-State: APjAAAVvxS2yzh6E5DEqq+l+CAdO4PfVnFKymCtb+RcP8H+SIbMljBy8
        ezk0HKBhp5jWwzTXypqfukU=
X-Google-Smtp-Source: APXvYqxSr9HND1eosZsevZQVdQF2PwZ14FVyCJA1A6sxDt0kyZSGxo/xFby5xXAgo8T7nROhtmBLFw==
X-Received: by 2002:a65:6209:: with SMTP id d9mr6459220pgv.220.1574295266086;
        Wed, 20 Nov 2019 16:14:26 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id r4sm565981pfl.61.2019.11.20.16.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:14:25 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 2/3] iommu: optimize iova_magazine_free_pfns()
Date:   Wed, 20 Nov 2019 16:13:47 -0800
Message-Id: <20191121001348.27230-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
References: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the maganize is empty, iova_magazine_free_pfns() should
be a nop, however it misses the case of mag->size==0. So we
should just call iova_magazine_empty().

This should reduce the contention on iovad->iova_rbtree_lock
a little bit.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 92f72a85e62a..b82c6f1cbfc2 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -797,13 +797,23 @@ static void iova_magazine_free(struct iova_magazine *mag)
 	kfree(mag);
 }
 
+static bool iova_magazine_full(struct iova_magazine *mag)
+{
+	return (mag && mag->size == IOVA_MAG_SIZE);
+}
+
+static bool iova_magazine_empty(struct iova_magazine *mag)
+{
+	return (!mag || mag->size == 0);
+}
+
 static void
 iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 {
 	unsigned long flags;
 	int i;
 
-	if (!mag)
+	if (iova_magazine_empty(mag))
 		return;
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
@@ -820,16 +830,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 	mag->size = 0;
 }
 
-static bool iova_magazine_full(struct iova_magazine *mag)
-{
-	return (mag && mag->size == IOVA_MAG_SIZE);
-}
-
-static bool iova_magazine_empty(struct iova_magazine *mag)
-{
-	return (!mag || mag->size == 0);
-}
-
 static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 				       unsigned long limit_pfn)
 {
-- 
2.21.0

