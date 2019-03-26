Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B46C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99142070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfCZGyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:54:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730918AbfCZGx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:53:59 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 41411242BF78D8EB364B;
        Tue, 26 Mar 2019 14:53:57 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Tue, 26 Mar 2019 14:53:49 +0800
From:   Xi Wang <wangxi11@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH net] net: hns3: fix compile error
Date:   Tue, 26 Mar 2019 14:53:49 +0800
Message-ID: <1553583229-121323-1-git-send-email-wangxi11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the rules for configuring search paths in Kbuild have
changed, this will lead some erros when compiling hns3 with the
following command:

make O=DIR M=drivers/net/ethernet/hisilicon/hns3

drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c:11:10:
fatal error: hnae3.h: No such file or directory

This patch fix it by adding $(srctree)/ prefix to the serach paths.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile b/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
index fffe8c1..0fb61d4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the HISILICON network device drivers.
 #
 
-ccflags-y := -Idrivers/net/ethernet/hisilicon/hns3
+ccflags-y := -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
 
 obj-$(CONFIG_HNS3_HCLGE) += hclge.o
 hclge-objs = hclge_main.o hclge_cmd.o hclge_mdio.o hclge_tm.o hclge_mbx.o hclge_err.o  hclge_debugfs.o
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile b/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile
index fb93bbd..6193f8f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the HISILICON network device drivers.
 #
 
-ccflags-y := -Idrivers/net/ethernet/hisilicon/hns3
+ccflags-y := -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
 
 obj-$(CONFIG_HNS3_HCLGEVF) += hclgevf.o
 hclgevf-objs = hclgevf_main.o hclgevf_cmd.o hclgevf_mbx.o
\ No newline at end of file
-- 
2.8.1

