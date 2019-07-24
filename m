Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9627C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD373229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996816;
	bh=l4coQT2jWIHS1qadkL5oCvqfcrlXLxCIBIK4OFgmrbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VGZOWON3VtL2jrbw/AmLJ3MRtWYz84cDV7+5yoC+nTP4MvyK/cmVFswqz8xwsudca
	 R9k+bl4rAZQ4fxbY9vhuW26KCtyddrl6AUUJPP9Gz+G0NRELXL6oFuHiswdwaMbFpm
	 CzlHUfn0m21mVrUTkFAwaJaEvIZziQdH7iFCdJuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbfGXTdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388994AbfGXTdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:33:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F0E20659;
        Wed, 24 Jul 2019 19:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996812;
        bh=l4coQT2jWIHS1qadkL5oCvqfcrlXLxCIBIK4OFgmrbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjT68A3HlNAz78XzPPAB5npvxIasy6ON8Meb2KtO8eobTEX7HMjSVBxLUpxXg7q1Y
         jQhjt3+mhHTg9oqrfnBnQNWrVST/zvuZWKm/wDv09dIexhns13zXrCYpUb0dNGdk0I
         jBaJjzG6LXymEt3c3s+q+xt5uu5yjW4PFe6ys+v8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 226/413] net: hns3: enable broadcast promisc mode when initializing VF
Date:   Wed, 24 Jul 2019 21:18:37 +0200
Message-Id: <20190724191751.124550889@linuxfoundation.org>
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

[ Upstream commit 2d5066fc175ea77a733d84df9ef414b34f311641 ]

For revision 0x20, the broadcast promisc is enabled by firmware,
it's unnecessary to enable it when initializing VF.

For revision 0x21, it's necessary to enable broadcast promisc mode
when initializing or re-initializing VF, otherwise, it will be
unable to send and receive promisc packets.

Fixes: f01f5559cac8 ("net: hns3: don't allow vf to enable promisc mode")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 5d53467ee2d2..3b02745605d4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2512,6 +2512,12 @@ static int hclgevf_reset_hdev(struct hclgevf_dev *hdev)
 		return ret;
 	}
 
+	if (pdev->revision >= 0x21) {
+		ret = hclgevf_set_promisc_mode(hdev, true);
+		if (ret)
+			return ret;
+	}
+
 	dev_info(&hdev->pdev->dev, "Reset done\n");
 
 	return 0;
@@ -2591,9 +2597,11 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 	 * firmware makes sure broadcast packets can be accepted.
 	 * For revision 0x21, default to enable broadcast promisc mode.
 	 */
-	ret = hclgevf_set_promisc_mode(hdev, true);
-	if (ret)
-		goto err_config;
+	if (pdev->revision >= 0x21) {
+		ret = hclgevf_set_promisc_mode(hdev, true);
+		if (ret)
+			goto err_config;
+	}
 
 	/* Initialize RSS for this VF */
 	ret = hclgevf_rss_init_hw(hdev);
-- 
2.20.1



