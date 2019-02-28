Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F803C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C13820C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367531;
	bh=+sJE7NA8F5F59KGZGM+EHa32LlcPyCt4QvjIrJ9DZQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iWo7SBosoy37PIXCTkIPmCj99peZFTY+ZdPbGBGxXq7WhAT7rxLzqgXaeGS8CZ45v
	 nd7zaorttdyshuZEgNPb4zpK/8jxKxqDT3FD6NYOiUim0UVSNAdz3bTRiUq4T7dNGU
	 rO775SYSqpFLDaEnbN/Ds1udy2j2HwGY6cDaNGfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388698AbfB1PXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:23:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388350AbfB1PNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45BCE2171F;
        Thu, 28 Feb 2019 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366781;
        bh=+sJE7NA8F5F59KGZGM+EHa32LlcPyCt4QvjIrJ9DZQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6ydPRiv7pyYOm9MxcklVOjPJlGn380vD96k9k5vKeFIvk8uJTnOjRD9UsjduxeNp
         so0qIeKm9FstZv2WZlo/FPn5FL1ps7bn4/XYaML6lyq/ZjijCx9N7uw1v9AF2ITuxM
         ofQDr7FbfK8QWlSJTuLUsvm8mZUsmwX5uRgs7MmU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 50/64] s390/qeth: cancel close_dev work before removing a card
Date:   Thu, 28 Feb 2019 10:10:51 -0500
Message-Id: <20190228151105.11277-50-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

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
index 970654fcc48d2..2d1f6a583641b 100644
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
index 76b2fba5fba22..b7513c5848cf9 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -854,6 +854,8 @@ static void qeth_l2_remove_device(struct ccwgroup_device *cgdev)
 
 	if (cgdev->state == CCWGROUP_ONLINE)
 		qeth_l2_set_offline(cgdev);
+
+	cancel_work_sync(&card->close_dev_work);
 	if (qeth_netdev_is_registered(card->dev))
 		unregister_netdev(card->dev);
 }
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index b7f6a8384543c..7f71ca0d08e7f 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2611,6 +2611,7 @@ static void qeth_l3_remove_device(struct ccwgroup_device *cgdev)
 	if (cgdev->state == CCWGROUP_ONLINE)
 		qeth_l3_set_offline(cgdev);
 
+	cancel_work_sync(&card->close_dev_work);
 	if (qeth_netdev_is_registered(card->dev))
 		unregister_netdev(card->dev);
 	qeth_l3_clear_ip_htable(card, 0);
-- 
2.19.1

