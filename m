Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15626C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E5821901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116793;
	bh=C3OcitmYivgqUCVsLTlEGGOwQiPtHcQTGHFFxy5Ejws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iWnKs8iYKSAPZ8b9LGXSGjGbt50QweY8ZiKg6f7N1R3Sn+Stmx3aWozYl10O/gtes
	 RS37Y0gurcojGFK2mtVNjeSZgGHYtfVrhpxp5buNnhOOOdmUMkqrv9b61MxRxitYm1
	 slK+1VTZXjL6Uc/QgFKSHku5UaW561p6VFl0H8ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbfDXOjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731064AbfDXOjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:39:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E597218FD;
        Wed, 24 Apr 2019 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116790;
        bh=C3OcitmYivgqUCVsLTlEGGOwQiPtHcQTGHFFxy5Ejws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SiJ7h8Z4dkgJ/p5YCMH6DEmo5957ohabv6s+0MqzdkAIdJ58gEAaRBHtVcSngPAWm
         pr3dkBc+NH7V+HyQe4UtbpP6fdIQHk2Xfu5CGTppTYcVh+E0e+j1m8fBVHCLwe4mIx
         WBVi29q/Oc3ZH3rAHE+1SgisKHX2xJzI2OGIqcMI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xi Wang <wangxi11@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/52] net: hns3: fix compile error
Date:   Wed, 24 Apr 2019 10:38:34 -0400
Message-Id: <20190424143911.28890-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

[ Upstream commit 669efc76b317b3aa550ffbf0b79d064cb00a5f96 ]

Currently, the rules for configuring search paths in Kbuild have
changed, this will lead some erros when compiling hns3 with the
following command:

make O=DIR M=drivers/net/ethernet/hisilicon/hns3

drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c:11:10:
fatal error: hnae3.h: No such file or directory

This patch fix it by adding $(srctree)/ prefix to the serach paths.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile b/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
index cb8ddd043476..d278fc7ea3ed 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the HISILICON network device drivers.
 #
 
-ccflags-y := -Idrivers/net/ethernet/hisilicon/hns3
+ccflags-y := -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
 
 obj-$(CONFIG_HNS3_HCLGE) += hclge.o
 hclge-objs = hclge_main.o hclge_cmd.o hclge_mdio.o hclge_tm.o hclge_mbx.o
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile b/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile
index fb93bbd35845..6193f8fa7cf3 100644
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
2.19.1

