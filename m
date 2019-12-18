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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A6C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64B720715
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0yzhS23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLREkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 23:40:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38648 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfLREkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:40:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so495984pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 20:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7tnHP49bcbdj6wbVlgmEh/i8N9jDvFKi9kaAZwgRO58=;
        b=O0yzhS23HGtIJZbs0zAM+mSOkQxGOG6AvwAEalcJQrw8ZovBcuay4V1Al0Dj1xAO1f
         wVwcbxEVekcuUvSyh+zo6MysMZ5iBMzSPyuDESXnLF9rM2PPdJsmgWA5pMB+8Diot1EN
         lSQGr0HWcuk9CMYUxTzT93IL2wrD4zOvVqK+OCMm/TxxvRsmeo/R8X13p7tTvk0jwo+f
         j9Uqkm+lpWXaZU7IkuGF6CpBWm39tcrP5N/RouvlnfyqEr7T1O97IH7dS5E/4zZeiggR
         nYUMan99mW+H1e5ehvAYcsf1mOavIMEUaJRhZJv0wLFajDCMFAdkVribcE+GJNceDZkj
         D3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tnHP49bcbdj6wbVlgmEh/i8N9jDvFKi9kaAZwgRO58=;
        b=TGENLqkYt8uZ2M7O6lm5ul2xHjA6UqEY6Nfhrk1fFIO7BfMxL4/P5RYnleRj7hdGRg
         5r6eV39zqrl1kbbw4TfuSsQ3viMpbZ5P5/qrMDEdbNpn2Xo0vzxZrl+V3aeS2ozhgUT7
         UeCDn2b6Hb6W6WmR9/Dtp0KUcGvlcDUqG7op7/GTSt6Lzwh44sZ9vVlOc163WiPmMfuv
         dkXRqu6bpPVKqEiNj0ouus8rvGqgqiRTMEoZ5FN+Rw6eu1Ey1fp3Supoq3FdiH+m2wAI
         g/eE7HMUx9BPKAaqzMrmERtFc2+qqneYfTpyQKwEPb0W5+qY2JbEIfpcZ1by+UlAZxf/
         mvtw==
X-Gm-Message-State: APjAAAVsxU0nSmCb/A33i0NGqoACMONxXiBnHOkZnGdB+lE0sRrYlWiu
        uyJBE15iHmrTccGT6ZD0vZy/QJxqSPc=
X-Google-Smtp-Source: APXvYqzSQ8EkWQ17u7mqdOiOyZaCadH8FPwTAgfdXevSealYbYZ5TAeFeSKvd1+6TyOxHGnOE1UJ0w==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr617092pgd.387.1576644019834;
        Tue, 17 Dec 2019 20:40:19 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id j21sm781105pfe.175.2019.12.17.20.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:40:19 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, Cong Wang <xiyou.wangcong@gmail.com>,
        John Garry <john.garry@huawei.com>
Subject: [Patch v3 2/3] iommu: optimize iova_magazine_free_pfns()
Date:   Tue, 17 Dec 2019 20:39:50 -0800
Message-Id: <20191218043951.10534-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the magazine is empty, iova_magazine_free_pfns() should
be a nop, however it misses the case of mag->size==0. So we
should just call iova_magazine_empty().

This should reduce the contention on iovad->iova_rbtree_lock
a little bit, not much at all.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index cb473ddce4cf..184d4c0e20b5 100644
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

