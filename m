Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB5CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E8221924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404536AbfISTwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 15:52:17 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:42866 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404506AbfISTwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 15:52:17 -0400
Received: from localhost.localdomain ([93.22.37.255])
        by mwinf5d35 with ME
        id 3XsC2100X5WHhHH03XsDuX; Thu, 19 Sep 2019 21:52:14 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 19 Sep 2019 21:52:14 +0200
X-ME-IP: 93.22.37.255
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] bluetooth: hci_nokia: Save a few cycles in 'nokia_enqueue()'
Date:   Thu, 19 Sep 2019 21:52:08 +0200
Message-Id: <20190919195208.2254-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'skb_pad()' a few lines above already initializes the "padded" byte to 0.
So there is no need to do it twice.

All what is needed is to increase the len of the skb. So 'skb_put(..., 1)'
is enough here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/bluetooth/hci_nokia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 6463350b7977..05f7f6de6863 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -520,7 +520,7 @@ static int nokia_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		err = skb_pad(skb, 1);
 		if (err)
 			return err;
-		skb_put_u8(skb, 0x00);
+		skb_put(skb, 1);
 	}
 
 	skb_queue_tail(&btdev->txq, skb);
-- 
2.20.1

