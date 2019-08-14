Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C9CC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A967F20842
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749600;
	bh=XIMbWmjJXQxXDoJhhtWkwzSm6UKZgYJvl1yBWhhTcs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hwEj0W7ofJCm4oHdDJ7UFd/HbvGuS9g4D23Amda78zy5z4Va/2OHI25I6IIPa7+99
	 5stIMQB2xXIKPRLs5uIPxK6Sh4dkFl2DUCjxe3fW49BmqQB6j+nIhR6HpvxGWSvzVx
	 50lc4cKwKpbW200NljTzdP0oBVPNz3TX1SyohthM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfHNC0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730346AbfHNC0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:26:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F3D2084F;
        Wed, 14 Aug 2019 02:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749592;
        bh=XIMbWmjJXQxXDoJhhtWkwzSm6UKZgYJvl1yBWhhTcs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9ZfpxeqHW8Adw0Eg4B/LkRrdo+iFmx0Os/P0WKjjOXLSF3O7tIqjdRxhkScLKOKE
         lgQZy1jKlsZsrWfmYE/WY7lMGwkMgyJpr6VUynYeg7jBKnTULo+n1+rFkVFsctAE7h
         JKddvKsnW5mHHx/UVJ63OQqsxWn81pQ/anAaT0hI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiangfeng Xiao <xiaojiangfeng@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 25/28] net: hisilicon: fix hip04-xmit never return TX_BUSY
Date:   Tue, 13 Aug 2019 22:25:47 -0400
Message-Id: <20190814022550.17463-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814022550.17463-1-sashal@kernel.org>
References: <20190814022550.17463-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>

[ Upstream commit f2243b82785942be519016067ee6c55a063bbfe2 ]

TX_DESC_NUM is 256, in tx_count, the maximum value of
mod(TX_DESC_NUM - 1) is 254, the variable "count" in
the hip04_mac_start_xmit function is never equal to
(TX_DESC_NUM - 1), so hip04_mac_start_xmit never
return NETDEV_TX_BUSY.

tx_count is modified to mod(TX_DESC_NUM) so that
the maximum value of tx_count can reach
(TX_DESC_NUM - 1), then hip04_mac_start_xmit can reurn
NETDEV_TX_BUSY.

Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index fdf8a477bec9c..a88d233df4e82 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -185,7 +185,7 @@ struct hip04_priv {
 
 static inline unsigned int tx_count(unsigned int head, unsigned int tail)
 {
-	return (head - tail) % (TX_DESC_NUM - 1);
+	return (head - tail) % TX_DESC_NUM;
 }
 
 static void hip04_config_port(struct net_device *ndev, u32 speed, u32 duplex)
-- 
2.20.1

