Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EE3C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF8A206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfD0PbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:31:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60938 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727158AbfD0PPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:15 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0000zM-Vr; Sat, 27 Apr 2019 16:15:13 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004W7-FA; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Julian Wiedmann" <jwi@linux.ibm.com>,
        "Alexandra Winter" <wintera@linux.ibm.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.697846572@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 096/202] s390/qeth: fix use-after-free in error path
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

commit afa0c5904ba16d59b0454f7ee4c807dae350f432 upstream.

The error path in qeth_alloc_qdio_buffers() that takes care of
cleaning up the Output Queues is buggy. It first frees the queue, but
then calls qeth_clear_outq_buffers() with that very queue struct.

Make the call to qeth_clear_outq_buffers() part of the free action
(in the correct order), and while at it fix the naming of the helper.

Fixes: 0da9581ddb0f ("qeth: exploit asynchronous delivery of storage blocks")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Add the qeth_free_output_queue() function, which didn't exist here
 - Keep using kfree() to free to free the qeth_qdio_out_q structure]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/net/qeth_core_main.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1288,6 +1288,15 @@ static void qeth_free_buffer_pool(struct
 	}
 }
 
+static void qeth_free_output_queue(struct qeth_qdio_out_q *q)
+{
+	if (!q)
+		return;
+
+	qeth_clear_outq_buffers(q, 1);
+	kfree(q);
+}
+
 static void qeth_free_qdio_buffers(struct qeth_card *card)
 {
 	int i, j;
@@ -1308,10 +1317,8 @@ static void qeth_free_qdio_buffers(struc
 	qeth_free_buffer_pool(card);
 	/* free outbound qdio_qs */
 	if (card->qdio.out_qs) {
-		for (i = 0; i < card->qdio.no_out_queues; ++i) {
-			qeth_clear_outq_buffers(card->qdio.out_qs[i], 1);
-			kfree(card->qdio.out_qs[i]);
-		}
+		for (i = 0; i < card->qdio.no_out_queues; i++)
+			qeth_free_output_queue(card->qdio.out_qs[i]);
 		kfree(card->qdio.out_qs);
 		card->qdio.out_qs = NULL;
 	}
@@ -2483,10 +2490,8 @@ out_freeoutqbufs:
 		card->qdio.out_qs[i]->bufs[j] = NULL;
 	}
 out_freeoutq:
-	while (i > 0) {
-		kfree(card->qdio.out_qs[--i]);
-		qeth_clear_outq_buffers(card->qdio.out_qs[i], 1);
-	}
+	while (i > 0)
+		qeth_free_output_queue(card->qdio.out_qs[--i]);
 	kfree(card->qdio.out_qs);
 	card->qdio.out_qs = NULL;
 out_freepool:

