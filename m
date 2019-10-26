Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA44ECA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AB2206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096752;
	bh=Bw+3inR4gFpPut2zAV1narDpoGAN/nMUFG1hkJV4n28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KbtMBUHeTd5h/tV/qqAXcsUlvPRcrsmnRlrtiwqtbo2jU0VZLNqMUojf+j/UyLaly
	 hxXVTMTJVBAU4y2pRd2dZsP0N+BrE2dHu6hspfPx/lKbrbdeSiToX2QlWOEvQchW5Y
	 CAJ2cOg+ohKfaM5gyRM0e5b+n6RWbF7pZdALJ0qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfJZNcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfJZNSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:18:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73C9021871;
        Sat, 26 Oct 2019 13:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095913;
        bh=Bw+3inR4gFpPut2zAV1narDpoGAN/nMUFG1hkJV4n28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvLDaU4SS8qITtI5s8HpcULC4RtfaZOjHaRzhiwuxhqFLYc8yzGFeIw+jQX06pB/C
         B1cQm0Bol8Vt73xi9xFI6dK3IJr/DWF26CaMqqhXZUHdRkIvgQhFbPAngPxEqHk4Vr
         /z7NMLkStMTimNCN/MVecDx254wR+tDl2uWZqYEc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florin Chiculita <florinlaurentiu.chiculita@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 85/99] dpaa2-eth: add irq for the dpmac connect/disconnect event
Date:   Sat, 26 Oct 2019 09:15:46 -0400
Message-Id: <20191026131600.2507-85-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florin Chiculita <florinlaurentiu.chiculita@nxp.com>

[ Upstream commit 8398b375a9e3f5e4bba9bcdfed152a8a247dee01 ]

Add IRQ for the DPNI endpoint change event, resolving the issue
when a dynamically created DPNI gets a randomly generated hw address
when the endpoint is a DPMAC object.

Signed-off-by: Florin Chiculita <florinlaurentiu.chiculita@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 6 +++++-
 drivers/net/ethernet/freescale/dpaa2/dpni.h      | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 0acb11557ed1c..488e8e446e17d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -3219,6 +3219,9 @@ static irqreturn_t dpni_irq0_handler_thread(int irq_num, void *arg)
 	if (status & DPNI_IRQ_EVENT_LINK_CHANGED)
 		link_state_update(netdev_priv(net_dev));
 
+	if (status & DPNI_IRQ_EVENT_ENDPOINT_CHANGED)
+		set_mac_addr(netdev_priv(net_dev));
+
 	return IRQ_HANDLED;
 }
 
@@ -3244,7 +3247,8 @@ static int setup_irqs(struct fsl_mc_device *ls_dev)
 	}
 
 	err = dpni_set_irq_mask(ls_dev->mc_io, 0, ls_dev->mc_handle,
-				DPNI_IRQ_INDEX, DPNI_IRQ_EVENT_LINK_CHANGED);
+				DPNI_IRQ_INDEX, DPNI_IRQ_EVENT_LINK_CHANGED |
+				DPNI_IRQ_EVENT_ENDPOINT_CHANGED);
 	if (err < 0) {
 		dev_err(&ls_dev->dev, "dpni_set_irq_mask(): %d\n", err);
 		goto free_irq;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpni.h b/drivers/net/ethernet/freescale/dpaa2/dpni.h
index a521242e23537..72cf1258f40fb 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpni.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpni.h
@@ -133,9 +133,12 @@ int dpni_reset(struct fsl_mc_io	*mc_io,
  */
 #define DPNI_IRQ_INDEX				0
 /**
- * IRQ event - indicates a change in link state
+ * IRQ events:
+ *       indicates a change in link state
+ *       indicates a change in endpoint
  */
 #define DPNI_IRQ_EVENT_LINK_CHANGED		0x00000001
+#define DPNI_IRQ_EVENT_ENDPOINT_CHANGED		0x00000002
 
 int dpni_set_irq_enable(struct fsl_mc_io	*mc_io,
 			u32			cmd_flags,
-- 
2.20.1

