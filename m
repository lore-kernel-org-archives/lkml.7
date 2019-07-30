Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1FBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E8D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NUZDgnrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfG3SQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41958 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387875AbfG3SQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so30271066pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJlVBcFw6cgQmE2TcJCLwuGNy4X0qqoZ4PXxrXo9yOs=;
        b=NUZDgnrnyDsEg+yvm339bqt4rMbfBLxY/tz2XFFLV3q1UxiT+G/pmXejX0awBm9gRQ
         YA4PnbOkaRVFki/qNwU54yjzc6A3SL6iIIHXUkYLwnr+x25aow3eHDRXXF7IJPnMwNae
         7tc8162WwXeDjKZAehgf5qPfDRSrUdgEGlJx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJlVBcFw6cgQmE2TcJCLwuGNy4X0qqoZ4PXxrXo9yOs=;
        b=c1H7CLGAIMqYAm0lP1bIXWgWGRl+ROyc7TihxR0n7prjBzxd6gYVbWMPW/lbt90RFV
         QOZoEokeSuAX6NF9cIHgbAch2LNxMd3sGXLZjNXHcr/UhBPgKfXWbmeOGtHO8atnWOV4
         /hTVpO+nEwa+KEyFsmP1q27QPpElitWfe1IpvKPiSYZ4ROEib/ix+9nmwJUNZyaqnvGj
         jpoiJVxUtoMCiHThnqHYPs+yfpIs3F+bjoWRopGjAYPA8I1B0uGTTO27ZUJnbKfF8ncw
         vrxj2NJoCp6+SV48+gboaBCCmiYCZoT9QG/H36nwqJ7Icy9cG1anvzJ5KER+I1j43SEQ
         GKzQ==
X-Gm-Message-State: APjAAAVXDJfW65ewg8YUp+vSF8wQOpZjEJ/YdUM0vonmK2bUW31tba3w
        AArJ/c9V37mu+jhYg0q3mNgqojgFS/s=
X-Google-Smtp-Source: APXvYqwxMVIkSlnyMuemYnqyVg6VCF6ylAjcO36mqfgO0GWe5e7cRnDDEAeUwhteeNYBMdgj63U28Q==
X-Received: by 2002:a17:90a:bc42:: with SMTP id t2mr117788662pjv.121.1564510573785;
        Tue, 30 Jul 2019 11:16:13 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:13 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 17/57] hwmon: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:17 -0700
Message-Id: <20190730181557.90391-18-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/hwmon/jz4740-hwmon.c    | 5 +----
 drivers/hwmon/npcm750-pwm-fan.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
index bec5befd1d8b..47bed41b55a1 100644
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -93,11 +93,8 @@ static int jz4740_hwmon_probe(struct platform_device *pdev)
 	hwmon->cell = mfd_get_cell(pdev);
 
 	hwmon->irq = platform_get_irq(pdev, 0);
-	if (hwmon->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n",
-			hwmon->irq);
+	if (hwmon->irq < 0)
 		return hwmon->irq;
-	}
 
 	hwmon->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hwmon->base))
diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 09aaefa6fdb8..11a28609da3c 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -967,10 +967,8 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 		spin_lock_init(&data->fan_lock[i]);
 
 		data->fan_irq[i] = platform_get_irq(pdev, i);
-		if (data->fan_irq[i] < 0) {
-			dev_err(dev, "get IRQ fan%d failed\n", i);
+		if (data->fan_irq[i] < 0)
 			return data->fan_irq[i];
-		}
 
 		sprintf(name, "NPCM7XX-FAN-MD%d", i);
 		ret = devm_request_irq(dev, data->fan_irq[i], npcm7xx_fan_isr,
-- 
Sent by a computer through tubes

