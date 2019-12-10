Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1EAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B89205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012453;
	bh=oTyZE3PvvugiXgfACgNDGttm2rPWx87oWQPYoTVhVU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JejsMUV3k6OWZ+9thQ1ST8ja/icb6kVwl+Bdeiyq/nEIC6QZlAm2zQeVm2t8HyZSE
	 W40yXHN11fF2mik2+TOxwmgHGPBnr50G5beHKX8+664DVRW1T3rzx2knBxCePqBTOF
	 ViqfShrXCNvxA03MtdIi7dHhLGaw6VBf6LOlwudU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfLJVOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:14:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729462AbfLJVNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:13:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D82AE214AF;
        Tue, 10 Dec 2019 21:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012430;
        bh=oTyZE3PvvugiXgfACgNDGttm2rPWx87oWQPYoTVhVU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRII+pLErXEVEWtbRyFYDk59yv7DT7DVb2WMcJbmklEv4YERqYr0hhUxjf8QRSFyd
         ALA7/Pw9ZevCwzTAyrNHookGe8scrKh5IGdD9G3rI4E8/KV6HWHoGx6zPnDio06dTY
         PP32RTtIhdfAUn9tluV5xfy2p85xVxpwPv19Suw4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 344/350] RDMA/bnxt_re: Fix missing le16_to_cpu
Date:   Tue, 10 Dec 2019 16:07:29 -0500
Message-Id: <20191210210735.9077-305-sashal@kernel.org>
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

From: Devesh Sharma <devesh.sharma@broadcom.com>

[ Upstream commit fca5b9dc0986aa49b3f0a7cfe24b6c82422ac1d7 ]

From sparse:

drivers/infiniband/hw/bnxt_re/main.c:1274:18: warning: cast from restricted __le16
drivers/infiniband/hw/bnxt_re/main.c:1275:18: warning: cast from restricted __le16
drivers/infiniband/hw/bnxt_re/main.c:1276:18: warning: cast from restricted __le16
drivers/infiniband/hw/bnxt_re/main.c:1277:21: warning: restricted __le16 degrades to integer

Fixes: 2b827ea1926b ("RDMA/bnxt_re: Query HWRM Interface version from FW")
Link: https://lore.kernel.org/r/1574317343-23300-4-git-send-email-devesh.sharma@broadcom.com
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 30a54f8aa42c0..b31e215882004 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1270,10 +1270,10 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 		return;
 	}
 	rdev->qplib_ctx.hwrm_intf_ver =
-		(u64)resp.hwrm_intf_major << 48 |
-		(u64)resp.hwrm_intf_minor << 32 |
-		(u64)resp.hwrm_intf_build << 16 |
-		resp.hwrm_intf_patch;
+		(u64)le16_to_cpu(resp.hwrm_intf_major) << 48 |
+		(u64)le16_to_cpu(resp.hwrm_intf_minor) << 32 |
+		(u64)le16_to_cpu(resp.hwrm_intf_build) << 16 |
+		le16_to_cpu(resp.hwrm_intf_patch);
 }
 
 static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
-- 
2.20.1

