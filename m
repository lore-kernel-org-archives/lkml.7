Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB30C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A66D21835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382783;
	bh=QKRCG8f/z7TmRpXy/oFC4HCqvZVx9ImvcBK7A1PeQ10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ri/5fdNd9l1kSx/FuKckmX/jiOEjg5aMDyTTb0M+1lX2vSfgAja1WPvdXik4zVRUu
	 dJzaPTyIQNmPcz2l985ph5/vYIuGKquHTBcLthjfeCYlN5mK7Dv/SqyWFD6MHaXtme
	 M6XYEcuo0BUyYC9WnMv1cy6c2BgM6WiDXgCxDMlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfJFR0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfJFR0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:26:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F300C2080F;
        Sun,  6 Oct 2019 17:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382778;
        bh=QKRCG8f/z7TmRpXy/oFC4HCqvZVx9ImvcBK7A1PeQ10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMVc0OUZXiu083lTRy9/0lvf/TW3bPXkCSFNI/KVJ+VYNuKCSnaxjj4Fdc/NM/S0I
         CrafPORzC8l4bVsZQfEReifnzaCxs3Eb7wgamEYDjluEdzrjoR+rycxQ9kc/7SXaWg
         RAB8fy5vTPp2bEoeZ1qzoNzol+kOsXBJBNukNyVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 35/68] rtc: snvs: fix possible race condition
Date:   Sun,  6 Oct 2019 19:21:11 +0200
Message-Id: <20191006171124.973127408@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171108.150129403@linuxfoundation.org>
References: <20191006171108.150129403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 6fd4fe9b496d9ba3382992ff4fde3871d1b6f63d ]

The RTC IRQ is requested before the struct rtc_device is allocated,
this may lead to a NULL pointer dereference in IRQ handler.

To fix this issue, allocating the rtc_device struct before requesting
the RTC IRQ using devm_rtc_allocate_device, and use rtc_register_device
to register the RTC device.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Link: https://lore.kernel.org/r/20190716071858.36750-1-Anson.Huang@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-snvs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 71eee39520f0b..7aa2c5ea0de4f 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -280,6 +280,10 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(data->rtc))
+		return PTR_ERR(data->rtc);
+
 	data->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "regmap");
 
 	if (IS_ERR(data->regmap)) {
@@ -342,10 +346,9 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 		goto error_rtc_device_register;
 	}
 
-	data->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					&snvs_rtc_ops, THIS_MODULE);
-	if (IS_ERR(data->rtc)) {
-		ret = PTR_ERR(data->rtc);
+	data->rtc->ops = &snvs_rtc_ops;
+	ret = rtc_register_device(data->rtc);
+	if (ret) {
 		dev_err(&pdev->dev, "failed to register rtc: %d\n", ret);
 		goto error_rtc_device_register;
 	}
-- 
2.20.1



