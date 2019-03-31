Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A6FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889772082C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex9Yil9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfCaRnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:43:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54241 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731443AbfCaRnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:43:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so7778520wmj.3;
        Sun, 31 Mar 2019 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BTdNk4nXAKkCPNoqdjuT77lIst9B+p+N+H/StWyTeH8=;
        b=ex9Yil9/vbxJ7xV+HOx2ZaTlRt3ZfurRKz1Bt72TpyEzi1GwHPRT4Wn9GjZid6ySjq
         W6GY5NGXmtkAWxDuBpxsXQj3kC9K7Shi/AF9MQKHhXtoUDH3UUSxi//itaSQ33eQmFsg
         v/mILhjYzcOKsBmKxA6MD3tsBaZWFxtm+f5MuTpWkzDJyTnYUR+g+gGbNGTHXxG8fdPh
         FKWtCcoO9gmb9aQr9Mh0HHdmbE7F3BYJ3j/kxco4tNkvEFQ2jnbT+GW40KNp0XXPeKuR
         tl7+3LWvOK0Ab4za6okqsw+xvtjM4BNFxMfDPqgh2n6h0qpT2ENQ+lvnWn2NuHGZ+ydO
         q2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BTdNk4nXAKkCPNoqdjuT77lIst9B+p+N+H/StWyTeH8=;
        b=dD4XghBlMxjadVrrSL/G+SXuSdp2Cjbib/X9Dc2tVqzAQ3oa2xOr+qvaOIZ7TL0UKz
         DCWgiS3/Mr+j1KAnKWDJC9s9OP3Wi9CHY+B+nq7T1SkONFnhXlkLCB8/7cJz0eSIUeUA
         DT4iZc6vMisuYwgOessA9D8rBuQb8GELEEEgLM+7wtgNeLpnhLerIRS65vmlSKNzgNzx
         IO3kmZMipQxmOBatXMJtm5RXhJ+XDM8ucDmkGMIy+UUhFUB0WKUodyqO5+eHgFyGDrse
         C+Iw15/7L3oqU8sHM1LOvxze5YE3Amzl0MmMk+58JN40Dyn/dpyg8T1q8wyINkwY6f2e
         OvFQ==
X-Gm-Message-State: APjAAAXcBeGtjZf5jhzhcguslJC/AcMJxK8RlgzwTlhJufcNDaG9h75O
        3EnyEzH/b2/LeydJjafFGpI=
X-Google-Smtp-Source: APXvYqwM6dOAzRCtGys11HL+f1x+jUrHn+5amQbRlBxXTqTPndrmpLl63e8DTF5btQ/6NKnvCjHXwQ==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr10445577wma.35.1554054179696;
        Sun, 31 Mar 2019 10:42:59 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:42:59 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 08/17] net: dsa: Be aware of switches where VLAN filtering is a global setting
Date:   Sun, 31 Mar 2019 20:42:23 +0300
Message-Id: <20190331174232.22060-9-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
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
 include/net/dsa.h |  5 +++++
 net/dsa/port.c    | 34 ++++++++++++++++++++++++++++++++++
 net/dsa/switch.c  |  1 +
 3 files changed, 40 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index b22c350c40f0..91375bcf2cfb 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -209,6 +209,11 @@ struct dsa_switch {
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
index 10065a622ada..d04e7c4f5efe 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -154,6 +154,37 @@ void dsa_port_bridge_leave(struct dsa_port *dp, struct net_device *br)
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
+		if (br_vlan_enabled(other_bridge) != vlan_filtering)
+			return false;
+	}
+	return true;
+}
+
 int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct switchdev_trans *trans)
 {
@@ -165,6 +196,9 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 		return 0;
 
 	if (ds->ops->port_vlan_filtering) {
+		if (!dsa_port_can_apply_vlan_filtering(dp, vlan_filtering))
+			return -EINVAL;
+
 		err = ds->ops->port_vlan_filtering(ds, dp->index,
 						   vlan_filtering);
 		if (err)
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

