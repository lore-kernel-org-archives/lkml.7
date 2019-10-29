Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11113CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 06:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB2E20830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 06:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbfJ2GJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 02:09:26 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:55125 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729754AbfJ2GJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 02:09:26 -0400
Received: from localhost.localdomain ([93.22.151.170])
        by mwinf5d72 with ME
        id KJ9N210043gq7t103J9N2i; Tue, 29 Oct 2019 07:09:23 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 29 Oct 2019 07:09:23 +0100
X-ME-IP: 93.22.151.170
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] rpmsg: char: Simplify 'rpmsg_eptdev_release()'
Date:   Tue, 29 Oct 2019 07:09:14 +0100
Message-Id: <20191029060915.3650-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'skb_queue_purge()' instead of re-implementing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/rpmsg/rpmsg_char.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 507bfe163883..0c3a340db7d1 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -146,7 +146,6 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 {
 	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
 	struct device *dev = &eptdev->dev;
-	struct sk_buff *skb;
 
 	/* Close the endpoint, if it's not already destroyed by the parent */
 	mutex_lock(&eptdev->ept_lock);
@@ -157,10 +156,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 	mutex_unlock(&eptdev->ept_lock);
 
 	/* Discard all SKBs */
-	while (!skb_queue_empty(&eptdev->queue)) {
-		skb = skb_dequeue(&eptdev->queue);
-		kfree_skb(skb);
-	}
+	skb_queue_purge(&eptdev->queue);
 
 	put_device(dev);
 
-- 
2.20.1

