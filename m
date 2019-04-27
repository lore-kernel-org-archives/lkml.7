Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB9DC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB454206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfD0PaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:30:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60978 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727189AbfD0PPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0000zQ-W8; Sat, 27 Apr 2019 16:15:13 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004WH-Gb; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Julian Wiedmann" <jwi@linux.ibm.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.499354079@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 098/202] s390/qeth: conclude all event processing
 before offlining a card
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

commit c0a2e4d10d9366ada133a8ae4ff2f32397f8b15b upstream.

Work for Bridgeport events is currently placed on a driver-wide
workqueue. If the card is removed and freed while any such work is still
active, this causes a use-after-free.
So put the events on a per-card queue, where we can control their
lifetime. As we also don't want stale events to last beyond an
offline & online cycle, flush this queue when setting the card offline.

Fixes: b4d72c08b358 ("qeth: bridgeport support - basic control")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Add gdev parameter to qeth_alloc_card(), as done upstream by commit
   121ca39aa558 "s390/qeth: uninstall IRQ handler on device removal"
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 10 ++++++++--
 drivers/s390/net/qeth_l2_main.c   |  6 ++++--
 drivers/s390/net/qeth_l3_main.c   |  2 ++
 4 files changed, 15 insertions(+), 5 deletions(-)

--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -793,6 +793,7 @@ struct qeth_card {
 	struct qeth_seqno seqno;
 	struct qeth_card_options options;
 
+	struct workqueue_struct *event_wq;
 	wait_queue_head_t wait_q;
 	spinlock_t vlanlock;
 	spinlock_t mclock;
@@ -903,7 +904,6 @@ extern const struct attribute_group *qet
 extern const struct attribute_group qeth_device_attr_group;
 extern const struct attribute_group qeth_device_blkt_group;
 extern const struct device_type qeth_generic_devtype;
-extern struct workqueue_struct *qeth_wq;
 
 const char *qeth_get_cardname_short(struct qeth_card *);
 int qeth_realloc_buffer_pool(struct qeth_card *, int);
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -67,8 +67,7 @@ static void qeth_notify_skbs(struct qeth
 static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf);
 static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *, int);
 
-struct workqueue_struct *qeth_wq;
-EXPORT_SYMBOL_GPL(qeth_wq);
+static struct workqueue_struct *qeth_wq;
 
 static void qeth_close_dev_handler(struct work_struct *work)
 {
@@ -1497,7 +1496,7 @@ static void qeth_core_sl_print(struct se
 			CARD_BUS_ID(card), card->info.mcl_level);
 }
 
-static struct qeth_card *qeth_alloc_card(void)
+static struct qeth_card *qeth_alloc_card(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card;
 
@@ -1511,6 +1510,10 @@ static struct qeth_card *qeth_alloc_card
 		QETH_DBF_TEXT(SETUP, 0, "iptbdnom");
 		goto out_card;
 	}
+
+	card->event_wq = alloc_ordered_workqueue("%s", 0, dev_name(&gdev->dev));
+	if (!card->event_wq)
+		goto out_wq;
 	if (qeth_setup_channel(&card->read))
 		goto out_ip;
 	if (qeth_setup_channel(&card->write))
@@ -1523,6 +1526,8 @@ static struct qeth_card *qeth_alloc_card
 out_channel:
 	qeth_clean_channel(&card->read);
 out_ip:
+	destroy_workqueue(card->event_wq);
+out_wq:
 	kfree(card->ip_tbd_list);
 out_card:
 	kfree(card);
@@ -4869,6 +4874,7 @@ static void qeth_core_free_card(struct q
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 	qeth_clean_channel(&card->read);
 	qeth_clean_channel(&card->write);
+	destroy_workqueue(card->event_wq);
 	kfree(card->ip_tbd_list);
 	qeth_free_qdio_buffers(card);
 	unregister_service_level(&card->qeth_service_level);
@@ -5332,7 +5338,7 @@ static int qeth_core_probe_device(struct
 
 	QETH_DBF_TEXT_(SETUP, 2, "%s", dev_name(&gdev->dev));
 
-	card = qeth_alloc_card();
+	card = qeth_alloc_card(gdev);
 	if (!card) {
 		QETH_DBF_TEXT_(SETUP, 2, "1err%d", -ENOMEM);
 		rc = -ENOMEM;
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -407,6 +407,8 @@ static int qeth_l2_stop_card(struct qeth
 		qeth_clear_cmd_buffers(&card->read);
 		qeth_clear_cmd_buffers(&card->write);
 	}
+
+	flush_workqueue(card->event_wq);
 	return rc;
 }
 
@@ -1542,7 +1544,7 @@ static void qeth_bridge_state_change(str
 	data->card = card;
 	memcpy(&data->qports, qports,
 			sizeof(struct qeth_sbp_state_change) + extrasize);
-	queue_work(qeth_wq, &data->worker);
+	queue_work(card->event_wq, &data->worker);
 }
 
 struct qeth_bridge_host_data {
@@ -1614,7 +1616,7 @@ static void qeth_bridge_host_event(struc
 	data->card = card;
 	memcpy(&data->hostevs, hostevs,
 			sizeof(struct qeth_ipacmd_addr_change) + extrasize);
-	queue_work(qeth_wq, &data->worker);
+	queue_work(card->event_wq, &data->worker);
 }
 
 /* SETBRIDGEPORT support; sending commands */
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2180,6 +2180,8 @@ static int qeth_l3_stop_card(struct qeth
 		qeth_clear_cmd_buffers(&card->read);
 		qeth_clear_cmd_buffers(&card->write);
 	}
+
+	flush_workqueue(card->event_wq);
 	return rc;
 }
 

