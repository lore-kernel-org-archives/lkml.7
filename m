Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715B1C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A1820659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+i5ZKSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfGBH6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:58:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33595 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBH6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:58:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so7862046pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A/JkjCB2ropmh2U8bl0kSXRX9Tm2mT9SL1AlS0wyJi4=;
        b=s+i5ZKSWs5hWLazcfs2D5TseLI5orDVhT2I1/syMUpPSO0w9D8aetagWV/pAVTUPJA
         wCvO0GsRnSuugubRURFxTuRLC/q6ooysu53uqVCC+Iq5EwDPrefTohbAiSeukVtPgAUo
         Rx0WrduElAkFuT+MyQmW/T70Shgx1KFBu85F5oZDZQc4XT+RQ8CojWc+/eNyFEoRC4FP
         EyJO08yQL/ATU28PjSxJSwOShCw3+Ib1TE4fFpGmOcFtZwza3PQ22i+Ioi/kgAEGyy16
         KgyXBAz3BVuo9d+z+vkOrfQclQIB1WWMRcc0W854tm4v6bJuUK1GqO1C19FqU4fqEgku
         E2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A/JkjCB2ropmh2U8bl0kSXRX9Tm2mT9SL1AlS0wyJi4=;
        b=cLINANxVjjwpvcPbRrmWn5G3psy4f5wJXP84+X6g3Ey47tfGOzrR8I3s3a0hEjusnr
         sbo/V4Nh5QinE/uOTAliVqNYZ5k/1K/HmxQApZxKQGwLLKo/2YRMpvQhPyh+56m+zk7n
         KnjC3JK3Op80N3X9k2VDKyjPS4ozfvuJsltr+AoUy900+U55qQtyXrhyfXSszhLcWy9n
         DncXKTpmcad38d9TFokbr6gcEg20AZlMdkMcZyuOQSvSiUo8U6IEM0Izf4gWGNuChp4F
         vXCSf7Qibz7fyBCHqkezvoSe8pdnwNjCdPqczCA8XAIqHs3V0Wn77mbQofBVEdYnTZhR
         qhTQ==
X-Gm-Message-State: APjAAAWaJzfXn3jY0JZIpb5+S7wQjK9Y4zaRKOJff9obiKoyLRRfd85n
        ngx48CDIMJVsNCEYKlx0WrXhAcsgOm4=
X-Google-Smtp-Source: APXvYqweaWt2pS6JT1XC42q3xoWEkf8gFvqP+C1Wrot+2bDBjCWYX8cpai9q5S2QcPl8+1UlHYMBtQ==
X-Received: by 2002:a65:6259:: with SMTP id q25mr7588494pgv.404.1562054296669;
        Tue, 02 Jul 2019 00:58:16 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id j11sm13415106pfa.2.2019.07.02.00.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:58:16 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 11/27] media: remove memset after dma_alloc_coherent/pci_alloc_consistent
Date:   Tue,  2 Jul 2019 15:58:11 +0800
Message-Id: <20190702075811.24020-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly.
In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset after these 2 functions is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/media/pci/ngene/ngene-core.c        | 4 ----
 drivers/media/platform/exynos4-is/fimc-is.c | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/media/pci/ngene/ngene-core.c b/drivers/media/pci/ngene/ngene-core.c
index b75ab7d29226..af15ca1c501b 100644
--- a/drivers/media/pci/ngene/ngene-core.c
+++ b/drivers/media/pci/ngene/ngene-core.c
@@ -854,8 +854,6 @@ static int create_ring_buffer(struct pci_dev *pci_dev,
 	if (!Head)
 		return -ENOMEM;
 
-	memset(Head, 0, MemSize);
-
 	PARingBufferCur = PARingBufferHead;
 	Cur = Head;
 
@@ -907,8 +905,6 @@ static int AllocateRingBuffers(struct pci_dev *pci_dev,
 	if (SCListMem == NULL)
 		return -ENOMEM;
 
-	memset(SCListMem, 0, SCListMemSize);
-
 	pRingBuffer->SCListMem = SCListMem;
 	pRingBuffer->PASCListMem = PASCListMem;
 	pRingBuffer->SCListMemSize = SCListMemSize;
diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
index e043d55133a3..77633e356305 100644
--- a/drivers/media/platform/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/exynos4-is/fimc-is.c
@@ -341,7 +341,6 @@ static int fimc_is_alloc_cpu_memory(struct fimc_is *is)
 		return -ENOMEM;
 
 	is->memory.size = FIMC_IS_CPU_MEM_SIZE;
-	memset(is->memory.vaddr, 0, is->memory.size);
 
 	dev_info(dev, "FIMC-IS CPU memory base: %#x\n", (u32)is->memory.paddr);
 
-- 
2.11.0

