Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C88C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9A5214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153401;
	bh=IVWKTLJ67r9Fag+JPkcDnWfalbUx2MqvHhQKGS417+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ecx7cqkWfivhl/43N0jaqFsFVo47XVm0rQbQLDsoHDY6LfDiCeWUM7NRlxuZQ7+rM
	 oINcgAtCmDpbqAdDmZspH2JCRFq6wiQFFi/ToyDqVeuhq+urzH0EdMq43LmWw6KWNE
	 c6BvMzqJFT2fuTZU7JZPh41R2ds6WEFAI4bTDhcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfEFOgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfEFOgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:36:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A7320B7C;
        Mon,  6 May 2019 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153395;
        bh=IVWKTLJ67r9Fag+JPkcDnWfalbUx2MqvHhQKGS417+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KSs5uvnop+wqNCPv0ikPOBax8gsYE8Uf1HOAAGNx3gk19fbLczSxnhDoh3J0OzUe3
         B6tqJX8Rcg2uQ7RlyDf47I0JGmJXfox0mBWZ+znKAwMLmZvG0rj6OK3MBYyKNlJF2e
         9LQQFuakGAtSu65Nu8lpAZpaezPoBCa2Nie4AV8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xi Wang <wangxi11@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 045/122] net: hns3: fix compile error
Date:   Mon,  6 May 2019 16:31:43 +0200
Message-Id: <20190506143058.973350300@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.20.1



