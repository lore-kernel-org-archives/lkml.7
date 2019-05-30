Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D7AC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9BE25F09
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192131;
	bh=F6fL20tFwnTnHRQPPUAAQLpR0OjfBcTWFSmquw6yw04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R/Bmp8ZDIO5w4t8ynZCAL4/TsuPY5gzlyDTayNLDlcFJUh5L6K50rHIGI2SA8kA4X
	 P7SynbESduYE3az3VMMqJ/LAKfUC64IvWjbrZORyBVEEa9WkJR7AsEz5UAJGQD6od0
	 D2pJCXGH6Kc6l/Lg1AphMCpi1ZAEYKKWWAJ6E7YI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389162AbfE3Ez3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfE3DKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:16 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01271244A9;
        Thu, 30 May 2019 03:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185816;
        bh=F6fL20tFwnTnHRQPPUAAQLpR0OjfBcTWFSmquw6yw04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RKnO7evygkzQiEYrSJN+H+nOAf7bd4g3q3Z7V8iehDQmhoM2EICpMdei3hGNBFkrW
         1Ifeuh4TY193HRb9TL9yIY6mcaZf3JQVMmRIvUjshjJ8pFS6ovAQZVv6Aj1IfeZSaz
         v0jH0EQb5TCwQ5PbHPrnM49cr5JbMuQdTsHe4AUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 108/405] net: hns3: fix pause configure fail problem
Date:   Wed, 29 May 2019 20:01:46 -0700
Message-Id: <20190530030546.469198018@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fba2efdae8b4f998f66a2ff4c9f0575e1c4bbc40 ]

When configure pause, current implementation returns directly
after setup PFC without setup BP, which is not sufficient.

So this patch fixes it, only return while setting PFC failed.

Fixes: 44e59e375bf7 ("net: hns3: do not return GE PFC setting err when initializing")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index aafc69f4bfdd6..a7bbb6d3091a6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1331,8 +1331,11 @@ int hclge_pause_setup_hw(struct hclge_dev *hdev, bool init)
 	ret = hclge_pfc_setup_hw(hdev);
 	if (init && ret == -EOPNOTSUPP)
 		dev_warn(&hdev->pdev->dev, "GE MAC does not support pfc\n");
-	else
+	else if (ret) {
+		dev_err(&hdev->pdev->dev, "config pfc failed! ret = %d\n",
+			ret);
 		return ret;
+	}
 
 	return hclge_tm_bp_setup(hdev);
 }
-- 
2.20.1



