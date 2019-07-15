Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF94C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6878B20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199145;
	bh=TQbRXzfc5WhIRgOGMu7vtqmyzHneb22EBvCzCpUcghY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lodiw2nPn8QAH5vHxmdtWEXsWy9mq7/kq8jDxmgaP1w3A4pC5Fkt4JEFK45k5TujN
	 WWLJ1SbwzGI/iG6eWl/njQNB57ZT0KZlylPm8sC67kNDTjA2TsgfvJ8yXnS9Gv/KrE
	 uzlTPUf12v6K9+IH+KpImbcHxDzb2L2EvDZ2+Tdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732907AbfGON7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbfGON7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:59:02 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D68420C01;
        Mon, 15 Jul 2019 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199141;
        bh=TQbRXzfc5WhIRgOGMu7vtqmyzHneb22EBvCzCpUcghY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHLWXE0vaMTjvr+ArDNeAziyO7mvfmKmPCrm0TIMhqViVN2zNQCiTjlbGzclazenO
         b/1dID1uM78eY81c9Gpgbz/GZCDunxqvaSYwFm86pSG4yoA4aOogI2hubdafVyEkDv
         Jv4KxhapNwnegVhHnVvS5hdaFkCrCQk6BE7IQI84=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Alan Winkowski <walan@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 203/249] net: mvpp2: prs: Don't override the sign bit in SRAM parser shift
Date:   Mon, 15 Jul 2019 09:46:08 -0400
Message-Id: <20190715134655.4076-203-sashal@kernel.org>
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

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit 8ec3ede559956f8ad58db7b57d25ac724bab69e9 ]

The Header Parser allows identifying various fields in the packet
headers, used for various kind of filtering and classification
steps.

This is a re-entrant process, where the offset in the packet header
depends on the previous lookup results. This offset is represented in
the SRAM results of the TCAM, as a shift to be operated.

This shift can be negative in some cases, such as in IPv6 parsing.

This commit prevents overriding the sign bit when setting the shift
value, which could cause instabilities when parsing IPv6 flows.

Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
Suggested-by: Alan Winkowski <walan@marvell.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
index ae2240074d8e..5692c6087bbb 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -312,7 +312,8 @@ static void mvpp2_prs_sram_shift_set(struct mvpp2_prs_entry *pe, int shift,
 	}
 
 	/* Set value */
-	pe->sram[MVPP2_BIT_TO_WORD(MVPP2_PRS_SRAM_SHIFT_OFFS)] = shift & MVPP2_PRS_SRAM_SHIFT_MASK;
+	pe->sram[MVPP2_BIT_TO_WORD(MVPP2_PRS_SRAM_SHIFT_OFFS)] |=
+		shift & MVPP2_PRS_SRAM_SHIFT_MASK;
 
 	/* Reset and set operation */
 	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_OP_SEL_SHIFT_OFFS,
-- 
2.20.1

