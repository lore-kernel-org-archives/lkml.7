Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA34C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D682089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554421;
	bh=N/HWZ6eecpTpT9fjMbEwRpzm6qtN5IsK/x3qcDuB1yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hR5YCx3jSVI893C98/cbcWLrzcUa4EKPtN6Adc9Te17lvdG6puzrh/oRK1HPXoSdO
	 3vNYdED9ve3Yu5rSisUKNt+DfRl7+dxweBdGsvJX8HP8sBmWFXNvxQc4Q8N2iUMhUo
	 YBXh4iT9sxKDDmH+ThEHlyCb/wH169FHOJxfpA0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfEVT1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731746AbfEVT1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:27:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB09421473;
        Wed, 22 May 2019 19:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553251;
        bh=N/HWZ6eecpTpT9fjMbEwRpzm6qtN5IsK/x3qcDuB1yQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wUDCh1OPA3pPCUbLYIqCoViDVSHooyYNEZRmGxiuNifuVcYXwGe1JA3nW+rjBJjA1
         ZXVCBnmMC1AHdDCx0EkXt4Oh9vF98EkGxndxA6At1aA/QeUiegMUG3V41xN2Ok3sEr
         Ujvny7D8Zu0n0p8elpBZL1g7EAdqJRPCmjRVO5eU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 035/244] scsi: qla2xxx: Fix a qla24xx_enable_msix() error path
Date:   Wed, 22 May 2019 15:23:01 -0400
Message-Id: <20190522192630.24917-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192630.24917-1-sashal@kernel.org>
References: <20190522192630.24917-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 24afabdbd0b3553963a2bbf465895492b14d1107 ]

Make sure that the allocated interrupts are freed if allocating memory for
the msix_entries array fails.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 36cbb29c84f63..88d8acf86a2a4 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3449,7 +3449,7 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct rsp_que *rsp)
 		ql_log(ql_log_fatal, vha, 0x00c8,
 		    "Failed to allocate memory for ha->msix_entries.\n");
 		ret = -ENOMEM;
-		goto msix_out;
+		goto free_irqs;
 	}
 	ha->flags.msix_enabled = 1;
 
@@ -3532,6 +3532,10 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct rsp_que *rsp)
 
 msix_out:
 	return ret;
+
+free_irqs:
+	pci_free_irq_vectors(ha->pdev);
+	goto msix_out;
 }
 
 int
-- 
2.20.1

