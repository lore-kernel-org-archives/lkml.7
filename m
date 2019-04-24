Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E9EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F289621905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116799;
	bh=5VZ2L8mSmGIl6VXCipuMibLFLTQo9WZLpPfU5m9+Fj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V8xSwLxibMI0DTSVFrY1hZSwlq58uLmnERWO6v1a0XcXYQz9i2G96Hdi+/Z4ZV062
	 ZVdjDw2ZcRfakrk8au22EyJPpOTWvzm62dltkF2jn0le0mEttlNVpRxjx+hzBeY+ZO
	 A1ymlPKaod0N7uZwQCdGtN2rozGEev7GOt+jsUas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfDXOj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbfDXOjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:39:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 609BE21900;
        Wed, 24 Apr 2019 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116794;
        bh=5VZ2L8mSmGIl6VXCipuMibLFLTQo9WZLpPfU5m9+Fj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbhPBuehuYffEHlPzbaQpZeqV7w+ef9ruRa+dulqKuX8Z1qKdrwGOrHODkkxghqYD
         OttmPv982XV2BhRDkty+CwB/jcwQdIKKPfoQqziCyjdNPaEbQFGJX+iXaroCTwQFha
         9qt5hisEbq3sVhXmBOb4Fo5KobllUd/5UA+ymbUs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/52] bonding: show full hw address in sysfs for slave entries
Date:   Wed, 24 Apr 2019 10:38:36 -0400
Message-Id: <20190424143911.28890-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
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
2.19.1

