Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BEDC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA8221479
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383032;
	bh=l7NP07G1Ea8ObzNjqXfvhMjFFJVuFFmr/gpg2A2d3/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RXftiHQxgFvY43ZJ152sp4I9rXmnKeR4zUkqwMJqo9oVUZMzqcmNzD6Vc7Ml7fKOT
	 Atr7F0N0VoSasP3+TnDtaJUlW9vLUyNItlMI/Qw1Ei/3m6AZISPzTNUj7mlf5tjxr9
	 dflxlrNaGta9TwYr3og/UtZ4quCDKDPm9DoQgjAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfJFRaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbfJFRaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:30:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2787B2087E;
        Sun,  6 Oct 2019 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383024;
        bh=l7NP07G1Ea8ObzNjqXfvhMjFFJVuFFmr/gpg2A2d3/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0NRMstMWEtcz8MeQO7fBSQb98B8iUPXL7fyNVG6UyOglLlLVOnUDWNzfyDt3/EiO
         GwmI+wZGH8x47mdhPenyCnEK4lUf7xAtPRFsu/hpv1SGrVh6O9DHo1rXQDWSKQmEkp
         SY/28PEKHZN/e26y1lAXfuBbkJPqp5ZsEJzMo/10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/106] rtc: snvs: fix possible race condition
Date:   Sun,  6 Oct 2019 19:21:04 +0200
Message-Id: <20191006171147.945904228@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
References: <20191006171124.641144086@linuxfoundation.org>
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
index b2483a749ac45..3cf011e120530 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -273,6 +273,10 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(data->rtc))
+		return PTR_ERR(data->rtc);
+
 	data->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "regmap");
 
 	if (IS_ERR(data->regmap)) {
@@ -335,10 +339,9 @@ static int snvs_rtc_probe(struct platform_device *pdev)
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



