Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6837BC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D2820651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356238;
	bh=sEMSincRBeagLJeJzGhIaLf3tATgxZm72E2Tv4T11XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2NGWGED+2uxFYPbVOvMHntvlQuTu76VNoAx16Br2CbJhfJetSswTAU3Bd9GooIFvV
	 GO2+JGtgeaSb4apGaFaZRUAHMWb3Dbke59syjf36s2mzmx+P8ThfJomHweLvTNvqnH
	 o1xWh+aOtZBoajARs8i00EfpGiSbx1RdkH5M4c3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfDOTGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730009AbfDOTGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E31C218A1;
        Mon, 15 Apr 2019 19:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355201;
        bh=sEMSincRBeagLJeJzGhIaLf3tATgxZm72E2Tv4T11XY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yvy9LVwSjMjEWirA94UWgdNzy0rEwF6OJOQachdQcGNTs6FYp3qkS+BOAolOjGZQA
         NkI30Qb5Hx4ejbq7J6vKoa64AjNhc6HlSIvzuxM1lKNipA6GZWYihsSqbMZYNCPoq4
         nr7NffouqSUPOpLQ6hLIbnaKBiZl4PQXv8SiKub8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Crowe <mac@mcrowe.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/101] r8169: disable default rx interrupt coalescing on RTL8168
Date:   Mon, 15 Apr 2019 20:58:31 +0200
Message-Id: <20190415183742.206867216@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 288ac524cf70a8e7ed851a61ed2a9744039dae8d ]

It was reported that re-introducing ASPM, in combination with RX
interrupt coalescing, results in significantly increased packet
latency, see [0]. Disabling ASPM or RX interrupt coalescing fixes
the issue. Therefore change the driver's default to disable RX
interrupt coalescing. Users still have the option to enable RX
coalescing via ethtool.

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=925496

Fixes: a99790bf5c7f ("r8169: Reinstate ASPM Support")
Reported-by: Mike Crowe <mac@mcrowe.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 1d24884e9897..7a50b911b180 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -5418,7 +5418,7 @@ static void rtl_hw_start_8168(struct rtl8169_private *tp)
 	tp->cp_cmd |= PktCntrDisable | INTT_1;
 	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
 
-	RTL_W16(tp, IntrMitigate, 0x5151);
+	RTL_W16(tp, IntrMitigate, 0x5100);
 
 	/* Work around for RxFIFO overflow. */
 	if (tp->mac_version == RTL_GIGA_MAC_VER_11) {
-- 
2.19.1



