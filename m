Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6129AC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3127B20868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199670;
	bh=ode6917U6GR0FYujY7U8gRtJst3Lbg8ZlGUdNqat0m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OYBoCSbin5R818OZaUJXGH8nL6g7ziH1vCpodVhYPSX85UOyciR4oZY4Dui2ybame
	 gkwDkGgXXCnljytyAOR/8/a2eMBsQYsgBhhrVGlsUVCJapmSQOKWDT5GZ7Gh2Lk1SA
	 fj86F4+Y/ZP4GJ3WsRPHMIFsij6PeA5ztWaPKf0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfGOOHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388199AbfGOOHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:07:38 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DE3F2081C;
        Mon, 15 Jul 2019 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199657;
        bh=ode6917U6GR0FYujY7U8gRtJst3Lbg8ZlGUdNqat0m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTacA1K7V5FUOzZzHOde7juQ1TulRbslYJbLMiYks8af84IBX0elyL8M8yObNwECM
         Unh7i8ytbkq6yifw5SXQKJWyxApdyS2NesnPjSZFOo5iTO0K3WP0yCuzPYcjJdFIRt
         CDjytzbECSYIQ6Cus3Lga4pYNoGFfB9urWqTpdew=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Biao Huang <biao.huang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 063/219] net: stmmac: modify default value of tx-frames
Date:   Mon, 15 Jul 2019 10:01:04 -0400
Message-Id: <20190715140341.6443-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
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
index 272b9ca66314..b069b3a2453b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -261,7 +261,7 @@ struct stmmac_safety_stats {
 #define STMMAC_COAL_TX_TIMER	1000
 #define STMMAC_MAX_COAL_TX_TICK	100000
 #define STMMAC_TX_MAX_FRAMES	256
-#define STMMAC_TX_FRAMES	25
+#define STMMAC_TX_FRAMES	1
 
 /* Packets types */
 enum packets_types {
-- 
2.20.1

