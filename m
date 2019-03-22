Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4593C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804FF218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253806;
	bh=rPO+3wBoT77RZ8MlX+97o8Fy0qGhAcUACyAQwytCeAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k2OE7B4lym8fTT3NfjuCm5svmCyQM7Pyz4HlmL6LEAIlHZAPSSttQx1e7I/zvAGaH
	 58oRVMkQ4/RyaAAc+gWjIObvd4+dWPDNIOTF3sS8LEM5uXcoHHbCb8pIqakT+ez7WZ
	 iE9LRWp+DqG5b0Yfo7prEeyXwGB+a3j2dmJ+978Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfCVLXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbfCVLXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:23:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC7C218D4;
        Fri, 22 Mar 2019 11:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253797;
        bh=rPO+3wBoT77RZ8MlX+97o8Fy0qGhAcUACyAQwytCeAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FlEnQLDxJVhnbHOwHhucmjWnK4JYIEXXqr/pohxc+CkoCfSwawVbqgZKRKpInfSRx
         BcJcWJrIKl0qMmwez16GFMpfMHsR7ObyCibHItnCyVSWdDhFPx55CSbAOEPD+PQJ5b
         sI4wQ2H6NSIu+PynYywyVDH3vxZXZi/glP7GYkIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 075/134] s390/qeth: fix use-after-free in error path
Date:   Fri, 22 Mar 2019 12:14:48 +0100
Message-Id: <20190322111215.509030089@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 2ac6d6665834..a874b821d239 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2423,11 +2423,12 @@ static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *q, int bidx)
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
@@ -2500,10 +2501,8 @@ static int qeth_alloc_qdio_buffers(struct qeth_card *card)
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
@@ -2536,10 +2535,8 @@ static void qeth_free_qdio_buffers(struct qeth_card *card)
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



