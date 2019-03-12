Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F589C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEF9217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410971;
	bh=RgubyJRQK+Gcu3OsN2oRis4tZ4/YU06HsO8FfrgHDCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZjVSn+R1yaF0o0LrONzm2u/mADUyofnuOH+R5bqVZZ4sQu+Hb6GjgZf1llSHluy5E
	 KbsSJhmNN0JglwpLpBmiAN/PRlJMHqat5ct5YJxsdipWiqTcBUuhGTdXGO6qt93RVU
	 11IOk2vwQXTK/BuLdD/brp3Jgkxw4XckK+6dJMr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfCLRQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbfCLRPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:12 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF99206DF;
        Tue, 12 Mar 2019 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410911;
        bh=RgubyJRQK+Gcu3OsN2oRis4tZ4/YU06HsO8FfrgHDCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tDS0PCgVJD7fyjuP4ytO0pFRUM5GPco8AszaYqxhooqn07SKy0XDHcajmvJGVYpj1
         diBaK5FAYkU7ZwS+yZQ53wRBFwoDUYn78PCw/g9Yqf/CMj/0h+6/s9FaW5Oulb++37
         oCJ6lrTfg8LAZY76GPL6CiQM49qnBFYbqTNjoM2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 107/149] s390/qeth: cancel close_dev work before removing a card
Date:   Tue, 12 Mar 2019 10:08:45 -0700
Message-Id: <20190312170358.478122814@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 970654fcc48d..2d1f6a583641 100644
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
index 76b2fba5fba2..b7513c5848cf 100644
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
index b7f6a8384543..7f71ca0d08e7 100644
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



