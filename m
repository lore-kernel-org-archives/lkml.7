Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2EAC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A0720850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCdxEQLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfDMB2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:28:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36929 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfDMB2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so13005837wmf.2;
        Fri, 12 Apr 2019 18:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mRyDydjM/0jLstVpogiOU2WllXY8Mx2/SEIAR0LYjQQ=;
        b=lCdxEQLyzdZ+Q7JnBHenfxMQTUJaNDd1DBnydWIieYUTKmh1JZ/TwFM5Kmko/otWk1
         Gr4rTtLREsraNuCCuxstuxp33y1FFNBsMmfpWiYtwqNd25uZo96LhmdJGvns/NyJ9UPu
         uKodS9Aozf9Qdu1fzksuaXq4J8BdrbrceSpjt502ZeNDRXELZZg+Hwxfin4AyvKxNHKH
         fnxqlMd9wXw3NySQEED8f876Rhhr24yHXol0lBQum5LUbckmd44CTZBe5dRemWjLM2MV
         fulFL8BXFl9E3WVsRoTZA4tTCdyQYFZb7ewPAPJYst+ldZw4zdgkEeNIhFYJV8k/3pqr
         xtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mRyDydjM/0jLstVpogiOU2WllXY8Mx2/SEIAR0LYjQQ=;
        b=A/YOQOY549XoSOI0ZqLmq4DomcMHAVyjpyvLpxslbshmyFiYq+Zt5Y9TkTU0fdkyea
         U+DmasgLqVHkuXK/pmvm2Gx7jSsNioOtBXkxW38Pbe0gjG+M68LQ5DDrbtspB9pBy75C
         kzFh6Nznw6Pv5i46pLAzRFJc+uDNIQYexmQ6qHVikfpKNb1DCk/eD6Iw8aNCqXHNdNyT
         tDrsbrnkQvs6GFtMMFLGXfKcN0Iaiay+gfPWgYASxJxgetSaAHZ7jD0NZfpOxbac8dMX
         kbFExmQEKvTMYjOLp7mWnet4plWAhHTk0M9CZah2bflQdAIYKODUSBDhA5K39xqTuHx4
         gT7w==
X-Gm-Message-State: APjAAAV0LLcAOCqaU0RZLkvNiCgCMSsnCuFJlfttaveAiLburj1oqpz4
        DX32eJFyvXpvkwEMojPJ/rHsn3+pb7s=
X-Google-Smtp-Source: APXvYqweb8ZnSlNzgXre2H4B/K0SQ7D50wTn4s+jS/0ul8+DJhP1kKjYf7ihklG0c7uXdA0O1tUvyw==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr13720599wme.29.1555118921873;
        Fri, 12 Apr 2019 18:28:41 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:41 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 10/24] net: dsa: Unset vlan_filtering when ports leave the bridge
Date:   Sat, 13 Apr 2019 04:28:08 +0300
Message-Id: <20190413012822.30931-11-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ports are standalone (after they left the bridge), they should have
no VLAN filtering semantics (they should pass all traffic to the CPU).
Currently this is not true for switchdev drivers, because the bridge
"forgets" to unset that.

Normally one would think that doing this at the bridge layer would be a
better idea, i.e. call br_vlan_filter_toggle() from br_del_if(), similar
to how nbp_vlan_init() is called from br_add_if().

However what complicates that approach, and makes this one preferable,
is the fact that for the bridge core, vlan_filtering is a per-bridge
setting, whereas for switchdev/DSA it is per-port. Also there are
switches where the setting is per the entire device, and unsetting
vlan_filtering one by one, for each leaving port, would not be possible
from the bridge core without a certain level of awareness. So do this in
DSA and let drivers be unaware of it.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v3:
Patch is new.

 net/dsa/switch.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index 03b8d8928651..7d8cd9bc0ecc 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -72,6 +72,9 @@ static int dsa_switch_bridge_join(struct dsa_switch *ds,
 static int dsa_switch_bridge_leave(struct dsa_switch *ds,
 				   struct dsa_notifier_bridge_info *info)
 {
+	bool unset_vlan_filtering = br_vlan_enabled(info->br);
+	int err, i;
+
 	if (ds->index == info->sw_index && ds->ops->port_bridge_leave)
 		ds->ops->port_bridge_leave(ds, info->port, info->br);
 
@@ -79,6 +82,31 @@ static int dsa_switch_bridge_leave(struct dsa_switch *ds,
 		ds->ops->crosschip_bridge_leave(ds, info->sw_index, info->port,
 						info->br);
 
+	/* If the bridge was vlan_filtering, the bridge core doesn't trigger an
+	 * event for changing vlan_filtering setting upon slave ports leaving
+	 * it. That is a good thing, because that lets us handle it and also
+	 * handle the case where the switch's vlan_filtering setting is global
+	 * (not per port). When that happens, the correct moment to trigger the
+	 * vlan_filtering callback is only when the last port left this bridge.
+	 */
+	if (unset_vlan_filtering && ds->vlan_filtering_is_global) {
+		for (i = 0; i < ds->num_ports; i++) {
+			if (i == info->port)
+				continue;
+			if (dsa_to_port(ds, i)->bridge_dev == info->br) {
+				unset_vlan_filtering = false;
+				break;
+			}
+		}
+	}
+	if (unset_vlan_filtering) {
+		struct switchdev_trans trans = {0};
+
+		err = dsa_port_vlan_filtering(&ds->ports[info->port],
+					      false, &trans);
+		if (err && err != EOPNOTSUPP)
+			return err;
+	}
 	return 0;
 }
 
-- 
2.17.1

