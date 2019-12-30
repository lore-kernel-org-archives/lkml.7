Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841F5C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C05320722
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577726795;
	bh=hpl/Co9KS2/LOKvrmlKkOwb9bVMQhrdELM9/mYvA0mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1c270KQ0H3v8swtD62AxR0ZWUJVzCzqikBnniwl3thClNagZXmX0sT8nLuRpUOyEQ
	 kLmgE8XkEYhBAfUkz5y300670eFojPAd2d5eJeetg4HhlPQ5K3b3KBoxjsMEiUly8d
	 1eFahoJTdA+wjZ91hHHIlZnp8xtzvPAKqrsahehg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfL3R0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:26:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfL3R0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:26:31 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 624E22071E;
        Mon, 30 Dec 2019 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577726790;
        bh=hpl/Co9KS2/LOKvrmlKkOwb9bVMQhrdELM9/mYvA0mA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YljdSTY8qMLQXFtcQUD+tseAIbH85X09zfrYeOaKxNX76qV9rOa6XYOpMvzGcJfS1
         6Bi6MvXfoL9Tzu0mtaINRfCGeXfaIBqHASTe4n4BlzG3Vvcy1TgB5Nq809XWxBdCUA
         MgQhpM1Ty8oyJIrxW270k6WOqqtMG3MJJXunOIN4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] iommu: omap: Fix printing format for size_t on 64-bit
Date:   Mon, 30 Dec 2019 18:26:18 +0100
Message-Id: <20191230172619.17814-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230172619.17814-1-krzk@kernel.org>
References: <20191230172619.17814-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print size_t as %zu or %zx to fix -Wformat warnings when compiling on
64-bit platform (e.g. with COMPILE_TEST):

    drivers/iommu/omap-iommu.c: In function ‘flush_iotlb_page’:
    drivers/iommu/omap-iommu.c:437:47: warning:
        format ‘%x’ expects argument of type ‘unsigned int’,
        but argument 7 has type ‘size_t {aka long unsigned int}’ [-Wformat=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/omap-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 50e8acf88ec4..887fefcb03b4 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -434,7 +434,7 @@ static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
 		bytes = iopgsz_to_bytes(cr.cam & 3);
 
 		if ((start <= da) && (da < start + bytes)) {
-			dev_dbg(obj->dev, "%s: %08x<=%08x(%x)\n",
+			dev_dbg(obj->dev, "%s: %08x<=%08x(%zx)\n",
 				__func__, start, da, bytes);
 			iotlb_load_cr(obj, &cr);
 			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
@@ -1352,11 +1352,11 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 
 	omap_pgsz = bytes_to_iopgsz(bytes);
 	if (omap_pgsz < 0) {
-		dev_err(dev, "invalid size to map: %d\n", bytes);
+		dev_err(dev, "invalid size to map: %zu\n", bytes);
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "mapping da 0x%lx to pa %pa size 0x%x\n", da, &pa, bytes);
+	dev_dbg(dev, "mapping da 0x%lx to pa %pa size 0x%zx\n", da, &pa, bytes);
 
 	iotlb_init_entry(&e, da, pa, omap_pgsz);
 
@@ -1393,7 +1393,7 @@ static size_t omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
 	size_t bytes = 0;
 	int i;
 
-	dev_dbg(dev, "unmapping da 0x%lx size %u\n", da, size);
+	dev_dbg(dev, "unmapping da 0x%lx size %zu\n", da, size);
 
 	iommu = omap_domain->iommus;
 	for (i = 0; i < omap_domain->num_iommus; i++, iommu++) {
-- 
2.17.1

