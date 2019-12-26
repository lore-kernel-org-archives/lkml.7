Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B782EC2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F79206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 15:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLZPEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 10:04:38 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:58751 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfLZPEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 10:04:38 -0500
Received: from localhost.localdomain ([90.40.29.152])
        by mwinf5d81 with ME
        id if4V2100M3Gv28S03f4V7d; Thu, 26 Dec 2019 16:04:36 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 26 Dec 2019 16:04:36 +0100
X-ME-IP: 90.40.29.152
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linux-net-drivers@solarflare.com, ecree@solarflare.com,
        mhabets@solarflare.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] sfc: avoid duplicate error handling code in 'efx_ef10_sriov_set_vf_mac()'
Date:   Thu, 26 Dec 2019 16:02:24 +0100
Message-Id: <20191226150224.8701-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'eth_zero_addr()' is already called in the error handling path. This is
harmless, but there is no point in calling it twice, so remove one.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/sfc/ef10_sriov.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10_sriov.c b/drivers/net/ethernet/sfc/ef10_sriov.c
index 52bd43f45761..14393767ef9f 100644
--- a/drivers/net/ethernet/sfc/ef10_sriov.c
+++ b/drivers/net/ethernet/sfc/ef10_sriov.c
@@ -522,10 +522,9 @@ int efx_ef10_sriov_set_vf_mac(struct efx_nic *efx, int vf_i, u8 *mac)
 
 	if (!is_zero_ether_addr(mac)) {
 		rc = efx_ef10_vport_add_mac(efx, vf->vport_id, mac);
-		if (rc) {
-			eth_zero_addr(vf->mac);
+		if (rc)
 			goto fail;
-		}
+
 		if (vf->efx)
 			ether_addr_copy(vf->efx->net_dev->dev_addr, mac);
 	}
-- 
2.20.1

