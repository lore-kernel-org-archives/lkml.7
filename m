Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3968DC28CC4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0FA275CB
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396235;
	bh=LTi+JbfTQHp/PZG7LixQxWzqEOh2c+JikTHhQVj8nHc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q92fsfnwmnTqeXVVZmdO/wZI9Y+c4xdA0GMZEh4Hh8reC3LR99FZdhrsBK4hUgz+u
	 oWcNBD5A7bsCEdySdDRKFY7RSJpzyj1ZYY39DrUXf9uWNUXLKvSdS8NDy33ynlj2cU
	 577NpKum7w1ugH97Gd1oW8YoJgjYiCKxgy3CbQp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfFANWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbfFANWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:22:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A14B27310;
        Sat,  1 Jun 2019 13:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395320;
        bh=LTi+JbfTQHp/PZG7LixQxWzqEOh2c+JikTHhQVj8nHc=;
        h=From:To:Cc:Subject:Date:From;
        b=a0lRNwNzQtwPSVuJiU38VxRx/Dnsxlk1gvmQ68TmdHhAHLJe8e60MmFxMYTNBl+Yz
         wOaPEhvSjeG8JyR00TVl6Os0Y7THgU7CQfzaqe9esHJaIJrgnRWE7FW/Bqdn7vAWTv
         fHn3oLso4lC5T/ebtCZa0JjgPUSOFZSt553X1+Ws=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Alexandre Bounine <alex.bou9@gmail.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 001/141] rapidio: fix a NULL pointer dereference when create_workqueue() fails
Date:   Sat,  1 Jun 2019 09:19:37 -0400
Message-Id: <20190601132158.25821-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 23015b22e47c5409620b1726a677d69e5cd032ba ]

In case create_workqueue fails, the fix releases resources and returns
-ENOMEM to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Acked-by: Alexandre Bounine <alex.bou9@gmail.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rapidio/rio_cm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index bad0e0ea4f305..ef989a15aefc4 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -2145,6 +2145,14 @@ static int riocm_add_mport(struct device *dev,
 	mutex_init(&cm->rx_lock);
 	riocm_rx_fill(cm, RIOCM_RX_RING_SIZE);
 	cm->rx_wq = create_workqueue(DRV_NAME "/rxq");
+	if (!cm->rx_wq) {
+		riocm_error("failed to allocate IBMBOX_%d on %s",
+			    cmbox, mport->name);
+		rio_release_outb_mbox(mport, cmbox);
+		kfree(cm);
+		return -ENOMEM;
+	}
+
 	INIT_WORK(&cm->rx_work, rio_ibmsg_handler);
 
 	cm->tx_slot = 0;
-- 
2.20.1

