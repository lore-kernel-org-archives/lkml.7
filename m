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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8D7C33C8C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 00:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DF42176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 00:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uv7cRYLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfK2AtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 19:49:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40772 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfK2AtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 19:49:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id i187so9658036pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 16:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DpznRcuYAqspUUeo19X/byGcrul93mEcWyqODmZkSA8=;
        b=uv7cRYLrhvi/aOD4vOaTCjHBCFan3ldiAvc4IyTrphTn6qsfNGu9KJgLDPplUhhsNE
         9rhYnafXvB2m+I68G52zwym3HOaI+9O3+crzu1sv+pykaitf0cs43RAKQwEY8ycEOZMA
         lX9jfVgIKz5YpPqOq0kuGSZTgXt2BDYcNcQVqSdiNt9xPdl0h1F1CphV+H8DfmXXCS1w
         TekYSCJVPgrsCgAi2pb8FqBfPsImxxi6ruIsbwJp1sGaeKZUZigQ3XzGPxvmmKodf41p
         LYSifRjh2RmQrwJmhHJIab+BDFz7f2MnCsz9zMT+0ZvxulqF5SNeaidw9uHSeZ8kixWP
         ZJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DpznRcuYAqspUUeo19X/byGcrul93mEcWyqODmZkSA8=;
        b=pLaD6e7A0c5s3URlTeWuRtM4jpCzBTgX5SJ7BPQHojtikXhMIlMrTHDzyLXdeVFhFz
         5GnIrZQEPrLMj7U0UxirEDjaW+ML2C5QqD81biHJ5/k0hyKKOMT8Ho6fnKbuF1rkH8zl
         3CYqDdTJp4LSYBt1sEMEd8oAoKEnc2FEwLtYNUciv6ft/O8qIfrQAiW0OmkLm9W32tjL
         8+lM3/0ltoiOx6h+4oKSNlTkzuLCMBOl+6sqQr5ZKkVuy9YLpJjLuEcQE6xT3ju7qsTK
         HNIAny6hSTc3eVHJjlJScdUyUd0yRp2sjDH+uFwPQlYU8HkJINGLSVZFfiRR4RboY2Oz
         AyvA==
X-Gm-Message-State: APjAAAVSHxxcXtffzTDrjOuGLut1Rn60zx4Hx5xDIlGj3V+7PNOlnedA
        gY2O5r12K96qwsdUUxt1BAg=
X-Google-Smtp-Source: APXvYqxhJpBu3a7f3trFLsAjKcUtittnlOzHQt84mLjfEE/MmzfgbT5/Xbz5tchacpJvSgs10fMTqA==
X-Received: by 2002:a63:5725:: with SMTP id l37mr14326615pgb.247.1574988561727;
        Thu, 28 Nov 2019 16:49:21 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id 64sm22418202pfe.147.2019.11.28.16.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 16:49:21 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v2 3/3] iommu: avoid taking iova_rbtree_lock twice
Date:   Thu, 28 Nov 2019 16:48:55 -0800
Message-Id: <20191129004855.18506-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both find_iova() and __free_iova() take iova_rbtree_lock,
there is no reason to take and release it twice inside
free_iova().

Fold them into the critical section by calling the unlock
versions instead.

Cc: Joerg Roedel <joro@8bytes.org>
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

