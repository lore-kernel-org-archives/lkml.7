Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B318DC10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F55820850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQWBb14a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfDMBak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:30:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55268 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfDMB2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so13313895wml.4;
        Fri, 12 Apr 2019 18:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wUSOzkl5O608U569ZFDBqB16t8pm46MnpISgPq0bNuY=;
        b=AQWBb14a67+b1no9oJW0np7ichCGA7Uvdfunt1ENVNgY5TPRCQa53Zxbor7w4f6tCy
         /IfQjy2aa8YGVA8dyIU8pMWUuHiuO6fkA9IMzD887RnTacaIigb5xlQdOb7AsvxTgqd1
         KfbomzIDqrW5EtlBzlAb1MKSK/J4ON1sSGO3Kd45LoYtkWn1PWA6voGsc7pT+rxylgtY
         KhKMlsrWm8vrbPw6fuqieWlrwGLVZ3h+P2q4MtszgnJLbOF1Xr3kePIuX6oJ6O0f4A+/
         jXcyXVYo/Cs0GJZkbh4V+mDodgUBD3GjAkQmrsthCcpJ+5GmXy2ruEkKQlv48QvvTK9/
         jOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wUSOzkl5O608U569ZFDBqB16t8pm46MnpISgPq0bNuY=;
        b=JG8QZfiHizanQEJWNWQrdm47GpqIkessaBPSFT5XVUU+fSi3jnMSt1mU4p5L5EsLZL
         n7zQ/5fMCzVS24kh4Zye0tuv/E74P/Qf0o3LeObo5kqk/9eUSJutzbFVE53NJvpHu9YQ
         0p+Q+NAvu8zJdzaMa/5P1MoCagNF9ARQl8cjnoLF0atZdjwJIU6nMiTuIgV4NsEW9ALE
         qb/y4dY2/6Xs23XULhuyBgnKbJVFjFhYF7/4/xpg6tj6iVoUw2BXtnchOD5qCIE8Ghws
         5ZVcz1mwYte0UWJRl2qmnjYLpf9nw7FCKa63JJtYa361HNfzIH4W8dNxxWPtFgRcuQmg
         tSow==
X-Gm-Message-State: APjAAAX/36gpM9sY0/wmdtamo1SFIFgML6ZcfgazFtLdN2gfrYTj4zHB
        wRAhBa5l7xyOkN9nik+2+KI=
X-Google-Smtp-Source: APXvYqyfs1llFW4TxQcjjr+htg+yRYu05XwJPVeo6WBGjTUgg3HXMBKN3B/1HvWY6cTFaeqF7Or58w==
X-Received: by 2002:a1c:9d4c:: with SMTP id g73mr13021547wme.48.1555118920699;
        Fri, 12 Apr 2019 18:28:40 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:40 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 09/24] net: dsa: b53: Let DSA handle mismatched VLAN filtering settings
Date:   Sat, 13 Apr 2019 04:28:07 +0300
Message-Id: <20190413012822.30931-10-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
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
Changes in v3:
None

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

