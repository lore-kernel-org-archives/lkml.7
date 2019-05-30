Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07525C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F1724D61
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188210;
	bh=RLTiq+lGe/TONivcXAkemCu/n92aFFinOfBl5ExwX0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M+Hdz+BTyFq2EzleNvoCKuWFYsISqiUMJdomjH5G//tSUcnvFsiX/Bm7BkMvD1Am4
	 6mVL5Q/x4HBZYLoZW8kRPj7i1l7TK+NsfCHImapC/60qa333N6sYMEvuaI1sTQFRf9
	 pZw4uNJu/cE5xGr/uk605v0Dtnd8lfzfMNh0ofAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbfE3DuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732104AbfE3DUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:20:00 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D62724908;
        Thu, 30 May 2019 03:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186400;
        bh=RLTiq+lGe/TONivcXAkemCu/n92aFFinOfBl5ExwX0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btIqwCtYGUA7ljFpiCWVssBX6iOXUSAPs1glgJtEZ0uUYL4RkOe9rN6EiWcZMMpjq
         A6LiDTkD9VIt8Ow1MhlstK7nwcx4aUeWFYAfjBBeKsBSoXsXt40FKJB7pLu9GRk16U
         Jjay+IAcBWYsrDXaHgjIYivAcB88EYZS/xNpgTwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 182/193] scsi: lpfc: Fix FDMI manufacturer attribute value
Date:   Wed, 29 May 2019 20:07:16 -0700
Message-Id: <20190530030512.819414438@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
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
 drivers/scsi/lpfc/lpfc_ct.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 126723a5bc6f6..54664a07d92ec 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -1734,6 +1734,9 @@ lpfc_fdmi_hba_attr_manufacturer(struct lpfc_vport *vport,
 	ae = (struct lpfc_fdmi_attr_entry *)&ad->AttrValue;
 	memset(ae, 0, 256);
 
+	/* This string MUST be consistent with other FC platforms
+	 * supported by Broadcom.
+	 */
 	strncpy(ae->un.AttrString,
 		"Emulex Corporation",
 		       sizeof(ae->un.AttrString));
-- 
2.20.1



