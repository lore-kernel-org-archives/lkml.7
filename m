Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B62FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF232147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413353;
	bh=m2cVWkKks7n/A8+M9+Guk8wW4+WEDe4ffcvSMoWBcT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jZAgAdNWGuRuxvu/0j14UjggGsF+coN7u/tj/iKNNhQXj/91FHoAoKxu5CT/MbHQ0
	 V1L+e4+dE9YQidULgTvq3C4JCri9z3X3sopj9+rrZlqEuGu1gSy1TAEmcb45gzRTVK
	 oSetPOkfw4/01DNAH0y2JteH3lSc0lEafE/sgfl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfCLROA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbfCLRNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:22 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E742217D4;
        Tue, 12 Mar 2019 17:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410801;
        bh=m2cVWkKks7n/A8+M9+Guk8wW4+WEDe4ffcvSMoWBcT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IC4w5FUtt77hjTwjF6BT+UOrDF7YCNZjD79rFc1bvc3aIT1UBAepzUbreGcWr3odM
         2V7SSHN2oNkmUMdaH5f8ZsBQKNGQ5Aumh7w8R6a3sUYPwFO0KTy9V0fejbGtn8TO+J
         MSSXMcIgJxRXDNfuUL9NoZD8gHHxXWL1Q8JcYTuk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 128/171] s390/qeth: conclude all event processing before offlining a card
Date:   Tue, 12 Mar 2019 10:08:28 -0700
Message-Id: <20190312170358.767633214@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 8999be74c545..8f2af450152f 100644
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
index 89cc172820ca..ebbc3ad504f9 100644
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
index 49fa09c67d49..a6c55cbf3d69 100644
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
index d1bf55b5c8e1..29a2408b9282 100644
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



