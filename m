Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61457C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9C5206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="egEFk8xV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfCMU00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:26:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45178 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfCMU0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:26:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id d21so1253895edx.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9B+OEl1xN6+JMUU1McDorXUZKv7xk++ozgoePbHhQA=;
        b=egEFk8xVfbxuYEcdKaBH7ezWmFJzNm80Y4DBAgb40fA+uXVLZtjLG+nP5D6pW6a6yW
         7g66ITEuM5TUaIgpXfjlZ565oOtK07/j3jgws/+IUoo86en01zMgxZPz2T9OOSmpqw1B
         79dNOUGHwc6Dqp4XD09X6ZngZNwk/rM71QW7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9B+OEl1xN6+JMUU1McDorXUZKv7xk++ozgoePbHhQA=;
        b=XJcr1nMS2Hut89WHaepU1sxMqP7ho5BK5Jh9TcHhiGkCKxWZ0FiXM5OVYuVRtjDhpk
         lbTW39HC1G35gACIliWijTiJdPjC5gVBirOi0xa2l9tjw/UkmZAByIlHaE4fEes/G4cG
         ZRnFlKBF4XjEHD6Wdr8FU0Pq+IiXrItP7caX7eiI8Z5e2QdVXrlmvvPFFmH7Xzbky515
         CE+oeeh8AqIWSSvrBjzvI2htzZbxR1XJAcB2/35PCMudX8yVXgEenVE1ijNcq/ZrNLkQ
         BTaCcipQ3ycZJ/zeQxAeyOOsYoEllgJJj23nZHCMFL9Qf4URnTvI3RkpGucY+D+CJTsG
         eGPQ==
X-Gm-Message-State: APjAAAWNJpwY67GVqQWI5/te96XWo1WTIYZExARe31lnuIfaa+TfqNV2
        9TtKDBVTBzUaB38pBy3Nwb1r+A==
X-Google-Smtp-Source: APXvYqyNLGKyJAbVnmeU8Eap/9kxtNRHgLp6UV1Y13Shh5f7bwOy9chh3h12u8l23O2zr+qKE4nGpA==
X-Received: by 2002:a50:c352:: with SMTP id q18mr8961183edb.175.1552508780906;
        Wed, 13 Mar 2019 13:26:20 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-119-202.cgn.fibianet.dk. [5.186.119.202])
        by smtp.gmail.com with ESMTPSA id m32sm940170edc.17.2019.03.13.13.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:26:20 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-leds@vger.kernel.org
Subject: [PATCH 2/4] leds: netdev trigger: factor out middle part of device_name_store
Date:   Wed, 13 Mar 2019 21:26:13 +0100
Message-Id: <20190313202615.22883-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take the part of device_name_store that puts the old device (if any),
copies the new device name, looks the name up etc. into a separate
helper function. This is preparation for using that helper from a
function that will initialize the led_netdev_data from a device tree
node. No functional change.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/leds/trigger/ledtrig-netdev.c | 30 ++++++++++++++++-----------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index ddc2b90ad7ec..55153a7e8433 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -104,19 +104,9 @@ static ssize_t device_name_show(struct device *dev,
 	return len;
 }
 
-static ssize_t device_name_store(struct device *dev,
-				 struct device_attribute *attr, const char *buf,
-				 size_t size)
+static void set_device(struct led_netdev_data *trigger_data,
+		       const char *buf, size_t size)
 {
-	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
-
-	if (size >= IFNAMSIZ)
-		return -EINVAL;
-
-	cancel_delayed_work_sync(&trigger_data->work);
-
-	spin_lock_bh(&trigger_data->lock);
-
 	if (trigger_data->net_dev) {
 		dev_put(trigger_data->net_dev);
 		trigger_data->net_dev = NULL;
@@ -137,6 +127,22 @@ static ssize_t device_name_store(struct device *dev,
 			set_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode);
 
 	trigger_data->last_activity = 0;
+}
+
+static ssize_t device_name_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t size)
+{
+	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
+
+	if (size >= IFNAMSIZ)
+		return -EINVAL;
+
+	cancel_delayed_work_sync(&trigger_data->work);
+
+	spin_lock_bh(&trigger_data->lock);
+
+	set_device(trigger_data, buf, size);
 
 	set_baseline_state(trigger_data);
 	spin_unlock_bh(&trigger_data->lock);
-- 
2.20.1

