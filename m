Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E7DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACA62166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103060;
	bh=6edj2RMHxJ1GdalHBATV/N2v4H6FUIHzV4FX8tASp94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fKDQI5UjTUkyPQHYJrDL6sh/vnmpWaz6WLIUZvzgJh8+t69npEBRtOfgkJ2cXUqsg
	 wpe11AF05zoAgk/Lu/DHq54uJ98JCrlCbErQfOW1BjUjGwmCrOAedgEviYiyVX08dY
	 +Udz9wpDb85p+YHbCeL0zqKBwhtKXPntpnIrZSbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfH2SYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729791AbfH2SQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:16:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A4323404;
        Thu, 29 Aug 2019 18:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102592;
        bh=6edj2RMHxJ1GdalHBATV/N2v4H6FUIHzV4FX8tASp94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQWQD69OESZgHZN4suBOf/kTyUZkaQTU7bRdoRmRo1MOox2TUzlcC60E4BQE5hVxh
         qsx5uoVO1BkrFYd3s4Jfefm+7fSjLJ8Sqs8FB1ynbQh/37Ne5EbfBMdQd1bPe4Y2FN
         HsPTYZO2YY6Uqa2UGr5FKaTMt9qyZmentxQH4bJU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 30/45] HID: cp2112: prevent sleeping function called from invalid context
Date:   Thu, 29 Aug 2019 14:15:30 -0400
Message-Id: <20190829181547.8280-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181547.8280-1-sashal@kernel.org>
References: <20190829181547.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

[ Upstream commit 2d05dba2b25ecb0f8fc3a0b4eb2232da6454a47b ]

When calling request_threaded_irq() with a CP2112, the function
cp2112_gpio_irq_startup() is called in a IRQ context.

Therefore we can not sleep, and we can not call
cp2112_gpio_direction_input() there.

Move the call to cp2112_gpio_direction_input() earlier to have a working
driver.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-cp2112.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 271f31461da42..6f65f52572368 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1160,8 +1160,6 @@ static unsigned int cp2112_gpio_irq_startup(struct irq_data *d)
 
 	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
 
-	cp2112_gpio_direction_input(gc, d->hwirq);
-
 	if (!dev->gpio_poll) {
 		dev->gpio_poll = true;
 		schedule_delayed_work(&dev->gpio_poll_worker, 0);
@@ -1209,6 +1207,12 @@ static int __maybe_unused cp2112_allocate_irq(struct cp2112_device *dev,
 		return PTR_ERR(dev->desc[pin]);
 	}
 
+	ret = cp2112_gpio_direction_input(&dev->gc, pin);
+	if (ret < 0) {
+		dev_err(dev->gc.parent, "Failed to set GPIO to input dir\n");
+		goto err_desc;
+	}
+
 	ret = gpiochip_lock_as_irq(&dev->gc, pin);
 	if (ret) {
 		dev_err(dev->gc.parent, "Failed to lock GPIO as interrupt\n");
-- 
2.20.1

