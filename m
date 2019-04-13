Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80CEC10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A1720850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npowlz4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfDMB2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:28:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40160 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfDMB2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so14133480wre.7;
        Fri, 12 Apr 2019 18:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SHATglJ6j5lGFJK1PiOPsQxb5iX443+qb+GkW8Hd9S0=;
        b=Npowlz4BLFF4Drx8LU5oW3G2XujaH2O8rXr+IzDT+/enG/uyYiuRDMkitHauShLJYH
         a2rTdY8hFjCSGUzy5BGGndxHbisX1iQNWrVzAZ55CCrP8FoeiPeI3nj0QIPQ4SXvxLkH
         UcXQalkEBUWPtvxXjjqbuqQvF9TWU+Z98XMHTuAD4UXn3QwrYoEVav1aQggkEoSguLkd
         QhrPcYFkaG+7kDXm6PXdsj6nbo7Db1+dd38NP6V1AKja9PBaNZXGAib8f/6GPU5tS+hy
         ux/wUXTwLvkZu+Xt3yTCF6jsHxFt03wcF7X1CdkyhMWd99nnvfi/Fh76UiD0Iv5KnuyO
         aZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SHATglJ6j5lGFJK1PiOPsQxb5iX443+qb+GkW8Hd9S0=;
        b=l0v+VZ7TyvS9mS1VF09QUXx31HDJjSmzL9W+U1NQERMm5GM6onb3VqexKnk/e6J1ZW
         6NrixCZz50H3yvbeYzxzDd7gtDj94RrFr2GefiEBSHQJSkuS2Gkc7vxCGP+UUS/zgS4Z
         h0/6gUhZwV+gvKgUUcRxrvKkyZzz3a9iGSwERpCTuouCHn0hV7jZFhK4uu3ZHaNq6SGx
         yHlDWcPUSyreZk3TyZydaGxq6jflNZNafyX5yXMYqiMaOtfRG3CT35LzcP8j1pQMOQTU
         MAYFE/wQHNly91HUqMKZNGf0S+tiiY1Nm3tdMBtQBTZhafU4C9hrbkXjbwC5IEAEoOqs
         pkTg==
X-Gm-Message-State: APjAAAXC9JnYByNcwiBUOKaPVi8s28uK2pAGOJi+pVO4IeZGAdqM8fud
        UsHbE2EvUeKGUQlCfBqTdn4=
X-Google-Smtp-Source: APXvYqxJhsPqqTdX8rtjp68fqLsThc7EeJ11XcGrv4qSttKEG35NSr9Y7ouH0HZKzfa0sjmrwdw5qw==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr36950845wrv.70.1555118913526;
        Fri, 12 Apr 2019 18:28:33 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:32 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 03/24] net: dsa: Store vlan_filtering as a property of dsa_port
Date:   Sat, 13 Apr 2019 04:28:01 +0300
Message-Id: <20190413012822.30931-4-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows drivers to query the VLAN setting imposed by the bridge
driver directly from DSA, instead of keeping their own state based on
the .port_vlan_filtering callback.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
None

Changes in v2:
None

 include/net/dsa.h |  1 +
 net/dsa/port.c    | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 0cfc2f828b87..e8f7a6302a38 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -143,6 +143,7 @@ struct dsa_port {
 	const char		*mac;
 	struct device_node	*dn;
 	unsigned int		ageing_time;
+	bool			vlan_filtering;
 	u8			stp_state;
 	struct net_device	*bridge_dev;
 	struct devlink_port	devlink_port;
diff --git a/net/dsa/port.c b/net/dsa/port.c
index ea848596afe3..0caf7f9bfb57 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -158,15 +158,19 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct switchdev_trans *trans)
 {
 	struct dsa_switch *ds = dp->ds;
+	int err;
 
 	/* bridge skips -EOPNOTSUPP, so skip the prepare phase */
 	if (switchdev_trans_ph_prepare(trans))
 		return 0;
 
-	if (ds->ops->port_vlan_filtering)
-		return ds->ops->port_vlan_filtering(ds, dp->index,
-						    vlan_filtering);
-
+	if (ds->ops->port_vlan_filtering) {
+		err = ds->ops->port_vlan_filtering(ds, dp->index,
+						   vlan_filtering);
+		if (err)
+			return err;
+		dp->vlan_filtering = vlan_filtering;
+	}
 	return 0;
 }
 
-- 
2.17.1

