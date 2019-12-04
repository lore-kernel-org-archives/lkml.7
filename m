Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31F0C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C690720865
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575462935;
	bh=M1Wf/f30+BvSWegCWZV9CQ1OJDcWNvDUUneWC9hFQOQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hDM0r2L4TjUsP8AH8JW0OSYZiuimRxFcfQnwFOuuToQow3O2QC0wdv+ytWq3NKHb/
	 X6C60rRK8jHDPvzhD0yVvjQjjBLRSlT2tQIgQFpWPmaURjIg4XBo/HEJrZPw4pciwF
	 3LLw7M8Ct4QCc+LyXQLxenBzpbeemg7iSwdYg/7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfLDMff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfLDMfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:35:34 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B2A20862;
        Wed,  4 Dec 2019 12:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575462933;
        bh=M1Wf/f30+BvSWegCWZV9CQ1OJDcWNvDUUneWC9hFQOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=A+OJZidzgtdJt6409seAEyH45Ss0kz2SBVJ8TWk3Q0UceO0y4S6OsXy2bjaslg5lP
         LK6ARqr0xZruFvxNrlV5jBQ6dU6ReePVQk9HAWRwyTXGhM4FszRdjBL0OgxolzqKS0
         a9CRC+a0jEEIjKw+N+wMhE7DRPXw7GklS56VuPLw=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] powerpc: ensure that swiotlb buffer is allocated from low memory
Date:   Wed,  4 Dec 2019 14:35:24 +0200
Message-Id: <20191204123524.22919-1-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Some powerpc platforms (e.g. 85xx) limit DMA-able memory way below 4G. If a
system has more physical memory than this limit, the swiotlb buffer is not
addressable because it is allocated from memblock using top-down mode.

Force memblock to bottom-up mode before calling swiotlb_init() to ensure
that the swiotlb buffer is DMA-able.

Link: https://lkml.kernel.org/r/F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Darren Stevens <darren@stevens-zone.net>
Cc: mad skateman <madskateman@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 arch/powerpc/mm/mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index be941d382c8d..14c2c53e3f9e 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -260,6 +260,14 @@ void __init mem_init(void)
 	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);
 
 #ifdef CONFIG_SWIOTLB
+	/*
+	 * Some platforms (e.g. 85xx) limit DMA-able memory way below
+	 * 4G. We force memblock to bottom-up mode to ensure that the
+	 * memory allocated in swiotlb_init() is DMA-able.
+	 * As it's the last memblock allocation, no need to reset it
+	 * back to to-down.
+	 */
+	memblock_set_bottom_up(true);
 	swiotlb_init(0);
 #endif
 
-- 
2.24.0

