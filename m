Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32790C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019C82064B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNaElmQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLTTYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:24:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32854 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfLTTYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:24:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id z16so5757695pfk.0;
        Fri, 20 Dec 2019 11:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4GzeXdyU3L09d+p6VudM7UCkmXBNG2pSPMa4Qrns3dw=;
        b=kNaElmQqXBu1h0ZJ9fZn3840iQ2aBE1JW7MqpiKPoRgCRSz+bLpeUmE/c01CjnEUuh
         uLiO/GoehagTxaJBKAy6rQZ/evlffqFW5oyyEmTUtHQBa6WX6e+QeXzq/dme65zHmdnn
         DHfIbD31g7bQPNLdSVilGzUdvQPXrroLNmnXgqijyVq1XwSSCZEmDTKcWI8LxGQD0bUD
         q0IgBJIJqmqMq3YBreovkSquXPGUFbsVjTzd2YhpKj/D+R4jHWNGmNJ5ftW8oW+q6O9M
         fJ2NUnkY7y8srKl0ai2/JTfiXlQ5N5cv2kXZNOqIFvQQmwyvdXX4y1TIt0VyT3zFM7rL
         OeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4GzeXdyU3L09d+p6VudM7UCkmXBNG2pSPMa4Qrns3dw=;
        b=b9VG7vNMU3qqlfFXZO8337HknMod/BRzyMklAe6oT6lP08ILL43VPmQb+4Bv8Gtvs1
         5+vmfDVfEQE+JCwAIBXZGHsZcCvoIysnAcTRlQdHSvQZlwgTkJGHwZ/GMS0hCaI2LdT6
         voOM8DfvSNPFchVhDPAn979SePw95XaQahuZOmz1UM8k1sLIAgzElcLvSXpyOxOo9ZeT
         2w2LJ9sIoBQsexrPp4txNA1z/MWGHiwyuZAOV/oxvMGr/LYik++bEFdlMYf7hPJ1vxjD
         ilO+R9BAj0ope+gwe2mzUA3sL/VC1jmkhSgpvOxKoPCVx/vuqbN+AauiXid7OmEoDq1k
         UCNg==
X-Gm-Message-State: APjAAAWAm7xYYHXmmJfgfLY6Tjpk4YXtvDsgJhPLi6ADfBDtOxqenSDN
        XHU0vjrecg2R62YhpEVgudW1ecsS
X-Google-Smtp-Source: APXvYqwW+FV/dL8e+jRz4PHbd08fdx6kfa8PYG+bucCf+fTm8k4sPW22OvuTACHfPISbZFzbkimezg==
X-Received: by 2002:a62:53c3:: with SMTP id h186mr17857785pfb.118.1576869875626;
        Fri, 20 Dec 2019 11:24:35 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u127sm14456133pfc.95.2019.12.20.11.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 11:24:35 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: dsa: bcm_sf2: Fix IP fragment location and behavior
Date:   Fri, 20 Dec 2019 11:24:21 -0800
Message-Id: <20191220192422.22354-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP fragment is specified through user-defined field as the first
bit of the first user-defined word. We were previously trying to extract
it from the user-defined mask which could not possibly work. The ip_frag
is also supposed to be a boolean, if we do not cast it as such, we risk
overwriting the next fields in CFP_DATA(6) which would render the rule
inoperative.

Fixes: 7318166cacad ("net: dsa: bcm_sf2: Add support for ethtool::rxnfc")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/bcm_sf2_cfp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2_cfp.c b/drivers/net/dsa/bcm_sf2_cfp.c
index f3f0c3f07391..1962c8330daa 100644
--- a/drivers/net/dsa/bcm_sf2_cfp.c
+++ b/drivers/net/dsa/bcm_sf2_cfp.c
@@ -358,7 +358,7 @@ static int bcm_sf2_cfp_ipv4_rule_set(struct bcm_sf2_priv *priv, int port,
 		return -EINVAL;
 	}
 
-	ip_frag = be32_to_cpu(fs->m_ext.data[0]);
+	ip_frag = !!(be32_to_cpu(fs->h_ext.data[0]) & 1);
 
 	/* Locate the first rule available */
 	if (fs->location == RX_CLS_LOC_ANY)
@@ -569,7 +569,7 @@ static int bcm_sf2_cfp_rule_cmp(struct bcm_sf2_priv *priv, int port,
 
 		if (rule->fs.flow_type != fs->flow_type ||
 		    rule->fs.ring_cookie != fs->ring_cookie ||
-		    rule->fs.m_ext.data[0] != fs->m_ext.data[0])
+		    rule->fs.h_ext.data[0] != fs->h_ext.data[0])
 			continue;
 
 		switch (fs->flow_type & ~FLOW_EXT) {
@@ -621,7 +621,7 @@ static int bcm_sf2_cfp_ipv6_rule_set(struct bcm_sf2_priv *priv, int port,
 		return -EINVAL;
 	}
 
-	ip_frag = be32_to_cpu(fs->m_ext.data[0]);
+	ip_frag = !!(be32_to_cpu(fs->h_ext.data[0]) & 1);
 
 	layout = &udf_tcpip6_layout;
 	slice_num = bcm_sf2_get_slice_number(layout, 0);
-- 
2.17.1

