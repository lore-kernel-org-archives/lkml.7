Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097B3C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB2520715
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSA6/OU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLREk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 23:40:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41569 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfLREkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:40:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id w62so488907pfw.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 20:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buvyJgIJY0R4gHfuaJpwEN38gwzHGwHEA+PtuFw57xs=;
        b=fSA6/OU6RZ4QSFkEveLrXMk7xfGo5Yml/4SapAlwGdyCNgt6hZvHpVJXueStFSsHRU
         E8cFUeFs80hq2ijU88iVgMzJbyAijs5ff9wE+NkkPiF2iJ9XGAthOz03SFgeQWN93Knc
         sxUokcCF+H9YitQqotepfn0/Z+vKvmrvDGp4PEfaS7oVzHaxx05dJjcuH1bLCw0F3GqB
         lBkVZB4XUJaRNgt7fr2Hd2Q8sbpoGUwVLYsgo6nGcVoUf+zHKWshZZBBA+L+Wcw3OsUZ
         B1eLZ2zD8Fs8xMcZ7wPwo4dThIhjfnksWJgczgKpxlIh5m6nPrk12rGDUrhJgCbdp9tY
         aWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buvyJgIJY0R4gHfuaJpwEN38gwzHGwHEA+PtuFw57xs=;
        b=IkfY01iVJ7ZmLkyiNSE1JPsqH2NwOsUCynbNvq18tmSKUDBr06ucJp4Dahjo0RXr/n
         VFrV1XdUt5gmB1d6VFxnSh9OlZAfqCkCdlfrflvU2VxZCz26STKQzi/rrNjTDD7GIcQ+
         n+uD0fILEAAHvuG5ITNbeK8MBreIka9U+eIpcC78XDLNt2lbv4wsJ06NOa86bErzatc5
         LKhqNXGQjAgTFuQihX8djKBw5MmQsInPoP+hTAotx1DdRk5WEd1k8NB92EoSq+5H0hZy
         xCUHIZGA4tZmj8xkyRM/DHLYLfR6T7TMUcqvi9y7ncMmH9q/6AMYLJzCuR/+Nubavxwx
         IpEA==
X-Gm-Message-State: APjAAAVBFxqN1Mlb6vd4uhHycpbrBc47p+zIHmpA0StJ0mk3fr7+lHJY
        2I5h9aArInZG3DBlPdTIc6E=
X-Google-Smtp-Source: APXvYqzYkNMV1tAM39yw129obSP47Du+yTcT5HVPg0cGDvNIcUAUzXmE7cRKZdrBA9z1l687aXPNXA==
X-Received: by 2002:a62:8205:: with SMTP id w5mr831686pfd.136.1576644020754;
        Tue, 17 Dec 2019 20:40:20 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id j21sm781105pfe.175.2019.12.17.20.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:40:20 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, Cong Wang <xiyou.wangcong@gmail.com>,
        John Garry <john.garry@huawei.com>
Subject: [Patch v3 3/3] iommu: avoid taking iova_rbtree_lock twice
Date:   Tue, 17 Dec 2019 20:39:51 -0800
Message-Id: <20191218043951.10534-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
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

