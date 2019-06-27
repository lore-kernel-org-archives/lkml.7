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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6474EC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B445205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2T611gY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfF0RiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:38:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38840 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0RiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:38:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so1586082pfn.5;
        Thu, 27 Jun 2019 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xxAIWMsFok0e7AabKJTw0feZUpouaQgm3aaB5lP85OA=;
        b=J2T611gYoLqlB+nCVFMztU4EqZmZ1fEfDi5dyhcFKARrjI1N1e7OIoyuqhUNAANW3Q
         utNZzB4RlUW20rDhjriv8mzX/zOn7Uthe9YK2CDBJIeeQ5BFIrHpP6vJDojt3iXb/UlR
         WvAxQPfQLf6Wn7JD20hQvSBJfsesOmVT9j3ypdIsrN2uBNH7DxOGWnUu60+wLS+FJS+P
         bAqiBbM1TFEKZ5PM3uOAOmyU5+eXJA56T2c1A+lmzzNY5owbVXPEXxiyVpvK9jZaJteM
         f179QRm03A9wfTNGi1Mcx9LdO9IXnuZJpfhEWyGl6jzjYFjbAa+8fEEAW7Puadt6TP6w
         xT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xxAIWMsFok0e7AabKJTw0feZUpouaQgm3aaB5lP85OA=;
        b=lnAcC7GHpdSDK0XQRIsdvNesOAQzObHzRb3S7Eo6WD+kLv46hBsMsDZroTexOB1TaS
         FZHuWqUIbW+d6tVQIAYiFHmM+A5InW5QB+luVe5dPaI3r9oBSVnR8I05Zc5Curnu4/6I
         HvSi5KmKxkP9gzu3gZEnLElTFGaic6E0iUt54FBbgkR+b5bClqMemD63kVyywV2/MHDG
         y6YvrdFmcNUDPc2PXhaZ2+V1HALVZlA5JD2lEa9TlTHevKBWWRXSWaNXbDvC6Mc2rUCR
         OjtKgx2xbFVfa4DPRlbUYwIoX4FZ+uB/IB8Y6xyu8DoCtzYbxl4wDc4i5qydC28NQB8I
         9IqA==
X-Gm-Message-State: APjAAAUHSqQrdQGQHFIWnE6DCtC/ICmlszThULcA4482gUtn2DyShtxa
        2AUDdeRNdJJfE36burMIMlg=
X-Google-Smtp-Source: APXvYqw2bZr/WdAtZpBk4xTffZarXcJCyEHqZwnRVnmrrM2Nx3KD/lJLfpK7gVVpwBmq4hVRF2NLFA==
X-Received: by 2002:a63:6143:: with SMTP id v64mr4749847pgb.407.1561657083337;
        Thu, 27 Jun 2019 10:38:03 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id x23sm6592249pfo.112.2019.06.27.10.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:38:02 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/87] infiniband: ocrdma: remove memset after dma_alloc_coherent in ocrdma_hw.c
Date:   Fri, 28 Jun 2019 01:37:54 +0800
Message-Id: <20190627173756.3253-1-huangfq.daxian@gmail.com>
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
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
index 5127e2ea4bdd..6e07712eb3ed 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
@@ -1351,7 +1351,6 @@ static int ocrdma_mbx_get_ctrl_attribs(struct ocrdma_dev *dev)
 	mqe->u.nonemb_req.sge[0].pa_hi = (u32) upper_32_bits(dma.pa);
 	mqe->u.nonemb_req.sge[0].len = dma.size;
 
-	memset(dma.va, 0, dma.size);
 	ocrdma_init_mch((struct ocrdma_mbx_hdr *)dma.va,
 			OCRDMA_CMD_GET_CTRL_ATTRIBUTES,
 			OCRDMA_SUBSYS_COMMON,
@@ -1690,7 +1689,6 @@ static int ocrdma_mbx_create_ah_tbl(struct ocrdma_dev *dev)
 		goto mem_err_ah;
 	dev->av_tbl.pa = pa;
 	dev->av_tbl.num_ah = max_ah;
-	memset(dev->av_tbl.va, 0, dev->av_tbl.size);
 
 	pbes = (struct ocrdma_pbe *)dev->av_tbl.pbl.va;
 	for (i = 0; i < dev->av_tbl.size / OCRDMA_MIN_Q_PAGE_SIZE; i++) {
@@ -2905,7 +2903,6 @@ static int ocrdma_mbx_get_dcbx_config(struct ocrdma_dev *dev, u32 ptype,
 	mqe_sge->pa_hi = (u32) upper_32_bits(pa);
 	mqe_sge->len = cmd.hdr.pyld_len;
 
-	memset(req, 0, sizeof(struct ocrdma_get_dcbx_cfg_req));
 	ocrdma_init_mch(&req->hdr, OCRDMA_CMD_GET_DCBX_CONFIG,
 			OCRDMA_SUBSYS_DCBX, cmd.hdr.pyld_len);
 	req->param_type = ptype;
-- 
2.11.0

