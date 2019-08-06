Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173FAC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03E320818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RzYHdp4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbfHFQGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:06:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387741AbfHFQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AGGvPGg8AA1Gw6ylv1raBDjNXF6ccyWYsPpDnZmLmBg=; b=RzYHdp4mJtW15Li7cWdiL7Rv01
        hFHEseFq+n0UFJMU+3w0w0dcwm6oTnyxs0LPJqTeUb/aik4SEyGDvWEb+rGvDp6r84fKCRpR8iku+
        LvpAQVKD7G9QKkzdJ/DeuZbZbTKro358y+zjuzVRUmFj6CfDmyP5rU7cFg+Mei2TOZGLqki/rhkRI
        +TaF7MWaORAz4mLE/jjH44uvJ1K8vxtIQOYU/+SL0CT+znouLR7X0cSZDFf8qWgYeOqRr0qwLahZj
        AwGNkm8JajYbsE5/lptaYXs7oJbj9ULssrgVQGlVhokMiDkdGrjv85x55+c8YH7Bg4a1zNcPtjDA3
        0XcoXJNg==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1yq-0000ee-I1; Tue, 06 Aug 2019 16:06:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] mm: make HMM_MIRROR an implicit option
Date:   Tue,  6 Aug 2019 19:05:52 +0300
Message-Id: <20190806160554.14046-15-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make HMM_MIRROR an option that is selected by drivers wanting to use it
instead of a user visible option as it is just a low-level
implementation detail.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig |  4 +++-
 drivers/gpu/drm/nouveau/Kconfig    |  4 +++-
 mm/Kconfig                         | 14 ++++++--------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index f6e5c0282fc1..2e98c016cb47 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -27,7 +27,9 @@ config DRM_AMDGPU_CIK
 config DRM_AMDGPU_USERPTR
 	bool "Always enable userptr write support"
 	depends on DRM_AMDGPU
-	depends on HMM_MIRROR
+	depends on MMU
+	select HMM_MIRROR
+	select MMU_NOTIFIER
 	help
 	  This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
 	  isn't already selected to enabled full userptr support.
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 96b9814e6d06..df4352c279ba 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -86,9 +86,11 @@ config DRM_NOUVEAU_SVM
 	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
 	depends on DEVICE_PRIVATE
 	depends on DRM_NOUVEAU
-	depends on HMM_MIRROR
+	depends on MMU
 	depends on STAGING
+	select HMM_MIRROR
 	select MIGRATE_VMA_HELPER
+	select MMU_NOTIFIER
 	default n
 	help
 	  Say Y here if you want to enable experimental support for
diff --git a/mm/Kconfig b/mm/Kconfig
index b18782be969c..563436dc1f24 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -675,16 +675,14 @@ config MIGRATE_VMA_HELPER
 config DEV_PAGEMAP_OPS
 	bool
 
+#
+# Helpers to mirror range of the CPU page tables of a process into device page
+# tables.
+#
 config HMM_MIRROR
-	bool "HMM mirror CPU page table into a device page table"
+	bool
 	depends on MMU
-	select MMU_NOTIFIER
-	help
-	  Select HMM_MIRROR if you want to mirror range of the CPU page table of a
-	  process into a device page table. Here, mirror means "keep synchronized".
-	  Prerequisites: the device must provide the ability to write-protect its
-	  page tables (at PAGE_SIZE granularity), and must be able to recover from
-	  the resulting potential page faults.
+	depends on MMU_NOTIFIER
 
 config DEVICE_PRIVATE
 	bool "Unaddressable device memory (GPU memory, ...)"
-- 
2.20.1

