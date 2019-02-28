Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBBEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC59520C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367767;
	bh=jJFvPKfSii3qd9C5hulLXys61bqDK1SjKBFKtqQYp7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R43d3CEgjg/dapI/1jAtZ26a0mQATbVoIlPFHYI/ZA6/FKQPEwGnJMw9PxE55fVHU
	 zL24JdnZYz8poLrHla1P3ZEPD13MxDn5+ROqYszLByPFSG1xZxKrye83QVBzhq8DXg
	 GUZP/LGPTIBBO3BRVwoEKuEsmZhq+M0NTB9pym8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbfB1P30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:29:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387718AbfB1PK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:10:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED7282171F;
        Thu, 28 Feb 2019 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366626;
        bh=jJFvPKfSii3qd9C5hulLXys61bqDK1SjKBFKtqQYp7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDn4zJJ3tWXLwk35cJayDPmyzhsGT+72S6LNAouRHrzFSY5752Ux3ivz4V2ydCHrU
         Y37vu3sukn9O1CQfT9uJxrnjdwzxyt85Did8mGzMzWYTSILCatpsQ1UqNt2SOUUQG+
         2uafZ9VvP/YuftaHxPRlnkpzktIaZqA/b8iVeKNM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 64/81] s390/qeth: conclude all event processing before offlining a card
Date:   Thu, 28 Feb 2019 10:07:56 -0500
Message-Id: <20190228150813.10256-64-sashal@kernel.org>
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

[ Upstream commit c0a2e4d10d9366ada133a8ae4ff2f32397f8b15b ]

Work for Bridgeport events is currently placed on a driver-wide
workqueue. If the card is removed and freed while any such work is still
active, this causes a use-after-free.
So put the events on a per-card queue, where we can control their
lifetime. As we also don't want stale events to last beyond an
offline & online cycle, flush this queue when setting the card offline.

Fixes: b4d72c08b358 ("qeth: bridgeport support - basic control")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 10 ++++++++--
 drivers/s390/net/qeth_l2_main.c   |  6 ++++--
 drivers/s390/net/qeth_l3_main.c   |  2 ++
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 8999be74c5451..8f2af450152fb 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -791,6 +791,7 @@ struct qeth_card {
 	struct qeth_seqno seqno;
 	struct qeth_card_options options;
 
+	struct workqueue_struct *event_wq;
 	wait_queue_head_t wait_q;
 	spinlock_t mclock;
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
@@ -969,7 +970,6 @@ extern const struct attribute_group *qeth_osn_attr_groups[];
 extern const struct attribute_group qeth_device_attr_group;
 extern const struct attribute_group qeth_device_blkt_group;
 extern const struct device_type qeth_generic_devtype;
-extern struct workqueue_struct *qeth_wq;
 
 int qeth_card_hw_is_reachable(struct qeth_card *);
 const char *qeth_get_cardname_short(struct qeth_card *);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 89cc172820ca4..ebbc3ad504f9e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -76,8 +76,7 @@ static void qeth_notify_skbs(struct qeth_qdio_out_q *queue,
 static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf);
 static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *, int);
 
-struct workqueue_struct *qeth_wq;
-EXPORT_SYMBOL_GPL(qeth_wq);
+static struct workqueue_struct *qeth_wq;
 
 int qeth_card_hw_is_reachable(struct qeth_card *card)
 {
@@ -1471,6 +1470,10 @@ static struct qeth_card *qeth_alloc_card(struct ccwgroup_device *gdev)
 	CARD_RDEV(card) = gdev->cdev[0];
 	CARD_WDEV(card) = gdev->cdev[1];
 	CARD_DDEV(card) = gdev->cdev[2];
+
+	card->event_wq = alloc_ordered_workqueue("%s", 0, dev_name(&gdev->dev));
+	if (!card->event_wq)
+		goto out_wq;
 	if (qeth_setup_channel(&card->read, true))
 		goto out_ip;
 	if (qeth_setup_channel(&card->write, true))
@@ -1486,6 +1489,8 @@ static struct qeth_card *qeth_alloc_card(struct ccwgroup_device *gdev)
 out_channel:
 	qeth_clean_channel(&card->read);
 out_ip:
+	destroy_workqueue(card->event_wq);
+out_wq:
 	dev_set_drvdata(&gdev->dev, NULL);
 	kfree(card);
 out:
@@ -5038,6 +5043,7 @@ static void qeth_core_free_card(struct qeth_card *card)
 	qeth_clean_channel(&card->read);
 	qeth_clean_channel(&card->write);
 	qeth_clean_channel(&card->data);
+	destroy_workqueue(card->event_wq);
 	qeth_free_qdio_buffers(card);
 	unregister_service_level(&card->qeth_service_level);
 	dev_set_drvdata(&card->gdev->dev, NULL);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 49fa09c67d49f..a6c55cbf3d69c 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -391,6 +391,8 @@ static void qeth_l2_stop_card(struct qeth_card *card, int recovery_mode)
 		qeth_clear_cmd_buffers(&card->read);
 		qeth_clear_cmd_buffers(&card->write);
 	}
+
+	flush_workqueue(card->event_wq);
 }
 
 static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
@@ -1455,7 +1457,7 @@ static void qeth_bridge_state_change(struct qeth_card *card,
 	data->card = card;
 	memcpy(&data->qports, qports,
 			sizeof(struct qeth_sbp_state_change) + extrasize);
-	queue_work(qeth_wq, &data->worker);
+	queue_work(card->event_wq, &data->worker);
 }
 
 struct qeth_bridge_host_data {
@@ -1527,7 +1529,7 @@ static void qeth_bridge_host_event(struct qeth_card *card,
 	data->card = card;
 	memcpy(&data->hostevs, hostevs,
 			sizeof(struct qeth_ipacmd_addr_change) + extrasize);
-	queue_work(qeth_wq, &data->worker);
+	queue_work(card->event_wq, &data->worker);
 }
 
 /* SETBRIDGEPORT support; sending commands */
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index d1bf55b5c8e1b..29a2408b9282e 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1436,6 +1436,8 @@ static void qeth_l3_stop_card(struct qeth_card *card, int recovery_mode)
 		qeth_clear_cmd_buffers(&card->read);
 		qeth_clear_cmd_buffers(&card->write);
 	}
+
+	flush_workqueue(card->event_wq);
 }
 
 /*
-- 
2.19.1

