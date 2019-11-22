Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790D4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3912068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403052;
	bh=jF9IsxwYOSuw62P1PeeupxUbte4FfaAr0h/JklSur88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zlOK0VRf70STfJosP0xWV8Shw0qaCE8aYhLRYpwnEan84aGtBCJnnhrm7H9Y0iG2q
	 NoIG4fmZqpOay/bkU09t/5OK6/XfwYMC/A2+9xpy1c6yIQpFcxSmP4BqjjjAO+nAie
	 dUm6NVtC97BSNLHmZIJVQ7qefev1pjLDdHh+Ju8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfKVF4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbfKVF4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:56:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 749532070A;
        Fri, 22 Nov 2019 05:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402191;
        bh=jF9IsxwYOSuw62P1PeeupxUbte4FfaAr0h/JklSur88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iv9rLq4oMbS6qeaU5RZidd0yZAUPs49zT6RNefz0Ptj+cKG42CDC4ju8ugx3lekTZ
         6jKiWgJb5XnL6ahCQfmHoGDvJxG1m6SxzKqp2wwukYMiJDMGzJ+st6hsGonEy5dc1R
         bAaG/Aa12HMyv/6IDIoV1RUTDBP2Kj5QBZzpTe5o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 041/127] bnxt_en: query force speeds before disabling autoneg mode.
Date:   Fri, 22 Nov 2019 00:54:19 -0500
Message-Id: <20191122055544.3299-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 4879371ad0c75..fc8e185718a1d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2258,17 +2258,37 @@ static int bnxt_hwrm_mac_loopback(struct bnxt *bp, bool enable)
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

