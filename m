Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C44C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E210F2522D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189725;
	bh=0BmoonTxna+NdQ9k0o4RZwsAJRHfJzAL/uf9v3EHa+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=joNy7wLivkWyqYjPbBIqVbt6Iw2WNFesQyFXVWLdiz3dAeuidpaBeAy8l95xGmFQI
	 NID6iUbhIImxREYOhAAEV1v8k2YRd99cNyByURyliN6TS2HQ4pOR4DJ4F/nAxIx6PD
	 KXnzcXp+56KFuQN5ZAhloYLHJfM5QdpDtbvnY2rM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfE3EPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730557AbfE3DQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:00 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 769EB24585;
        Thu, 30 May 2019 03:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186160;
        bh=0BmoonTxna+NdQ9k0o4RZwsAJRHfJzAL/uf9v3EHa+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdcXYTwPjEjxjxPk53sgExLZGrW+1BxrqwUFTsUKjpARxceh15awEiTbDI/u9KGkZ
         inlh1DWf2BvERM7ldIliXrqqZ/u44agltyknucgeDQIZfUzWG3fR86u0ebbpCtJwuB
         qtsnIlbSfgodYfURgOjrKMlYX8xDp3RCjFkJuNBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 311/346] scsi: lpfc: Fix FDMI manufacturer attribute value
Date:   Wed, 29 May 2019 20:06:24 -0700
Message-Id: <20190530030556.582661426@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d67f935b79a76ac9d86dde1a27bdd413feb5d987 ]

The FDMI manufacturer value being reported on Linux is inconsistent with
other OS's.

Set the value to "Emulex Corporation" for consistency.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_ct.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 221f8fd87d242..912aad3d5b043 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -2005,8 +2005,11 @@ lpfc_fdmi_hba_attr_manufacturer(struct lpfc_vport *vport,
 	ae = (struct lpfc_fdmi_attr_entry *)&ad->AttrValue;
 	memset(ae, 0, 256);
 
+	/* This string MUST be consistent with other FC platforms
+	 * supported by Broadcom.
+	 */
 	strncpy(ae->un.AttrString,
-		"Broadcom Inc.",
+		"Emulex Corporation",
 		       sizeof(ae->un.AttrString));
 	len = strnlen(ae->un.AttrString,
 			  sizeof(ae->un.AttrString));
-- 
2.20.1



