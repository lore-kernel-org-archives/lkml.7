Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F50C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48882086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FxmLNSsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406019AbfIIUv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 16:51:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39988 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728204AbfIIUv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 16:51:27 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x89KnfaC027339
        for <linux-kernel@vger.kernel.org>; Mon, 9 Sep 2019 13:51:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=5xZuDgxXFkU1bj7orI6uy6eYQF7vmCZw+o4m3LprmoU=;
 b=FxmLNSsxgTNh9mKyPiueOjHG8u/a4SsgJqj+7Lta2tRAP/V6cC5jNcEdu7VfagVpLTfA
 em+XRZF9gJM0oPosM0Ez4v+FAEd3FPhAYWv7p3VHlAqBwfyBQE9bJucvuhScxvGgTP9n
 fT0mK29StUyqiDhbrG5BGQt4EoSiikcDQz0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2uv820ha85-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 13:51:25 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 9 Sep 2019 13:51:24 -0700
Received: by devvm1794.vll1.facebook.com (Postfix, from userid 150176)
        id A7AE321AB8FB; Mon,  9 Sep 2019 13:48:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm1794.vll1.facebook.com
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Vladimir Oltean <olteanv@gmail.com>,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Smtp-Origin-Cluster: vll1c12
Subject: [PATCH net-next v8 1/3] net: phy: modify assignment to OR for dev_flags in phy_attach_direct
Date:   Mon, 9 Sep 2019 13:48:45 -0700
Message-ID: <20190909204845.2190885-1-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-09_07:2019-09-09,2019-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=818
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909090204
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the assignment to OR when dealing with phydev->dev_flags in
phy_attach_direct function, and this is to make sure dev_flags set in
driver's probe callback won't be lost.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>
CC: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Tao Ren <taoren@fb.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Changes:
  - nothing is changed in v1-v7: it's given v8 to align with the version
    of patch series.

 drivers/net/phy/phy_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index d347ddcac45b..8933f07d39e9 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1270,7 +1270,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 			phydev_err(phydev, "error creating 'phy_standalone' sysfs entry\n");
 	}
 
-	phydev->dev_flags = flags;
+	phydev->dev_flags |= flags;
 
 	phydev->interface = interface;
 
-- 
2.17.1

