Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D78C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D0C21900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116439;
	bh=D5foliqRf+QYmfVkErUvdWWa6s5sVbXIsFXb9JvYSLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2n+KsLsjgtOGb9SoRXahRqvvGJ5D9gnrlk5JCryatx1xsiQSSXm+ThK1g/3hMl+c7
	 9GEnoH4BGcgg03LLSLjosbGUsRp3rDRpk4EEY22pODDhRNOZmVVTi7ixxfAiBlxtGG
	 jUKHcoo8z4uRIBM0tfvgK5D4hhqeaGX0OkhJf6cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfDXOd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730687AbfDXOdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:33:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 370552089F;
        Wed, 24 Apr 2019 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116434;
        bh=D5foliqRf+QYmfVkErUvdWWa6s5sVbXIsFXb9JvYSLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1+mvSskfruZXEpBj+i30C4dFZRwgXFQn7gRr3Soo6YlOcCNCSjcjGaUZrUMUrgRV
         2FlKpaNhKIWUDtkJCyGUaotT34L9zUg/3F/jKoYUu6OfnEAf5jUxHPIAtvikJiNkDB
         SfXYCO5a03XLmAkMNqqFg7pJh4DbwWgv+qX7zdRc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Evan Green <evgreen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 05/66] rtc: cros-ec: Fail suspend/resume if wake IRQ can't be configured
Date:   Wed, 24 Apr 2019 10:32:39 -0400
Message-Id: <20190424143341.27665-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit d6752e185c3168771787a02dc6a55f32260943cc ]

If we encounter a failure during suspend where this RTC was programmed
to wakeup the system from suspend, but that wakeup couldn't be
configured because the system didn't support wakeup interrupts, we'll
run into the following warning:

	Unbalanced IRQ 166 wake disable
	WARNING: CPU: 7 PID: 3071 at kernel/irq/manage.c:669 irq_set_irq_wake+0x108/0x278

This happens because the suspend process isn't aborted when the RTC
fails to configure the wakeup IRQ. Instead, we continue suspending the
system and then another suspend callback fails the suspend process and
"unwinds" the previously suspended drivers by calling their resume
callbacks. When we get back to resuming this RTC driver, we'll call
disable_irq_wake() on an IRQ that hasn't been configured for wake.

Let's just fail suspend/resume here if we can't configure the system to
wake and the user has chosen to wakeup with this device. This fixes this
warning and makes the code more robust in case there are systems out
there that can't wakeup from suspend on this line but the user has
chosen to do so.

Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Evan Green <evgreen@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Acked-By: Benson Leung <bleung@chromium.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/rtc/rtc-cros-ec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index e5444296075e..4d6bf9304ceb 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -298,7 +298,7 @@ static int cros_ec_rtc_suspend(struct device *dev)
 	struct cros_ec_rtc *cros_ec_rtc = dev_get_drvdata(&pdev->dev);
 
 	if (device_may_wakeup(dev))
-		enable_irq_wake(cros_ec_rtc->cros_ec->irq);
+		return enable_irq_wake(cros_ec_rtc->cros_ec->irq);
 
 	return 0;
 }
@@ -309,7 +309,7 @@ static int cros_ec_rtc_resume(struct device *dev)
 	struct cros_ec_rtc *cros_ec_rtc = dev_get_drvdata(&pdev->dev);
 
 	if (device_may_wakeup(dev))
-		disable_irq_wake(cros_ec_rtc->cros_ec->irq);
+		return disable_irq_wake(cros_ec_rtc->cros_ec->irq);
 
 	return 0;
 }
-- 
2.19.1

