Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C953DC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D4524684
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8nRiiaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLFVjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:39:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42494 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLFVi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:38:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id i5so3945919pgj.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 13:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buvyJgIJY0R4gHfuaJpwEN38gwzHGwHEA+PtuFw57xs=;
        b=R8nRiiaFenf0S2R88EQdmqaDdEkzal1TT5LYPVJqdE3YdqF26NIAT4aivvlxoTcAha
         43Qgzo49EYxnR0j9ZtNH5O0d4se9QbhWp20Quu0EUliNxt370LnVL1eMI/iUwXJMPulq
         YA9lXAYBcBjysIKsp5Z0O098mvIt7WiCWJd0Dawa02xDJ59xsEmE3boZLhKwOm9dUfBe
         9YkFdTfRyqwt0tHr92XgZYHKaE0ovo7PPK8V1p1S9PsV00qsYj410ybPklavLDpdDWIE
         kpqNijDRaMCrK39LX80p2gPtUZ1FQGgeQcDI/qIMd51lrKgLSBpjH/bcKVFQwt4Seqog
         E3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buvyJgIJY0R4gHfuaJpwEN38gwzHGwHEA+PtuFw57xs=;
        b=CU7dGEMS3/IhmNvVQ7dNlZ7vaED9RErXUbdJiR5il3TxdclZl5EItW2fjcW0p+gpAz
         o4u7EUrkMKcuPrMgsX7s9SOMLgmWkZ0AEbuoJEKtjdtFVI03g12ynll/hserR0VSLJ5S
         eo5ZCJbN72/Ue4hmirQgOOeIRPTIJ6MMxsWSJKsRMzzU5+WHa3M0wzSVcF3l3wCnUuWl
         n1ebzCSi5DO4gXIn04s0xoEco6bsieYWTPQUfua/dBvXb2EgD1MoCkFgME4WynjeH8Em
         gZsbxmNd89LX9dCXFZK70dke0pWEdJZqdRlVZQa700QWyF6ngiPaC8ASQNwJMdcPtEma
         A4ew==
X-Gm-Message-State: APjAAAUdTJxNFuJXixtRO4nWn59GU5IJPFGx3kk8mGdRZL3HPMlgJZHl
        I8k/F0G1GFn1S0nz4a8LocU=
X-Google-Smtp-Source: APXvYqxXY0wRv1On4fHZpoVxEfqL3TRfZrkRbl55+hRkNwdTrHFwMh1XpW6Bq564Df40fsqvpr5qbQ==
X-Received: by 2002:a65:4d46:: with SMTP id j6mr6030301pgt.63.1575668338823;
        Fri, 06 Dec 2019 13:38:58 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id d65sm17368579pfa.159.2019.12.06.13.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 13:38:58 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        Cong Wang <xiyou.wangcong@gmail.com>,
        John Garry <john.garry@huawei.com>
Subject: [Patch v3 3/3] iommu: avoid taking iova_rbtree_lock twice
Date:   Fri,  6 Dec 2019 13:38:03 -0800
Message-Id: <20191206213803.12580-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
References: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both find_iova() and __free_iova() take iova_rbtree_lock,
there is no reason to take and release it twice inside
free_iova().

Fold them into one critical section by calling the unlock
versions instead.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 184d4c0e20b5..f46f8f794678 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -390,10 +390,14 @@ EXPORT_SYMBOL_GPL(__free_iova);
 void
 free_iova(struct iova_domain *iovad, unsigned long pfn)
 {
-	struct iova *iova = find_iova(iovad, pfn);
+	unsigned long flags;
+	struct iova *iova;
 
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = private_find_iova(iovad, pfn);
 	if (iova)
-		__free_iova(iovad, iova);
+		private_free_iova(iovad, iova);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 
 }
 EXPORT_SYMBOL_GPL(free_iova);
-- 
2.21.0

