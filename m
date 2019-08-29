Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F6AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F442189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH2JYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:24:20 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:57642 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfH2JYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:24:19 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Horatiu.Vultur@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Horatiu.Vultur@microchip.com";
  x-sender="Horatiu.Vultur@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Horatiu.Vultur@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Horatiu.Vultur@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: K9qjtGmCkJXBZS9NtJNMUdFoe0jVZbYtANKuCmWcNL+LbstwSn9gMVdmw8mhY90L5hmvky6dkC
 srJgJAytZf/v+TdHfCL1faz9HTq9co5ufWD1gHxEyrsz3pTiRDf3NgmOciNK6+3g3qAb+mzW5l
 jRXsoUMCQjFAUVeFBynQjcep5sWVa+IaH0AHwTM6zlpCl/gaL5Z3iqv3BxJ8wPEdM3Hsf6vZtR
 vIsjIDHX2sgtV8jD9ItnyDuzfl/9vOv9PNQr+ZWGl6Ro8ag7oiHFHBauLqes2A9OSYhmH3fhxE
 OYM=
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="46054437"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2019 02:24:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Aug 2019 02:24:14 -0700
Received: from soft-dev3.microsemi.net (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 29 Aug 2019 02:24:14 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <andrew@lunn.ch>,
        <allan.nielsen@microchip.com>, <jiri@resnulli.us>,
        <ivecera@redhat.com>, <f.fainelli@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v3 1/2] net: core: Notify on changes to dev->promiscuity.
Date:   Thu, 29 Aug 2019 11:22:28 +0200
Message-ID: <1567070549-29255-2-git-send-email-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567070549-29255-1-git-send-email-horatiu.vultur@microchip.com>
References: <1567070549-29255-1-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SWITCHDEV_ATTR_ID_PORT_PROMISCUITY switchdev notification type,
used to indicate whenever the dev promiscuity counter is changed.

The notification doesn't use any switchdev_attr attribute because in the
notifier callbacks is it possible to get the dev and read directly
the promiscuity value.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/net/switchdev.h | 1 +
 net/core/dev.c          | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index aee86a1..14b1617 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -40,6 +40,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
 	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
 	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
+	SWITCHDEV_ATTR_ID_PORT_PROMISCUITY,
 };
 
 struct switchdev_attr {
diff --git a/net/core/dev.c b/net/core/dev.c
index 49589ed..40c74f2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -142,6 +142,7 @@
 #include <linux/net_namespace.h>
 #include <linux/indirect_call_wrapper.h>
 #include <net/devlink.h>
+#include <net/switchdev.h>
 
 #include "net-sysfs.h"
 
@@ -7377,6 +7378,11 @@ static void dev_change_rx_flags(struct net_device *dev, int flags)
 static int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 {
 	unsigned int old_flags = dev->flags;
+	struct switchdev_attr attr = {
+		.orig_dev = dev,
+		.id = SWITCHDEV_ATTR_ID_PORT_PROMISCUITY,
+		.flags = SWITCHDEV_F_DEFER,
+	};
 	kuid_t uid;
 	kgid_t gid;
 
@@ -7419,6 +7425,9 @@ static int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 	}
 	if (notify)
 		__dev_notify_flags(dev, old_flags, IFF_PROMISC);
+
+	switchdev_port_attr_set(dev, &attr);
+
 	return 0;
 }
 
-- 
2.7.4

