Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7249AC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428B6206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfD0PbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:31:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60944 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727159AbfD0PPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:15 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0000zP-U8; Sat, 27 Apr 2019 16:15:13 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004WB-Fy; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Julian Wiedmann" <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.618660317@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 097/202] s390/qeth: cancel close_dev work before
 removing a card
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

commit c2780c1a3fb724560b1d44f7976e0de17bf153c7 upstream.

A card's close_dev work is scheduled on a driver-wide workqueue. If the
card is removed and freed while the work is still active, this causes a
use-after-free.
So make sure that the work is completed before freeing the card.

Fixes: 0f54761d167f ("qeth: Support VEPA mode")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/net/qeth_core.h    | 1 +
 drivers/s390/net/qeth_l2_main.c | 2 ++
 drivers/s390/net/qeth_l3_main.c | 1 +
 3 files changed, 4 insertions(+)

--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/seq_file.h>
 #include <linux/ethtool.h>
+#include <linux/workqueue.h>
 
 #include <net/ipv6.h>
 #include <net/if_inet6.h>
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -924,6 +924,7 @@ static void qeth_l2_remove_device(struct
 	if (cgdev->state == CCWGROUP_ONLINE)
 		qeth_l2_set_offline(cgdev);
 
+	cancel_work_sync(&card->close_dev_work);
 	if (card->dev) {
 		unregister_netdev(card->dev);
 		free_netdev(card->dev);
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3342,6 +3342,7 @@ static void qeth_l3_remove_device(struct
 	if (cgdev->state == CCWGROUP_ONLINE)
 		qeth_l3_set_offline(cgdev);
 
+	cancel_work_sync(&card->close_dev_work);
 	if (card->dev) {
 		unregister_netdev(card->dev);
 		free_netdev(card->dev);

