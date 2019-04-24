Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395D2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CD821901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116769;
	bh=6qqmETBo/nc4faKEAgvHUD6ZCm0mocVHbn1DDQT2a4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R5fsvFMWZDHpcwNVJNcYZtjBDTCGJ82/wJar3qjVJmz5zRepKIA1i12qS6t/ds8OF
	 v5XOtk6DfWyqhCcY134y9Gj/xS6bwJsM3XqUVbBj7cZ1vGix+lmHsTTFtM355cuu1H
	 BxySSkb/YHThuXhcliYY//oT8jKRSyDMGDj4OEis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfDXOj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731484AbfDXOjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:39:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 210E921901;
        Wed, 24 Apr 2019 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116763;
        bh=6qqmETBo/nc4faKEAgvHUD6ZCm0mocVHbn1DDQT2a4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjDvpk+IGUtPwvCieqM87xJNB2DojiuL8fZpbVDXAE1RC8ue9v8TaHy0I1vmU379/
         KX3ag90Jln0ccRgacD0K5oVu7Cx8IyCCDsUbKn34s1qvByWSEobdqyP+m3RwCUHQ1N
         tQgxc+hevMJkwUd3SdeqtjdtjDvk7QW5gRskVfBw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Evan Green <evgreen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 04/52] rtc: cros-ec: Fail suspend/resume if wake IRQ can't be configured
Date:   Wed, 24 Apr 2019 10:38:22 -0400
Message-Id: <20190424143911.28890-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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

