Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25806C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E526A20874
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dREXYzE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDJA5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:57:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53158 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDJA5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so658621wma.2;
        Tue, 09 Apr 2019 17:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=szMqoxzNugzLC2Wf+rjWCAWM3zJ+UmhbNzpRfhtDUPE=;
        b=dREXYzE1HmmeXzPE3R/09aeZEARPdESH974sATAKebHzvn+5pzIROPf3pCQh7KvjKy
         ZO2wvoRdtLCMAmRJLYoB3c6Qog965SJcI3AAiziMJJiO7lHWp5K+zQXKnP1IlS7JwTsj
         vivaHFmVR/fZ7sHpQ0GN9chwRBhxQ1JiigMcYqenT/gRCjtXiYwmlq1rAABEr+iQGW7o
         hRmQEAV/G0uzEP19otUMRQDm+IrNNEq+b4VNap96uJ8ciEdeOs8T4X04fR9TKlJCt2yB
         Ogn9gAiiFdYcLyqizBnuaUqf4JRaEhnK8/f+NI6FxCXkWgGv7y33Sp13dLS/PmqWChfl
         Fzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=szMqoxzNugzLC2Wf+rjWCAWM3zJ+UmhbNzpRfhtDUPE=;
        b=f5wmYAsGj4p9CluLqoAzkGjRbKhDmvGfYKoy8lJfNclsQI7FZtRvs3dxrkRYDJhSLj
         JmO+T9PCdF2/0Ac2hv3SeeUh//n9tVks6MaQMRYyrnD8lP2JaQgMqZFAFtA6gM6dz3Uf
         7P2g1F386EyFmnKAGSngQwqrbocxkBSbeiay8IiZOS3q7cTe35jFDIEiJyg8u+sWIEiN
         ElvMWbcLxjQMs/zrrdsp6rkDTdHr6/WabmBJJDeUdZTrTFGsXJ4Qt+2z4DVSKPabmpuC
         5Hf1DiX6/HGPnw1YI8KdDDjz4Zj5MHgu7RJtgcXx6fuHQcHm7wi7HYH+uJaavBXd5Hbp
         IkCg==
X-Gm-Message-State: APjAAAUwtLXvn9PhDye7r25ywYB6wZxKjW3LgPJxUabb618qKR0mKLSs
        f2evgJQfcAFJ7M3lBCzRUBMaJxtS5og=
X-Google-Smtp-Source: APXvYqzqoAyzml6W+aTTLQO4X9jDDgSi051PrQL1eIx3e25gwMhEzwbXalzjy/kKwMUtmP8rIGsTvw==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr667189wmk.9.1554857843004;
        Tue, 09 Apr 2019 17:57:23 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:22 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 03/22] net: dsa: Store vlan_filtering as a property of dsa_port
Date:   Wed, 10 Apr 2019 03:56:41 +0300
Message-Id: <20190410005700.31582-4-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
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
Changes in v2:
None

 include/net/dsa.h |  1 +
 net/dsa/port.c    | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index ae480bba11f5..a16fd577349b 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -142,6 +142,7 @@ struct dsa_port {
 	const struct dsa_port	*cpu_dp;
 	struct device_node	*dn;
 	unsigned int		ageing_time;
+	bool			vlan_filtering;
 	u8			stp_state;
 	struct net_device	*bridge_dev;
 	struct devlink_port	devlink_port;
diff --git a/net/dsa/port.c b/net/dsa/port.c
index caeef4c99dc0..a86fe3be1261 100644
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

