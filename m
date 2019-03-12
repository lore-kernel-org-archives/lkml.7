Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BD2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999FF2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412854;
	bh=4wOJzHrG0xkU0ibdSUgtQrIcKHJYiyJ9Q8TuuxAlPoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DIQpn+G4oKZF6hQsIqrnktY6tJM/6IYwqBRaR9vgGOBcPcr+PHKqfxeQlNVjxdoR2
	 nt2rwYTKFtZcugevi42gdfWiP0pxG5Sp4FB5zpTBoDXU67v6gK3r80JUFcmCwMPBjk
	 0E5twZMUNutVOQwhN9eahjkXX3spVhpelDJmrSHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfCLRrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbfCLRPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:11 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18CFB21874;
        Tue, 12 Mar 2019 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410910;
        bh=4wOJzHrG0xkU0ibdSUgtQrIcKHJYiyJ9Q8TuuxAlPoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yh9KW/+MdAuWcZzUcF1iFGTa4dG8eaFcQtHoecP5wPWyoAA6FXI0F/lSursT1BA37
         WGqZnARCMl2X3fdlqAl18R9UzeB0ChfsZN0QNJSQNy0Vchli7eeuJS9P0OBnHNqUwV
         nqL4NfKOebPG5/4Cl4qmSKIqC3970PvN8IMRhlDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 105/149] s390/qeth: release cmd buffer in error paths
Date:   Tue, 12 Mar 2019 10:08:43 -0700
Message-Id: <20190312170358.334414678@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index b03515d43745..4b3b9c4e46d2 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -565,6 +565,7 @@ static int __qeth_issue_next_read(struct qeth_card *card)
 		QETH_DBF_MESSAGE(2, "%s error in starting next read ccw! "
 			"rc=%i\n", dev_name(&card->gdev->dev), rc);
 		atomic_set(&channel->irq_pending, 0);
+		qeth_release_buffer(channel, iob);
 		card->read_or_write_problem = 1;
 		qeth_schedule_recovery(card);
 		wake_up(&card->wait_q);
@@ -1187,6 +1188,8 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		rc = qeth_get_problem(cdev, irb);
 		if (rc) {
 			card->read_or_write_problem = 1;
+			if (iob)
+				qeth_release_buffer(iob->channel, iob);
 			qeth_clear_ipacmd_list(card);
 			qeth_schedule_recovery(card);
 			goto out;
@@ -1852,6 +1855,7 @@ static int qeth_idx_activate_get_answer(struct qeth_channel *channel,
 		QETH_DBF_MESSAGE(2, "Error2 in activating channel rc=%d\n", rc);
 		QETH_DBF_TEXT_(SETUP, 2, "2err%d", rc);
 		atomic_set(&channel->irq_pending, 0);
+		qeth_release_buffer(channel, iob);
 		wake_up(&card->wait_q);
 		return rc;
 	}
@@ -1923,6 +1927,7 @@ static int qeth_idx_activate_channel(struct qeth_channel *channel,
 			rc);
 		QETH_DBF_TEXT_(SETUP, 2, "1err%d", rc);
 		atomic_set(&channel->irq_pending, 0);
+		qeth_release_buffer(channel, iob);
 		wake_up(&card->wait_q);
 		return rc;
 	}
@@ -2110,6 +2115,7 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 	}
 	reply = qeth_alloc_reply(card);
 	if (!reply) {
+		qeth_release_buffer(channel, iob);
 		return -ENOMEM;
 	}
 	reply->callback = reply_cb;
-- 
2.19.1



