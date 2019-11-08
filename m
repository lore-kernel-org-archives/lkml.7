Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D781FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B84207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213933;
	bh=HShIySpLPUNeFNOt26VHwgmGLAKWF2+VsW+uRVUMwGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jIk22p2pwjfJbWCWSED7j1bTqFPTd1IxiwS0HrCeXF8T2RCNBhK2OimNk7dmPWjpb
	 q7gVlzkbCfwzuRtPBcmUr/7YV9LSBXB4Tfsv+CTVgt0xDEt46ZbXlSDRmr+/2J/DU3
	 lgL6Z8G67DUF9WxsbbCDKH9CoiGjA+aTzTZi0nOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391417AbfKHLwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:52:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390511AbfKHLrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:47:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E146222CE;
        Fri,  8 Nov 2019 11:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213631;
        bh=HShIySpLPUNeFNOt26VHwgmGLAKWF2+VsW+uRVUMwGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2kdjwde4yt8/g75V3htuFEB5bP1lURzZOLISopP7aAAlhzZHWBL7/v5zfWHQLKYHu
         kFT5yxdJea5SaDxwqpFoXCFTC9MEI3R9Z/TVdiPrVy6hdV/czy8wPvGqt7uwfp9MqI
         PcK2hW6Tu1W0J3EBho61LcjeHPzxFyw5RKRlcKlA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 58/64] power: reset: at91-poweroff: do not procede if at91_shdwc is allocated
Date:   Fri,  8 Nov 2019 06:45:39 -0500
Message-Id: <20191108114545.15351-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 9f1e44774be578fb92776add95f1fcaf8284d692 ]

There should be only one instance of struct shdwc in the system. This is
referenced through at91_shdwc. Return in probe if at91_shdwc is already
allocated.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 90b0b5a70ce52..04ca990e8f6cb 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -246,6 +246,9 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 	if (!pdev->dev.of_node)
 		return -ENODEV;
 
+	if (at91_shdwc)
+		return -EBUSY;
+
 	at91_shdwc = devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL);
 	if (!at91_shdwc)
 		return -ENOMEM;
-- 
2.20.1

