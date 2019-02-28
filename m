Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A921C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD4F218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366899;
	bh=syEqZrYYcw+/cL6WIuruJAWF1k1EOT8HXe1tS/MPf0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WmKHL6iFQ/gGDyqpHteUoHVDDWYGuU2LcNi+q2gu0dZBLpMfJUjO4fuPH1mEhUI6m
	 ufwdP8Nok2XtsAtGCyP68IFR72+eS1t42iE0uAyQNU/niaWiSA/z1VR+ygFLextR1Q
	 nsXQ8VRaE9UmEUHNS7HH8gQuVBvKctfrj6U09N68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388746AbfB1PO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388725AbfB1POw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:14:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AAFF218C3;
        Thu, 28 Feb 2019 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366891;
        bh=syEqZrYYcw+/cL6WIuruJAWF1k1EOT8HXe1tS/MPf0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLPhycyPui4qyLCyNyIqQgaeuJjjQ3nYmd90JkB0hQ3q/VlRVTMIF0ZUmrfSZ2zOP
         cxF4l0qDrs3rgskeLdaKfEpKtKU0rixGKpJKu8ldctFKfzIDRBtxvdfO6Uw4I1ii5S
         7++y83vPqdtBHfabBOrxQkkWtOSt3NcK9YuL8PYo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 28/36] s390/qeth: fix use-after-free in error path
Date:   Thu, 28 Feb 2019 10:13:29 -0500
Message-Id: <20190228151337.12176-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit afa0c5904ba16d59b0454f7ee4c807dae350f432 ]

The error path in qeth_alloc_qdio_buffers() that takes care of
cleaning up the Output Queues is buggy. It first frees the queue, but
then calls qeth_clear_outq_buffers() with that very queue struct.

Make the call to qeth_clear_outq_buffers() part of the free action
(in the correct order), and while at it fix the naming of the helper.

Fixes: 0da9581ddb0f ("qeth: exploit asynchronous delivery of storage blocks")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 69ef5f4060edb..6566fceef38d5 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2472,11 +2472,12 @@ static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *q, int bidx)
 	return rc;
 }
 
-static void qeth_free_qdio_out_buf(struct qeth_qdio_out_q *q)
+static void qeth_free_output_queue(struct qeth_qdio_out_q *q)
 {
 	if (!q)
 		return;
 
+	qeth_clear_outq_buffers(q, 1);
 	qdio_free_buffers(q->qdio_bufs, QDIO_MAX_BUFFERS_PER_Q);
 	kfree(q);
 }
@@ -2549,10 +2550,8 @@ static int qeth_alloc_qdio_buffers(struct qeth_card *card)
 		card->qdio.out_qs[i]->bufs[j] = NULL;
 	}
 out_freeoutq:
-	while (i > 0) {
-		qeth_free_qdio_out_buf(card->qdio.out_qs[--i]);
-		qeth_clear_outq_buffers(card->qdio.out_qs[i], 1);
-	}
+	while (i > 0)
+		qeth_free_output_queue(card->qdio.out_qs[--i]);
 	kfree(card->qdio.out_qs);
 	card->qdio.out_qs = NULL;
 out_freepool:
@@ -2585,10 +2584,8 @@ static void qeth_free_qdio_buffers(struct qeth_card *card)
 	qeth_free_buffer_pool(card);
 	/* free outbound qdio_qs */
 	if (card->qdio.out_qs) {
-		for (i = 0; i < card->qdio.no_out_queues; ++i) {
-			qeth_clear_outq_buffers(card->qdio.out_qs[i], 1);
-			qeth_free_qdio_out_buf(card->qdio.out_qs[i]);
-		}
+		for (i = 0; i < card->qdio.no_out_queues; i++)
+			qeth_free_output_queue(card->qdio.out_qs[i]);
 		kfree(card->qdio.out_qs);
 		card->qdio.out_qs = NULL;
 	}
-- 
2.19.1

