Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EE7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05B1218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117182;
	bh=yQWrj10usIeH9/gR88CrZLg8iZ7FfzQJwVZCdUTvT7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vaB7K4hywcWotCqoUxTGfDNqhTz+B5tT6OAUPpfkFPr5UqDYBY1s/Zqwojis5hBfO
	 /dM8JWsj0u8zxGavZm347QT29XqVpazmNOXdoUPs0ipknJCx+dCCE8CoUJiSnHC0/R
	 RIBjVpa28RGCoAL9vP0PrvlxgcO/WqJzqjseXS2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbfDXOem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfDXOej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:34:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB6142089F;
        Wed, 24 Apr 2019 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116479;
        bh=yQWrj10usIeH9/gR88CrZLg8iZ7FfzQJwVZCdUTvT7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ieQ3Wh7JQQM9vM95vigAzadTf6sU2HgmThXvskHGyZ1MycY58xknLGTSNNawl1ODg
         FHECNV8Ja//2O/jtMYRISNcyacr81wIq+yzZHJQv2hPEqABHtfbLpYQtMRDt6GcjdI
         Zon1sp5NeZo6end1HAsVBmOVZIMOMPK0bEAVlmmI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xi Wang <wangxi11@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 22/66] net: hns3: fix compile error
Date:   Wed, 24 Apr 2019 10:32:56 -0400
Message-Id: <20190424143341.27665-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile b/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
index fffe8c1c45d3..0fb61d440d3b 100644
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

