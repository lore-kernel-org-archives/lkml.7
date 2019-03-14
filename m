Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F9BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439FB2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="g/5ym+NN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfCNOGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:06:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38687 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfCNOG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:06:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id a6so1947818lfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fnGp6MyrIgI8CJxIUeRKJX4O7LkaHin0DCpR0E8fmSQ=;
        b=g/5ym+NNS54tZz0hahiy+J2jB0O3LEfeUQZwXF74pLWMhcf7Xk+28KBS6+wnp6e2wS
         zyGUNUvjeUp51arpj27nRJaEDNwj4OVOn7cDuIFQ77hYfyqDec/IpvSVcTDET7jK0LpM
         JyMtJDm2iCYuQmIOBG//oa2X53yJqVTdXUwMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fnGp6MyrIgI8CJxIUeRKJX4O7LkaHin0DCpR0E8fmSQ=;
        b=py+igYGqLz9ntkQDEn/9wlBhocGDL+M5pAMZpArSHJdWmpFzE89LPgfSpgk7NkcVCs
         HkMfH1yuB1nR51EmxeiOZ3cxNTHUK5iqB7yZDg6iLA7O0lho74k05ZQ5IlJwFtNZI6Hy
         Yh0/8pt6KJgBsoTx4bC7e0Mk5O5L3p+ndrINppqFb/3eO70Jn+QRTuiGXG9JD13A1bCs
         hl35c4V1aCiNsAhS9lGRmirbbx3EO+8LZM+m5HhJYPh2rFq6Es6dULKdvQ+12U4srE41
         zrDX11oUnpfLug56BTumrNrdnJD+SqEsCDc0/MfhEHXxCVt/ZJ+Hr+ctp4mYgLYfvjvF
         RWbw==
X-Gm-Message-State: APjAAAXjYq/yAWJMkYTV+zmczvxqUxeoLriIJcyw43RfRy2w4o/tgvMT
        +QgLHiQwFDw+imCmCpSKxTxaCQ==
X-Google-Smtp-Source: APXvYqyyNyfqD3yFDcLdcUqnE01Fpq1P2xAvspoAKvpezFk018aLKEJluSXsEu34aWCK9cXJzzrBVg==
X-Received: by 2002:a19:f615:: with SMTP id x21mr27507954lfe.16.1552572386226;
        Thu, 14 Mar 2019 07:06:26 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t14sm2733709lfe.51.2019.03.14.07.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:06:25 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-leds@vger.kernel.org
Subject: [PATCH v2 2/6] leds: netdev trigger: factor out middle part of device_name_store
Date:   Thu, 14 Mar 2019 15:06:15 +0100
Message-Id: <20190314140619.3309-3-linux@rasmusvillemoes.dk>
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
index 8d476b92f58c..21605033e322 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -104,19 +104,9 @@ static ssize_t device_name_show(struct device *dev,
 	return len;
 }
 
-static ssize_t device_name_store(struct device *dev,
-				 struct device_attribute *attr, const char *buf,
-				 size_t size)
+static void netdev_trig_set_device(struct led_netdev_data *trigger_data,
+				   const char *buf, size_t size)
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
+	netdev_trig_set_device(trigger_data, buf, size);
 
 	set_baseline_state(trigger_data);
 	spin_unlock_bh(&trigger_data->lock);
-- 
2.20.1

