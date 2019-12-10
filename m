Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5D8C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E8D246AC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012182;
	bh=FdNJn6LTR+IH5OsSPDJhEfyujLXBrv5DPRzcv0HIc0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YdciYOag+qJ1wLb2ZaZ+uoao104bbw3fwX++stL8xnHRF2uRyTAGB8rY+Fwn0ss+l
	 4rNxmXaSN0Sf1VEp8bWMgcTkDrcJUB2FS5naxlWn250I0Mo3BAtsGShXNFBezwkFJ1
	 fG8uEn8v5DT1Aef1Suqf0HWhd/t02M/XG9qnUjFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfLJVJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbfLJVJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:09:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC99424697;
        Tue, 10 Dec 2019 21:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012176;
        bh=FdNJn6LTR+IH5OsSPDJhEfyujLXBrv5DPRzcv0HIc0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHS2OdH1p1zidBEfxNXcqqFYc19RMMMPuShIDZQFZ7J9Iv5THmYyONLcsO/lSEflh
         8/4oN6tc/JN+s17l04pRiFgiz9RXmhpe6V0HNR/a6JGNAm99HArtwzJ+OxOl6FV9P8
         /crVGcl27/fAxD3O3j5l+bXikFon0RPQBrMc5sK0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jian Shen <shenjian15@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 134/350] net: hns3: log and clear hardware error after reset complete
Date:   Tue, 10 Dec 2019 16:03:59 -0500
Message-Id: <20191210210735.9077-95-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit 4fdd0bca6152aa201898454e63cbb255a18ae6e9 ]

When device is resetting, the CMDQ service may be stopped until
reset completed. If a new RAS error occurs at this moment, it
will no be able to clear the RAS source. This patch fixes it
by clear the RAS source after reset complete.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c052bb33b3d34..162881005a6df 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9443,6 +9443,9 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
 		return ret;
 	}
 
+	/* Log and clear the hw errors those already occurred */
+	hclge_handle_all_hns_hw_errors(ae_dev);
+
 	/* Re-enable the hw error interrupts because
 	 * the interrupts get disabled on global reset.
 	 */
-- 
2.20.1

