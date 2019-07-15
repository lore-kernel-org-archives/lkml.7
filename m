Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AC7C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A845A20896
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200785;
	bh=uKMX8Ym3o/S1IofsjFrz+39LEPoxQiwnccXs4ducSEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=10cOPZgahogS5C3KHp61jhsdwLWtGa2GI0jP88SESAWDBXCqrrci/ZJPqG1T45xXI
	 1NmSDkxV0UYdwvWBAWmSIdiOQoMAslxsEP/PxjlGzcYrDCCTeovKCvCFM0GFG8/y3R
	 2bgtB3xScLd+eC5hJqQRyNWehRmbcUVsf753CynY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391013AbfGOO0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731936AbfGOO0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:26:21 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60846217D8;
        Mon, 15 Jul 2019 14:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200780;
        bh=uKMX8Ym3o/S1IofsjFrz+39LEPoxQiwnccXs4ducSEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcFuF53nw6dkfzsWcWS5XTZg9sEx9DGiPy3ygKzb0KZaSrajsB4cIL+0BDzluLY2C
         zqEUCC5CoMI+l8f9CvQr7TL6QMrcHhPdjDbCzLc7qaflfwYZdVESAayfmYADBiMALp
         Ate0rK4zdkbZW1bz/cpAUu0G+8t451BrhWFoknYY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 129/158] net: hns3: fix a -Wformat-nonliteral compile warning
Date:   Mon, 15 Jul 2019 10:17:40 -0400
Message-Id: <20190715141809.8445-129-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715141809.8445-1-sashal@kernel.org>
References: <20190715141809.8445-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 18d219b783da61a6cc77581f55fc4af2fa16bc36 ]

When setting -Wformat=2, there is a compiler warning like this:

hclge_main.c:xxx:x: warning: format not a string literal and no
format arguments [-Wformat-nonliteral]
strs[i].desc);
^~~~

This patch adds missing format parameter "%s" to snprintf() to
fix it.

Fixes: 46a3df9f9718 ("Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 4648c6a9d9e8..89ca69fa2b97 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -663,8 +663,7 @@ static u8 *hclge_comm_get_strings(u32 stringset,
 		return buff;
 
 	for (i = 0; i < size; i++) {
-		snprintf(buff, ETH_GSTRING_LEN,
-			 strs[i].desc);
+		snprintf(buff, ETH_GSTRING_LEN, "%s", strs[i].desc);
 		buff = buff + ETH_GSTRING_LEN;
 	}
 
-- 
2.20.1

