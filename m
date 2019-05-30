Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5D7C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4318724F76
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188846;
	bh=zq2IzT5/tusyLj7SVWNL7fCEDbYFdla++tTcy53xHHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y1fG0hC1IZHx8IsYB0YTzd916E+2tmoR0K89JFqDyrYGa4cbw45x0XH9IQKAiUqzQ
	 0fTphHqTFyGQxXg/XJX3XvWXfFL4/7vUL7Mu/Q/4yt8IpqMtoUFLoZr6yrDj4eyizG
	 8cRrEqUwa4QOpd3Pd43qmiAjlnZU96CCvHmVTwaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbfE3EAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729977AbfE3DST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:18:19 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E24E2479F;
        Thu, 30 May 2019 03:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186298;
        bh=zq2IzT5/tusyLj7SVWNL7fCEDbYFdla++tTcy53xHHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNvNRqk/B4Xd5h4DW0URE9/46WrIm0B2jGvWbTcfIAG+WfKv6LyOybp7WmS8QtVsn
         o1GoZHU2zTW7kkeva2IQVllujzuxvkZpTDXn95r9XB9OOm6UvxohHdVLdZvpcuamns
         cAtymQmgK9zCqTaIEm4/mlSRxwTuu8dR9JNc6DRo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 261/276] scsi: lpfc: Fix fc4type information for FDMI
Date:   Wed, 29 May 2019 20:06:59 -0700
Message-Id: <20190530030541.521247250@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 32a80c093b524a0682f1c6166c910387b116ffce ]

The driver is reporting support for NVME even when not configured for NVME
operation.

Fix (and make more readable) when NVME protocol support is indicated.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_ct.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 06621a438cade..d909d90035bb2 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -2120,10 +2120,11 @@ lpfc_fdmi_port_attr_fc4type(struct lpfc_vport *vport,
 	ae = (struct lpfc_fdmi_attr_entry *)&ad->AttrValue;
 	memset(ae, 0, 32);
 
-	ae->un.AttrTypes[3] = 0x02; /* Type 1 - ELS */
-	ae->un.AttrTypes[2] = 0x01; /* Type 8 - FCP */
-	ae->un.AttrTypes[6] = 0x01; /* Type 40 - NVME */
-	ae->un.AttrTypes[7] = 0x01; /* Type 32 - CT */
+	ae->un.AttrTypes[3] = 0x02; /* Type 0x1 - ELS */
+	ae->un.AttrTypes[2] = 0x01; /* Type 0x8 - FCP */
+	if (vport->nvmei_support || vport->phba->nvmet_support)
+		ae->un.AttrTypes[6] = 0x01; /* Type 0x28 - NVME */
+	ae->un.AttrTypes[7] = 0x01; /* Type 0x20 - CT */
 	size = FOURBYTES + 32;
 	ad->AttrLen = cpu_to_be16(size);
 	ad->AttrType = cpu_to_be16(RPRT_SUPPORTED_FC4_TYPES);
@@ -2428,9 +2429,11 @@ lpfc_fdmi_port_attr_active_fc4type(struct lpfc_vport *vport,
 	ae = (struct lpfc_fdmi_attr_entry *)&ad->AttrValue;
 	memset(ae, 0, 32);
 
-	ae->un.AttrTypes[3] = 0x02; /* Type 1 - ELS */
-	ae->un.AttrTypes[2] = 0x01; /* Type 8 - FCP */
-	ae->un.AttrTypes[7] = 0x01; /* Type 32 - CT */
+	ae->un.AttrTypes[3] = 0x02; /* Type 0x1 - ELS */
+	ae->un.AttrTypes[2] = 0x01; /* Type 0x8 - FCP */
+	if (vport->phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
+		ae->un.AttrTypes[6] = 0x1; /* Type 0x28 - NVME */
+	ae->un.AttrTypes[7] = 0x01; /* Type 0x20 - CT */
 	size = FOURBYTES + 32;
 	ad->AttrLen = cpu_to_be16(size);
 	ad->AttrType = cpu_to_be16(RPRT_ACTIVE_FC4_TYPES);
-- 
2.20.1



