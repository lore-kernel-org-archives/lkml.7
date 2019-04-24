Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E786C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1508621905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117443;
	bh=a3n0wUB3rX+UC8RedvQRQjA8CAUero+XD2d3Is0hxGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rC43+IwG6StC97AJ4qsnRaqTGeCz0fwD3jijlC+RNZp1S7J3HdgMCr6WtH5hYYCHb
	 oL9btb263ch5PGBzhI8d8XrbvHWg5X5ktADDpGhaTPdkv3OUiKyhGch8skoQ/dgZNG
	 /hlyc2VzNUcCv9tV8lKw6l1kCnDKJEQCNPgFsmR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbfDXOum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732633AbfDXOuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:50:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12075218FC;
        Wed, 24 Apr 2019 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117439;
        bh=a3n0wUB3rX+UC8RedvQRQjA8CAUero+XD2d3Is0hxGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qMHBk28vVId/H2ioosWiyejRVVG97vfQzF65QCahaT0spa/1I7769No1937ptZ3Bx
         i/zsjpwaIeSEXUBUCxGZMV7tp3Wenq9ZPxlUH3UfZLr/goJI3y3rKmHHN8V6bu/56M
         lBi5HG/cAd7D0E55BVEd+WUkM3PhR5xdKNONGbS8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 11/28] net: stmmac: don't overwrite discard_frame status
Date:   Wed, 24 Apr 2019 10:49:55 -0400
Message-Id: <20190424145012.30886-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145012.30886-1-sashal@kernel.org>
References: <20190424145012.30886-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

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
index ce97e522566a..2c40cafa2619 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -235,9 +235,10 @@ static int enh_desc_get_rx_status(void *data, struct stmmac_extra_stats *x,
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
2.19.1

