Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECC3C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E9B2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPGeRtXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfDJA7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:59:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36518 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfDJA5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so823899wrd.3;
        Tue, 09 Apr 2019 17:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ESfryYM/idTx4yNFErYve0hL3+p2MBVMrp6fA9AjOE=;
        b=ZPGeRtXFqrnZ6bbYSj/FsOFHLNL3kWjeTiZ1hY8Oc4CtszdIeOQ27sZA6vKPilVkK8
         smbXR62sRmxQzSkrq3GSDa4Uz2QuIBCmTnqWJOA8tcLM8RcVYkWJPvSrWsr93z7diW8d
         09u1+gf+ftJZzOKKIX233uux/fwTwDrpBBah3ObzHQ3COZ8f2Fn2QpUYihBBen+vavO5
         rhpxVRJ4eSRjQPNr8Vv69MdXG9mGXWyIUpGhpvhiqEBFwvBK4FWRlEpWZOG6dKwRNlIm
         wTHF/AIQFAZe5KRuTKDpDBZlyVYJh8Jlkhkxmo7EFWtBwcu+mJBfFTgn5okHPxhtfhNU
         +W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ESfryYM/idTx4yNFErYve0hL3+p2MBVMrp6fA9AjOE=;
        b=p05NQQrHVWIjPpz6AtOywdGODNbpyxT4nJ4eUyG/nybR5F20GdaprODFdI44TqjvD2
         VEtZGz2CPOHUJrjqur+N4MCWV0L/nK4YmVMLFjw3BoXOvslRY6DD/mLItq23ZDAXOmQH
         BFLaDo/gm+tZNPEqiBPOuq8YS/uM9F1sdfCWQLdp1nGFgQmAAfUD7FxSW0SPYGKr1DkO
         1B5f1mJbVwDvWKFZfhBRl2XT3fAxoK4ehSYck9dY8MxJeXrESINiQmcqnVhIrIhfmpLW
         JRH1uEe/OPTs6RyNZviu0itSYcddehFeDS3FztG8vfYGp6CfLrm/Y8ox4uSgB6gZXdAd
         fDQg==
X-Gm-Message-State: APjAAAWzMkby9yQ2uMBQrvv+19xNcRCxEiIkVwozPc2wRd5/hx1C+42M
        xkUQHv5xR1P+vkIYlHYphXk=
X-Google-Smtp-Source: APXvYqyjdnN99gQnFAFdSxDEyifxL+6/fHLAQP3zXMfW4lboEMKaIYOva7OeVp6OK8KTvaJ2KpCTlg==
X-Received: by 2002:adf:f101:: with SMTP id r1mr3510328wro.251.1554857851622;
        Tue, 09 Apr 2019 17:57:31 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:31 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 10/22] net: dsa: b53: Let DSA handle mismatched VLAN filtering settings
Date:   Wed, 10 Apr 2019 03:56:48 +0300
Message-Id: <20190410005700.31582-11-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
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
Changes in v2:
None

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

