Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7AFC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891E8206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfC1K3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:29:32 -0400
Received: from relay.sw.ru ([185.231.240.75]:36842 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfC1K3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:29:30 -0400
Received: from [10.94.4.83] (helo=finist-ce7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <khorenko@virtuozzo.com>)
        id 1h9SHh-0005Mg-Td; Thu, 28 Mar 2019 13:29:22 +0300
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Jarod Wilson <jarod@redhat.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH] bonding: show full hw address in sysfs for slave entries
Date:   Thu, 28 Mar 2019 13:29:21 +0300
Message-Id: <20190328102921.11680-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bond expects ethernet hwaddr for its slave, but it can be longer than 6
bytes - infiniband interface for example.

 # cat /sys/devices/<skipped>/net/ib0/address
 80:00:02:08:fe:80:00:00:00:00:00:00:7c:fe:90:03:00:be:5d:e1

 # cat /sys/devices/<skipped>/net/ib0/bonding_slave/perm_hwaddr
 80:00:02:08:fe:80

So print full hwaddr in sysfs "bonding_slave/perm_hwaddr" as well.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 drivers/net/bonding/bond_sysfs_slave.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_sysfs_slave.c b/drivers/net/bonding/bond_sysfs_slave.c
index 2f120b2ffef0..4985268e2273 100644
--- a/drivers/net/bonding/bond_sysfs_slave.c
+++ b/drivers/net/bonding/bond_sysfs_slave.c
@@ -55,7 +55,9 @@ static SLAVE_ATTR_RO(link_failure_count);
 
 static ssize_t perm_hwaddr_show(struct slave *slave, char *buf)
 {
-	return sprintf(buf, "%pM\n", slave->perm_hwaddr);
+	return sprintf(buf, "%*phC\n",
+		       slave->dev->addr_len,
+		       slave->perm_hwaddr);
 }
 static SLAVE_ATTR_RO(perm_hwaddr);
 
-- 
2.15.1

