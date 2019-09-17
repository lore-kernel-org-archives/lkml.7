Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB41C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761C82171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="I1QY13u5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfIQNBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:01:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44471 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfIQNBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:01:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so4209715qth.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wB/yUVsEzHmjEqDrCN9BJsxtLoalzHkJD0nWY9LtcbA=;
        b=I1QY13u5DCoSEpWMdwipP2BfhnUP54oguZgW6q2KhXUO6YkJh6vy/swFUoIUYgG4o9
         H+DBMeEyKC+ZDrwIhiA/kWNsyGu7+QNK8+Nbb80l+6kCdHLPMIqQKqhAtAuHV3JpJgbq
         YNVnD2dlUZI8xSofghRE9/nlewjkSxj3JbccdFo3QS1CYLZmSWXn0FhlADYzaQqJYjwk
         VWJhncjdiQTTBFDPacyZqIMbS3SF9p+c3VGgI8+J04CNGVs0z+jO6ZVa7fORW5QvQyY+
         IZCp/zNN3AzcpjstYfVdwUPA2AjLc5/gezWjCgLxqWgfdPUzACU3XADaPtplLf5ElvrO
         lxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wB/yUVsEzHmjEqDrCN9BJsxtLoalzHkJD0nWY9LtcbA=;
        b=dQubVwwCF2bUfxEqTWfeMgib7cG34c3PDGDxrf053KaUhKBR4MNFf8dZwIzPNju0FE
         0qZHrqtyw8Uira7MmCaymylqbtOgIuFM88jDlX8WsJzVxRWyKOmTWwFFDgAr2V1NNxft
         WdoK3QCbRUCFtXzBatzK9tEmbwEWvGB1UCUQfd6PehPQi6/87wPhOuvzCacS/6axtoCb
         4Xawytl9phz8/G0Q0JNqcPbWM2tVG5aYnp+Xq/p/vd0JpsHBt3xVRCdoQU3Vyh/mD43D
         ioTHeu6H7s4UG7bHPi3yiKlY2CFZNVMgjxewBKwV6FDv5YGvyznZGylvIpry/zz//Ldt
         1tfw==
X-Gm-Message-State: APjAAAXUIMZZAfLcSJJeDz8akBn+Tqka3/KLb4+jf6xTU+K75aBmlP70
        kGCmyNDIu+yuRc3MtoPYC4iQrqpH9ik=
X-Google-Smtp-Source: APXvYqxAci1+zEx6rBgZfCxzusb3uOXudrjs/u2TX7wBccuj3ghucqQWalJZ8MKnNU78cHSuY3Xe9w==
X-Received: by 2002:a0c:fca8:: with SMTP id h8mr2898054qvq.187.1568725259403;
        Tue, 17 Sep 2019 06:00:59 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l3sm1370442qtc.33.2019.09.17.06.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 06:00:58 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, robin.murphy@arm.com,
        vladimir.murzin@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] dma/coherent: remove unused dma_get_device_base()
Date:   Tue, 17 Sep 2019 09:00:42 -0400
Message-Id: <1568725242-2433-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_get_device_base() was first introduced in the commit c41f9ea998f3
("drivers: dma-coherent: Account dma_pfn_offset when used with device
tree"). Later, it was removed by the commit 43fc509c3efb ("dma-coherent:
introduce interface for default DMA pool")

Found by the -Wunused-function compilation warning.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/dma/coherent.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 29fd6590dc1e..909b38e1c29b 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -28,15 +28,6 @@ static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *de
 	return NULL;
 }
 
-static inline dma_addr_t dma_get_device_base(struct device *dev,
-					     struct dma_coherent_mem * mem)
-{
-	if (mem->use_dev_dma_pfn_offset)
-		return (mem->pfn_base - dev->dma_pfn_offset) << PAGE_SHIFT;
-	else
-		return mem->device_base;
-}
-
 static int dma_init_coherent_memory(phys_addr_t phys_addr,
 		dma_addr_t device_addr, size_t size,
 		struct dma_coherent_mem **mem)
-- 
1.8.3.1

