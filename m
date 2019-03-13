Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABF1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F4621850
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504380;
	bh=czZl/gcxHPAw0X51AAq6wUpiY10Lipe9Aso2/qfZ9n4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vUdnK52baG/Nf+16JVmKAS7vpxoIkqL7j7+c8VRFpdbmp9zACyNzyaw/F6n0vXuFt
	 UWIsvkmbUUipsh7x50jJG4JbWdnjI/LRWWiSqD2KMfiri9SlL0SmdId/1QIJ5SZREC
	 xyav6EeyQCz1Ruhoksb9uZHKUcKIrV53n+PlV+y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCMTM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbfCMTMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:12:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD7EE2075C;
        Wed, 13 Mar 2019 19:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504374;
        bh=czZl/gcxHPAw0X51AAq6wUpiY10Lipe9Aso2/qfZ9n4=;
        h=From:To:Cc:Subject:Date:From;
        b=yABPdJkQboZrRpV8It624+OftS/CMVp36QkedaME1vL++4QvPq3Pd7Mrd+m4ElbAG
         64CyMm4OXew1ECgnG/1zt96tVSc6c24YE/EP5bMjh2Epqg3N4XMykaBMl/DHEQ6Lvc
         OVQIyuJywFQd8qKSu6dxOF5XPaZ013L2eRxwyS6M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/48] clk: sunxi-ng: v3s: Fix TCON reset de-assert bit
Date:   Wed, 13 Mar 2019 15:12:03 -0400
Message-Id: <20190313191250.158955-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

[ Upstream commit 5c59801f7018acba11b12de59017a3fcdcf7421d ]

According to the datasheet and the reference code from Allwinner, the
bit used to de-assert the TCON reset is bit 4, not bit 3.

Fix it in the V3s CCU driver.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index 621b1cd996db..ac12f261f8ca 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -542,7 +542,7 @@ static struct ccu_reset_map sun8i_v3s_ccu_resets[] = {
 	[RST_BUS_OHCI0]		=  { 0x2c0, BIT(29) },
 
 	[RST_BUS_VE]		=  { 0x2c4, BIT(0) },
-	[RST_BUS_TCON0]		=  { 0x2c4, BIT(3) },
+	[RST_BUS_TCON0]		=  { 0x2c4, BIT(4) },
 	[RST_BUS_CSI]		=  { 0x2c4, BIT(8) },
 	[RST_BUS_DE]		=  { 0x2c4, BIT(12) },
 	[RST_BUS_DBG]		=  { 0x2c4, BIT(31) },
-- 
2.19.1

