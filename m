Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A50C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8322064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSNkZWgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfF0RhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:37:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42170 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfF0RhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:37:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id k13so1330242pgq.9;
        Thu, 27 Jun 2019 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4pFcqCKesKooJPGpC0eii+1Zl+R/M9LpbHQRdWKt710=;
        b=QSNkZWgqAoq76YJMoNIQ6voFVS5kgLO8yHt7Zd4qXf+q45yFbvf0G0JLcc3YZEz/MK
         fx2u6WMYj1s581bEBu/NmffrVuqr99v0KDzD7uIUwDfundY/7fzLrtPY8yfzg6fsT58C
         hdRZIPcHmibYiAOehFGJwYOkatwbJtvj/iJLfh8k4DERd+UNGWESAb5qNO8B7T6H/YJr
         7hn4Tr4tdMgTXOWg3Z2K+16eU2UUL0bcRpm+PVb1BD70X4oIBxly46nkWdA1R8ljK0H7
         dnoZLZdt4SQU62nxHeb9sMGo6/MVRyiKtPitAfTSf0E/rDr8YcmuUwEOqT5H74mVo4yc
         70hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4pFcqCKesKooJPGpC0eii+1Zl+R/M9LpbHQRdWKt710=;
        b=hyZzXeDZR7HBlwZWB9lFB1JO80BUo+ZJViXlYbbmocx12ec2fAGrtqxJFL+neefqQf
         xxe9D0mYrgE5DnjHo1FdrRzgY3kWNTq5DrSEU3fEF03ez++l588qdiPUuAUW7/372N5z
         fK5md0SP5c50LA6Mr6ohF5FF8ibhU4hUqRK6cSKTBtv8lzhwZaFlmVDy9O1j4Aors/Pa
         xVl4yB/NvWlSOUVUgzz7ie12Ku/ljD/aLy5do4OGZdVdAIQVgB2QyUO4/6xNol3uBiYM
         i7T5jLTmbrRExEKk33fmM6whsb4UgnH92v1GAVIDj+hWFWIpWdzad7vPe6WgEh/1CmZy
         erYA==
X-Gm-Message-State: APjAAAWcl2eEDbjYLhT5/Rr1lkDRryUtM8SxkVGab8Ep4JaVMHhnPOdx
        5Qd7+Udroc7R2Og9x5bSK6I=
X-Google-Smtp-Source: APXvYqx7EUnSxGX/HUDHKbJMmpCIoNjUT7AKVZGdghR14KNxPFtfZERkIsC4RbDLIdZ1V5I3JhPz3A==
X-Received: by 2002:a17:90a:2163:: with SMTP id a90mr7081610pje.3.1561657027401;
        Thu, 27 Jun 2019 10:37:07 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q1sm3947721pfg.84.2019.06.27.10.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:37:07 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/87] infiniband: cxgb3: Remove call to memset after dma_alloc_coherent in cxio_hal.c
Date:   Fri, 28 Jun 2019 01:37:00 +0800
Message-Id: <20190627173700.2887-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/infiniband/hw/cxgb3/cxio_hal.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
index 8ac72ac7cbac..0e37f55678f8 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
+++ b/drivers/infiniband/hw/cxgb3/cxio_hal.c
@@ -174,7 +174,6 @@ int cxio_create_cq(struct cxio_rdev *rdev_p, struct t3_cq *cq, int kernel)
 		return -ENOMEM;
 	}
 	dma_unmap_addr_set(cq, mapping, cq->dma_addr);
-	memset(cq->queue, 0, size);
 	setup.id = cq->cqid;
 	setup.base_addr = (u64) (cq->dma_addr);
 	setup.size = 1UL << cq->size_log2;
@@ -538,8 +537,6 @@ static int cxio_hal_init_ctrl_qp(struct cxio_rdev *rdev_p)
 	dma_unmap_addr_set(&rdev_p->ctrl_qp, mapping,
 			   rdev_p->ctrl_qp.dma_addr);
 	rdev_p->ctrl_qp.doorbell = (void __iomem *)rdev_p->rnic_info.kdb_addr;
-	memset(rdev_p->ctrl_qp.workq, 0,
-	       (1 << T3_CTRL_QP_SIZE_LOG2) * sizeof(union t3_wr));
 
 	mutex_init(&rdev_p->ctrl_qp.lock);
 	init_waitqueue_head(&rdev_p->ctrl_qp.waitq);
-- 
2.11.0

