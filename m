Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78F6C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92FA20872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXgF0jsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfCaRnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:43:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33533 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731459AbfCaRnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:43:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so8901988wrp.0;
        Sun, 31 Mar 2019 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iz0jFSWD+1wyaTMTU4Z0tR7cJmqeHJV89XUQaF3l7tI=;
        b=oXgF0jsggwq+CmoMZsZzbZlnZrkuZUShn/MlMJdecP5eW8DduoBVlb892BOL2w9iHm
         GMrKNPpz3ZiVBKKB3niJ/ng4i68BjDCc0epr663yRP7zSgMbeuTZzZgBnx5aXaHPRzWr
         tqPIpFBtjBS3oQ7xKhbRloaJ3NmKGCwtpWh4PLgM/fP0+ziTsSv/sMx5ipnTg+ul3Te9
         uVKy5za19x4i3IjyQ82qRfIYSiCyp+80rnG9KUhqIdfnVet+b+I2HlvQcbhmCPcSNr8A
         5NIF/LvJF3hGBBIbeEXoDRh96sSeHDbJzQrkzNVKfnthDO8Ms5bqrexKjCgQ8XeRP9i9
         SZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Iz0jFSWD+1wyaTMTU4Z0tR7cJmqeHJV89XUQaF3l7tI=;
        b=Twaa9/NxUNfUW6ZATPcpg5basx+prJAEOuCKzX9calIsFepepU/U758fzgE7tnwXjA
         O40xV1eGolY6uCkYPp0ojkIaIBCeGvC/qVT3egMDRz8A4EEar4Yk/dYSy8vQzxQGaCum
         Lr262bDc/I5LCgkVVrh9zbIx51qO3reHlNzdrhCF/RVFJCQ293UVQhYEP+L1Nx37mLe1
         7cRx3XZKmBwhdm+GxIrj3KrVd/tbe09Nx46d+FzJ/2RLT1AAi+qP0xbdpwM+5LWGnNMm
         DYJzGnlYtvupRt+WLvm5Sfw+HE/hWE6xGeO73QlaAZgtcVSrm1FK4BqMPzV8OjGKfq6A
         +CfA==
X-Gm-Message-State: APjAAAVDWSYRHbMXlyN+PXkx3tNOzqiPdOyw4DOsXgz8biS8mVyjiIuW
        G4j2BO/Q96PHAcC+puiAOiIWaX8vVS/tgQ==
X-Google-Smtp-Source: APXvYqz5nriOXj8pRl/BXaMbX76QB7al12ZF6LWSP5vtDhpyPcNql/Lr7a6CUzUcJasBsX6dFwQKHw==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr17296987wrr.147.1554054180872;
        Sun, 31 Mar 2019 10:43:00 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:43:00 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 09/17] net: dsa: b53: Let DSA handle mismatched VLAN filtering settings
Date:   Sun, 31 Mar 2019 20:42:24 +0300
Message-Id: <20190331174232.22060-10-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSA core is now able to do this check prior to calling the
.port_vlan_filtering callback, so tell it that VLAN filtering is global
for this particular hardware.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0852e5e08177..a779b9c3ab6e 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -966,6 +966,13 @@ static int b53_setup(struct dsa_switch *ds)
 			b53_disable_port(ds, port);
 	}
 
+	/* Let DSA handle the case were multiple bridges span the same switch
+	 * device and different VLAN awareness settings are requested, which
+	 * would be breaking filtering semantics for any of the other bridge
+	 * devices. (not hardware supported)
+	 */
+	ds->vlan_filtering_is_global = true;
+
 	return ret;
 }
 
@@ -1275,26 +1282,8 @@ EXPORT_SYMBOL(b53_phylink_mac_link_up);
 int b53_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering)
 {
 	struct b53_device *dev = ds->priv;
-	struct net_device *bridge_dev;
-	unsigned int i;
 	u16 pvid, new_pvid;
 
-	/* Handle the case were multiple bridges span the same switch device
-	 * and one of them has a different setting than what is being requested
-	 * which would be breaking filtering semantics for any of the other
-	 * bridge devices.
-	 */
-	b53_for_each_port(dev, i) {
-		bridge_dev = dsa_to_port(ds, i)->bridge_dev;
-		if (bridge_dev &&
-		    bridge_dev != dsa_to_port(ds, port)->bridge_dev &&
-		    br_vlan_enabled(bridge_dev) != vlan_filtering) {
-			netdev_err(bridge_dev,
-				   "VLAN filtering is global to the switch!\n");
-			return -EINVAL;
-		}
-	}
-
 	b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), &pvid);
 	new_pvid = pvid;
 	if (dev->vlan_filtering_enabled && !vlan_filtering) {
-- 
2.17.1

