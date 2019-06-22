Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9CDC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 04:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044172075E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 04:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etSM9Q7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfFVEiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 00:38:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47042 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfFVEiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 00:38:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so4549702pfy.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 21:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UVjWSqB/7Lf0YYDkLp4LkWZ43zZWpfRLYB/XiGKhRY8=;
        b=etSM9Q7XVXL92xsCiw4I+XZtigD2/HnHeL8qQ90VPhdsEwiEymS+PrgqSSVXRjrzY+
         sg164nUnohbeF0Q3nvvg2DimOz8gb+sTKIrELJBL5z1OSxlcQuZ/Pw5nLSZTMB03XEYg
         blTNS6arcQYH3VsASTVi3/FuM0lXEh6PuCY40tGi2UjHGg6frNymobGN4UD+TwYXeRRn
         7lw+dUfNUCXQm/2Rm1yCIkvBn9f3mGA3SwmeJ0pFR/534Uh0KIXBK0SWAL2VYMRwc5nw
         FBYwl1KydxJkteEJJDMJw0iD/GR37c2Pfy6rwCIe4n25O++3cX8KR15Q+W89OLQxfn0O
         /5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UVjWSqB/7Lf0YYDkLp4LkWZ43zZWpfRLYB/XiGKhRY8=;
        b=kYJLDhpcCojNgVzvPQnEL35/ZMIY/tIkcpseSF3yZUn9wtNc3JjtAEw839gvs7PHkB
         +akEBACk4B+wZ68fXuxRc+H8G2YQZzmY9/JhGBJs0zj0I2td0e00ZR/wJOLyoTAYrgU+
         RgQv3/uDVigkvjbI+Zca9xmDxSQ7veHABz8KBlk6XuKDe1wAPMWicAw8eWi0ZMDg4wdm
         AQCgLAtEsmOxOlWBLHKE7ckLHhTgiVuMahu79e6pwnio1tRxdlF9oYxnSYt/v7aCUVuv
         E0YlTdv3jqQseTJ2D7FsLKEV2L89r62N5864qT46L36A8NPpPohtwpv9utw/baZZPV7U
         y0oA==
X-Gm-Message-State: APjAAAXsLW/bk5NMz8UtUn3idoUpyCgFN1AtS4KIVZpbZYlq3FHYpjcm
        gnIdnbRXU3482pLqZB0aQ37f0Ys9LXk=
X-Google-Smtp-Source: APXvYqzRsqXCbeug24DzwsENw7/g/zBC/20NAsJBzRau4julnTvQAbQ9Ks3XyflyGM1L6QEBiQoF6g==
X-Received: by 2002:a65:620a:: with SMTP id d10mr21909649pgv.42.1561178287301;
        Fri, 21 Jun 2019 21:38:07 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r2sm6338586pfl.67.2019.06.21.21.38.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 21:38:06 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     joro@8bytes.org
Cc:     robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/dma: Fix calculation overflow in __finalise_sg()
Date:   Fri, 21 Jun 2019 21:38:14 -0700
Message-Id: <20190622043814.5003-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max_len is a u32 type variable so the calculation on the
left hand of the last if-condition will potentially overflow
when a cur_len gets closer to UINT_MAX -- note that there're
drivers setting max_seg_size to UINT_MAX:
  drivers/dma/dw-edma/dw-edma-core.c:745:
    dma_set_max_seg_size(dma->dev, U32_MAX);
  drivers/dma/dma-axi-dmac.c:871:
    dma_set_max_seg_size(&pdev->dev, UINT_MAX);
  drivers/mmc/host/renesas_sdhi_internal_dmac.c:338:
    dma_set_max_seg_size(dev, 0xffffffff);
  drivers/nvme/host/pci.c:2520:
    dma_set_max_seg_size(dev->dev, 0xffffffff);

So this patch just casts the cur_len in the calculation to a
size_t type to fix the overflow issue, as it's not necessary
to change the type of cur_len after all.

Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a9f13313a22f..676b7ecd451e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -764,7 +764,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		 * - and wouldn't make the resulting output segment too long
 		 */
 		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
-		    (cur_len + s_length <= max_len)) {
+		    ((size_t)cur_len + s_length <= max_len)) {
 			/* ...then concatenate it with the previous one */
 			cur_len += s_length;
 		} else {
-- 
2.17.1

