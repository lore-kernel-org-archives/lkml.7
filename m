Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DCDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EB02081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554390;
	bh=3WjJSY7vZLVqoeVZv6ccOG1TIWOYqs8oAQ8eRPMkcSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ya8YbNNGmaxabwzCBijSPKzkRurPmtbqVb4vq/KWqbQRixzPMFLfGIZiyqXHH3HcJ
	 O411rZ+y/kg51u2u66gxpXHFJ1oUqcCBNmgxl9UJSvqcK18Bhr3GjeI3+gdxL6D2s6
	 KyJZh+o/Dj6tzNdInteyhyvx4QHUZzClwKYjkk3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbfEVTq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbfEVT1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:27:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6666D2173C;
        Wed, 22 May 2019 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553269;
        bh=3WjJSY7vZLVqoeVZv6ccOG1TIWOYqs8oAQ8eRPMkcSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3xVTa2nPaqGElsQ+mt1PSz3WmGmQ7pl/Oe8agMzHc3GT/TFy8OpJVcRvDOmOQnfu
         82FPty9XukjNNutOsybyk2Dc/cMm+zrWUc6qK7lN1h9Hkejp7A9w9km6Trv557JVnm
         SEEtnYqVj0S/CWkHxu33hE1UYvLE8NqsG6aRmVj4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 045/244] rtc: stm32: manage the get_irq probe defer case
Date:   Wed, 22 May 2019 15:23:11 -0400
Message-Id: <20190522192630.24917-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192630.24917-1-sashal@kernel.org>
References: <20190522192630.24917-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Dessenne <fabien.dessenne@st.com>

[ Upstream commit cf612c5949aca2bd81a1e28688957c8149ea2693 ]

Manage the -EPROBE_DEFER error case for the wake IRQ.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Acked-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-stm32.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index c5908cfea2340..8e6c9b3bcc29a 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -788,11 +788,14 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	ret = device_init_wakeup(&pdev->dev, true);
 	if (rtc->data->has_wakeirq) {
 		rtc->wakeirq_alarm = platform_get_irq(pdev, 1);
-		if (rtc->wakeirq_alarm <= 0)
-			ret = rtc->wakeirq_alarm;
-		else
+		if (rtc->wakeirq_alarm > 0) {
 			ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
 							    rtc->wakeirq_alarm);
+		} else {
+			ret = rtc->wakeirq_alarm;
+			if (rtc->wakeirq_alarm == -EPROBE_DEFER)
+				goto err;
+		}
 	}
 	if (ret)
 		dev_warn(&pdev->dev, "alarm can't wake up the system: %d", ret);
-- 
2.20.1

