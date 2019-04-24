Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E09C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3599F21900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117259;
	bh=G9Bk4vD31SPIxN6xD/wj+xW/JOzU4jjbn2sR94YCRmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qyp1hAXRYeIfof6YvYOzOy9ijbKosBA9tH/U3HkLip9KWeDoOP2AVawBIgFnmxkcA
	 gBYGoQU1AMj3RzV37bR7ZCH/WDhMcPRpYempJ+ljzqdBhywbSsD2woPh3g2jKmYtFL
	 03yWjt1v0qOvcuxR8PWZZFMiZAyuHgdRQ5Qq1lUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbfDXOri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732263AbfDXOrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:47:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E29221902;
        Wed, 24 Apr 2019 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117255;
        bh=G9Bk4vD31SPIxN6xD/wj+xW/JOzU4jjbn2sR94YCRmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYInLlE5BQsu7wjlM9LU1jc1qan9wDdCl58A1QZWuwuC5uKkyYIkAn4JNWgbmgYwA
         nbzKIVhu2fQL8XOiEh5oqZkg6X7Yj1OXrRL7E1FV7POUbCvqykjZPXXyRMciFr9w7q
         j6iyjjDacXOexg9F/eNOT+gKVf2BIaeB8jHbrrA8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 11/35] bonding: show full hw address in sysfs for slave entries
Date:   Wed, 24 Apr 2019 10:46:45 -0400
Message-Id: <20190424144709.30215-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khorenko <khorenko@virtuozzo.com>

[ Upstream commit 18bebc6dd3281955240062655a4df35eef2c46b3 ]

Bond expects ethernet hwaddr for its slave, but it can be longer than 6
bytes - infiniband interface for example.

 # cat /sys/devices/<skipped>/net/ib0/address
 80:00:02:08:fe:80:00:00:00:00:00:00:7c:fe:90:03:00:be:5d:e1

 # cat /sys/devices/<skipped>/net/ib0/bonding_slave/perm_hwaddr
 80:00:02:08:fe:80

So print full hwaddr in sysfs "bonding_slave/perm_hwaddr" as well.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_sysfs_slave.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_sysfs_slave.c b/drivers/net/bonding/bond_sysfs_slave.c
index 7d16c51e6913..641a532b67cb 100644
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
2.19.1

