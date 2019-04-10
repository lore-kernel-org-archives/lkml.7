Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B20C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F196E20874
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArwyMncq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDJA5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:57:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39361 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfDJA5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so798873wrn.6;
        Tue, 09 Apr 2019 17:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9H8bnpVkrE0nOtDJWTPXFmq35hhkom4cnPHeOhOR/2g=;
        b=ArwyMncqIW10Evy8FKqpKpqWOL2Bu4Z6bB2Ni1g7pHtmanEICT3KZQrspF9hGjhAAu
         TSFBPkgvlzR8iI4KE/K0YR3rj9cZ90OciE6kKljamp1MJLH0SCboN3N1ZI6NE4wnyvHR
         PeFkNWKs/VEtjAnuuo33TAZnWKO8Ilkm2JPCOC9sa8iqU/0p8jupdZbp4E/P5MQbnZi9
         BZowMl4xl72jvzhTEbCZvAWnDwGYn22CR7OOVs+PHEKVvz1sfWkFgyoa+5HcDBSwjlSu
         Fcn2hLlATAbx31EelWcCkxNSgTTv+4Y2PsUFsxvp2XgSEMutih73QZJqBSVZm89TE6ZN
         2XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9H8bnpVkrE0nOtDJWTPXFmq35hhkom4cnPHeOhOR/2g=;
        b=QBNH+7t/c+MjNy1GBMml0/xqv6QE/OJHhLqZYwjoqBubd4ESpoe26VhoNX6QKDR4Mz
         xd+3sWo0P0+xBcPA2AHfxSHyVmyh+arj22KD0cTzy1N1PggDfHe0jVkKXmHWDhEa/w06
         Loi2wPgFlwvhovCkXagcjYdSsx1+Q7Zm2mtSs6LN+jAUX96qCcHE/axZYra6YAXEkjSn
         PN+5EdhW9lA0OSg/mb4uF3MyUUHbp9oxf4xex8gpr8Wtvoj2D6fIsMff/JYOxf4MB6ZR
         KGv5CeDE2WOTATwYUwbatEqZzT9vcAfbkFA3SMn3kIRu2HwEkuztMVu99lMI45g50Cfa
         pMeA==
X-Gm-Message-State: APjAAAV0uX1Mk4kOrtJycFpwB37KeZc3dCddioJfhx3cKnOobwrAnDw8
        U1qOSBylU/u96S0mkskfYBs=
X-Google-Smtp-Source: APXvYqzU+j6sVTIyq6vvXOtZFGPhAKd5WpAC7rjegQ5Sl6TX1tULbd1ZrrR484b24K8K9b0Uy7s71A==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr3161885wrt.13.1554857852805;
        Tue, 09 Apr 2019 17:57:32 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:32 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 11/22] net: dsa: Allow drivers to modulate between presence and absence of tagging
Date:   Wed, 10 Apr 2019 03:56:49 +0300
Message-Id: <20190410005700.31582-12-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frames get processed by DSA and redirected to switch port net devices
based on the ETH_P_XDSA multiplexed packet_type handler found by the
network stack when calling eth_type_trans().

The running assumption is that once the DSA .rcv function is called, DSA
is always able to decode the switch tag in order to change the skb->dev
from its master.

However there are tagging protocols (such as the new
DSA_TAG_PROTO_SJA1105) where this assumption is not completely true,
since switch tagging piggybacks on the absence of a vlan_filtering
bridge.

Having DSA receive untagged traffic would put it in an impossible
situation: the eth_type_trans() function would invoke the DSA .rcv(),
which could not change skb->dev, then eth_type_trans() would be invoked
again, which again would call the DSA .rcv, and the packet would never
be able to exit the DSA filter and would spiral in a loop until the
whole system dies.

This happens because eth_type_trans() doesn't actually look at the skb
(so as to identify a potential tag) when it deems it as being
ETH_P_XDSA. It just checks whether skb->dev has a DSA private pointer
installed (therefore it's a DSA master) and that there exists a .rcv
callback (everybody except DSA_TAG_PROTO_NONE has that). This is
understandable as there are many switch tags out there, and exhaustively
checking for all of them is far from ideal.

The solution lies in the observation that a more nuanced check can be
made when eth_type_trans() determines that switch tagging is used or
not. In a way, this reverts patch "717ffbfb28ac net: dsa: remove
dsa_uses_tagged_protocol", but instead of adding it back as a DSA
function, it is now a boolean property. This is because the driver might
actually know better when it can and can't support switch tagging.

With this patch, all tagging protocols can morph at runtime into the
DSA_TAG_PROTO_NONE on receive, by setting cpu_dp->uses_tag_protocol = 0.
This permits them to at least terminate traffic through the master net
device. Their .rcv callback no longer even gets called in this mode.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v2:
Patch is new.

 include/net/dsa.h | 8 +++++++-
 net/dsa/dsa2.c    | 7 +++++++
 net/dsa/legacy.c  | 7 +++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 91375bcf2cfb..97325a412156 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -156,6 +156,12 @@ struct dsa_port {
 	 * Original copy of the master netdev net_device_ops
 	 */
 	const struct net_device_ops *orig_ndo_ops;
+
+	/* Property used to allow traffic at runtime to bypass the DSA
+	 * filter in eth_type_trans and be processed as regular on the
+	 * master net device.
+	 */
+	bool			uses_tag_protocol;
 };
 
 struct dsa_switch {
@@ -502,7 +508,7 @@ struct net_device *dsa_dev_to_net_device(struct device *dev);
 static inline bool netdev_uses_dsa(struct net_device *dev)
 {
 #if IS_ENABLED(CONFIG_NET_DSA)
-	return dev->dsa_ptr && dev->dsa_ptr->rcv;
+	return dev->dsa_ptr && dev->dsa_ptr->uses_tag_protocol;
 #endif
 	return false;
 }
diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index f4277ee314da..e800bbf9d183 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -585,6 +585,13 @@ static int dsa_port_parse_cpu(struct dsa_port *dp, struct net_device *master)
 	dp->tag_ops = tag_ops;
 	dp->master = master;
 	dp->dst = dst;
+	/* Initially tell DSA to filter all traffic on the master net
+	 * device in eth_type_trans unconditionally if we have a
+	 * packet_type handler (true for all tagging protocols except
+	 * DSA_TAG_PROTO_NONE). Then drivers can later change this
+	 * property.
+	 */
+	dp->uses_tag_protocol = !!dp->rcv;
 
 	return 0;
 }
diff --git a/net/dsa/legacy.c b/net/dsa/legacy.c
index cb42939db776..6450c2deded9 100644
--- a/net/dsa/legacy.c
+++ b/net/dsa/legacy.c
@@ -161,6 +161,13 @@ static int dsa_switch_setup_one(struct dsa_switch *ds,
 		/* Few copies for faster access in master receive hot path */
 		dst->cpu_dp->rcv = dst->cpu_dp->tag_ops->rcv;
 		dst->cpu_dp->dst = dst;
+		/* Initially tell DSA to filter all traffic on the master net
+		 * device in eth_type_trans unconditionally if we have a
+		 * packet_type handler (true for all tagging protocols except
+		 * DSA_TAG_PROTO_NONE). Then drivers can later change this
+		 * property.
+		 */
+		dst->cpu_dp->uses_tag_protocol = !!dst->cpu_dp->rcv;
 	}
 
 	memcpy(ds->rtable, cd->rtable, sizeof(ds->rtable));
-- 
2.17.1

