Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555B6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2284E214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413609;
	bh=C5orn661uvyrGoyLa3Y8cUTFhlCr1T1HQdhkWiAdOvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XLXV6binG23w4wRvTHoRvJASQSoZXsGCcQDlnFWGCRIhO9blDw4/aZ1IrzGkWyyvT
	 FeSdG6THkYPah2ytC91an7rDzg6YjDsxZIdHa+DKdpUbxj5xcTTeXGq8po8cf255W7
	 bofWgap9ut2FQSjivPnsjVQR4MyJ+eqnIBad+R/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfCLSAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfCLRN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:27 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65E9F217F4;
        Tue, 12 Mar 2019 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410806;
        bh=C5orn661uvyrGoyLa3Y8cUTFhlCr1T1HQdhkWiAdOvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PL3FE/j1EVF/ewsArAT3v+LaLUp6+k7thzppKpj7uIy9ZAFNEhYVv+lJVcLYeHpeE
         C6xYkre7EmrzdYdxS2ZEOL9s3m7FV4gaUNYsAAP8lI3mofhtYkQ2n46+oZjbL9aQcf
         1+j2lsCmdhNHKqGzCCsX0n+XTIcoGd+tnEjrCQCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 125/171] s390/qeth: release cmd buffer in error paths
Date:   Tue, 12 Mar 2019 10:08:25 -0700
Message-Id: <20190312170358.525131923@linuxfoundation.org>
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
index 0c9a5250dd93..623ddda5d2ba 100644
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



