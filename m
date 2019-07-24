Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF74C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E997A20659
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996676;
	bh=pSoYODkGw1XNJJXndGg8c6zsQxwYstfcpwBikoEnivA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ms6zDKRd66tGX3XISKhRUIdC1l5ICt/ObXA1KvNOV8NgFsX/vCu1rK/bJHcpz0C+a
	 3K2O+RjFMRyrjSr/NhHyeuACb2LDn0ZhdciR6lqMzzIZCz/7NCvc11WxAvM7CTks4w
	 hR7Elx7qE/4bj8lWoP5fLF9Frvf6nZWaaAZgEb0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbfGXTbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387625AbfGXTbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:31:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BC0322ADC;
        Wed, 24 Jul 2019 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996669;
        bh=pSoYODkGw1XNJJXndGg8c6zsQxwYstfcpwBikoEnivA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ks06ZPJs5kzjXul4y5FKo8wBMINd+JBiC4eJvczTsY0H28rqxH5xltMeFcohjjkDa
         NUTMQkNtKfTfs+Lu/mre4ErALSwsMiyDwgQqSQjScWoyha/IeBYsoCcwD7BrRV72RD
         QOLokCwprXvLJj0kJPUQuD5e/K8S4zwG9sOhLRv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 177/413] net: hns3: restore the MAC autoneg state after reset
Date:   Wed, 24 Jul 2019 21:17:48 +0200
Message-Id: <20190724191747.544403271@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d736fc6c68a5f76e89a6c2c4100e3678706003a3 ]

When doing global reset, the MAC autoneg state of fibre
port is set to default, which may cause user configuration
lost. This patch fixes it by restore the MAC autoneg state
after reset.

Fixes: 22f48e24a23d ("net: hns3: add autoneg and change speed support for fibre port")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 4d9bcad26f06..645b9b3e0256 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2389,6 +2389,15 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 		return ret;
 	}
 
+	if (hdev->hw.mac.support_autoneg) {
+		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.autoneg);
+		if (ret) {
+			dev_err(&hdev->pdev->dev,
+				"Config mac autoneg fail ret=%d\n", ret);
+			return ret;
+		}
+	}
+
 	mac->link = 0;
 
 	if (mac->user_fec_mode & BIT(HNAE3_FEC_USER_DEF)) {
-- 
2.20.1



