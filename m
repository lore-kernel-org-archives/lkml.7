Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42537C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF942082C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947053;
	bh=gLSeBiYtRW05Fgp8Wur43XLorR7RRR+t7EZkK1UFHcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ANU81ZsWI6M3ACvhDyFjE3EzPOVuT/M1x2gvlUDf77+WS5jiGVtONn5UrhlxuCzVg
	 lxMt5mI2FWlswjnBxjBfwu/m6GKUZ4I/JjduiTiQxqmch0/H9GXR6o/CszxXfLBzff
	 bPMpMXIuFPZHQBxUwJNd+E66mSltNe+zDkwzg/p4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbfIHMuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732280AbfIHMus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:50:48 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C29A2196F;
        Sun,  8 Sep 2019 12:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947045;
        bh=gLSeBiYtRW05Fgp8Wur43XLorR7RRR+t7EZkK1UFHcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0qXX3utMDzh4t8i/4irVz0MjMor0o0S8OuT7GEp2MYHj0scQ8vTczPIzgBVfGtsI
         XY5NXO/sSZ0KLIb0MuWStXRP+vfI8cZxBOCNUPJhSxm/gA7U6T1qJihEC+5bm3SSCX
         deEcGwWz4oI0a7pLq7r+NPivJFZSZ+UNKb+ypDjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 39/94] s390/qeth: serialize cmd reply with concurrent timeout
Date:   Sun,  8 Sep 2019 13:41:35 +0100
Message-Id: <20190908121151.557585474@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 072f79400032f74917726cf76f4248367ea2b5b8 ]

Callbacks for a cmd reply run outside the protection of card->lock, to
allow for additional cmds to be issued & enqueued in parallel.

When qeth_send_control_data() bails out for a cmd without having
received a reply (eg. due to timeout), its callback may concurrently be
processing a reply that just arrived. In this case, the callback
potentially accesses a stale reply->reply_param area that eg. was
on-stack and has already been released.

To avoid this race, add some locking so that qeth_send_control_data()
can (1) wait for a concurrently running callback, and (2) zap any
pending callback that still wants to run.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 784a2e76a1b04..c5f60f95e8db9 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -640,6 +640,7 @@ struct qeth_seqno {
 struct qeth_reply {
 	struct list_head list;
 	struct completion received;
+	spinlock_t lock;
 	int (*callback)(struct qeth_card *, struct qeth_reply *,
 		unsigned long);
 	u32 seqno;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index b1823d75dd35c..6b8f99e7d8a81 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -548,6 +548,7 @@ static struct qeth_reply *qeth_alloc_reply(struct qeth_card *card)
 	if (reply) {
 		refcount_set(&reply->refcnt, 1);
 		init_completion(&reply->received);
+		spin_lock_init(&reply->lock);
 	}
 	return reply;
 }
@@ -832,6 +833,13 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 
 	if (!reply->callback) {
 		rc = 0;
+		goto no_callback;
+	}
+
+	spin_lock_irqsave(&reply->lock, flags);
+	if (reply->rc) {
+		/* Bail out when the requestor has already left: */
+		rc = reply->rc;
 	} else {
 		if (cmd) {
 			reply->offset = (u16)((char *)cmd - (char *)iob->data);
@@ -840,7 +848,9 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 			rc = reply->callback(card, reply, (unsigned long)iob);
 		}
 	}
+	spin_unlock_irqrestore(&reply->lock, flags);
 
+no_callback:
 	if (rc <= 0)
 		qeth_notify_reply(reply, rc);
 	qeth_put_reply(reply);
@@ -1880,6 +1890,16 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 		rc = (timeout == -ERESTARTSYS) ? -EINTR : -ETIME;
 
 	qeth_dequeue_reply(card, reply);
+
+	if (reply_cb) {
+		/* Wait until the callback for a late reply has completed: */
+		spin_lock_irq(&reply->lock);
+		if (rc)
+			/* Zap any callback that's still pending: */
+			reply->rc = rc;
+		spin_unlock_irq(&reply->lock);
+	}
+
 	if (!rc)
 		rc = reply->rc;
 	qeth_put_reply(reply);
-- 
2.20.1



