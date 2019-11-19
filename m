Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA30C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917A3208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142707;
	bh=k2A1BTemWvg7On3V9rWsnCXdzojip5BlRvpssb7PQBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iv6lVkeevSkzIBXXyI99hNcauUT8NLVaCUEdaUtaN6tg/fufx+sytBZlIJsvOTQmY
	 imHZ6XE7eULWS+yCiCxPP7hxpTGg4JFqYTL5brJk4rwzaHKV2rYvCWr7WbKpa7Z+2u
	 pJNNHnFhnLc/nqCsAjWUGXp4n0JudZXlQZ8xcfjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfKSFvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:51:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731829AbfKSFvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:51:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B753208C3;
        Tue, 19 Nov 2019 05:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142702;
        bh=k2A1BTemWvg7On3V9rWsnCXdzojip5BlRvpssb7PQBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMGey3TKFaWDzbcWkUTnRHAsKyY+oG5gke7ozMO4NcDnqMDXzvOM20ePyG0Cr3BT5
         i1ds4O3V4ncO8mdBYwjZlCa9ojG3gDAGAc6WvQV6ysTA7/VquC1ZTKiHZT85CM+42t
         3pDHdVD5xSSSyosh4wqwqT+uLXBiZN7HcJGgHstw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 130/239] s390/qeth: invoke softirqs after napi_schedule()
Date:   Tue, 19 Nov 2019 06:18:50 +0100
Message-Id: <20191119051330.641783172@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
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
index 2845316db5545..6fa07c2469150 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -869,7 +869,10 @@ static int __qeth_l2_open(struct net_device *dev)
 
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
index d9830c86d0c11..8bccfd686b735 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2849,7 +2849,10 @@ static int __qeth_l3_open(struct net_device *dev)
 
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



