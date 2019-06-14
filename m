Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2B3C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C84221773
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfFNCgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:36:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfFNCgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:36:52 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A5F6E7656D109436D821;
        Fri, 14 Jun 2019 10:36:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Jun 2019 10:36:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Varun Prakash <varun@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cxgbit: remove set but not used variable 'ppmax'
Date:   Fri, 14 Jun 2019 02:44:13 +0000
Message-ID: <20190614024413.110449-1-yuehaibing@huawei.com>
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

drivers/target/iscsi/cxgbit/cxgbit_ddp.c: In function 'cxgbit_ddp_init':
drivers/target/iscsi/cxgbit/cxgbit_ddp.c:303:15: warning:
 variable 'ppmax' set but not used [-Wunused-but-set-variable]

It's not used since commit a248384e6420 ("cxgb4/libcxgb/cxgb4i/cxgbit:
enable eDRAM page pods for iSCSI")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/target/iscsi/cxgbit/cxgbit_ddp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
index 1443ef045a5f..fe1be5feaf21 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
@@ -300,7 +300,6 @@ int cxgbit_ddp_init(struct cxgbit_device *cdev)
 	struct cxgb4_lld_info *lldi = &cdev->lldi;
 	struct net_device *ndev = cdev->lldi.ports[0];
 	struct cxgbi_tag_format tformat;
-	unsigned int ppmax;
 	int ret, i;
 
 	if (!lldi->vr->iscsi.size) {
@@ -308,8 +307,6 @@ int cxgbit_ddp_init(struct cxgbit_device *cdev)
 		return -EACCES;
 	}
 
-	ppmax = lldi->vr->iscsi.size >> PPOD_SIZE_SHIFT;
-
 	memset(&tformat, 0, sizeof(struct cxgbi_tag_format));
 	for (i = 0; i < 4; i++)
 		tformat.pgsz_order[i] = (lldi->iscsi_pgsz_order >> (i << 3))



