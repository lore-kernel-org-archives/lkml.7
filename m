Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC81C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BE820665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565750281;
	bh=aCcaF41kxT3VQhGRRPMf3R15/dqODMKM6cnjPf8pLqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vor63Tuo/cua1j6ELI5RVJ9471GUoKGLpCRBEHT/nfJbRIgE/DMJ0w65wDB5Yah8e
	 Qr3uuWSZzDIomN9J0D/3Cq5YLaygpnQkf77qlqoFT46y8WODcsYrMSlpDY9EjJ1v6+
	 0ueOei/xWEmYrKX+D5zj3vCJ+RpZlUpz+R0vp2Do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfHNCh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbfHNCMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:12:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0794720874;
        Wed, 14 Aug 2019 02:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748755;
        bh=aCcaF41kxT3VQhGRRPMf3R15/dqODMKM6cnjPf8pLqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xrDJFmQHhj0ed0pzaUPBA4TEGuHCvTtdNC00/05evX7MJjlB7/iCwll2buLB39+VW
         6Djqg73ldXWp4cbjFowEA8RFffZlNfyf7dfDGWDf3RtJFTmrEtxCzj9Mf4gr0FoRQU
         KqPCDQbguSW5Nz/JYWrhBEM79qUsjWsgGlcwmPQc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 050/123] qed: RDMA - Fix the hw_ver returned in device attributes
Date:   Tue, 13 Aug 2019 22:09:34 -0400
Message-Id: <20190814021047.14828-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kalderon <michal.kalderon@marvell.com>

[ Upstream commit 81af04b432fdfabcdbd2c06be2ee647e3ca41a22 ]

The hw_ver field was initialized to zero. Return the chip revision.
This is relevant for rdma driver.

Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index 13802b825d65a..909422d939033 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -442,7 +442,7 @@ static void qed_rdma_init_devinfo(struct qed_hwfn *p_hwfn,
 	/* Vendor specific information */
 	dev->vendor_id = cdev->vendor_id;
 	dev->vendor_part_id = cdev->device_id;
-	dev->hw_ver = 0;
+	dev->hw_ver = cdev->chip_rev;
 	dev->fw_ver = (FW_MAJOR_VERSION << 24) | (FW_MINOR_VERSION << 16) |
 		      (FW_REVISION_VERSION << 8) | (FW_ENGINEERING_VERSION);
 
-- 
2.20.1

