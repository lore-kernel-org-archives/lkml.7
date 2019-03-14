Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D2AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91172184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="B2aH6ObB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfCNOGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:06:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34435 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfCNOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:06:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id y18so4347105lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugGKi5F3qXScZthoWLEHSmP8Nu33dGLtFdl4STCni7Y=;
        b=B2aH6ObBaC1172QGpMisaDebLrcbytqQT/FKIKSuV+U6ps4USRVv3PkPQe/uXrkpwa
         yeBqa0lso6v4mjsnhbehFbEiqz5TyB59ox+piIIFDH86db5aykXOl6+UQ8+4TNF0Ua7Q
         iLPZaRq09A6BlybsDJeE3HjpmN0pq88OEVxUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugGKi5F3qXScZthoWLEHSmP8Nu33dGLtFdl4STCni7Y=;
        b=da10LEQv9YIvKN9BnuClx2Z6VLeFpzm5sX41QyZ97Ee5JtUfueaVXHMYwrjTh2K3f3
         w7xh+DmgI19xNEQ2k9riRMjHQ36Kh8jbOWOt+4NVG+sCU98P9Gwyg/IDDcvxFhDx6tF+
         IIA5OFdgyEDBg4y8CXQP5BoOvH3xj+2LPk9UMfdZRuIRlkZS0++uQWfRsF6IgeDqEvOC
         O6neV2WgFUz/S19R+jbDWQ/eH62H3Wr/N8Mk0Bh2qbNF0qAb0Hu+J7vSHJI9OOsaXZ8B
         myqXC3//JSC7eOV8757JDSKBnsyjAhxhPMpxgU36JUfVUl4GcXtlmvH78Z03XISLSZgo
         IMtw==
X-Gm-Message-State: APjAAAVa8xr8IcLfQELbAv2f+W6ESZrx4kLqJJEA2ipaQ/088rjO3epj
        iemTQvjRIn4HV1PX+fUysOrWWA==
X-Google-Smtp-Source: APXvYqwB0eFDalUXWboIO+dJctOVT+OgHKhmOq+cX07CDTXjqnKY/5e7cjnNrZV9Ol+2UGh0VYfYqA==
X-Received: by 2002:ac2:52a1:: with SMTP id r1mr22361245lfm.155.1552572387367;
        Thu, 14 Mar 2019 07:06:27 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t14sm2733709lfe.51.2019.03.14.07.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:06:26 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-leds@vger.kernel.org
Subject: [PATCH v2 3/6] leds: netdev trigger: move newline handling back to device_name_store
Date:   Thu, 14 Mar 2019 15:06:16 +0100
Message-Id: <20190314140619.3309-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190314140619.3309-1-linux@rasmusvillemoes.dk>
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, setting device_name to a 15-character name requires
avoiding a trailing newline (e.g. by using 'echo -n' or 'printf'),
which is inconsistent and potentially surprising. Instead of
potentially including a newline in the copy and then overwriting it,
move the newline detection logic to the sysfs handler itself, and
handle it by passing a smaller buffer size to
netdev_trig_set_device().

This also makes netdev_trig_set_device() a better fit for a future
user, which will not need the newline truncation logic.

We still have to tell userspace we consumed all the bytes it gave us,
so we have to stash the original value of size.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/leds/trigger/ledtrig-netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 21605033e322..c35439291424 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -114,8 +114,6 @@ static void netdev_trig_set_device(struct led_netdev_data *trigger_data,
 
 	memcpy(trigger_data->device_name, buf, size);
 	trigger_data->device_name[size] = 0;
-	if (size > 0 && trigger_data->device_name[size - 1] == '\n')
-		trigger_data->device_name[size - 1] = 0;
 
 	if (trigger_data->device_name[0] != 0)
 		trigger_data->net_dev =
@@ -134,7 +132,11 @@ static ssize_t device_name_store(struct device *dev,
 				 size_t size)
 {
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
+	size_t orig_size = size;
 
+	/* Ignore trailing newline */
+	if (size > 0 && buf[size - 1] == '\n')
+		size--;
 	if (size >= IFNAMSIZ)
 		return -EINVAL;
 
@@ -147,7 +149,7 @@ static ssize_t device_name_store(struct device *dev,
 	set_baseline_state(trigger_data);
 	spin_unlock_bh(&trigger_data->lock);
 
-	return size;
+	return orig_size;
 }
 
 static DEVICE_ATTR_RW(device_name);
-- 
2.20.1

