Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905FDC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67650214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504188AbfIXJ0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:26:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729643AbfIXJ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:26:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7204EC4F7326A7C97CB1;
        Tue, 24 Sep 2019 17:26:09 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Sep 2019 17:26:00 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <nixiaoming@huawei.com>
Subject: [PATCH] tty:n_gsm.c: destroy port by tty_port_destroy()
Date:   Tue, 24 Sep 2019 17:25:56 +0800
Message-ID: <1569317156-45850-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the comment of tty_port_destroy():
    When a port was initialized using tty_port_init, one has to destroy
    the port by tty_port_destroy();

tty_port_init() is called in gsm_dlci_alloc()
so tty_port_destroy() needs to be called in gsm_dlci_free()

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 drivers/tty/n_gsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 36a3eb4..3f5bcc9 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1681,6 +1681,7 @@ static void gsm_dlci_free(struct tty_port *port)
 
 	del_timer_sync(&dlci->t1);
 	dlci->gsm->dlci[dlci->addr] = NULL;
+	tty_port_destroy(&dlci->port);
 	kfifo_free(dlci->fifo);
 	while ((dlci->skb = skb_dequeue(&dlci->skb_list)))
 		dev_kfree_skb(dlci->skb);
-- 
1.8.5.6

