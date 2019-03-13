Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A49C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03640217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504558;
	bh=pN/6CRpBPzhI5WdVYHcwWCgFonE/1uYZpryVkXrwPVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QRsJd7CyVG5p6+GsJbcGBkRAouvwhSbSAbg3a/UwoAipTJA9ZcIYvkrBDq6/hwoKc
	 BCjoxRHLijz+0IvomOSiMB//qS9jHHTRV3sl5n9EXim8cRTLpAtb8SKBjGZYxHJyuF
	 tjdLck5cUwocmRIYs8srsEhywWwcv5gsWgKG9PAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfCMTP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbfCMTPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:15:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D7A12171F;
        Wed, 13 Mar 2019 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504552;
        bh=pN/6CRpBPzhI5WdVYHcwWCgFonE/1uYZpryVkXrwPVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxhICxbnT++zPWXtzvz1tVw/2sYl+5hdzV2A8DNgKSSj8F+Epu8px+YYFJ7/a1/6o
         Q1w0KQPXRHuM1eewAjRHylB1z1Xd4n+eNQb4irYJmSRy9NaCAi9hYXIsPcCTYMYrh7
         /BOHooeOsInsc0F1ztLCIEoTsKelJLv9Xs9T5sz8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 16/33] qed: Fix iWARP syn packet mac address validation.
Date:   Wed, 13 Mar 2019 15:14:49 -0400
Message-Id: <20190313191506.159677-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191506.159677-1-sashal@kernel.org>
References: <20190313191506.159677-1-sashal@kernel.org>
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
index eb666877d1aa..bb09f5a9846f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -1651,6 +1651,15 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *p_hwfn,
 
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

