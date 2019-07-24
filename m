Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BBDC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D60206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999388;
	bh=OMIEmC5y38l87lwjmF+MWWlsfb57JJMC0HeRUrSKT10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OyCZRmw+iBEwnXXqeCbY3OqA3SOIUHXIISK7FnXwEE/I9eSl9ObfKhGNjE8Ae2oZH
	 C7Wz7E/S4jmlshmpMmJs830ruAmEe1OmuPuWzlMl9jpZvzc7uAUlKssxz/s5XXlmwE
	 WwC8me/mjsXMrYN9lDAYaoFSTeclKEUV0+jN0kvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404354AbfGXUQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388222AbfGXTvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:51:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B5220578;
        Wed, 24 Jul 2019 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997882;
        bh=OMIEmC5y38l87lwjmF+MWWlsfb57JJMC0HeRUrSKT10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jfaoh+1om2ko8e1wtMtwyKKdPAwI1hxN8mMuGa8hrCKgZ4+EMiyLGC/GskYx4ZTH1
         JP3e/opGaCvukB5EGjyt3lT7Pkul3g4y2Zw/TacBllq1Io3Hib2ifCRrKmQeXXZ49E
         PFPz+4KF97MFUT0JasODyvdjcI+gUl0tJaTCEeWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Winkowski <walan@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 177/371] net: mvpp2: prs: Dont override the sign bit in SRAM parser shift
Date:   Wed, 24 Jul 2019 21:18:49 +0200
Message-Id: <20190724191738.532830430@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



