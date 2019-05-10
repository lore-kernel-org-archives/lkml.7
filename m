Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC88C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6554217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfEJV5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 17:57:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfEJV5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 17:57:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F87C307D913;
        Fri, 10 May 2019 21:57:39 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com [10.16.210.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C82941A267;
        Fri, 10 May 2019 21:57:35 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH] bonding: fix arp_validate toggling in active-backup mode
Date:   Fri, 10 May 2019 17:57:09 -0400
Message-Id: <20190510215709.19162-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 10 May 2019 21:57:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's currently a problem with toggling arp_validate on and off with an
active-backup bond. At the moment, you can start up a bond, like so:

modprobe bonding mode=1 arp_interval=100 arp_validate=0 arp_ip_targets=192.168.1.1
ip link set bond0 down
echo "ens4f0" > /sys/class/net/bond0/bonding/slaves
echo "ens4f1" > /sys/class/net/bond0/bonding/slaves
ip link set bond0 up
ip addr add 192.168.1.2/24 dev bond0

Pings to 192.168.1.1 work just fine. Now turn on arp_validate:

echo 1 > /sys/class/net/bond0/bonding/arp_validate

Pings to 192.168.1.1 continue to work just fine. Now when you go to turn
arp_validate off again, the link falls flat on it's face:

echo 0 > /sys/class/net/bond0/bonding/arp_validate
dmesg
...
[133191.911987] bond0: Setting arp_validate to none (0)
[133194.257793] bond0: bond_should_notify_peers: slave ens4f0
[133194.258031] bond0: link status definitely down for interface ens4f0, disabling it
[133194.259000] bond0: making interface ens4f1 the new active one
[133197.330130] bond0: link status definitely down for interface ens4f1, disabling it
[133197.331191] bond0: now running without any active interface!

The problem lies in bond_options.c, where passing in arp_validate=0
results in bond->recv_probe getting set to NULL. This flies directly in
the face of commit 3fe68df97c7f, which says we need to set recv_probe =
bond_arp_recv, even if we're not using arp_validate. Said commit fixed
this in bond_option_arp_interval_set, but missed that we can get to that
same state in bond_option_arp_validate_set as well.

One solution would be to universally set recv_probe = bond_arp_recv here
as well, but I don't think bond_option_arp_validate_set has any business
touching recv_probe at all, and that should be left to the arp_interval
code, so we can just make things much tidier here.

Fixes: 3fe68df97c7f ("bonding: always set recv_probe to bond_arp_rcv in arp monitor")
CC: Jay Vosburgh <j.vosburgh@gmail.com>
CC: Veaceslav Falico <vfalico@gmail.com>
CC: Andy Gospodarek <andy@greyhouse.net>
CC: "David S. Miller" <davem@davemloft.net>
CC: netdev@vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/net/bonding/bond_options.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index da1fc17295d9..b996967af8d9 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1098,13 +1098,6 @@ static int bond_option_arp_validate_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting arp_validate to %s (%llu)\n",
 		   newval->string, newval->value);
-
-	if (bond->dev->flags & IFF_UP) {
-		if (!newval->value)
-			bond->recv_probe = NULL;
-		else if (bond->params.arp_interval)
-			bond->recv_probe = bond_arp_rcv;
-	}
 	bond->params.arp_validate = newval->value;
 
 	return 0;
-- 
2.20.1

