Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2513621852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="iiyYDh0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfCNOGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:06:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37791 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfCNOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:06:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id u2so4302103lfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8EpCtqjAm4J2CBGC1CDK0h+QRPUremQspzB4HLzQkM=;
        b=iiyYDh0hQqtDSOIY3ADO4E2t/q8s7H2qCJ/oyrbHGCDuy6vRE8qrSHTXgjOmLEegOP
         IAiloUMw7Ke5+3IjG3KwtFyvr34bq9MQT9Q/g4cdppRoZxBzhnXEl25Rtr0mZ3+ZJX1N
         DDzkFRpA3uftSDnDot9ocPU/iJoyMj7MVlcWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8EpCtqjAm4J2CBGC1CDK0h+QRPUremQspzB4HLzQkM=;
        b=iN9QhKugSF5pgsoPnTrDnskJUORtIHQAYVEhRMhAWKfOumD0CT02tkAhKuITINYY3m
         bG0ExsmY5R8kM/xJHFWMDIKeKSpOyntsUWmY+6aeimtJ/2IS0bYjUE/Q1zeB+kqXWZIV
         qYJRnFeSKvsPGOaxYxTIFMbBzjeoOWKQnsT6vzRXjChWjsrDhf3lwnrPnpBCJ6PdUQp8
         Q6sAOMysAGzyTSndBW+fFRyYN/8KncVh28TLuAkKYyI1N4kgG9x4410ycoO3c3hV91bN
         q440qMBkBfD7IEOjYEo6UnfwKyuVVCnD4amsB8fULWYMxTB802OJErqe+PIExlakGGYo
         Y4/A==
X-Gm-Message-State: APjAAAXa7Gz973RjRY0feB1C7yb+3cmmrU35lFtI2uImRYa9HHO+L1Ew
        ID4eBRwNTKWqBBEDuWvMVbxNdkk9nODtttNE
X-Google-Smtp-Source: APXvYqzpk2z3DfJL4S6UzjKZnRyCDk3gmSZ35+QMup0ZVo7OrsOatZUkLGELgXwGaNdDICa1qFhHwA==
X-Received: by 2002:ac2:4310:: with SMTP id l16mr25782184lfh.58.1552572388394;
        Thu, 14 Mar 2019 07:06:28 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t14sm2733709lfe.51.2019.03.14.07.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:06:28 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-leds@vger.kernel.org
Subject: [PATCH v2 4/6] leds: netdev trigger: move name length checking to netdev_trig_set_device
Date:   Thu, 14 Mar 2019 15:06:17 +0100
Message-Id: <20190314140619.3309-5-linux@rasmusvillemoes.dk>
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

It's better to check that size is sane in the function that does the
memcpy'ing and 0-termination to the IFNAMSIZ-sized buffer instead of
relying on callers getting it right. Not rejecting size upfront does
mean we would do the cancel_delayed_work_sync(), but that gets fixed
up by the set_baseline_state() call.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/leds/trigger/ledtrig-netdev.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index c35439291424..e4a76ce4e4c7 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -104,9 +104,12 @@ static ssize_t device_name_show(struct device *dev,
 	return len;
 }
 
-static void netdev_trig_set_device(struct led_netdev_data *trigger_data,
-				   const char *buf, size_t size)
+static ssize_t netdev_trig_set_device(struct led_netdev_data *trigger_data,
+				      const char *buf, size_t size)
 {
+	if (size >= IFNAMSIZ)
+		return -EINVAL;
+
 	if (trigger_data->net_dev) {
 		dev_put(trigger_data->net_dev);
 		trigger_data->net_dev = NULL;
@@ -125,6 +128,7 @@ static void netdev_trig_set_device(struct led_netdev_data *trigger_data,
 			set_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode);
 
 	trigger_data->last_activity = 0;
+	return 0;
 }
 
 static ssize_t device_name_store(struct device *dev,
@@ -133,23 +137,22 @@ static ssize_t device_name_store(struct device *dev,
 {
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
 	size_t orig_size = size;
+	ssize_t ret;
 
 	/* Ignore trailing newline */
 	if (size > 0 && buf[size - 1] == '\n')
 		size--;
-	if (size >= IFNAMSIZ)
-		return -EINVAL;
 
 	cancel_delayed_work_sync(&trigger_data->work);
 
 	spin_lock_bh(&trigger_data->lock);
 
-	netdev_trig_set_device(trigger_data, buf, size);
+	ret = netdev_trig_set_device(trigger_data, buf, size);
 
 	set_baseline_state(trigger_data);
 	spin_unlock_bh(&trigger_data->lock);
 
-	return orig_size;
+	return ret ? ret : orig_size;
 }
 
 static DEVICE_ATTR_RW(device_name);
-- 
2.20.1

