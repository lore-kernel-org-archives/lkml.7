Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFC6C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05957206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153646;
	bh=kE/1oxJYgmNTL8Ovm9139oKe/JLOIehv6BCJ+0rIqKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=twefrBbxbH8OkJHRzw8ITWxi/8D/wSU6MgiH0R295NtjdFwZ729NXNsKjMcmmR1JB
	 KNfT4oTPqxUAUncRcShy6GG6GTdIqOE/lv823vTf0Hm9l0t9KYrOn158idLD7Nhyg/
	 2BZ2bc2CKMJP+kVH2TEG03tGOFABkP1F8MZ1cllM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfEFOko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbfEFOkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:40:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 397E6206A3;
        Mon,  6 May 2019 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153640;
        bh=kE/1oxJYgmNTL8Ovm9139oKe/JLOIehv6BCJ+0rIqKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQn86XPxl/DcEu1vLLVUp3OEqYESBX8pfsC803Zy70aNFjBDaitrneZoYA94jHnzP
         UEkJS+vfB8LfwSid0puvuaF6lOeJIgNVk56tqQ4DNYVKgSdwVZNbdpvw4BKv2Lhj4P
         AS/vhL14k0C4Ti6PkfKvKcpZUNdlkBu1IQCCFUy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 41/99] net: stmmac: dont overwrite discard_frame status
Date:   Mon,  6 May 2019 16:32:14 +0200
Message-Id: <20190506143057.683729949@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1b746ce8b397e58f9e40ce5c63b7198de6930482 ]

If we have error bits set, the discard_frame status will get overwritten
by checksum bit checks, which might set the status back to good one.
Fix by checking the COE status only if the frame is good.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index e8855e6adb48..c42ef6c729c0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -231,9 +231,10 @@ static int enh_desc_get_rx_status(void *data, struct stmmac_extra_stats *x,
 	 * It doesn't match with the information reported into the databook.
 	 * At any rate, we need to understand if the CSUM hw computation is ok
 	 * and report this info to the upper layers. */
-	ret = enh_desc_coe_rdes0(!!(rdes0 & RDES0_IPC_CSUM_ERROR),
-				 !!(rdes0 & RDES0_FRAME_TYPE),
-				 !!(rdes0 & ERDES0_RX_MAC_ADDR));
+	if (likely(ret == good_frame))
+		ret = enh_desc_coe_rdes0(!!(rdes0 & RDES0_IPC_CSUM_ERROR),
+					 !!(rdes0 & RDES0_FRAME_TYPE),
+					 !!(rdes0 & ERDES0_RX_MAC_ADDR));
 
 	if (unlikely(rdes0 & RDES0_DRIBBLING))
 		x->dribbling_bit++;
-- 
2.20.1



