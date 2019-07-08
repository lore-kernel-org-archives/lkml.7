Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDBCC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DBA20693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RqwarEYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388125AbfGHRFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:05:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46001 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730562AbfGHRFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:05:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so3876281plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tOpykf3uA7PgIAj57BVeb5Ckpsxwk0DmaPVryuo4XDg=;
        b=RqwarEYe4UuOlIdigKo9s3lm/K/wVHdBOuWbrfreSzdLm5getPo5gHeG0nAHigIVJa
         kY05g9fm1xUuqurBFSvJHSDrt/QEk+OEoOaKcjvOMU9RSWlPHS0lEpz2hh6fm1UEmlkv
         E/zVZBb1QaRjO0QFNSdAb72mhif9YZ7z3PVlXpEJqNQ4NMGohPM1Ji5Db2O0e5T24C6d
         8tB9U48NztW2SP3v0UwvIoI0BGOvgOf9aSKRKDus5lGJuFkq7ef8XWf+Y/j5C4ci++41
         mq9O5jG+gsEr1T/kFQ27AOwj8wWI88FZKgViq2dD/YAq3feXSlOMKczL3FZF2W1Texw8
         mg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tOpykf3uA7PgIAj57BVeb5Ckpsxwk0DmaPVryuo4XDg=;
        b=hzJpF4RN2r03aOVnyuqn3pSCJ3S2qreAEAaWNjtVkFq+uOYs/yMxJaSCOpD4rFbhsD
         kGGMficRmu/ijYrtAYgyEPXdUnai327GLQPI2xHTGxClGuc6jilE0eTW64MbTEuGdYK6
         bc1ppqxoDaWYaJ6A6MPt4AaH3EM1ldIij2W48zx6ooZ6CLneQDPlJgLyP5hZaiOiqQPI
         7xoX1orlXa0S9SJzl7ByJy1Cv9vTtyo9anxAeuTamVv/Uu1pdtXawDt2iPpwXTA99b5n
         RrT5f3RRttLZSLZDoEbfTTdYzVVnL7zaflOfTNl4KF9x/5oMksk2fUdtJx/cQgczBmfW
         VIIg==
X-Gm-Message-State: APjAAAVKASTbl/F1un2PrFACIfCvxWUcTG+a7/DBHDQXA0FageXDyaCv
        RKLrbne60Ux6zpgibYi2uymfv/Uh9XI=
X-Google-Smtp-Source: APXvYqwM7tLzP2qjV/jjo4GIuB7FNendUt8Pl8OkfRPNMnV0NJhG7mc9q5Gi4NYmGu6GxAaqOl35ww==
X-Received: by 2002:a17:902:9898:: with SMTP id s24mr25809547plp.226.1562605520279;
        Mon, 08 Jul 2019 10:05:20 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j15sm12173877pfn.150.2019.07.08.10.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 10:05:19 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2] nvme-pci: Check for null on pci_alloc_p2pmem()
Date:   Mon,  8 Jul 2019 10:05:11 -0700
Message-Id: <1562605511-6564-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify nvme_alloc_sq_cmds() to call pci_free_p2pmem()
to free the memory it allocated using pci_alloc_p2pmem()
in case pci_p2pmem_virt_to_bus() returns null.

Makes sure not to call pci_free_p2pmem() if pci_alloc_p2pmem()
returned null which can happen if CONFIG_PCI_P2PDMA is not
configured.

Current implementation is not expected to leak since
pci_p2pmem_virt_to_bus() is expected to fail only if
pci_alloc_p2pmem() returns null. However, checking
the return value of pci_alloc_p2pmem() is more explicit.

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

