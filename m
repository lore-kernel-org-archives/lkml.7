Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0FF2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411124;
	bh=3xq9oY/fmZuO6GRcN5l3juMscvFQu3s1Ge8bPp0hzdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xUqa11XFDjhVoLnZ8441m1EFFQMw/b0yI9wehe8Jle1YrstDbeV7XJG42SpaIn6E8
	 izE/WC5aZeYTt0oynBssfzFQ3M9EM1L20NEqzNgORtWvaWjb3aUHc1+wo8t7trv6eU
	 ye0ZwjiiDuosYiL0sVZ4hBhKN1YyM9Y++HWKP+10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfCLRSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728906AbfCLRSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:18:02 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA632184E;
        Tue, 12 Mar 2019 17:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411082;
        bh=3xq9oY/fmZuO6GRcN5l3juMscvFQu3s1Ge8bPp0hzdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0q1/0HO/5Po+qriYcK0fSZyNEw6lV4uQMcPk477nR3XNO2BZOrMclk+WYi/YwRvI
         OoafB5mVgMc4bzUP8sd8lWGpDEanjLISte9hEb2tCE8La4l5ddMDIjhPscrP0o+sYU
         6/WG+jS8wvxlFqn4TUUMOvi2xqgE7AS27zSIDin4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 78/96] s390/qeth: fix use-after-free in error path
Date:   Tue, 12 Mar 2019 10:10:36 -0700
Message-Id: <20190312171040.473526716@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index 8f77fc0630ce..86a02592b982 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2449,11 +2449,12 @@ static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *q, int bidx)
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
@@ -2526,10 +2527,8 @@ static int qeth_alloc_qdio_buffers(struct qeth_card *card)
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
@@ -2562,10 +2561,8 @@ static void qeth_free_qdio_buffers(struct qeth_card *card)
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



