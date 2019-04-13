Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A47C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA91D20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAyZLYbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDMBan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:30:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36926 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfDMB2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so13005791wmf.2;
        Fri, 12 Apr 2019 18:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RrLsx8dsjp50VpYUQ8My/g4maZhetyDDg/dJPc5shKc=;
        b=YAyZLYbcao26zoj2uSNLE7SClh6FFMy5V6T/138LVHulCf5PaCoQKk+IGwqsA39dGi
         ixZh7OLE1cZzukCyWJnTFceMyLvILb1PhDkSBf2BL/CFgOA5OKtE0sWkOY9Pt97PCbTw
         s6L/vcyKcRCYmNZYBJnoifdJvh8/E7Aoh1hdJGSwoahxjpJ36l4mbsF/FeCnLqpduY5d
         FVJnCb6c9ZZMtBb0UDSIs8gFSsPHvkJDO46XvjVb6tZka9r+J7AwqfjcKXHji+eOZklF
         PS39rK4heSmpycGLwu3S4iLzfzBe+yhoVIFiz5lM9MS9fnU33IzjvCXsDZGEM5M7VsqX
         YtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RrLsx8dsjp50VpYUQ8My/g4maZhetyDDg/dJPc5shKc=;
        b=bgwJyLsuL5FFyZMqTMj2cv/3iDHOV/n2kkL6iGsyt8hDpiZeu8QbsByDMl4+G4B3KW
         vtfBBHXMCVBOctPMVnJOx1fOk9cK3s6LpbTJeC67c85VkwUwDjgG4uIonC2nfsv+QemT
         hFgCwmxkxOrvkZ3PxsZTTU9bdK3ud7Hjge3HxyuDKldpclljr1CqvEoARP+2rJYqlBV1
         wAQgwWKgbQDMD6PScfYBB2J1INHCvffva8hQ0sH79ZSGj+Foym1g7JRBtfbISWrHooi/
         Zd+u3dFH+PuvYUQUhnR0ymLekm6exygOx2rzKVYTEsgfil2AI1KqxWy9bAmUUj9vCZ6s
         YIjg==
X-Gm-Message-State: APjAAAUuAhQCB+uTbmsjs3H5Ca4hQgIkoqbzLWW4XGpU1NbSJt5XdmEr
        5kWemrwy1cPc2cU7cRccFP8=
X-Google-Smtp-Source: APXvYqwTD/yotETbiDTi1c7ZRx8GG4eEZGooHJ9pg479GaDqB5CMz2uLOu+muDHEOoTvQG8tWjkUpQ==
X-Received: by 2002:a1c:730c:: with SMTP id d12mr13618360wmb.10.1555118919516;
        Fri, 12 Apr 2019 18:28:39 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:38 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 08/24] net: dsa: Be aware of switches where VLAN filtering is a global setting
Date:   Sat, 13 Apr 2019 04:28:06 +0300
Message-Id: <20190413012822.30931-9-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some switches, the action of whether to parse VLAN frame headers and use
that information for ingress admission is configurable, but not per
port. Such is the case for the Broadcom BCM53xx and the NXP SJA1105
families, for example. In that case, DSA can prevent the bridge core
from trying to apply different VLAN filtering settings on net devices
that belong to the same switch.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
Reduced the indentation level by 1 in dsa_port_vlan_filtering().

Changes in v2:
None

 include/net/dsa.h |  5 +++++
 net/dsa/port.c    | 52 ++++++++++++++++++++++++++++++++++++++++-------
 net/dsa/switch.c  |  1 +
 3 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 809046f6a718..94a9f096568d 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -210,6 +210,11 @@ struct dsa_switch {
 	/* Number of switch port queues */
 	unsigned int		num_tx_queues;
 
+	/* Disallow bridge core from requesting different VLAN awareness
+	 * settings on ports if not hardware-supported
+	 */
+	bool			vlan_filtering_is_global;
+
 	unsigned long		*bitmap;
 	unsigned long		_bitmap;
 
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 029169c2dd3b..c8eb2cbcea6e 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -154,6 +154,39 @@ void dsa_port_bridge_leave(struct dsa_port *dp, struct net_device *br)
 	dsa_port_set_state_now(dp, BR_STATE_FORWARDING);
 }
 
+static bool dsa_port_can_apply_vlan_filtering(struct dsa_port *dp,
+					      bool vlan_filtering)
+{
+	struct dsa_switch *ds = dp->ds;
+	int i;
+
+	if (!ds->vlan_filtering_is_global)
+		return true;
+
+	/* For cases where enabling/disabling VLAN awareness is global to the
+	 * switch, we need to handle the case where multiple bridges span
+	 * different ports of the same switch device and one of them has a
+	 * different setting than what is being requested.
+	 */
+	for (i = 0; i < ds->num_ports; i++) {
+		struct net_device *other_bridge;
+
+		other_bridge = dsa_to_port(ds, i)->bridge_dev;
+		if (!other_bridge)
+			continue;
+		/* If it's the same bridge, it also has same
+		 * vlan_filtering setting => no need to check
+		 */
+		if (other_bridge == dp->bridge_dev)
+			continue;
+		if (br_vlan_enabled(other_bridge) != vlan_filtering) {
+			dev_err(ds->dev, "VLAN filtering is a global setting\n");
+			return false;
+		}
+	}
+	return true;
+}
+
 int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct switchdev_trans *trans)
 {
@@ -164,13 +197,18 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 	if (switchdev_trans_ph_prepare(trans))
 		return 0;
 
-	if (ds->ops->port_vlan_filtering) {
-		err = ds->ops->port_vlan_filtering(ds, dp->index,
-						   vlan_filtering);
-		if (err)
-			return err;
-		dp->vlan_filtering = vlan_filtering;
-	}
+	if (!ds->ops->port_vlan_filtering)
+		return 0;
+
+	if (!dsa_port_can_apply_vlan_filtering(dp, vlan_filtering))
+		return -EINVAL;
+
+	err = ds->ops->port_vlan_filtering(ds, dp->index,
+					   vlan_filtering);
+	if (err)
+		return err;
+
+	dp->vlan_filtering = vlan_filtering;
 	return 0;
 }
 
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index fde4e9195709..03b8d8928651 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -10,6 +10,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/if_bridge.h>
 #include <linux/netdevice.h>
 #include <linux/notifier.h>
 #include <linux/if_vlan.h>
-- 
2.17.1

