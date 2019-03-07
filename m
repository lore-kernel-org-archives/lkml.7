Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BFCC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0836320835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfCGIBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:01:19 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:54495 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCGIBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:01:18 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MsZeX-1gn0pF0d0l-00txjM; Thu, 07 Mar 2019 09:00:42 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: work around clang bug
Date:   Thu,  7 Mar 2019 09:00:25 +0100
Message-Id: <20190307080038.3727426-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SnRTwP7mB1YqM4Ju0tIDBNxdpmKOjjsaltQRQqdqOs6SJgdPNEG
 qML6XcUhF83mtJcarIloWoyYtOlTZRao8xWFZctzxcOcvIvMuMEC3T0WBd2LMr2C+hwp1Sh
 x7KZlWkdTHteysVNHEyw89nSiSqz5aOMWlbXYCdUA5npGURM0KWRJKTeoYYwyh2H7oaui9m
 qtpISyDN3FdrO/Th/ZuZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mvI6dVuhiUU=:/R7VamLGMWNcYf311jvRHq
 qg0QfAvZnVzoUfZKJaapNdto//AYugPjk5TYwiMvo3NpB7Zb/tZJ3fZm/F3scEAv24S463rgW
 YqiqJVnNprt4WuyRaDZ67D2SxgSGMNu8EuY9g0GsZB2pruo35JYQedX36NQptfcdLu6jokkRK
 FOUQ/nPAmKNhRCRzE9/6dRjgI6y0FQZfd3VmFShAbAZSz9I9tGWQ+VC9t/ux4KMo4HGEK9m+s
 5uKDeBp+OTqmWSVc4ys6isJImPoCspCrO0FxtwuIbDSZJ5GRwdtptYmDy2lfnDoWO1i/dBrX5
 b4m7XHuxEGWzy3QOZvfVnrmPftbolGx7NKPbA+znCw40zy89WXHeAuqt+hTNrfZ6dn4MzsBiZ
 EX9NNoBL88W6nD1ICcaQFWdihFdWCvfxFcTwPKiOIbFG18W2CSuk2oKJOW1kfowyzPOiav+8c
 /1BLIwPSaRdRKPslVqQb5yHOBF4pkDstbxm14tN5FNkeYIdJpqjmysPhhQ5r0dU6zEr2EmPqL
 ZvnQypB+1kOleJhFxwWc1VcDJYO7XzUDg+Ja9dfQttxlSQVMmGfb60W5zUA/kuR+/9jbW8dK9
 wjzPe+CewWmcZu84AlZLkqj0ts7BOaLG4CustNA7jiheu3V90/CDJKIfgEll6KHOsRmix4mqv
 oU8JYMjr2tLLCVE0TsUuZeIVdpquitA5p2Fi8cPlQa/fnmtm1o2ttJk/Y9zHpm4kccZz4qqla
 H83h4kxVORszuMisF5pRZHqg5sHXCCo8ZqcKjA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang has a rather annoying behavior of checking for integer
arithmetic problems in code paths that are discarded by gcc
before that perfoms the same checks.

For DMA_BIT_MASK(64), this leads to a warning despite the
result of the macro being completely sensible:

arch/arm/plat-iop/adma.c:146:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
                .coherent_dma_mask = DMA_BIT_MASK(64),

The best workaround I could come up with is to shift the
value twice, which makes the macro way less readable but
always has the same result.

Link: https://bugs.llvm.org/show_bug.cgi?id=38789
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/dma-mapping.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 75e60be91e5f..380d3a95d02e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -138,7 +138,8 @@ struct dma_map_ops {
 extern const struct dma_map_ops dma_virt_ops;
 extern const struct dma_map_ops dma_dummy_ops;
 
-#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
+/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
+#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : (((1ULL<<((n)-1))-1) << 1))
 
 #define DMA_MASK_NONE	0x0ULL
 
-- 
2.20.0

