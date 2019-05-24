Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1091C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EAB21841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEOS4vpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbfEXEIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 00:08:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44727 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbfEXEIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:08:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id g9so4467577pfo.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 21:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vxeV9ft42Z9weuRQsncwqOnoZhf6GFp447KDcblUrfk=;
        b=uEOS4vpSHdvXshyeyQ0iD5vi/t5HfXMC3vH5rAwA3MkTTMmV9SwBcKO6u2MgfwD9Qv
         rg1ur842IMCEA0od5Kz1Bv0neEZVP1EFQ2hnPy6aqnCPu5vv/305N8orS5j1TIBm7RZr
         DKlEvNF10U80id4FfPyCmZCEINE1FFalSGEjnvRo6BfpitC35mWn0iQrw5vn7AiTBhif
         Kxp6iu6brjDoyH44Gsj4iu6eW63mCBq11PMUMbdOAIsgMjTC3mx8K4KwGv1R93lWGzOB
         ZYth9SqRBCknZjn4lf5D7bcJSLyfsIhameDrjsQYZHjABq4YfuC8DW9+L0WJQsVTOnVj
         SZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vxeV9ft42Z9weuRQsncwqOnoZhf6GFp447KDcblUrfk=;
        b=I+ypdS8ek9zR+RF/7L5TsVU40Q/IwLZeOBwRRKHc5QStFchbAO9d+qJT2g+HXYAR1C
         ypUbrCLVWgi1294dxeSCRQkFlWeOngB/8IZ31CE9r1ytwGDRZWQHuKIqulUE83nMKo1O
         11UR2F3jcVaTiUjM6Q9XmsTwMiCndJz6cYmJbblr5Y5KPH5Byng3KhmCDhkXypBMAvkT
         fchXHZ7EdxsVGHfkRG00xQBZ80uNc1OMh7AhyqkUgNQmQQ67osuCTkoUwofJl0gbZBG2
         hFQkZCFtvREhcp0ELCnAydEnjFr1TLe4/YUGCupBl1RIrzJN4qZGpB6n3n/oLSZ9l/Fi
         TU7Q==
X-Gm-Message-State: APjAAAXs8HBh7QrpqC9R0X2W5vE/pcEcteH/uzB7kpwytWprvxA9n3jM
        crDyZ7I1GSeYxI8N4Y+s8Uw=
X-Google-Smtp-Source: APXvYqz3rANqBcGuU0hMuqFXJhoStKwnDv8T7RVd97CjQ1RaDUTPIv1XEAw8pA1ErKVwCpbE/Uq31g==
X-Received: by 2002:a62:3605:: with SMTP id d5mr89150670pfa.28.1558670884755;
        Thu, 23 May 2019 21:08:04 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e123sm786412pgc.29.2019.05.23.21.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 21:08:04 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        dann.frazier@canonical.com
Subject: [PATCH v3 2/2] dma-contiguous: Use fallback alloc_pages for single pages
Date:   Thu, 23 May 2019 21:06:33 -0700
Message-Id: <20190524040633.16854-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524040633.16854-1-nicoleotsuka@gmail.com>
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addresses within a single page are always contiguous, so it's
not so necessary to always allocate one single page from CMA area.
Since the CMA area has a limited predefined size of space, it may
run out of space in heavy use cases, where there might be quite a
lot CMA pages being allocated for single pages.

However, there is also a concern that a device might care where a
page comes from -- it might expect the page from CMA area and act
differently if the page doesn't.

This patch tries to use the fallback alloc_pages path, instead of
one-page size allocations from the global CMA area in case that a
device does not have its own CMA area. This'd save resources from
the CMA global area for more CMA allocations, and also reduce CMA
fragmentations resulted from trivial allocations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/contiguous.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 21f39a6cb04f..6914b92d5c88 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -223,14 +223,23 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
  * This function allocates contiguous memory buffer for specified device. It
  * first tries to use device specific contiguous memory area if available or
  * the default global one, then tries a fallback allocation of normal pages.
+ *
+ * Note that it byapss one-page size of allocations from the global area as
+ * the addresses within one page are always contiguous, so there is no need
+ * to waste CMA pages for that kind; it also helps reduce fragmentations.
  */
 struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 {
 	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
 	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	size_t align = get_order(PAGE_ALIGN(size));
-	struct cma *cma = dev_get_cma_area(dev);
 	struct page *page = NULL;
+	struct cma *cma = NULL;
+
+	if (dev && dev->cma_area)
+		cma = dev->cma_area;
+	else if (count > 1)
+		cma = dma_contiguous_default_area;
 
 	/* CMA can be used only in the context which permits sleeping */
 	if (cma && gfpflags_allow_blocking(gfp)) {
-- 
2.17.1

