Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73A6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F77A20665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749977;
	bh=tRUp6fLueYqV+50jDsF7vOJAP8OxAuhCOq0AkDQBUDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZVzopNL/oCD8175jJWgKLbgyiFNNEUEf8cKaefDdgCPpa+eAZnAJjnCDITyAsE8o1
	 KYeysuIhFxhUrpTfVet1HK4wrUQ4Iy9kcHR+9oEo+g1cO3HbpIjkpMP6udhC/1jy6w
	 mwqFL//LURPYKL9C65GxpnhAp9oB9JFai9Lx7atg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfHNCc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbfHNCQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:16:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A4F82133F;
        Wed, 14 Aug 2019 02:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748963;
        bh=tRUp6fLueYqV+50jDsF7vOJAP8OxAuhCOq0AkDQBUDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zRIjQlpnmvjpeoUcA/ZpstRPuP7qXW9Sp8cAFoG5RYPaaElo/NmBti1dDUvtxEhld
         qVomgWzDT5Ucsh6BRtIvqult6Csd9iv2TPmyyLN5hJIivCblXIE6GvUsMVtQQO2xpZ
         EYaDiFnk8Cj7EBqNLSeWfhO9z3f66k+Wz5r6YZJo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Falcon <tlfalcon@linux.ibm.com>,
        Jarod Wilson <jarod@redhat.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/68] bonding: Force slave speed check after link state recovery for 802.3ad
Date:   Tue, 13 Aug 2019 22:14:47 -0400
Message-Id: <20190814021548.16001-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021548.16001-1-sashal@kernel.org>
References: <20190814021548.16001-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Falcon <tlfalcon@linux.ibm.com>

[ Upstream commit 12185dfe44360f814ac4ead9d22ad2af7511b2e9 ]

The following scenario was encountered during testing of logical
partition mobility on pseries partitions with bonded ibmvnic
adapters in LACP mode.

1. Driver receives a signal that the device has been
   swapped, and it needs to reset to initialize the new
   device.

2. Driver reports loss of carrier and begins initialization.

3. Bonding driver receives NETDEV_CHANGE notifier and checks
   the slave's current speed and duplex settings. Because these
   are unknown at the time, the bond sets its link state to
   BOND_LINK_FAIL and handles the speed update, clearing
   AD_PORT_LACP_ENABLE.

4. Driver finishes recovery and reports that the carrier is on.

5. Bond receives a new notification and checks the speed again.
   The speeds are valid but miimon has not altered the link
   state yet.  AD_PORT_LACP_ENABLE remains off.

Because the slave's link state is still BOND_LINK_FAIL,
no further port checks are made when it recovers. Though
the slave devices are operational and have valid speed
and duplex settings, the bond will not send LACPDU's. The
simplest fix I can see is to force another speed check
in bond_miimon_commit. This way the bond will update
AD_PORT_LACP_ENABLE if needed when transitioning from
BOND_LINK_FAIL to BOND_LINK_UP.

CC: Jarod Wilson <jarod@redhat.com>
CC: Jay Vosburgh <j.vosburgh@gmail.com>
CC: Veaceslav Falico <vfalico@gmail.com>
CC: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index be0b785becd09..ff27f29b6fe76 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2188,6 +2188,15 @@ static void bond_miimon_commit(struct bonding *bond)
 	bond_for_each_slave(bond, slave, iter) {
 		switch (slave->new_link) {
 		case BOND_LINK_NOCHANGE:
+			/* For 802.3ad mode, check current slave speed and
+			 * duplex again in case its port was disabled after
+			 * invalid speed/duplex reporting but recovered before
+			 * link monitoring could make a decision on the actual
+			 * link status
+			 */
+			if (BOND_MODE(bond) == BOND_MODE_8023AD &&
+			    slave->link == BOND_LINK_UP)
+				bond_3ad_adapter_speed_duplex_changed(slave);
 			continue;
 
 		case BOND_LINK_UP:
-- 
2.20.1

