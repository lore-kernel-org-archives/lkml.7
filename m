Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E3CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D27321905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117447;
	bh=VPIp3X7U2xKq2vogYXAyIoq3mFs0qIyNzfg3oElyvGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JhGOTGakRM7OE3sMJBvF9jYgunGIDg03kVrmNKWEmAuQ61W0OvH0teazkylQ3SEpv
	 f4WS768DvklDJY94657YVSrz/eCmaVVSuAF7SWcCslKwMdG037p+imQewleFJaWjHj
	 GvJYcjVtVkCYIKvhFCJRA0ijV3Nm48rZNWfZyZqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbfDXOuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732664AbfDXOuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:50:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7766E218FC;
        Wed, 24 Apr 2019 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117444;
        bh=VPIp3X7U2xKq2vogYXAyIoq3mFs0qIyNzfg3oElyvGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSHDnSGx1YZ4acm2WbQGufJCy657bXmkcJiLBqy48fCz5ExUM+A9eBUBUT1Ceulnz
         Q+rbWCECgWuMU/G3lGyECYtM6KWk9Yh0KaZ+QUs9qkyMoH9v58JnCDB0+HgO8+smjC
         YQvRZPDwDhzJ64e3/XoWJJjWOE+PdkBwJc44mJ8M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 13/28] net: stmmac: don't log oversized frames
Date:   Wed, 24 Apr 2019 10:49:57 -0400
Message-Id: <20190424145012.30886-13-sashal@kernel.org>
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

[ Upstream commit 057a0c5642a2ff2db7c421cdcde34294a23bf37b ]

This is log is harmful as it can trigger multiple times per packet. Delete
it.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index fd78406e2e9a..01f8f2e94c0f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -95,8 +95,6 @@ static int ndesc_get_rx_status(void *data, struct stmmac_extra_stats *x,
 		return dma_own;
 
 	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
-		pr_warn("%s: Oversized frame spanned multiple buffers\n",
-			__func__);
 		stats->rx_length_errors++;
 		return discard_frame;
 	}
-- 
2.19.1

