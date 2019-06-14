Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37489C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097AE204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFNCla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:41:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfFNCl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:41:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 78812A7D564B635DBDEA;
        Fri, 14 Jun 2019 10:41:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Jun 2019 10:41:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Karen Xie <kxie@chelsio.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-scsi@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] scsi: cxgb4i: remove set but not used variable 'ppmax'
Date:   Fri, 14 Jun 2019 02:48:56 +0000
Message-ID: <20190614024856.115652-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/cxgbi/cxgb4i/cxgb4i.c: In function 'cxgb4i_ddp_init':
drivers/scsi/cxgbi/cxgb4i/cxgb4i.c:2072:15: warning:
 variable 'ppmax' set but not used [-Wunused-but-set-variable]

It's not used since commit a248384e6420 ("cxgb4/libcxgb/cxgb4i/cxgbit:
enable eDRAM page pods for iSCSI")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
index 66d6e1f4b3c3..0fbb4edc4161 100644
--- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
+++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
@@ -2069,7 +2069,6 @@ static int cxgb4i_ddp_init(struct cxgbi_device *cdev)
 	struct cxgb4_lld_info *lldi = cxgbi_cdev_priv(cdev);
 	struct net_device *ndev = cdev->ports[0];
 	struct cxgbi_tag_format tformat;
-	unsigned int ppmax;
 	int i, err;
 
 	if (!lldi->vr->iscsi.size) {
@@ -2078,7 +2077,6 @@ static int cxgb4i_ddp_init(struct cxgbi_device *cdev)
 	}
 
 	cdev->flags |= CXGBI_FLAG_USE_PPOD_OFLDQ;
-	ppmax = lldi->vr->iscsi.size >> PPOD_SIZE_SHIFT;
 
 	memset(&tformat, 0, sizeof(struct cxgbi_tag_format));
 	for (i = 0; i < 4; i++)



