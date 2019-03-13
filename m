Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEB1C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC84E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505286;
	bh=8sB01o3GUid3gNasrcMg9mFLCrQ100U/3nsJOZkaYdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jb13HEDxNUoyOYr62DpRfFJf7fN77/mlE2940rBACrPWO/1iKJ3AmBw0wdNpLWg3F
	 WPMbs+60rhRIHQJiuKXeUCOyaIaRnVOd+56aBRnjXDGxXdPGEKUbkqHFBU+cA0TUdg
	 4lQRlfcDNpkDh9qDfpTAwrX7gK2+Wyhf6vjUpwUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfCMTNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727583AbfCMTNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:13:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CACA2213A2;
        Wed, 13 Mar 2019 19:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504428;
        bh=8sB01o3GUid3gNasrcMg9mFLCrQ100U/3nsJOZkaYdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AD+ku/t8RPX0LDNrEGWMwJrndYDwJZ0+tScro3a02IYyGLxgudZqizi48HlSIwhU3
         015bXuXVcgp3VMyWVngwjPHDK+nc/ThiNbI5MGZ5RI4KMoEJrxcGImDO7d1/24FI+r
         piluMgmOrK8YaRPCAJWo620+CywPhKtEcXTQ+Ycg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/48] qed: Fix iWARP syn packet mac address validation.
Date:   Wed, 13 Mar 2019 15:12:24 -0400
Message-Id: <20190313191250.158955-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kalderon <michal.kalderon@marvell.com>

[ Upstream commit 8be3dadf04050c2907760ec1955ca1c8fbc25585 ]

The ll2 forwards all syn packets to the driver without validating the mac
address. Add validation check in the driver's iWARP listener flow and drop
the packet if it isn't intended for the device.

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index 3c932f79a02e..b7471e48db7b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -1689,6 +1689,15 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *p_hwfn,
 
 	eth_hlen = ETH_HLEN + (vlan_valid ? sizeof(u32) : 0);
 
+	if (!ether_addr_equal(ethh->h_dest,
+			      p_hwfn->p_rdma_info->iwarp.mac_addr)) {
+		DP_VERBOSE(p_hwfn,
+			   QED_MSG_RDMA,
+			   "Got unexpected mac %pM instead of %pM\n",
+			   ethh->h_dest, p_hwfn->p_rdma_info->iwarp.mac_addr);
+		return -EINVAL;
+	}
+
 	ether_addr_copy(remote_mac_addr, ethh->h_source);
 	ether_addr_copy(local_mac_addr, ethh->h_dest);
 
-- 
2.19.1

