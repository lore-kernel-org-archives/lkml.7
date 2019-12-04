Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECD0C2D0BE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 06:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395822469A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 06:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfLDGjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 01:39:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725932AbfLDGjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 01:39:47 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0E0FC20E8F9F239D4783;
        Wed,  4 Dec 2019 14:39:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Dec 2019 14:39:36 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <alexios.zavras@intel.com>, <oneukum@suse.com>,
        <tglx@linutronix.de>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] NFC: port100: Convert cpu_to_le16(le16_to_cpu(E1) + E2) to use le16_add_cpu().
Date:   Wed, 4 Dec 2019 14:37:17 +0800
Message-ID: <20191204063717.102854-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to convert cpu_to_le16(le16_to_cpu(frame->datalen) + len) to
use le16_add_cpu().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/nfc/port100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 604dba4..8e4d355 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -565,7 +565,7 @@ static void port100_tx_update_payload_len(void *_frame, int len)
 {
 	struct port100_frame *frame = _frame;
 
-	frame->datalen = cpu_to_le16(le16_to_cpu(frame->datalen) + len);
+	le16_add_cpu(&frame->datalen, len);
 }
 
 static bool port100_rx_frame_is_valid(void *_frame)
-- 
2.7.4

