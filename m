Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F185C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5842077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLJT6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:58:13 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:41215 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfLJT6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:58:12 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M3lHZ-1idwhK3twp-000urC; Tue, 10 Dec 2019 20:58:06 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tom Murphy <murphyt7@tcd.ie>,
        Julien Grall <julien.grall@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: fix min_not_zero() type mismatch warning
Date:   Tue, 10 Dec 2019 20:57:56 +0100
Message-Id: <20191210195803.866126-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V0PTrzRDmYv2osv56dZM7Vo+oE2UI7e/kklN8s5/0zdjDkWO6PK
 Syr2cpC870aQUfBxI/LQKX9UnQ52eZYLqOSd2qvQkBpN//NCWo0iM81Nxw+2YBrXdGcQ4RB
 pg0vsdCSmVp9qll1ByW2hslofn4NGZNapb5tmHEmAu28G2OCyKJQ2/VNjecSBSVvQ+huvVa
 bOG58DgSx5dcelzI2jpqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NXJLDdAXMEU=:NSSpjT2T1r5c0ziBNCNW/r
 5vnGk8xhvaVmVr+eAbSykEY0l8MXV0Wx2rALNBcOoWZLDtTbils0slf3We/yHQ0rs7OGAsgYf
 5BlmvFI+7ar5wj3br9ulKnVBH1vDniBmMjOmeTjw5BF/n83OaZw/FTW/VPkUBnGpCiYQwa1Bm
 TtbQRFXz1pB9U8xQASCg9cMF+tXDUpiL+wvTbvcLYmhg8FbgQbTcAmTx8R19l3DW4foPflf2J
 7m+PywNID43s/9dvT18yzrYBJImDKwLg7zWCAgC0/dIgW7X2Xfl8TwuMZZti4aROTSOj5TbzL
 V//i43puiGW4XEntyk/qJzHB62ulXThNiQeIYgzwOJWK+0INVtjJoa7GYtf6I1Tt4cmA8Fc9z
 xf17zZt2tyfoPl6Sl/YzBTxoUMIOlnNwjYOSHmv/s8bmFg1glL7zuRxFtSdkwDuTzHKKLxk4P
 OVnL+x7WQUXg48TuZhF4KXwo2uD7dLYZf/gZZdq8KfjhgIt+T8NrPi3mydPt2+kHY2D/zqAu8
 QN4FGFLqeKLlce1sU0SrUWhrhOPeBH06pkZR8YBLrnvBdR9exwt/T2okQ2SmxBG0/KZiAEwdt
 ODgDVfocrwulKZkzpuWKllnc7mpI8nJFeejNINauyVZVxqwjbSfLEqXxpTCOIlAgDEG91gpA5
 pXgdP8WGTsOK2C4wPIF4wgFDaXpmPX3JdJ/IPRv9sJ2Wtysigw43HPuRfwR7vf6LFykoeABW7
 HqP1mV1W5NEmJ08yjYYay3e8yVEpVCGDEx/Ra6f9NTK4FiRNRaOxRupAJsPwWjHncFdRIrG/r
 ZEH8CT6uQv3PclquS/i8WgYVHUM/WAVkYqVNjSsA+aV3RNVBXjAhyVc9C3JQskKFCHOpdvtef
 m75EGNB98XOtH3nYdf4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

min()/max() require the arguments to be of the same type.

When dma_addr_t is not compatible with __u64, this causes
a warning:

In file included from include/linux/list.h:9,
                 from include/linux/kobject.h:19,
                 from include/linux/of.h:17,
                 from include/linux/irqdomain.h:35,
                 from include/linux/acpi.h:13,
                 from include/linux/acpi_iort.h:10,
                 from drivers/iommu/dma-iommu.c:11:
drivers/iommu/dma-iommu.c: In function 'iommu_dma_alloc_iova':
include/linux/kernel.h:844:29: error: comparison of distinct pointer types lacks a cast [-Werror]
   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                             ^~
include/linux/kernel.h:858:4: note: in expansion of macro '__typecheck'
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^~~~~~~~~~~
include/linux/kernel.h:868:24: note: in expansion of macro '__safe_cmp'
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
include/linux/kernel.h:877:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
include/linux/kernel.h:910:39: note: in expansion of macro 'min'
  __x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
                                       ^~~
drivers/iommu/dma-iommu.c:424:14: note: in expansion of macro 'min_not_zero'
  dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
              ^~~~~~~~~~~~

Add an explicit cast to work around it, as there is no min_not_zero_t()
equivalent of min_t().

Fixes: a7ba70f1787f ("dma-mapping: treat dev->bus_dma_mask as a DMA limit")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0cc702a70a96..6fa32231dc9f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -421,7 +421,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
 		iova_len = roundup_pow_of_two(iova_len);
 
-	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
+	dma_limit = min_not_zero((u64)dma_limit, dev->bus_dma_limit);
 
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
-- 
2.20.0

