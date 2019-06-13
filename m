Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2986C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCC520B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442921;
	bh=HTx1fHVj5uezsO/DXs83fYpWV86qC1ZT8ZkQv5D7U4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kY3OgDjAy1KlbIAnak9udzWoOjvH0fLQG95PmNIM7GSfyaTFTcgi6rFGs2cws2mWp
	 zPK5sDYuzLaZ5uOQ7xOqrNOkGuKkCWv/TH30mhlKGJUbYq9W4K6e3sWwkpCj+ssW9G
	 Ksa7Etjn3tg1bitvKAZXRLqDSIpqx+fXLh6XFC9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391893AbfFMQWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731052AbfFMIie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:38:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32482147A;
        Thu, 13 Jun 2019 08:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415114;
        bh=HTx1fHVj5uezsO/DXs83fYpWV86qC1ZT8ZkQv5D7U4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtFcGM4ViSvrgMEx9zoWFeRvvRn5aP2UXfXO3tnN7PxxbeP3Y2xeHnibbp0N4boLj
         NqxUQQMGWv0LOuTeMXwa3A2UCkGXLqUptgtIpYrxi+eRVEcRQFfEZKXLYeaq+M027Q
         i6ry6pnfh7ISWbJE73DtNCBsY7ZXdjmWBV72D0eg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 001/118] rapidio: fix a NULL pointer dereference when create_workqueue() fails
Date:   Thu, 13 Jun 2019 10:32:19 +0200
Message-Id: <20190613075643.733402894@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index bad0e0ea4f30..ef989a15aefc 100644
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



