Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC118C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757592087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WQs3glU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbfCAKyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:54:49 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:47764 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfCAKyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:54:35 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 709A410C13CD;
        Fri,  1 Mar 2019 02:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551437675; bh=+qkyc0CyFIH9yhruqAuRAEm2ZTxuVrD3lHzUlt67mpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=WQs3glU+tz0bGK8R8Wr2lrB1XnGZhFNfjDbkWjSMHbqgVfa/Cc0XLZHwgKuCiuP9S
         /TcsAoF5YOqHB1cDMxXFPUJ2jueSWrHVTN+aU8LIbS4wKEiveXPndxUq+EzkTL1TKS
         e0N3whO36xp+WcGL4dLw0BsRcRAySrPDYKVYyEoWQopesHiC4TxYnjgEVC0AVVGXzV
         xSCowr3Dpjc5dyHIrMNGH4/3tr5GmCXeWruKk2TDmFy2X3s5UnxRK0ZKwbiMTnUzvt
         9lh00xuIan5M47wTdqo4/q6jyLWhwWB01PEZXVgK/VvDN6cw1UBcFIXFC4nZQRDXKC
         7GrbBzLe0+PtA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 13037501E;
        Fri,  1 Mar 2019 02:54:33 -0800 (PST)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: [PATCH net 1/2] net: phy: Use C45 Helpers in phy_read_status()
Date:   Fri,  1 Mar 2019 11:54:23 +0100
Message-Id: <27b3e9f2318c87aac928165b8dfe7d98e272f3d1.1551437561.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1551437561.git.joabreu@synopsys.com>
References: <cover.1551437561.git.joabreu@synopsys.com>
In-Reply-To: <cover.1551437561.git.joabreu@synopsys.com>
References: <cover.1551437561.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently phy_read_status() considers that either the PHY driver has the
read_status() callback or uses the generic callback.

For C45 PHYs we need to use the gen10g_read_status() callback.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Joao Pinto <joao.pinto@synopsys.com>
---
 include/linux/phy.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 333b56d8f746..872899136fdc 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1030,6 +1030,8 @@ static inline int phy_read_status(struct phy_device *phydev)
 
 	if (phydev->drv->read_status)
 		return phydev->drv->read_status(phydev);
+	else if (phydev->is_c45)
+		return gen10g_read_status(phydev);
 	else
 		return genphy_read_status(phydev);
 }
-- 
2.7.4

