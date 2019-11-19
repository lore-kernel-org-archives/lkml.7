Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA03C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B42222DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141504;
	bh=CxMd0H4p3VQzZUSiZPmnNe8aQlpthgB19KGLnWY0qB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eynnbaDgdzrTeLTNGTJMowb6bR8lRo/LpRt2rOio6spUBpZPBdpudubjv+XC+WI3m
	 3KBoCsK7/koUzIPKpPTZN2rJWb1QywX+4QO7JQOJZ5XOcMCVR123B2NklZkW433k27
	 K5Qv/mkaBT8n0+iszDbya0t7RA7JjpAjWgouujMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfKSFbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:31:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbfKSFbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:31:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F96921939;
        Tue, 19 Nov 2019 05:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141498;
        bh=CxMd0H4p3VQzZUSiZPmnNe8aQlpthgB19KGLnWY0qB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8n5i4OX6Px2BPr5HTYlhHjJAJ91+7iVdSI0zNgmQekkX3vM7/pTkJGRUJqDyFx1Q
         n3nuCCoyyLdR6bWMlP9CP/ZWsp79Kt6NA1z95vKEVVMiTXBtdXjz+gKBjskBzifsDB
         BRghbJ8JEbqTsJ5yKQetURm4IGW1KIw4JhZMmABw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 179/422] scsi: lpfc: Correct invalid EQ doorbell write on if_type=6
Date:   Tue, 19 Nov 2019 06:16:16 +0100
Message-Id: <20191119051410.051405937@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit aad59d5d34738d6fd8c359df8048a84cd443e504 ]

During attachment, the driver writes the EQ doorbell to disable potential
interrupts from an EQ. The current EQ doorbell format used for clearing the
interrupt is incorrect and uses an if_type=2 format, making the operation act
on the wrong EQ.

Correct the code to use the proper if_type=6 EQ doorbell format.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_sli.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index a490e63c94b67..e704297618e06 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -392,11 +392,7 @@ lpfc_sli4_if6_eq_clr_intr(struct lpfc_queue *q)
 	struct lpfc_register doorbell;
 
 	doorbell.word0 = 0;
-	bf_set(lpfc_eqcq_doorbell_eqci, &doorbell, 1);
-	bf_set(lpfc_eqcq_doorbell_qt, &doorbell, LPFC_QUEUE_TYPE_EVENT);
-	bf_set(lpfc_eqcq_doorbell_eqid_hi, &doorbell,
-		(q->queue_id >> LPFC_EQID_HI_FIELD_SHIFT));
-	bf_set(lpfc_eqcq_doorbell_eqid_lo, &doorbell, q->queue_id);
+	bf_set(lpfc_if6_eq_doorbell_eqid, &doorbell, q->queue_id);
 	writel(doorbell.word0, q->phba->sli4_hba.EQDBregaddr);
 }
 
-- 
2.20.1



