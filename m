Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F88C17440
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52FF215EA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353964;
	bh=k2A1BTemWvg7On3V9rWsnCXdzojip5BlRvpssb7PQBA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RxqVpO0f2QtLtALeJXeqHsGvOUoaUZG2Su4YdxlOmt6wqCR5LfAQ0xECT3HhHWK19
	 yqtiYpj07Xpt75TSeLuiFfo40gSeiirMeFB1I7nP1h+JAtlpDUq00ftGHx8hfwRUv9
	 gZoeYKMZiLDIum71btc9e9rAy8vFfzef8h5AcDWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfKJCqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:46:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbfKJCpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:45:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C94C21655;
        Sun, 10 Nov 2019 02:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353942;
        bh=k2A1BTemWvg7On3V9rWsnCXdzojip5BlRvpssb7PQBA=;
        h=From:To:Cc:Subject:Date:From;
        b=UoCgDKMmmGEp08trX5ii14ciVQBFC70EL5HsqVdqaMJ3mjmaXHBqfSwLSft8VMjMt
         Ejgk7K8a5wwCCn3EppU2rPToxkBwRAI3HHuXaARdbHS0VotGGxRUiUNC9JqwTcYDY6
         6nmyRnU+YYE+ZNIlnhwo1PrM0tzGrDqMG9ABm6g4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 001/109] s390/qeth: invoke softirqs after napi_schedule()
Date:   Sat,  9 Nov 2019 21:43:53 -0500
Message-Id: <20191110024541.31567-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 4d19db777a2f32c9b76f6fd517ed8960576cb43e ]

Calling napi_schedule() from process context does not ensure that the
NET_RX softirq is run in a timely fashion. So trigger it manually.

This is no big issue with current code. A call to ndo_open() is usually
followed by a ndo_set_rx_mode() call, and for qeth this contains a
spin_unlock_bh(). Except for OSN, where qeth_l2_set_rx_mode() bails out
early.
Nevertheless it's best to not depend on this behaviour, and just fix
the issue at its source like all other drivers do. For instance see
commit 83a0c6e58901 ("i40e: Invoke softirqs after napi_reschedule").

Fixes: a1c3ed4c9ca0 ("qeth: NAPI support for l2 and l3 discipline")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l2_main.c | 3 +++
 drivers/s390/net/qeth_l3_main.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 2845316db5545..6fa07c2469150 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -869,7 +869,10 @@ static int __qeth_l2_open(struct net_device *dev)
 
 	if (qdio_stop_irq(card->data.ccwdev, 0) >= 0) {
 		napi_enable(&card->napi);
+		local_bh_disable();
 		napi_schedule(&card->napi);
+		/* kick-start the NAPI softirq: */
+		local_bh_enable();
 	} else
 		rc = -EIO;
 	return rc;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index d9830c86d0c11..8bccfd686b735 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2849,7 +2849,10 @@ static int __qeth_l3_open(struct net_device *dev)
 
 	if (qdio_stop_irq(card->data.ccwdev, 0) >= 0) {
 		napi_enable(&card->napi);
+		local_bh_disable();
 		napi_schedule(&card->napi);
+		/* kick-start the NAPI softirq: */
+		local_bh_enable();
 	} else
 		rc = -EIO;
 	return rc;
-- 
2.20.1

