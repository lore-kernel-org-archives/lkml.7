Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E218C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 13:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED79C2054F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 13:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCWN2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 09:28:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbfCWN2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 09:28:13 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 448FAC3CEC138D302B2F;
        Sat, 23 Mar 2019 21:28:08 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Sat, 23 Mar 2019
 21:27:59 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <qla2xxx-upstream@qlogic.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: qla2xxx: Remove useless set memory to zero use memset()
Date:   Sat, 23 Mar 2019 21:27:53 +0800
Message-ID: <20190323132753.22508-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

The memory return by kzalloc() has already be set to zero, so
remove useless memset(0).

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 3b81a2a..90da4b9 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -8852,7 +8852,6 @@ struct qla_qpair *qla2xxx_create_qpair(struct scsi_qla_host *vha, int qos,
 			    "Failed to allocate memory for queue pair.\n");
 			return NULL;
 		}
-		memset(qpair, 0, sizeof(struct qla_qpair));
 
 		qpair->hw = vha->hw;
 		qpair->vha = vha;
-- 
2.7.0


