Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4E1C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB6E218DE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946735;
	bh=l4gihC0EG1LPrmRUkSJRdFlEevjeyYnCovbSKbMjJJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpy9eTCgQIEpYocHi1rNFzff7qBh0UxUZqoLH20hY3vgTd8eqDZMjLRjxZzfYri9J
	 Hc6LbyXYqClVuvpFoixtdWCQp9gUgYvLCRQZamMGEdXbtzH6BIXqPFFoyReu7y0+Wu
	 0Eii3xZvZwTQ9aaJ7pMDLjQNbddkAZNdbgxpSYKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfIHMpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730105AbfIHMpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:45:32 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3170216C8;
        Sun,  8 Sep 2019 12:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946732;
        bh=l4gihC0EG1LPrmRUkSJRdFlEevjeyYnCovbSKbMjJJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOaYVji4OwvUzU/+RgqZ7AJCIJBQwq2f0T1v3MVUDZodUG2dDG2q6fUjUFb+OuUtC
         vv9V7hdYss6BUU9ehadG0HhDZoLf1jvwPvc359SSXnALvoxuKAR//90GTWFjIAg8Lw
         Jvc0tMlELu6tbZdhXrwD5KTJtN3/ufwaN3l7zp0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 20/40] HID: cp2112: prevent sleeping function called from invalid context
Date:   Sun,  8 Sep 2019 13:41:53 +0100
Message-Id: <20190908121122.560928004@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121114.260662089@linuxfoundation.org>
References: <20190908121114.260662089@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 4e940a096b2ac..abf1079457664 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1149,8 +1149,6 @@ static unsigned int cp2112_gpio_irq_startup(struct irq_data *d)
 
 	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
 
-	cp2112_gpio_direction_input(gc, d->hwirq);
-
 	if (!dev->gpio_poll) {
 		dev->gpio_poll = true;
 		schedule_delayed_work(&dev->gpio_poll_worker, 0);
@@ -1198,6 +1196,12 @@ static int __maybe_unused cp2112_allocate_irq(struct cp2112_device *dev,
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



