Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA67C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283A6218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MZCe//Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfDXOUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:20:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42321 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDXOUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:20:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id u23so15757413eds.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=GEXaBMD3U4sWuwXoHlsxPa0R20Q7P10dRF3KDQL2tvo=;
        b=MZCe//Am5X21XLFVYlr3pytX7fCBJ/q1M912/aF3gzt4UqSFUTgrB26DmfRZYqceQg
         ygy/yVUZWBxf8ANuZE1PuNElLSzIaZbCIEpWYbP06zULQ4fX5tKg2wOTL0a1fwJ3qUW3
         ok/Zr+2hDDlnIP+y1tFT51fKLh1DCYiw59PETX6diQDrGd8nKeveMN016v/vbZFXqWML
         BSTQVwx0kDW7Ma0T9wVtKm7GiNxNScSDGYfHxZVm1U6aqFLgbIqYoayPy66QFWxaMc2j
         I0r0NSmw29K0e7nY06nyM0Ja5ZATnurmdkCgnNWs/gn32j3oOqpIXitKVpuU+EF1xZmc
         t63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GEXaBMD3U4sWuwXoHlsxPa0R20Q7P10dRF3KDQL2tvo=;
        b=ubxpKxHQBpqAYVPfBoG6q1cru49AxpYHiCfpddNM0P+BtktFtpz6dQHj+G4o+xMtuR
         sYvUpQGpg+TnQFyhWO4BXUWBSnIwZkYvNVP9LZfakEL4OlflUn9EpqHRvs3YTfmRe9zg
         RbzxHR2/iQEWkMbY7eMgdWUpx/b5R5zNDe+KcbQzTKr9e4eoRBJkJXzkqGXvtC8Yh1re
         +SG2zDamKGEoOR+m3s9TXoTA7TWzh6weBfDkKJqS7qrstXjfkK96nYTvPgsnkIOLde27
         igY0lKGyO7zdvnX7ELM/DWFobxHyWv1GqUdzbK+o+sAUZK2FgeZP9dXjN1waWzOBF5/U
         xQ/w==
X-Gm-Message-State: APjAAAWEL2YKsEaJOFrVDhdmHWKolsxnLCSYUXiSqISQXHYv6Ba5i6vy
        mol21QgZR9e361D/4kxcHngJ9g==
X-Google-Smtp-Source: APXvYqxQoWkEWkvX0AnpeUvXGVH2qnp8HAFlWH0AjCbnHDYypkrpxh2W0ZiM0+baEcssjpVT7UdWEA==
X-Received: by 2002:aa7:d50a:: with SMTP id y10mr20113750edq.261.1556115602709;
        Wed, 24 Apr 2019 07:20:02 -0700 (PDT)
Received: from linux-ThinkPad-X1-Carbon-5th.Hitronhub.home ([89.100.89.87])
        by smtp.gmail.com with ESMTPSA id r24sm1582159ejo.84.2019.04.24.07.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 07:20:02 -0700 (PDT)
From:   Tom Murphy <tmurphy@arista.com>
To:     iommu@lists.linux-foundation.org
Cc:     murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: flush not present cache in iommu_map_page
Date:   Wed, 24 Apr 2019 15:18:59 +0100
Message-Id: <20190424141900.8883-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check if there is a not-present cache present and flush it if there is.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..8ef43224aae0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1636,6 +1636,12 @@ static int iommu_map_page(struct protection_domain *dom,
 		pte[i] = __pte;
 
 	update_domain(dom);
+	if (!dom->updated) {
+		if (unlikely(amd_iommu_np_cache)) {
+			domain_flush_pages(dom, bus_addr, page_size);
+			domain_flush_complete(dom);
+		}
+	}
 
 	/* Everything flushed out, free pages now */
 	free_page_list(freelist);
-- 
2.17.1

