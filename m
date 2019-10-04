Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18327ECE58B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAC4222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570201520;
	bh=PY00z/yQLvdHY3HuHe8b++knUuCmduzQH84HBTF1sBc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bF3nWBpabkGCVvWHi6O/lnb92S6PN02XLvH5YtuWq57AdN+3cFQiQtpFL5Ty3TOIz
	 RLPX6o+oxW8us2CmH53YrULZwzm893XdtSdW+d6OY7ZFv0KLqaGqnSNLIBt8q1Y0MV
	 YxrBAkIz8TRDbR5nBLMgPwpd/+N4jSRhxfo9Nigo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389479AbfJDPFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388802AbfJDPFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:05:18 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4232A2133F;
        Fri,  4 Oct 2019 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570201518;
        bh=PY00z/yQLvdHY3HuHe8b++knUuCmduzQH84HBTF1sBc=;
        h=From:To:Cc:Subject:Date:From;
        b=VKsZHLOovHV5rTTC5N1+XY2+t0yT6eGKvbZh60P63Es0abcv7MFIV9ltQIBY0Kwlc
         5AWwpRKUmIJ5rTH3gMgY7bbPi4HN5Mz6mxAXqK8jdRXDrjk3Zj4pjv2qKw8tXEtT5E
         GGiGm4RTVRJ07vs8O3yktxzqNX9e0fpK6BdR8Ce4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFT] rtc: da9063: Handle invalid IRQ from platform_get_irq_byname()
Date:   Fri,  4 Oct 2019 17:05:10 +0200
Message-Id: <20191004150510.6278-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq_byname() might return -errno which later would be
cast to an unsigned int and used in request_irq().

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not marking as cc-stable as this was not reproduced and not tested.
---
 drivers/rtc/rtc-da9063.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index 15908d51b1cb..046b1d4c3dae 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -483,6 +483,9 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 		rtc->rtc_dev->uie_unsupported = 1;
 
 	irq_alarm = platform_get_irq_byname(pdev, "ALARM");
+	if (irq_alarm < 0)
+		return irq_alarm;
+
 	ret = devm_request_threaded_irq(&pdev->dev, irq_alarm, NULL,
 					da9063_alarm_event,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-- 
2.17.1

