Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C9CC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDC9208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfGaPsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:48:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730264AbfGaPsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:48:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1CBAEB05E;
        Wed, 31 Jul 2019 15:48:11 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org,
        robh+dt@kernel.org, eric@anholt.net, mbrugger@suse.com,
        nsaenzjulienne@suse.de, akpm@linux-foundation.org,
        frowand.list@gmail.com, m.szyprowski@samsung.com,
        linux-rpi-kernel@lists.infradead.org
Subject: [PATCH 8/8] mm: comment arm64's usage of 'enum zone_type'
Date:   Wed, 31 Jul 2019 17:47:51 +0200
Message-Id: <20190731154752.16557-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731154752.16557-1-nsaenzjulienne@suse.de>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 uses both ZONE_DMA and ZONE_DMA32 for the same reasons x86_64
does: peripherals with different DMA addressing limitations. This
updates both ZONE_DMAs comments to inform about the usage.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

 include/linux/mmzone.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d77d717c620c..8fa6bcf72e7c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -365,23 +365,24 @@ enum zone_type {
 	 *
 	 * Some examples
 	 *
-	 * Architecture		Limit
-	 * ---------------------------
-	 * parisc, ia64, sparc	<4G
-	 * s390, powerpc	<2G
-	 * arm			Various
-	 * alpha		Unlimited or 0-16MB.
+	 * Architecture			Limit
+	 * ----------------------------------
+	 * parisc, ia64, sparc, arm64	<4G
+	 * s390, powerpc		<2G
+	 * arm				Various
+	 * alpha			Unlimited or 0-16MB.
 	 *
 	 * i386, x86_64 and multiple other arches
-	 * 			<16M.
+	 *				<16M.
 	 */
 	ZONE_DMA,
 #endif
 #ifdef CONFIG_ZONE_DMA32
 	/*
-	 * x86_64 needs two ZONE_DMAs because it supports devices that are
-	 * only able to do DMA to the lower 16M but also 32 bit devices that
-	 * can only do DMA areas below 4G.
+	 * x86_64 and arm64 need two ZONE_DMAs because they support devices
+	 * that are only able to DMA a fraction of the 32 bit addressable
+	 * memory area, but also devices that are limited to that whole 32 bit
+	 * area.
 	 */
 	ZONE_DMA32,
 #endif
-- 
2.22.0

