Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CB1C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AA520820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567612957;
	bh=7qzM2gbgcZH8LjA8YqY/rq6Rfs4xuVzEsRBat+ya2eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nlcb8a3UvKPefq0KEWMpDgFvrLw2xssGK5WhGjSomQ1BbpSMxyWIuVZxe0MkkRpuz
	 QxHXut5SRHBV07jx8YBCRQmVyxNW3+8/x5lYWU2FHF9edJS6wE5Pax66DCiFYstU4B
	 8GthXaCYorA7WMR2jUS//EjXvcnINmPB3xD1b16U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbfIDQCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387394AbfIDQCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:02:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E73222341D;
        Wed,  4 Sep 2019 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612951;
        bh=7qzM2gbgcZH8LjA8YqY/rq6Rfs4xuVzEsRBat+ya2eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvWtNsZWdH3NlbyRyCmiFk3sc+IW1u45etNZxmJXBWW6jp8gelLx3xZBjdELvOpio
         K2+ybqLeytqERMCMs1CQOBOw9eDfjBhij1DqSiofMJ2ik1BzQwkyrhARY7TbiJo8vp
         xEJ01epSDUjy6dgpd/HgDPRAgQK2BTDdn8YEUHzM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/27] qed: Add cleanup in qed_slowpath_start()
Date:   Wed,  4 Sep 2019 12:02:02 -0400
Message-Id: <20190904160220.4545-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160220.4545-1-sashal@kernel.org>
References: <20190904160220.4545-1-sashal@kernel.org>
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
index a769196628d91..708117fc6f733 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -958,7 +958,7 @@ static int qed_slowpath_start(struct qed_dev *cdev,
 					      &drv_version);
 		if (rc) {
 			DP_NOTICE(cdev, "Failed sending drv version command\n");
-			return rc;
+			goto err4;
 		}
 	}
 
@@ -966,6 +966,8 @@ static int qed_slowpath_start(struct qed_dev *cdev,
 
 	return 0;
 
+err4:
+	qed_ll2_dealloc_if(cdev);
 err3:
 	qed_hw_stop(cdev);
 err2:
-- 
2.20.1

