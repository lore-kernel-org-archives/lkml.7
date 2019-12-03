Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F90C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5ED20848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413467;
	bh=CNp5Bv0TclL9MKLcrB14tMvBBV+oreR/zTbo2XPb6NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zzMOmiuy30QTyp0CrzjInVyRScHKD2Qa7HF1qNnbj9KVE1pXkZKnqe/MYTyuL8FW9
	 /0u9avTJjDWf2Hy6a+kRn+PJWV/E0+LDqe+DXFw1RN3YlXJn0VgQeufXONbCnR9zYb
	 j8+m25wEix5d0W7gokhkkYUvP+OvZ3yfJiCQ9tNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfLCWvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729823AbfLCWvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:51:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2B32054F;
        Tue,  3 Dec 2019 22:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413462;
        bh=CNp5Bv0TclL9MKLcrB14tMvBBV+oreR/zTbo2XPb6NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHDexBGrpGCUY1JsnYgow4+Dwlqf9y1q0zFHCmb76YabyzcCDj6SFjCsDXgMRA3dh
         Tc86LwdCz7/nX9TfVsiMP2c/mocBWE8Y4ZmZ+Bgk9ZVBuw9QKetWIp2AiUUGpEozYH
         icoLh41ySsRwk7S797bAWyJ/uyNiv0eCUzz0Ol7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 138/321] bnxt_en: query force speeds before disabling autoneg mode.
Date:   Tue,  3 Dec 2019 23:33:24 +0100
Message-Id: <20191203223434.340912492@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit 56d374624778652d2a999e18c87a25338b127b41 ]

With autoneg enabled, PHY loopback test fails. To disable autoneg,
driver needs to send a valid forced speed to FW. FW is not sending
async event for invalid speeds. To fix this, query forced speeds
and send the correct speed when disabling autoneg mode.

Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index eaa285bf908b9..2240c23b0a4c9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2390,17 +2390,37 @@ static int bnxt_hwrm_mac_loopback(struct bnxt *bp, bool enable)
 	return hwrm_send_message(bp, &req, sizeof(req), HWRM_CMD_TIMEOUT);
 }
 
+static int bnxt_query_force_speeds(struct bnxt *bp, u16 *force_speeds)
+{
+	struct hwrm_port_phy_qcaps_output *resp = bp->hwrm_cmd_resp_addr;
+	struct hwrm_port_phy_qcaps_input req = {0};
+	int rc;
+
+	bnxt_hwrm_cmd_hdr_init(bp, &req, HWRM_PORT_PHY_QCAPS, -1, -1);
+	mutex_lock(&bp->hwrm_cmd_lock);
+	rc = _hwrm_send_message(bp, &req, sizeof(req), HWRM_CMD_TIMEOUT);
+	if (!rc)
+		*force_speeds = le16_to_cpu(resp->supported_speeds_force_mode);
+
+	mutex_unlock(&bp->hwrm_cmd_lock);
+	return rc;
+}
+
 static int bnxt_disable_an_for_lpbk(struct bnxt *bp,
 				    struct hwrm_port_phy_cfg_input *req)
 {
 	struct bnxt_link_info *link_info = &bp->link_info;
-	u16 fw_advertising = link_info->advertising;
+	u16 fw_advertising;
 	u16 fw_speed;
 	int rc;
 
 	if (!link_info->autoneg)
 		return 0;
 
+	rc = bnxt_query_force_speeds(bp, &fw_advertising);
+	if (rc)
+		return rc;
+
 	fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_1GB;
 	if (netif_carrier_ok(bp->dev))
 		fw_speed = bp->link_info.link_speed;
-- 
2.20.1



