Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26C1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA4720C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367783;
	bh=dTjbH+x6F2EbsL8pWq8JJ5oYGAeCuOV6L4kY/YnfzaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bMdrF+GPQR3KFBSvKieUfFW58UVJh2pWHMKvJbklJJ92pChOF6PIfGPSOZNPaJ0lM
	 ctcREsW+whS3JizsfzjyeWyYXS2WP8q9u8efbfOqLrQf6nd6qGDakOZ4cTK7BwaaSD
	 NgMC25dLreZCwH9bt9QXSzb1uUGWsaexH5t4ITRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbfB1P3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:29:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731658AbfB1PKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:10:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92DB7218B0;
        Thu, 28 Feb 2019 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366623;
        bh=dTjbH+x6F2EbsL8pWq8JJ5oYGAeCuOV6L4kY/YnfzaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AkY/H9/WMsbwf8xhA1mW4r7Sejf60AN4WP2cvru3IeQh1FGi4TKIxmIpEtxKdds1G
         YvClwpWS/C5ZeiJ91B2URRtJPLbohfr79pw/BCcX4r68H1X5tgP4mQDUe+OsLGQ5F4
         L4ksxoSdln+PVKuKe4ZbDljbltmuOjEUdMnY+xUs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 61/81] s390/qeth: release cmd buffer in error paths
Date:   Thu, 28 Feb 2019 10:07:53 -0500
Message-Id: <20190228150813.10256-61-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 5065b2dd3e5f9247a6c9d67974bc0472bf561b9d ]

Whenever we fail before/while starting an IO, make sure to release the
IO buffer. Usually qeth_irq() would do this for us, but if the IO
doesn't even start we obviously won't get an interrupt for it either.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 0c9a5250dd93f..623ddda5d2ba8 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -568,6 +568,7 @@ static int __qeth_issue_next_read(struct qeth_card *card)
 		QETH_DBF_MESSAGE(2, "error %i on device %x when starting next read ccw!\n",
 				 rc, CARD_DEVID(card));
 		atomic_set(&channel->irq_pending, 0);
+		qeth_release_buffer(channel, iob);
 		card->read_or_write_problem = 1;
 		qeth_schedule_recovery(card);
 		wake_up(&card->wait_q);
@@ -1129,6 +1130,8 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		rc = qeth_get_problem(card, cdev, irb);
 		if (rc) {
 			card->read_or_write_problem = 1;
+			if (iob)
+				qeth_release_buffer(iob->channel, iob);
 			qeth_clear_ipacmd_list(card);
 			qeth_schedule_recovery(card);
 			goto out;
@@ -1811,6 +1814,7 @@ static int qeth_idx_activate_get_answer(struct qeth_card *card,
 		QETH_DBF_MESSAGE(2, "Error2 in activating channel rc=%d\n", rc);
 		QETH_DBF_TEXT_(SETUP, 2, "2err%d", rc);
 		atomic_set(&channel->irq_pending, 0);
+		qeth_release_buffer(channel, iob);
 		wake_up(&card->wait_q);
 		return rc;
 	}
@@ -1880,6 +1884,7 @@ static int qeth_idx_activate_channel(struct qeth_card *card,
 			rc);
 		QETH_DBF_TEXT_(SETUP, 2, "1err%d", rc);
 		atomic_set(&channel->irq_pending, 0);
+		qeth_release_buffer(channel, iob);
 		wake_up(&card->wait_q);
 		return rc;
 	}
@@ -2060,6 +2065,7 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 	}
 	reply = qeth_alloc_reply(card);
 	if (!reply) {
+		qeth_release_buffer(channel, iob);
 		return -ENOMEM;
 	}
 	reply->callback = reply_cb;
-- 
2.19.1

