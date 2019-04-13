Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD55C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586CA20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZG4RjkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfDMB2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:28:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33809 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfDMB2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so14168894wrq.1;
        Fri, 12 Apr 2019 18:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eKtukLITHjZOFmXH71ClXG5HJG4MwVZ1id0UFReImso=;
        b=NZG4RjkX3e+sMM9IGYcEjcWtxPZAFG0YQOv01tIbS5DhYCa0nCLUfMPbC4xN8iaMIW
         0WE7uRc3ygR4WxK5CMCfcIne0xNxQ8dPSGGRWwRIEEZqyrI2yLVhTn7Om6KucGTAe72M
         qd4BLJQ3oxBIf6+kp8H5C4DSvSNrv8MO36tEiVviq/i09/8oBc0ROhY6sdD+Fu06f3CB
         92KT6bSyICWptgVJ/k+JrpJYbiJwXyBXQeMa3ImCEFl54CUhgGlDW4BUtvvjYdxCZ8g9
         0PhTBpH0RWUWgiNkMGF2oHLH36c7Y+zHL4yEUZwTu32JhS3MjXtQMCJ/JfLAf8hyd0Q+
         QBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eKtukLITHjZOFmXH71ClXG5HJG4MwVZ1id0UFReImso=;
        b=GnXVmYG3C0D3aUf5QI0Zx9WJKPk5/0Qbw5w7gTXfbGfsHvQWYQAlnSM/JZN4L03caT
         UQDZNu+nb3UEWZ+4cblptbcGXAFkGY/0m+g0kBs7JFExaNmTPMYVH4dzpfQuNxSJScK/
         ceE+nl3+cIR+Dj2EfzGUos0B4u/+5W5GA9VLaKSAJd0TBVQkqUcsMImk7bGWga/5vHsa
         3h9f0EdwVVYc5SKGGKw3dKfAsFciXdp/ysPDvoIe8ByAXjXMJlcOFBQ9+v9KTOap1wUp
         0PKHvLBMCYFzTtOBRgYorkTaOaOxwvyC5/BJ7ke+wTmtQKn2ph8gZg/Yv1fLCV7OnUs3
         pCsw==
X-Gm-Message-State: APjAAAWiGRw0T7TItrF/ZAE0K7hnYKG/9lJRyw1sf7+YZXdgz+CiWXbA
        0RPxyWyLFevpK1hMJxORMsy9JN6VcrE=
X-Google-Smtp-Source: APXvYqzvzOS4GQTPGTj0dmm/1dK5G2tZwghZreUctCfWzheN5fD9ZvUjRM7IbI2MkMBmjqU/+Lq+2w==
X-Received: by 2002:adf:db05:: with SMTP id s5mr39546304wri.247.1555118915882;
        Fri, 12 Apr 2019 18:28:35 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:35 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 05/24] net: dsa: Add more convenient functions for installing port VLANs
Date:   Sat, 13 Apr 2019 04:28:03 +0300
Message-Id: <20190413012822.30931-6-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This hides the need to perform a two-phase transaction and construct a
switchdev_obj_port_vlan struct.

Call graph (including a function that will be introduced in a follow-up
patch) looks like this now (same for the *_vlan_del function):

dsa_slave_vlan_rx_add_vid   dsa_port_setup_8021q_tagging
            |                        |
            |                        |
            |          +-------------+
            |          |
            v          v
           dsa_port_vid_add      dsa_slave_port_obj_add
                  |                         |
                  +-------+         +-------+
                          |         |
                          v         v
                       dsa_port_vlan_add

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v3:
Reworked dsa_slave_vlan_rx_kill_vid so that symmetry of the calling
graph is kept with the vlan_add functions.

Changes in v2:
Renamed __dsa_port_vlan_add to dsa_port_vid_add and not to
dsa_port_vlan_add_trans, as suggested, because the corresponding _del function
does not have a transactional phase and the naming is more uniform this way.

 net/dsa/dsa_priv.h |  2 ++
 net/dsa/port.c     | 31 +++++++++++++++++++++++++++++++
 net/dsa/slave.c    | 24 +++---------------------
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 093b7d145eb1..4246523e3133 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -169,6 +169,8 @@ int dsa_port_vlan_add(struct dsa_port *dp,
 		      struct switchdev_trans *trans);
 int dsa_port_vlan_del(struct dsa_port *dp,
 		      const struct switchdev_obj_port_vlan *vlan);
+int dsa_port_vid_add(struct dsa_port *dp, u16 vid, u16 flags);
+int dsa_port_vid_del(struct dsa_port *dp, u16 vid);
 int dsa_port_link_register_of(struct dsa_port *dp);
 void dsa_port_link_unregister_of(struct dsa_port *dp);
 
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 0caf7f9bfb57..029169c2dd3b 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -326,6 +326,37 @@ int dsa_port_vlan_del(struct dsa_port *dp,
 	return 0;
 }
 
+int dsa_port_vid_add(struct dsa_port *dp, u16 vid, u16 flags)
+{
+	struct switchdev_obj_port_vlan vlan = {
+		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
+		.flags = flags,
+		.vid_begin = vid,
+		.vid_end = vid,
+	};
+	struct switchdev_trans trans;
+	int err;
+
+	trans.ph_prepare = true;
+	err = dsa_port_vlan_add(dp, &vlan, &trans);
+	if (err == -EOPNOTSUPP)
+		return 0;
+
+	trans.ph_prepare = false;
+	return dsa_port_vlan_add(dp, &vlan, &trans);
+}
+
+int dsa_port_vid_del(struct dsa_port *dp, u16 vid)
+{
+	struct switchdev_obj_port_vlan vlan = {
+		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
+		.vid_begin = vid,
+		.vid_end = vid,
+	};
+
+	return dsa_port_vlan_del(dp, &vlan);
+}
+
 static struct phy_device *dsa_port_get_phy_device(struct dsa_port *dp)
 {
 	struct device_node *phy_dn;
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index ce26dddc8270..8ad9bf957da1 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1001,13 +1001,6 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 				     u16 vid)
 {
 	struct dsa_port *dp = dsa_slave_to_port(dev);
-	struct switchdev_obj_port_vlan vlan = {
-		.vid_begin = vid,
-		.vid_end = vid,
-		/* This API only allows programming tagged, non-PVID VIDs */
-		.flags = 0,
-	};
-	struct switchdev_trans trans;
 	struct bridge_vlan_info info;
 	int ret;
 
@@ -1024,25 +1017,14 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 			return -EBUSY;
 	}
 
-	trans.ph_prepare = true;
-	ret = dsa_port_vlan_add(dp, &vlan, &trans);
-	if (ret == -EOPNOTSUPP)
-		return 0;
-
-	trans.ph_prepare = false;
-	return dsa_port_vlan_add(dp, &vlan, &trans);
+	/* This API only allows programming tagged, non-PVID VIDs */
+	return dsa_port_vid_add(dp, vid, 0);
 }
 
 static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 				      u16 vid)
 {
 	struct dsa_port *dp = dsa_slave_to_port(dev);
-	struct switchdev_obj_port_vlan vlan = {
-		.vid_begin = vid,
-		.vid_end = vid,
-		/* This API only allows programming tagged, non-PVID VIDs */
-		.flags = 0,
-	};
 	struct bridge_vlan_info info;
 	int ret;
 
@@ -1059,7 +1041,7 @@ static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 			return -EBUSY;
 	}
 
-	ret = dsa_port_vlan_del(dp, &vlan);
+	ret = dsa_port_vid_del(dp, vid);
 	if (ret == -EOPNOTSUPP)
 		ret = 0;
 
-- 
2.17.1

