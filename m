Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4123C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1752087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334350;
	bh=pQzPFDLIqOgpy2IM2GT1F42J3ReIR43qxt3onHuCkx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dFQhW2/zVV4ZFL1qtQS4pmuoddhKgpl6waCqPec5DfWRulHpgwudHOeKCvB53EZa/
	 yDSZKggeE9iKjlNSjxXD6XwZlJPo0C4igLTpxUGe/V7t6GJYPfXZ1WLJVPIufkYpFe
	 4MXG7RRslKcj0/07vLFjmZwQKVpKXHRXx1pBdP2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfCKT7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbfCKT7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:59:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C0592087C;
        Mon, 11 Mar 2019 19:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334345;
        bh=pQzPFDLIqOgpy2IM2GT1F42J3ReIR43qxt3onHuCkx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+VqEudYsz+69JwFbAXKgJBSYSduwuCggdqv34hEnWXthUOGaPgojJQfo9JLyQj29
         l9buMg2+s7K3ZTb+Z+ETNi/msUPpFA0hvt1HPMhkHSNBjL+uKbD8Lf3pfp2xbIJTHt
         O3F/75CmN/qjsCCn5WQ/qjOU+/7vlHEcr9V0RRJo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huang Zijiang <huang.zijiang@zte.com.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 23/27] net: hns: Fix object reference leaks in hns_dsaf_roce_reset()
Date:   Mon, 11 Mar 2019 15:58:20 -0400
Message-Id: <20190311195824.139043-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195824.139043-1-sashal@kernel.org>
References: <20190311195824.139043-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Zijiang <huang.zijiang@zte.com.cn>

[ Upstream commit c969c6e7ab8cb42b5c787c567615474fdbad9d6a ]

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index 51d42d7f6074..7e82dfbb4340 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -3074,6 +3074,7 @@ int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
 	dsaf_dev = dev_get_drvdata(&pdev->dev);
 	if (!dsaf_dev) {
 		dev_err(&pdev->dev, "dsaf_dev is NULL\n");
+		put_device(&pdev->dev);
 		return -ENODEV;
 	}
 
@@ -3081,6 +3082,7 @@ int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
 	if (AE_IS_VER1(dsaf_dev->dsaf_ver)) {
 		dev_err(dsaf_dev->dev, "%s v1 chip doesn't support RoCE!\n",
 			dsaf_dev->ae_dev.name);
+		put_device(&pdev->dev);
 		return -ENODEV;
 	}
 
-- 
2.19.1

