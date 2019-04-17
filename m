Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD90C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358CA2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733147AbfDQVLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:11:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfDQVLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:11:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E1503003199;
        Wed, 17 Apr 2019 21:11:49 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E852A5C205;
        Wed, 17 Apr 2019 21:11:46 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] mm/hmm: add ARCH_HAS_HMM_MIRROR ARCH_HAS_HMM_DEVICE Kconfig
Date:   Wed, 17 Apr 2019 17:11:41 -0400
Message-Id: <20190417211141.17580-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 17 Apr 2019 21:11:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This patch just add 2 new Kconfig that are _not use_ by anyone. I check
that various make ARCH=somearch allmodconfig do work and do not complain.
This new Kconfig need to be added first so that device driver that do
depend on HMM can be updated.

Once drivers are updated then i can update the HMM Kconfig to depends
on this new Kconfig in a followup patch.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 mm/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 25c71eb8a7db..daadc9131087 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -676,6 +676,22 @@ config ZONE_DEVICE
 
 	  If FS_DAX is enabled, then say Y.
 
+config ARCH_HAS_HMM_MIRROR
+	bool
+	default y
+	depends on (X86_64 || PPC64)
+	depends on MMU && 64BIT
+
+config ARCH_HAS_HMM_DEVICE
+	bool
+	default y
+	depends on (X86_64 || PPC64)
+	depends on MEMORY_HOTPLUG
+	depends on MEMORY_HOTREMOVE
+	depends on SPARSEMEM_VMEMMAP
+	depends on ARCH_HAS_ZONE_DEVICE
+	select XARRAY_MULTI
+
 config ARCH_HAS_HMM
 	bool
 	default y
-- 
2.20.1

