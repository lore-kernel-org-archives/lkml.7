Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD816C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91967207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641301;
	bh=rJ9T0NsU4NCiXEL3LAWvxfY7uGboWhRhsy19r41m7Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AQpR4kQQk64RDHtaRH8hXRG4CmTjL5MoCfYkeCNvhcA2d+pHHhgSlVouLW5j3Kwir
	 S424dXKwD6tYdTuIAxAXfhD72FPhMyiDF/t0D74KRKfikWoOYcyzJfljyPEw0TXnyq
	 UXLC/qXZgu6YmB5Z1mDzxpiET23vNJ6xQG9RdSbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbfL2Rlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:41:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbfL2R34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:29:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81F3620409;
        Sun, 29 Dec 2019 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640596;
        bh=rJ9T0NsU4NCiXEL3LAWvxfY7uGboWhRhsy19r41m7Ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3kwcEtaT99Q6oeZrz4vK41igR08alhjjA7s7cA8vXX7suN/F3lwdbONCDd9AdSm5
         4aMl+EGWFxyCmayGwaM2YcTBtRmY2/JI+rP3E+AnDKvog4GESaNd6QTiwxevD1f2la
         v29ZbybXMopcu0iR1azEZUWk3bgY7qzRfNSuvlss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 061/219] mwifiex: pcie: Fix memory leak in mwifiex_pcie_init_evt_ring
Date:   Sun, 29 Dec 2019 18:17:43 +0100
Message-Id: <20191229162515.953663409@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit d10dcb615c8e29d403a24d35f8310a7a53e3050c ]

In mwifiex_pcie_init_evt_ring, a new skb is allocated which should be
released if mwifiex_map_pci_memory() fails. The release for skb and
card->evtbd_ring_vbase is added.

Fixes: 0732484b47b5 ("mwifiex: separate ring initialization and ring creation routines")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Acked-by: Ganapathi Bhat <gbhat@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 3fe81b2a929a..918c69936540 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -691,8 +691,11 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		skb_put(skb, MAX_EVENT_SIZE);
 
 		if (mwifiex_map_pci_memory(adapter, skb, MAX_EVENT_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   PCI_DMA_FROMDEVICE)) {
+			kfree_skb(skb);
+			kfree(card->evtbd_ring_vbase);
 			return -1;
+		}
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
 
-- 
2.20.1



