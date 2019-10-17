Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC9EECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBDB21835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408874AbfJQKhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:37:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfJQKhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:37:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 83CE2B9B9276EA885477;
        Thu, 17 Oct 2019 18:37:12 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 18:37:02 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>
CC:     <tglx@linutronix.de>, <peterz@infradead.org>, <fw@strlen.de>,
        <bigeasy@linutronix.de>, <pabeni@redhat.com>,
        <jonathan.lemon@gmail.com>, <anshuman.khandual@arm.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next] pktgen: remove unnecessary assignment in pktgen_xmit()
Date:   Thu, 17 Oct 2019 18:34:13 +0800
Message-ID: <1571308453-213479-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable ret is not used after jumping to "unlock" label, so
the assignment is redundant.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 net/core/pktgen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 48b1e42..294bfcf 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3404,7 +3404,6 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 	HARD_TX_LOCK(odev, txq, smp_processor_id());
 
 	if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
-		ret = NETDEV_TX_BUSY;
 		pkt_dev->last_ok = 0;
 		goto unlock;
 	}
-- 
2.8.1

