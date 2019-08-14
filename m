Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE91C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04491208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bM+YSebv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfHNIAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:00:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfHNIAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aAnmSRph1c1Gu2+S0Bf5dmihLUaL6lE7+YQ+WyB/8Io=; b=bM+YSebvWYi9TWCoNWvznDU4rK
        PbGYSC1kDL4lM+HJPv/XKvL+1+89tZCp9zpByE9sGHwJjWDQjUUyETZEtrYJ2ZVWr+nImLnODGhGr
        Px7VZx/459JkWE+617Z320wbe59gs70dEAfTZFkf7gxjUpz+comcBvRsHIs/2/wp7d/28TxxQGeaC
        QnxdelxFLgpddzI4JUuX9iBWcEcI3jEaTh983n/LE0kJUerNxqxQekySl+oWl/1d+10zpd/blkhvt
        1FKMaw1LL9eaVdr02KhYgcBEOpEj61YaLSReU27GR2//wmzBVDoKxKWf4VXSE3L6wcQsGyle3EMmm
        WVu8ZTag==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxoCP-0008Bl-UL; Wed, 14 Aug 2019 08:00:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] mm: remove CONFIG_MIGRATE_VMA_HELPER
Date:   Wed, 14 Aug 2019 09:59:28 +0200
Message-Id: <20190814075928.23766-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814075928.23766-1-hch@lst.de>
References: <20190814075928.23766-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_MIGRATE_VMA_HELPER guards helpers that are required for proper
devic private memory support.  Remove the option and just check for
CONFIG_DEVICE_PRIVATE instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/Kconfig | 1 -
 mm/Kconfig                      | 3 ---
 mm/migrate.c                    | 4 ++--
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index df4352c279ba..3558df043592 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -89,7 +89,6 @@ config DRM_NOUVEAU_SVM
 	depends on MMU
 	depends on STAGING
 	select HMM_MIRROR
-	select MIGRATE_VMA_HELPER
 	select MMU_NOTIFIER
 	default n
 	help
diff --git a/mm/Kconfig b/mm/Kconfig
index 563436dc1f24..2fe4902ad755 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -669,9 +669,6 @@ config ZONE_DEVICE
 
 	  If FS_DAX is enabled, then say Y.
 
-config MIGRATE_VMA_HELPER
-	bool
-
 config DEV_PAGEMAP_OPS
 	bool
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 33e063c28c1b..993386cb5335 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2117,7 +2117,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 
 #endif /* CONFIG_NUMA */
 
-#if defined(CONFIG_MIGRATE_VMA_HELPER)
+#ifdef CONFIG_DEVICE_PRIVATE
 static int migrate_vma_collect_hole(unsigned long start,
 				    unsigned long end,
 				    struct mm_walk *walk)
@@ -2942,4 +2942,4 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 	}
 }
 EXPORT_SYMBOL(migrate_vma_finalize);
-#endif /* defined(MIGRATE_VMA_HELPER) */
+#endif /* CONFIG_DEVICE_PRIVATE */
-- 
2.20.1

