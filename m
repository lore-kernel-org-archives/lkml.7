Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F033C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240392054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563203572;
	bh=HPKAxa+ogAdv4Fdus1QyLtjfbr+BZUadXGnCKAhszeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lffQ1Zlcd6NBFqWER2fJtrUfjH5EZ29lZQk49WMQ39PDG+i9av9GFFAAO2nu3Kg3Z
	 nVx8JkIfg83qzHlkGio6qIVV+R/eJb0lH05S0MJKuNi8GlNSZ3X9VmrEalu+0IBr7S
	 nouVaa+d0ZysLGeULFQVKb6qPDT4pQj9X1/di69s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbfGOPMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732038AbfGONu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:50:57 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE3F9216C4;
        Mon, 15 Jul 2019 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198655;
        bh=HPKAxa+ogAdv4Fdus1QyLtjfbr+BZUadXGnCKAhszeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZAGU9Cx+km6dpyAKR4qbNgyjVrhb1IZjhp0tNIZfLO66vR70JUNoi/8dMFbitFGp
         PU4943j38JRsQJ164vTJfTTG4sC83E82QlpaKr6llisHCUxG8U4w4scNXV61thQfHV
         p+IlEp4PdIIpxRYzFO1HQ+rUaf5hUXh2WqyOqHW8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Biao Huang <biao.huang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 073/249] net: stmmac: modify default value of tx-frames
Date:   Mon, 15 Jul 2019 09:43:58 -0400
Message-Id: <20190715134655.4076-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biao Huang <biao.huang@mediatek.com>

[ Upstream commit d2facb4b3983425f6776c24dd678a82dbe673773 ]

the default value of tx-frames is 25, it's too late when
passing tstamp to stack, then the ptp4l will fail:

ptp4l -i eth0 -f gPTP.cfg -m
ptp4l: selected /dev/ptp0 as PTP clock
ptp4l: port 1: INITIALIZING to LISTENING on INITIALIZE
ptp4l: port 0: INITIALIZING to LISTENING on INITIALIZE
ptp4l: port 1: link up
ptp4l: timed out while polling for tx timestamp
ptp4l: increasing tx_timestamp_timeout may correct this issue,
       but it is likely caused by a driver bug
ptp4l: port 1: send peer delay response failed
ptp4l: port 1: LISTENING to FAULTY on FAULT_DETECTED (FT_UNSPECIFIED)

ptp4l tests pass when changing the tx-frames from 25 to 1 with
ethtool -C option.
It should be fine to set tx-frames default value to 1, so ptp4l will pass
by default.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index ceb0d23f5041..c265cc5770e8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -251,7 +251,7 @@ struct stmmac_safety_stats {
 #define STMMAC_COAL_TX_TIMER	1000
 #define STMMAC_MAX_COAL_TX_TICK	100000
 #define STMMAC_TX_MAX_FRAMES	256
-#define STMMAC_TX_FRAMES	25
+#define STMMAC_TX_FRAMES	1
 
 /* Packets types */
 enum packets_types {
-- 
2.20.1

