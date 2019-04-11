Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC044C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751D420850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDKSDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:03:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfDKSDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:03:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C43581219B9;
        Thu, 11 Apr 2019 18:03:30 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E94405D9C4;
        Thu, 11 Apr 2019 18:03:28 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] mm/hmm: kconfig split HMM address space mirroring from device memory
Date:   Thu, 11 Apr 2019 14:03:26 -0400
Message-Id: <20190411180326.18958-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 11 Apr 2019 18:03:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

To allow building device driver that only care about address space
mirroring (like RDMA ODP) on platform that do not have all the pre-
requisite for HMM device memory (like ZONE_DEVICE on ARM) split the
HMM_MIRROR option dependency from the HMM_DEVICE dependency.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 mm/Kconfig | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 2e6d24d783f7..00d9febbc775 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -679,12 +679,13 @@ config ZONE_DEVICE
 config ARCH_HAS_HMM
 	bool
 	default y
-	depends on (X86_64 || PPC64)
-	depends on ZONE_DEVICE
 	depends on MMU && 64BIT
-	depends on MEMORY_HOTPLUG
-	depends on MEMORY_HOTREMOVE
-	depends on SPARSEMEM_VMEMMAP
+
+config ARCH_HAS_HMM_DEVICE
+	bool
+	default y
+	depends on (X86_64 || PPC64)
+	depends on ARCH_HAS_ZONE_DEVICE
 
 config MIGRATE_VMA_HELPER
 	bool
@@ -710,7 +711,8 @@ config HMM_MIRROR
 
 config DEVICE_PRIVATE
 	bool "Unaddressable device memory (GPU memory, ...)"
-	depends on ARCH_HAS_HMM
+	depends on ARCH_HAS_HMM_DEVICE
+	depends on ZONE_DEVICE
 	select HMM
 	select DEV_PAGEMAP_OPS
 
@@ -721,7 +723,8 @@ config DEVICE_PRIVATE
 
 config DEVICE_PUBLIC
 	bool "Addressable device memory (like GPU memory)"
-	depends on ARCH_HAS_HMM
+	depends on ARCH_HAS_HMM_DEVICE
+	depends on ZONE_DEVICE
 	select HMM
 	select DEV_PAGEMAP_OPS
 
-- 
2.20.1

