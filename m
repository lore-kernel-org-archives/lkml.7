Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44564C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1036D21D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239945;
	bh=PPt6GBJsSbXbytF2kq1k6abXEUt6ZqOmQYI4oa1Cr6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ppDLsHgu0hdwFy7MaPevx49DM3qqKjYZtriD2cxGRqnXb2NlqyHmilgnWtS4tM4Ur
	 YLZaDPCjM/VzaAsICapKc1JA8owNpc8vK+v3gM6uH4sG4NGq9b54hD83nckglZRvSm
	 ZgJJBHNIZJzntpjk93LhTtx6l01VzWBJxK94MRsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391169AbfKHTFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:05:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391161AbfKHTFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:05:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4100F2067B;
        Fri,  8 Nov 2019 19:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239941;
        bh=PPt6GBJsSbXbytF2kq1k6abXEUt6ZqOmQYI4oa1Cr6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goagINl+NR1LU21b6AephUC2jRQt2YYL3yJ8cTSmcCoxFTQg5G/TeIXMQUIUBnD0A
         ONPl2QOrg2WoyKJXQbWP6kAeBreoDuHY7zfauVUkzjAXBM2STvfNoSNqnFTkUm0RXO
         cTAV7OEWMW1DaWb0tSD/sCUGYd4HupJOMvHmxK3E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Allen Pais <allen.pais@oracle.com>,
        Martin Wilck <mwilck@suse.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 035/140] scsi: qla2xxx: fix a potential NULL pointer dereference
Date:   Fri,  8 Nov 2019 19:49:23 +0100
Message-Id: <20191108174906.890027432@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>

[ Upstream commit 35a79a63517981a8aea395497c548776347deda8 ]

alloc_workqueue is not checked for errors and as a result a potential
NULL dereference could occur.

Link: https://lore.kernel.org/r/1568824618-4366-1-git-send-email-allen.pais@oracle.com
Signed-off-by: Allen Pais <allen.pais@oracle.com>
Reviewed-by: Martin Wilck <mwilck@suse.com>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2835afbd2edc7..04cf6986eb8e6 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3233,6 +3233,10 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	    req->req_q_in, req->req_q_out, rsp->rsp_q_in, rsp->rsp_q_out);
 
 	ha->wq = alloc_workqueue("qla2xxx_wq", 0, 0);
+	if (unlikely(!ha->wq)) {
+		ret = -ENOMEM;
+		goto probe_failed;
+	}
 
 	if (ha->isp_ops->initialize_adapter(base_vha)) {
 		ql_log(ql_log_fatal, base_vha, 0x00d6,
-- 
2.20.1



