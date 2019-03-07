Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134C5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB07520684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCGKtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:49:24 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:45513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:49:24 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MQ5jC-1hNlBo2eyu-00M4YD; Thu, 07 Mar 2019 11:49:04 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paul.burton@mips.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] dma-mapping: work around clang bug
Date:   Thu,  7 Mar 2019 11:48:41 +0100
Message-Id: <20190307104900.2506657-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SzMYzs5WTwwfpI3IgrpvZg3w8SruVDTlenEysSiOwZsB642hMs3
 1Q8mb5BaswhiPxtn3DvOU9dv9TrsI/Qtw1FKvyVV1z+5I7K4pULqclcZPjyt2LHgRtlslGO
 i0aAZG+1N3RKOblrHF4QEqd4AeoTNX1lfWUbudH/+nV5THGMsrGElx3rTF5L43V7JhyjeRB
 rvokGZl+nlcvsaWKF0U6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0LqwgvOLYpM=:psrSLhepFK/TX/fa5B7zsI
 +mm474dCa4yiYd2mx8wiCjcxsgDpqfCMFA8eVXJ7qyaihJltnMiDP5A0wp9TV06j7hv8I6TIE
 URb8Uhf5bu9TBzQilP7cMZnU/GazFdtLf+WZx8UrTeb7SKnSShLpda+Y9Wdbyg0CQ02sRiSmu
 9/RB2IV5xjqDymnv02KkJ84IqoN9EPrecHyGF7xvHMfJoo9BOW0kOWtQxgmiY/sR+kMfOcA9f
 3E1ofvaKSbRLMT8sIx7wRxrfjE3boG//26IzaknFQI03Q1NqGlvFpeD3lCPF4IOykYoz1aHUg
 JW7wEBrCjaqb2d8ku2i1RcikXinshSXKs+HDruNd1ieMSvC5AeAVAEySOlUj2FMjJRowXGbmw
 3J2Vwm0BVYQupoCt+fARnhHpCM4dq5vrgExAttVhcaGOjb226dJW2UVhRPCecFNM0ZPC3D/BT
 KY1E3UTWCGSklLsTarsGPl5BcDWR2PLr5PQWGPaCOvdnMwZ4hpkvd5cErWX9qYOMCb5xM+Brv
 nagn7qakxYKc57Ia90WjVFxnJIQNvwhlOhtSJjp0Kvy32sJYoSRjZEUJfHIRVTu7nkTFnwBXI
 ypQscp7GJ2qg2OF7GrxW5d7x817iFi7j+9yEhY02fmJM9JdiQIAPy3gtCniJX/NV5X26LegFI
 Xx2bsqQS5+p+oAG7OkM0/LcYeUlmHx/aWAU4brmyMxBxOVTvbAVr88j0uafz77IZ/mJF2w5Iw
 7BFvbiosfCpZyb6eBbBA0puf1/gf9yZZjL9E1g==
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: use (2ull << n-1) instead of ((1ull << n-1) << 1)
    special-case 0 instead of 64
v2: fix off-by-one error
---
 include/linux/dma-mapping.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 75e60be91e5f..5788d60c2223 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -138,7 +138,11 @@ struct dma_map_ops {
 extern const struct dma_map_ops dma_virt_ops;
 extern const struct dma_map_ops dma_dummy_ops;
 
-#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
+/*
+ * Shifting '2' instead of '1' because of
+ * https://bugs.llvm.org/show_bug.cgi?id=38789
+ */
+#define DMA_BIT_MASK(n)	(((n) == 0) ? 0ULL : (2ULL<<((n)-1))-1)
 
 #define DMA_MASK_NONE	0x0ULL
 
-- 
2.20.0

