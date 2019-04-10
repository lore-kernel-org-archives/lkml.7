Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E39FC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AFF20874
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TexGUpnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfDJA7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:59:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37743 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfDJA5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so666953wmf.2;
        Tue, 09 Apr 2019 17:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RW3tn52MAXjNnRNsPRKCa31OzR8yf3/F3iVTbj5ONyE=;
        b=TexGUpndr9hWva0j1NKsoQItYTYLiTGMHQfEVNoLoMaRKjJaufozL5zZ4x+B66vGqr
         DlkcXOrCTlcZ+nYq5TFHU5O6hN1L6kMgZzmh8/ZPtegOJ8Zai4Ubytpm1awZPZVFpXAx
         E4UBgM8O3FWNXHnWS/CeRBY8cBTd7sYO/EFfNmcObkJ5gkNCWWxmwTHp6ncw7YMav1sO
         wRVCZDHOWJ3xSK+66OJwvyxXRnjA7cBWfAGfSGjUT2877C9iaGfnPLbq7rT1aU/X0GjK
         2F+1YEUzEC6OGPV/PLZlV6I4qrcNouCNvgAr2S9KsG8dHshF8IAs/gxBNh+PAIse5XHc
         dd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RW3tn52MAXjNnRNsPRKCa31OzR8yf3/F3iVTbj5ONyE=;
        b=iXyPjrUv93TBeCxxYtQqQxFTldM4idrIj23qU4UPjQv0swMnDWY9WxKJADB3oAlB3i
         rk656ETCdM2ct578dyvTZpcDt6iPbtoIG5ESVExQ3XbtJuue3OFD70z1kuSSx6hpncUF
         6WOrkZBvIDx7ZestOYyyIoDuaHD/6K0oGZQU6Ho/tHFQsVN/3gu4sbKC+wgmCrt3mlAa
         Y1q89G5Z7yQG7mO0+ZuKfk7HPAp4LcVoL/FT6xHEkFJqsQEe+O5djK108KS3UNRKd5Ro
         gDQvjK6u1W0Ood8Ba7HlrLE8+Th6wYPeeFsp78wH6ayvaSjoCWWw05+PfHY7tecOy0cp
         Reuw==
X-Gm-Message-State: APjAAAVX9iKbM8WNtjdvL6VOmkF3urMaT4q6xBZpjv9BrweoLe0zqOik
        CYZxfRkdYzgej9JCsT09Z8Y=
X-Google-Smtp-Source: APXvYqwGXGk1b8xRQrNxE3k34LTT4EysNxZVDZdCfXtcfR5UDA6Apxuam4DLHuDzW7aJpQGszduvcw==
X-Received: by 2002:a05:600c:2208:: with SMTP id z8mr663618wml.89.1554857850467;
        Tue, 09 Apr 2019 17:57:30 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:29 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 09/22] net: dsa: Be aware of switches where VLAN filtering is a global setting
Date:   Wed, 10 Apr 2019 03:56:47 +0300
Message-Id: <20190410005700.31582-10-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
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
Changes in v2:
None

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
index 19f3b91c648d..b192d2f594e7 100644
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

