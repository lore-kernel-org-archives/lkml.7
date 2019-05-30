Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6A2C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4B825332
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190088;
	bh=h97403slzt+aUJCshZfyfWkq30Iiw7lJH4ga9p0XgO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pMwRt2OP5zQ3t9q2POdsw7CyNaIfImUv7ZfxLrhrB3oVo8/iMvHac36Csrhv7fPg8
	 CMbAx2eMMuw4wkGogXBXvtEcZ3W8hHD6evFiLhZyfjoV3jQGI1PaO0oRv3Iinlrf1N
	 i55fOKmWGCmfbF84w8Xjbg2xrpWduE2SjFJARDQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfE3DPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbfE3DMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:32 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 932D123D14;
        Thu, 30 May 2019 03:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185951;
        bh=h97403slzt+aUJCshZfyfWkq30Iiw7lJH4ga9p0XgO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ep56G2dpmDAmVXBwS/4S9mtrspRx6H9JVmTZm0Klndzmv28qOiKbWPEyk4rxfD49B
         pMLV2thA6Mji2ug6ctQP2lf3qfVDERa6k+10Rq/MqLsXrvTm2IFWS5sh6k1n4olsfO
         9CxSyZdgKUte9dVGxRTG/PJKHfnHiEm/2sXKIGAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 364/405] scsi: lpfc: Fix io lost on host resets
Date:   Wed, 29 May 2019 20:06:02 -0700
Message-Id: <20190530030559.015596636@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c66a91974634bfdf9d8e8736219d3b27621fa704 ]

If the driver undergoes repeated host resets it starts losing exchange
structures and eventually returns SCSI_MLQUEUE_HOST_BUSY and does not
recover. The offline path is not reclaiming the outstanding ios on the fcp
pring txcmplq before calling lpfc_destroy_multixripool, which causes the
txmcplq to be reinit and the resources lost.

Flush the fcp rings before destroying the multixripools.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 7fcdaed3fa945..89a0c2bdb6a15 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -3245,6 +3245,13 @@ void lpfc_destroy_multixri_pools(struct lpfc_hba *phba)
 	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
 		lpfc_destroy_expedite_pool(phba);
 
+	if (!(phba->pport->load_flag & FC_UNLOADING)) {
+		lpfc_sli_flush_fcp_rings(phba);
+
+		if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
+			lpfc_sli_flush_nvme_rings(phba);
+	}
+
 	hwq_count = phba->cfg_hdw_queue;
 
 	for (i = 0; i < hwq_count; i++) {
-- 
2.20.1



