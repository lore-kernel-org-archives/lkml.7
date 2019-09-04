Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD3AC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FE42053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613942;
	bh=jsxjZ6c2pKwOfwzh1srusN1d3KgkyddtgzEIeAdJ3vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d12lTHjNts0EebTeML9yOM6AaEaESDo3eYIx2O4ZBDd9WGqWOrjnyai6urZHsr9C+
	 zhgQyoq4UIA9GQ3vp7olX6AOsAB6iTju5J0gFn/q9f7aNZHtcE1kAz8lBQ5KtnsaR6
	 onf1S+Vyb6a3bG8nTwS9LVPSyh42JqxizngDTSoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbfIDQTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731992AbfIDP62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:58:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB412377D;
        Wed,  4 Sep 2019 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612707;
        bh=jsxjZ6c2pKwOfwzh1srusN1d3KgkyddtgzEIeAdJ3vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zeyD17NVoWoeheTbxmWyfz8R5xex0yCZIFxiHXiDJmN/MkMmuszaejaImEWV2c3Ft
         UaRw657ZNDa5Rr4U7wh2T8XxhfP/qy2sqlbpYwDJTXe78DKBtG+k/7RsydoG2HZtbd
         FFrXvR4pWKGAbK2oXdl+RZaoXsKVpz8gqtThoC+c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 34/94] qed: Add cleanup in qed_slowpath_start()
Date:   Wed,  4 Sep 2019 11:56:39 -0400
Message-Id: <20190904155739.2816-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit de0e4fd2f07ce3bbdb69dfb8d9426b7227451b69 ]

If qed_mcp_send_drv_version() fails, no cleanup is executed, leading to
memory leaks. To fix this issue, introduce the label 'err4' to perform the
cleanup work before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Acked-by: Sudarsana Reddy Kalluru <skalluru@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 6de23b56b2945..c875a2fa75966 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1215,7 +1215,7 @@ static int qed_slowpath_start(struct qed_dev *cdev,
 					      &drv_version);
 		if (rc) {
 			DP_NOTICE(cdev, "Failed sending drv version command\n");
-			return rc;
+			goto err4;
 		}
 	}
 
@@ -1223,6 +1223,8 @@ static int qed_slowpath_start(struct qed_dev *cdev,
 
 	return 0;
 
+err4:
+	qed_ll2_dealloc_if(cdev);
 err3:
 	qed_hw_stop(cdev);
 err2:
-- 
2.20.1

