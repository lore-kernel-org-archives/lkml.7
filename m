Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812E4C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C22F208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355521;
	bh=p6r+QGUnfn2ffH/1ck6OW/KCJMN+5kOwAu34b+yJ69o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OXUZRuzxGAl3XdQoR1NOWP5//mIFWUnWxAuHdAXCSTQZtlcn9colGlZamWci5o0ZW
	 rW67L6VE8OmmLz+uVQfzOFX4b/CRhVl58XKJkAHKeeUegBYM4J/ZefKjgiU9JHDge2
	 FWpAlW+Q/lXwXqTuLQXr5XSoj3QRd+BNgVHZwle0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfKJDMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:12:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfKJCnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:43:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6428F21655;
        Sun, 10 Nov 2019 02:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353805;
        bh=p6r+QGUnfn2ffH/1ck6OW/KCJMN+5kOwAu34b+yJ69o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mp3tq539kQ0Isth3KGE0QTHuOyUPmhfoPpF0uxcMxdLAy57jxb72icAYHQ/wmbH0P
         GChWxV8cK1aCiEWPsvFfhQ3LPVsPnbDStL/uBlSsjM6XWq+5xbFBsSvihpyluDyExD
         b6ntQVemwItDzvPV1ZKt76wTpjpH3QIx6G05w6FE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhong jiang <zhongjiang@huawei.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 103/191] ARM: at91: pm: call put_device instead of of_node_put in at91_pm_config_ws
Date:   Sat,  9 Nov 2019 21:38:45 -0500
Message-Id: <20191110024013.29782-103-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

[ Upstream commit 95590a6286c547b7287d01c55515fb96b904aa03 ]

of_find_device_by_node takes a reference to the struct device when it
finds a match via get_device. but it fails to put_device in
at91_pm_config_ws, for_each_matching_node_and_match will get and put
the node properly, there is no need to call the of_put_node. Therefore,
just call put_device instead of of_node_put in at91_pm_config_ws.

Fixes: d7484f5c6b3b ("ARM: at91: pm: configure wakeup sources for ULP1 mode")
Suggested-by: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-at91/pm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 0921e2c10edfd..e2e4df3d11e53 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -143,15 +143,15 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool set)
 
 			/* Check if enabled on SHDWC. */
 			if (wsi->shdwc_mr_bit && !(val & wsi->shdwc_mr_bit))
-				goto put_node;
+				goto put_device;
 
 			mode |= wsi->pmc_fsmr_bit;
 			if (wsi->set_polarity)
 				polarity |= wsi->pmc_fsmr_bit;
 		}
 
-put_node:
-		of_node_put(np);
+put_device:
+		put_device(&pdev->dev);
 	}
 
 	if (mode) {
-- 
2.20.1

