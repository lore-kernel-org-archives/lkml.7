Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D14C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C643A20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4jYkWc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbfCAShl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:37:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36751 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfCAShk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:37:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so11815688pfa.3;
        Fri, 01 Mar 2019 10:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=drKF7dhed4X2Aym/ocLahh9cnaxLNH4t9byfpOh0/Qs=;
        b=b4jYkWc5OkJ+joevwyW7qXRr2gly/hGB/FOeCzVXH5iOCyFjmE2D+fZB6adj3kCe4X
         9lgA81dr5DMPtsVG50tbZS/DaRFkQhZ4CPjc6AEJ9CMSeILWyhs7xzAIg4dCMeuePQXD
         2fzuf0Y/WuepuSSzlygGT1AjPeX1BADlJNOqBmHBQhGFhqm8DZWzGMEMXXs2WQf2UUf8
         T4LG5PuT6zPepAVi+JPeNK8CwVkAnPKF6xXiKvbFFNXy1OVEQMWE1WK8LIrrFh4BIIPR
         urfLKFyD1KDCAFde1uNHMA9pmLJP4p0fvTG4emySZUmdsBFJ4VPWjKQu2/cSngP36hqu
         VRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=drKF7dhed4X2Aym/ocLahh9cnaxLNH4t9byfpOh0/Qs=;
        b=rDjSS2f57Z6JKh5UqkCeyL9nq3E0i/b74znhgoyqX2r0aQbe/3lU/FSTMAc8JtktlQ
         aTb031/LwAqWjp6y4exnNs//TgvbXzutmDx1JCse/jordslJO+hWjTR+OPZdybZL0m5W
         wOahfheV4GAwDNvu+ympQjgHMQFBzPtjjMgLew0z1189yjBDPYU+ppQG3GQbf1PK7KiB
         tam9XV9YHOYvy6+d7sDJlsjrobaoW1bfTQW5PoFJp5P6W2keb6S9/H+vA+LlLHs6bEws
         8f5Ic/LOgEQzlL5HNUnUoQUcy/Boj5dtTI7tIKVTl/ENVKVJUosGneg1VPnlf8w7H8zt
         t2sg==
X-Gm-Message-State: APjAAAWEemFC/cHEtFTuS91liRGsYkIcXbCHX2NOmO5WUr4hjfoNgmQ6
        lc5iHg8DL+OQdZoyv9OtovAdxcg/
X-Google-Smtp-Source: AHgI3IaEzb2ICh026CIiowwwX3S0aqwq7t5Tzt9fEmwE7Te0qaICX+TNESrYo88N84a+PUzzbUNPdg==
X-Received: by 2002:a62:e214:: with SMTP id a20mr6833948pfi.192.1551465459127;
        Fri, 01 Mar 2019 10:37:39 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v1sm31029543pff.9.2019.03.01.10.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 10:37:33 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] net: dsa: Use prepare/commit phase in dsa_slave_vlan_rx_add_vid()
Date:   Fri,  1 Mar 2019 10:37:25 -0800
Message-Id: <20190301183726.30900-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were skipping the prepare phase which causes some problems with at
least a couple of drivers:

- mv88e6xxx chooses to skip programming VID = 0 with -EOPNOTSUPP in
  the prepare phase, but we would still try to force this VID since we
  would only call the commit phase and so we would get the driver to
  return -EINVAL instead

- qca8k does not currently have a port_vlan_add() callback implemented,
  yet we would try to call that unconditionally leading to a NPD

Fix both issues by conforming to the current model doing a
prepare/commit phase, this makes us consistent throughout the code and
assumptions.

Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Reported-by: Michal Vokáč <michal.vokac@ysoft.com>
Fixes: 061f6a505ac3 ("net: dsa: Add ndo_vlan_rx_{add, kill}_vid implementation")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 1808a2cd6872..093eef6f2599 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -993,6 +993,7 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 		/* This API only allows programming tagged, non-PVID VIDs */
 		.flags = 0,
 	};
+	struct switchdev_trans trans;
 	struct bridge_vlan_info info;
 	int ret;
 
@@ -1009,11 +1010,13 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 			return -EBUSY;
 	}
 
-	ret = dsa_port_vlan_add(dp, &vlan, NULL);
+	trans.ph_prepare = true;
+	ret = dsa_port_vlan_add(dp, &vlan, &trans);
 	if (ret == -EOPNOTSUPP)
-		ret = 0;
+		return 0;
 
-	return ret;
+	trans.ph_prepare = false;
+	return dsa_port_vlan_add(dp, &vlan, &trans);
 }
 
 static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
-- 
2.17.1

