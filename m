Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9A7C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1668F20840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfFGPBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:01:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729192AbfFGPAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:00:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 329E3C04B93D;
        Fri,  7 Jun 2019 15:00:07 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com [10.16.210.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 592B782F69;
        Fri,  7 Jun 2019 15:00:02 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org
Subject: [PATCH net-next 1/7] bonding: improve event debug usability
Date:   Fri,  7 Jun 2019 10:59:26 -0400
Message-Id: <20190607145933.37058-2-jarod@redhat.com>
In-Reply-To: <20190607145933.37058-1-jarod@redhat.com>
References: <20190607145933.37058-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 07 Jun 2019 15:00:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing bonding debug log data along the lines of "event: 5" is a bit spartan,
and often requires a lookup table if you don't remember what every event is.
Make use of netdev_cmd_to_name for an improved debugging experience, so for
the prior example, you'll see: "bond_netdev_event received NETDEV_REGISTER"
instead (both are prefixed with the device for which the event pertains).

CC: Jay Vosburgh <j.vosburgh@gmail.com>
CC: Veaceslav Falico <vfalico@gmail.com>
CC: Andy Gospodarek <andy@greyhouse.net>
CC: netdev@vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/net/bonding/bond_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 407f4095a37a..32b6c1f9b82e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3212,7 +3212,8 @@ static int bond_netdev_event(struct notifier_block *this,
 {
 	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
 
-	netdev_dbg(event_dev, "event: %lx\n", event);
+	netdev_dbg(event_dev, "%s received %s\n",
+		   __func__, netdev_cmd_to_name(event));
 
 	if (!(event_dev->priv_flags & IFF_BONDING))
 		return NOTIFY_DONE;
-- 
2.20.1

