Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22675C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044F2218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390173AbfIIJ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:58:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:41762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390130AbfIIJ6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:58:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17B6FABE3;
        Mon,  9 Sep 2019 09:58:18 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     f.fainelli@gmail.com, will@kernel.org, robin.murphy@arm.com,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        mbrugger@suse.com, linux-rpi-kernel@lists.infradead.org,
        phill@raspberrypi.org, m.szyprowski@samsung.com
Subject: [PATCH v5 4/4] mm: refresh ZONE_DMA and ZONE_DMA32 comments in 'enum zone_type'
Date:   Mon,  9 Sep 2019 11:58:07 +0200
Message-Id: <20190909095807.18709-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909095807.18709-1-nsaenzjulienne@suse.de>
References: <20190909095807.18709-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These zones usage has evolved with time and the comments were outdated.
This joins both ZONE_DMA and ZONE_DMA32 explanation and gives up to date
examples on how they are used on different architectures.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

---

Changes in v3:
- Update comment to match changes in arm64

Changes in v2:
- Try another approach merging both ZONE_DMA comments into one
- Address Christoph's comments
- If this approach doesn't get much traction I'll just drop the patch
  from the series as it's not really essential

 include/linux/mmzone.h | 45 ++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3f38c30d2f13..bf1b916c9ecb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -357,33 +357,40 @@ struct per_cpu_nodestat {
 #endif /* !__GENERATING_BOUNDS.H */
 
 enum zone_type {
-#ifdef CONFIG_ZONE_DMA
 	/*
-	 * ZONE_DMA is used when there are devices that are not able
-	 * to do DMA to all of addressable memory (ZONE_NORMAL). Then we
-	 * carve out the portion of memory that is needed for these devices.
-	 * The range is arch specific.
+	 * ZONE_DMA and ZONE_DMA32 are used when there are peripherals not able
+	 * to DMA to all of the addressable memory (ZONE_NORMAL).
+	 * On architectures where this area covers the whole 32 bit address
+	 * space ZONE_DMA32 is used. ZONE_DMA is left for the ones with smaller
+	 * DMA addressing constraints. This distinction is important as a 32bit
+	 * DMA mask is assumed when ZONE_DMA32 is defined. Some 64-bit
+	 * platforms may need both zones as they support peripherals with
+	 * different DMA addressing limitations.
+	 *
+	 * Some examples:
+	 *
+	 *  - i386 and x86_64 have a fixed 16M ZONE_DMA and ZONE_DMA32 for the
+	 *    rest of the lower 4G.
+	 *
+	 *  - arm only uses ZONE_DMA, the size, up to 4G, may vary depending on
+	 *    the specific device.
+	 *
+	 *  - arm64 has a fixed 1G ZONE_DMA and ZONE_DMA32 for the rest of the
+	 *    lower 4G.
 	 *
-	 * Some examples
+	 *  - powerpc only uses ZONE_DMA, the size, up to 2G, may vary
+	 *    depending on the specific device.
 	 *
-	 * Architecture		Limit
-	 * ---------------------------
-	 * parisc, ia64, sparc	<4G
-	 * s390, powerpc	<2G
-	 * arm			Various
-	 * alpha		Unlimited or 0-16MB.
+	 *  - s390 uses ZONE_DMA fixed to the lower 2G.
 	 *
-	 * i386, x86_64 and multiple other arches
-	 * 			<16M.
+	 *  - ia64 and riscv only use ZONE_DMA32.
+	 *
+	 *  - parisc uses neither.
 	 */
+#ifdef CONFIG_ZONE_DMA
 	ZONE_DMA,
 #endif
 #ifdef CONFIG_ZONE_DMA32
-	/*
-	 * x86_64 needs two ZONE_DMAs because it supports devices that are
-	 * only able to do DMA to the lower 16M but also 32 bit devices that
-	 * can only do DMA areas below 4G.
-	 */
 	ZONE_DMA32,
 #endif
 	/*
-- 
2.23.0

