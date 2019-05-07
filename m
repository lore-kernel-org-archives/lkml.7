Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E32C04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5689920675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557209125;
	bh=5TjZaBYSgceF7iNSbVKKpL0yebG/csYnnmkws1WVf7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cjlEW6j9FMUqEKaijxEW/MOY4RxMelq10J9UQaLhg/Mr70OLPfforE7WSmbmQ01Rh
	 RiKJZ9CZsXuJjBvouaZCbhZaYwq1KisTkWiqGM9Lh/J7nt060UPXy4SL9oJjTMSipg
	 FUBc9iAzcEy77ARbFCg4qkaOSb7DwpDP71de8FRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEGGFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbfEGFeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:34:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F2C20B7C;
        Tue,  7 May 2019 05:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207252;
        bh=5TjZaBYSgceF7iNSbVKKpL0yebG/csYnnmkws1WVf7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEwj/gepjl8acZL51QDfk+GGWTYJi4b1UZuaufoOWy/lc9KzP9bt1H9EBfqNBR5FD
         peIWreoKooHi8p99I0UDYQlzwAED+Vry0Y4Df0FERvf8pA/C/yD+g0wsmeOowl4rJ2
         41nMrAk/kXWV1DajQLwFzq93igHSP6YTk/cocERs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 52/99] ocelot: Don't sleep in atomic context (irqs_disabled())
Date:   Tue,  7 May 2019 01:31:46 -0400
Message-Id: <20190507053235.29900-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Manoil <claudiu.manoil@nxp.com>

[ Upstream commit a8fd48b50deaa20808bbf0f6685f6f1acba6a64c ]

Preemption disabled at:
 [<ffff000008cabd54>] dev_set_rx_mode+0x1c/0x38
 Call trace:
 [<ffff00000808a5c0>] dump_backtrace+0x0/0x3d0
 [<ffff00000808a9a4>] show_stack+0x14/0x20
 [<ffff000008e6c0c0>] dump_stack+0xac/0xe4
 [<ffff0000080fe76c>] ___might_sleep+0x164/0x238
 [<ffff0000080fe890>] __might_sleep+0x50/0x88
 [<ffff0000082261e4>] kmem_cache_alloc+0x17c/0x1d0
 [<ffff000000ea0ae8>] ocelot_set_rx_mode+0x108/0x188 [mscc_ocelot_common]
 [<ffff000008cabcf0>] __dev_set_rx_mode+0x58/0xa0
 [<ffff000008cabd5c>] dev_set_rx_mode+0x24/0x38

Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 215a45374d7b..0ef95abde6bb 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -613,7 +613,7 @@ static int ocelot_mact_mc_add(struct ocelot_port *port,
 			      struct netdev_hw_addr *hw_addr)
 {
 	struct ocelot *ocelot = port->ocelot;
-	struct netdev_hw_addr *ha = kzalloc(sizeof(*ha), GFP_KERNEL);
+	struct netdev_hw_addr *ha = kzalloc(sizeof(*ha), GFP_ATOMIC);
 
 	if (!ha)
 		return -ENOMEM;
-- 
2.20.1

