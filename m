Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9417DC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6982220679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VixCw8al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfFXX5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:57:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40266 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfFXX5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:57:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so7928361pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 16:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EWd21nCYRg84WSpQXPJVjMWkNm03qaZe3d9MXyHClVQ=;
        b=VixCw8alxWT8K/HkqFguASctouXsEzuvGCOYHVmqElcW1gPxiFCLXr4OqaKIgDJMy6
         obWkNElQtEOdY3xStj24EvWfHFe0/QhmKxc4Z40jG6CK1oFp81qTPtPf0Z785HnxCeuu
         eGYYJAxjQANiTFI45yD3g7KrzKJXrF5KpABVczo1mIdp0qcW23MxygKmrxVc8Tw81c1u
         5PG3/4guxe+rapHj+Jx60WDyoxmYNODoXvxP+wzEZWyfFEyzVWhUowfiW6f48RlhXJs/
         AS1GILpY4010jYJK8dkYTcMfKBVV14EQ4G95SBS6nFQHcngiIJapeiD0MsuNEpdM/38+
         /Fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EWd21nCYRg84WSpQXPJVjMWkNm03qaZe3d9MXyHClVQ=;
        b=ewr/Uzg7u+FbyFja03YCdNv2J6nfYFI+vYU7BTLZqjfpTcrga3N+KTJACCEo0zvKpL
         n6YQVbnwBNgc7BcamkhcAhydiya/Ckq742llVttd8ERxClv8sZZYfl8cKO/jqGy1MeJB
         LEmXzkjmDOtcgWTNVHySy/xfL0Og3+VpSTXDZnjdc+SSkwDOjPKDrJLamPNAChfmECiy
         SzBfLUCTfYkXuxmVUuca00hu12ChXzZsC59Z1tsD2lVvlHMJ5fFm9eBXP7a5STISN4JZ
         uGlpJJ/g7ggGZGRYGYju1djS1JxpByIKaM9JEGpDTkIj9I7rdUuTJt4WSZWgol6cM2xC
         R82A==
X-Gm-Message-State: APjAAAXL9VeuRxYcl7N1hp0n62c+gQepWHtbVA2dcGbo63/QFqu6JjDW
        DncbCgbldVDymgXBREcmtXAQzw==
X-Google-Smtp-Source: APXvYqzAaa6PoOBFZTIRVOfw04tMBXd+p/jLR9GMhGwwnBp89+8nJwsBf+HuB1ozjSetHRkQSaJUdA==
X-Received: by 2002:a63:de50:: with SMTP id y16mr19184127pgi.431.1561420666183;
        Mon, 24 Jun 2019 16:57:46 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 125sm1335727pfg.23.2019.06.24.16.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 16:57:45 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] nvme-pci: Avoid leak if pci_p2pmem_virt_to_bus() returns null
Date:   Mon, 24 Jun 2019 16:57:22 -0700
Message-Id: <1561420642-21186-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify nvme_alloc_sq_cmds() to call pci_free_p2pmem()
to free the memory it allocated using pci_alloc_p2pmem()
in case pci_p2pmem_virt_to_bus() returns null.

Make sure not to call pci_free_p2pmem() if pci_alloc_p2pmem()
returned null which can happen if CONFIG_PCI_P2PDMA is not
configured.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/nvme/host/pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 524d6bd6d095..5dfa067f6506 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1456,11 +1456,15 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 
 	if (qid && dev->cmb_use_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
 		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
-		nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
-						nvmeq->sq_cmds);
-		if (nvmeq->sq_dma_addr) {
-			set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
-			return 0; 
+		if (nvmeq->sq_cmds) {
+			nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
+							nvmeq->sq_cmds);
+			if (nvmeq->sq_dma_addr) {
+				set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
+				return 0;
+			}
+
+			pci_free_p2pmem(pdev, nvmeq->sq_cmds, SQ_SIZE(depth));
 		}
 	}
 
-- 
2.7.4

