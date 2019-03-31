Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DC1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E9320870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCNLlk7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfCaRpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:45:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41058 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbfCaRmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:42:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so8875755wrq.8;
        Sun, 31 Mar 2019 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bBZwwBixeF/Fs0m6UziEqOecYenQFflee0raiIlvWPc=;
        b=sCNLlk7T89sAM7YjfDs59i4AxZTVDW3PNaJfclRhrGO7IiTKuFJ1ca4TfpOJKOc7Gm
         rc8P2TTeHCjcCjJEXKx6Y+3L26Hx9T9cpJysOyJm0vOWyaPdOc2hAyy0N9Hdxs5Z9HnM
         D/jsuK+WHDYDDqytx8TbHGpnOZombkiWYthbuxxfsGaHVHhqTU60jtvXlO+GuriX5+7m
         7pfNc9P90FKBP9hIY5dFampOEMfvHxWfvjqodbYtsB0NKRBHgJhVm5CS0ML2885j7eca
         IHfJvL/xW6GPPLGaEjRIkQZ8n8Z3tkM2LkYdQLad9arlsjXwHCo17ogDr0q2Ooowph0O
         X5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bBZwwBixeF/Fs0m6UziEqOecYenQFflee0raiIlvWPc=;
        b=iQFsNk5a3tCDqPEFD1cCkJTIr3uChdUZbmrdq+2iXk0C2cqJvaIe283O7jM6jj/J9v
         WIuREyjTKrOR5k+XLNPUqRNc6QHT5H+hG/2qO2elF+7D62+uMmZrwCPAwr/LgSrLzRfB
         Jx7GT4oyS7KifYHLQpjfX3kaBUbkCiMOOk0BrfVPS9x67Z3M+waBG/oQKZYIKSfVYDPC
         2+kNgPSAKdNq/ASoTSBI9GuFKywKH2uz2FD7C6cuvb8OvIqTOuO89Pq8CDjLhIgRgOVZ
         YyjshJjODPyFRXT90HceFDcU/bN09VGmiZbs5ImYKJtjEVqZ7s9Ys6QQrzef/BpxhjfU
         nL+Q==
X-Gm-Message-State: APjAAAUU8uHN4iEz3JDkpADNE5rvDnCIWHfl7Ue2sWDr1sSagbeuDp1E
        GPHpTgDDxDjm3UNk7W3guok=
X-Google-Smtp-Source: APXvYqxGw/a4PPJ/DeVIZ3hObhtqdV4OPi4vQmPnQkTJtrGyyR4k8hc6CWB4ZZurvhzlXweUnfTcpA==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr37401037wru.30.1554054173222;
        Sun, 31 Mar 2019 10:42:53 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:42:52 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 03/17] net: dsa: Store vlan_filtering as a property of dsa_port
Date:   Sun, 31 Mar 2019 20:42:18 +0300
Message-Id: <20190331174232.22060-4-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
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

