Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE5CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD5E20862
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141661;
	bh=n6QzZCLFvjcRY9Gen25EumCUyRvB0LU/DHo9DES47YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nqFQ/ogzwecwjV08RBZNDbsBrpwbp/jsRO+TpMozwHJam908lq2YK/i8cIhuHggfe
	 o7BayunHzVxLa/eIWRp2aHrrlwVnIiyjf2t0WQbsJQG7HkjlAOSJT3GMKNeL6+wnot
	 6hCuqNRZnVVAQlaxQhcs+fZm3p40lbXC3fYKhaKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfKSFeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbfKSFeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:34:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6614F20672;
        Tue, 19 Nov 2019 05:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141656;
        bh=n6QzZCLFvjcRY9Gen25EumCUyRvB0LU/DHo9DES47YM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuTh8EkfacZIgIWA0je7ab1Oh17Uw8hn+Et95imG702PlNCRsb7yITDdiiNeWTkLv
         5egzIzmHP5f7ZRV9wPE/XPTRGbyFXK6lbl+siX5li7Gdim7B6Agvti/J8CA4gnETod
         bHsNd2cLPHE/8ExljaR3fe633XmQUwOQ/FQI8aWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 236/422] s390/qeth: invoke softirqs after napi_schedule()
Date:   Tue, 19 Nov 2019 06:17:13 +0100
Message-Id: <20191119051414.378040494@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 4d19db777a2f32c9b76f6fd517ed8960576cb43e ]

Calling napi_schedule() from process context does not ensure that the
NET_RX softirq is run in a timely fashion. So trigger it manually.

This is no big issue with current code. A call to ndo_open() is usually
followed by a ndo_set_rx_mode() call, and for qeth this contains a
spin_unlock_bh(). Except for OSN, where qeth_l2_set_rx_mode() bails out
early.
Nevertheless it's best to not depend on this behaviour, and just fix
the issue at its source like all other drivers do. For instance see
commit 83a0c6e58901 ("i40e: Invoke softirqs after napi_reschedule").

Fixes: a1c3ed4c9ca0 ("qeth: NAPI support for l2 and l3 discipline")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l2_main.c | 3 +++
 drivers/s390/net/qeth_l3_main.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index c1c35eccd5b65..95669d47c389e 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -789,7 +789,10 @@ static int __qeth_l2_open(struct net_device *dev)
 
 	if (qdio_stop_irq(card->data.ccwdev, 0) >= 0) {
 		napi_enable(&card->napi);
+		local_bh_disable();
 		napi_schedule(&card->napi);
+		/* kick-start the NAPI softirq: */
+		local_bh_enable();
 	} else
 		rc = -EIO;
 	return rc;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 9c5e801b3f6cb..52e0ae4dc7241 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2414,7 +2414,10 @@ static int __qeth_l3_open(struct net_device *dev)
 
 	if (qdio_stop_irq(card->data.ccwdev, 0) >= 0) {
 		napi_enable(&card->napi);
+		local_bh_disable();
 		napi_schedule(&card->napi);
+		/* kick-start the NAPI softirq: */
+		local_bh_enable();
 	} else
 		rc = -EIO;
 	return rc;
-- 
2.20.1



