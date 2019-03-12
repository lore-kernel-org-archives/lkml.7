Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FC9217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410834;
	bh=kOtjHQJl66byfjxpcZ8qcknYhXokst2XzUsEMKpldJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qY8O15WmAb6vCXg7/WSph1rn3CdcTUzvMT7yKJQoNDF5cnw9fNsfRcqKhbdqydRHT
	 +BESnBGf6B2K5WHKu6Vb9n0cCAuLegeXOIZIWNBUF+Qgr5aw+j4wpbWtUUj40xMNit
	 WjlD9/muS12GeOXWAuNXLzfYlnEuukWBFo90lkOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfCLRNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfCLRNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:19 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BDCF217D4;
        Tue, 12 Mar 2019 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410798;
        bh=kOtjHQJl66byfjxpcZ8qcknYhXokst2XzUsEMKpldJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTET5TOvpsjK4bUIz6c+pIY2c2wvW7EArxmo5DL0UEffwEXKLz/QnI1fvXkOvAQaU
         UK2fUpcM8IyKE4t2w06WZ7Nlm5R91KActXTbXPf4ALyiY1smWKdpv3upc/duWYebsJ
         FTo+gVe196kbTT07xldXB2dvSLmmMqC2SuK7G8bc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 127/171] s390/qeth: cancel close_dev work before removing a card
Date:   Tue, 12 Mar 2019 10:08:27 -0700
Message-Id: <20190312170358.679237737@linuxfoundation.org>
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

[ Upstream commit c2780c1a3fb724560b1d44f7976e0de17bf153c7 ]

A card's close_dev work is scheduled on a driver-wide workqueue. If the
card is removed and freed while the work is still active, this causes a
use-after-free.
So make sure that the work is completed before freeing the card.

Fixes: 0f54761d167f ("qeth: Support VEPA mode")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h    | 1 +
 drivers/s390/net/qeth_l2_main.c | 2 ++
 drivers/s390/net/qeth_l3_main.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 99af1a0a3314..8999be74c545 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -22,6 +22,7 @@
 #include <linux/hashtable.h>
 #include <linux/ip.h>
 #include <linux/refcount.h>
+#include <linux/workqueue.h>
 
 #include <net/ipv6.h>
 #include <net/if_inet6.h>
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 8d3601891c62..49fa09c67d49 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -823,6 +823,8 @@ static void qeth_l2_remove_device(struct ccwgroup_device *cgdev)
 
 	if (cgdev->state == CCWGROUP_ONLINE)
 		qeth_l2_set_offline(cgdev);
+
+	cancel_work_sync(&card->close_dev_work);
 	if (qeth_netdev_is_registered(card->dev))
 		unregister_netdev(card->dev);
 }
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index f08b745c2007..d1bf55b5c8e1 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2428,6 +2428,7 @@ static void qeth_l3_remove_device(struct ccwgroup_device *cgdev)
 	if (cgdev->state == CCWGROUP_ONLINE)
 		qeth_l3_set_offline(cgdev);
 
+	cancel_work_sync(&card->close_dev_work);
 	if (qeth_netdev_is_registered(card->dev))
 		unregister_netdev(card->dev);
 	qeth_l3_clear_ip_htable(card, 0);
-- 
2.19.1



