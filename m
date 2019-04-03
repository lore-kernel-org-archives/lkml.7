Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173F4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA58F206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp+FtYfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfDCE2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:28:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44318 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCE2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:28:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so7629262pgj.11;
        Tue, 02 Apr 2019 21:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okQiFa1LucnY9MvnxTQta/a/jKxZN0Lx4xzIHtSBdfk=;
        b=gp+FtYfG89oTn0cjPZgm29E/rVv0nns0d/TVCFbygFk1U65bgu8hIFVOivuOQ6evJX
         8j5XrJpkkcIfApXGTMqGPG9dLC3wK0DgE2rPVs+4jD6tvuc03KvfBAoaaI1RJBTZwsgk
         21qoEKE96HpFMz0HxbMfPY/0c1KpAP83N7PXXh8QKVsa+8dgUg4LNukLi1QuQ1kt1Cuk
         aUdEUs7LVrjdJ+GLFk0Nwcp/1avGs44YLG9X/aVCdM75Z58w/rAOpVimAkXPFDg8teFE
         c3VzVoElVAwZWS7PvwbzdC5fcfUfFRgQzg+kUVrmt1Wb7clQpiKmu2+CxIFPN5ZBRf+x
         O+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okQiFa1LucnY9MvnxTQta/a/jKxZN0Lx4xzIHtSBdfk=;
        b=cTywPip9p250CEzeVnU0X6Gibrz21pAAvFwEmOpIXR3+88LA8WYzDFW0CnWCVkdwXU
         uHIJWHbzfiKOX1d8Ub90BpQSlFwY8P/HQKwndJzLRjGVI4rGSzJ42zx86z1oUgbxEQzp
         41i3b63ZveCvc77CDNGiVz4BBfiWhzyovmw4lAgAqswqXu1d7QsIkOh6M6ergiYw62PN
         w25DpCCcGaAVl5miv1P91hO6ELTA3AVzr7ww6cLpOB1158TKLzMXgb8Uk57s+z7I2jbC
         17/2JUKCsAvOmSef+Kz0IB+KkZXHhOM6jAIqOIYzb4Af1WZiZtaypa4sMrJb5rWJaaR0
         5hrA==
X-Gm-Message-State: APjAAAX2mAiCiagwBoxEyUtabD/e+fW570BAz/t4UekQ2y0slhSXPFhZ
        5/oTasNEdAmM/Pfl8agNbss=
X-Google-Smtp-Source: APXvYqy/VCfgtRfYQVJPgR6QYFvCt+pHfm0O4I3h7G9OHoh6fqdo7YLngUFBRN2mvE9bufudlCe+kA==
X-Received: by 2002:a65:5685:: with SMTP id v5mr68870041pgs.365.1554265702855;
        Tue, 02 Apr 2019 21:28:22 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id r145sm7138450pgr.84.2019.04.02.21.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:28:21 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (iio_hwmon) Simplify attr.name generation in iio_hwmon_probe()
Date:   Tue,  2 Apr 2019 21:28:11 -0700
Message-Id: <20190403042812.26357-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since every call to devm_kasprintf() in the switch statement is mostly
the same, we can move all of the shared code outside and capture
differencies with two helper variables. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/hwmon/iio_hwmon.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 5c3c08449de7..1770423f7a80 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -92,6 +92,9 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < st->num_channels; i++) {
+		const char *prefix;
+		int n;
+
 		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
 		if (a == NULL)
 			return -ENOMEM;
@@ -103,28 +106,28 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 
 		switch (type) {
 		case IIO_VOLTAGE:
-			a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-							       "in%d_input",
-							       in_i++);
+			n = in_i++;
+			prefix = "in";
 			break;
 		case IIO_TEMP:
-			a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-							       "temp%d_input",
-							       temp_i++);
+			n = temp_i++;
+			prefix = "temp";
 			break;
 		case IIO_CURRENT:
-			a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-							       "curr%d_input",
-							       curr_i++);
+			n = curr_i++;
+			prefix = "curr";
 			break;
 		case IIO_HUMIDITYRELATIVE:
-			a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-							       "humidity%d_input",
-							       humidity_i++);
+			n = humidity_i++;
+			prefix = "humidity";
 			break;
 		default:
 			return -EINVAL;
 		}
+
+		a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
+						       "%s%d_input",
+						       prefix, n);
 		if (a->dev_attr.attr.name == NULL)
 			return -ENOMEM;
 
-- 
2.20.1

