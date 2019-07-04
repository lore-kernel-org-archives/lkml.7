Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEE1C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62754216E3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfGDGrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:47:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDGrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:47:46 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6DEB7E0C4A215B01883D;
        Thu,  4 Jul 2019 14:47:42 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 4 Jul 2019
 14:47:31 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <jeffrey.l.hugo@gmail.com>, <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] remoteproc: qcom: q6v5-mss: Fix build error without QCOM_MDT_LOADER
Date:   Thu, 4 Jul 2019 14:46:49 +0800
Message-ID: <20190704064649.51748-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If QCOM_Q6V5_MSS is set but QCOM_MDT_LOADER is not,
building will fails:

drivers/remoteproc/qcom_q6v5_mss.o: In function `q6v5_start':
qcom_q6v5_mss.c:(.text+0x3260): undefined reference to `qcom_mdt_read_metadata'

Add QCOM_MDT_LOADER dependency for QCOM_Q6V5_MSS.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: f04b91383456 ("remoteproc: qcom: q6v5-mss: Support loading non-split images")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/remoteproc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 9b0f0cb..28ed306 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -116,6 +116,7 @@ config QCOM_Q6V5_MSS
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
+	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
-- 
2.7.4


