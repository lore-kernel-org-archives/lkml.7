Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73165C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50495206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CLGyJ8Cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbfIVRvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 13:51:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38571 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388274AbfIVRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 13:51:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id x10so6557974pgi.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0Jvq2gWf/yc3DKxkkbLAZjrOsRcmbm8R0ZFM96m1Ss=;
        b=CLGyJ8CjvFpO6DQOxgVu42i80iyo6IweyKYwfXgdn3GdBiOj+1DCVFqLwq8ReIOG/E
         WjJSnaJvrJzyOCM1bguzQT+ObydY8RbjHwfBSR7yaPHPpevZly8hGfu4HbYKJkl0CPZ4
         pLlVbq7U+4p2liJzXvsUj5ZlrHqrpK0+XkWqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0Jvq2gWf/yc3DKxkkbLAZjrOsRcmbm8R0ZFM96m1Ss=;
        b=V8PRcjeCdgPMY58MRUGncoF+e20k8hYXSZM2l33y9HOCUlT+rMXLKJuZoPyJ8V/YH7
         JESCSdJJ7FZ5TNNhzNv5/xGtfNWOd4vAzSZ+ChLFdyv2931clcoxWf1mcV2C9iZjv5i1
         cT/jS4Y2CjQMbJ/bmSjotn4FThe1MAQMNg2/cN8lyTiAcpz38ySN2sMHQ+HsXrmrHaIX
         R38FO+LKcEA4ER/uD7OI0mogCFRdKFNoZfsT5L9bt8F/YsoQdFxuQ3jOcGc0SeiTuQj4
         TDQwqIvPJDme/rRWT9e8oaEWvjegcQA6bhrd1VuT4D4MQ/f4FfDbIvsAjwDsMst4IOVl
         GNcQ==
X-Gm-Message-State: APjAAAUrVDW9QM/6tqOZbVLntB6bFhtL96F8TMZLTQ9i94jaEf2rMXUw
        QTLNsf26wuX+oEytUrCFgvF+qg==
X-Google-Smtp-Source: APXvYqwOuLPNBcsdGZoO3oSQzFhOCAEKES65yg8cyHFLtPjH+1lmOljfGpO9sgvuIW7MxzRoEqVGyA==
X-Received: by 2002:a17:90a:8416:: with SMTP id j22mr16513707pjn.39.1569174668730;
        Sun, 22 Sep 2019 10:51:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id w69sm11726474pgd.91.2019.09.22.10.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 10:51:08 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Enrico Granata <egranata@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 05/13] platform: chrome: cros_ec: Do not attempt to register a non-positive IRQ number
Date:   Sun, 22 Sep 2019 10:50:13 -0700
Message-Id: <20190922175021.53449-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190922175021.53449-1-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

Add a layer of sanity checking to cros_ec_register against attempting to
register IRQ values that are not strictly greater than 0.

Signed-off-by: Enrico Granata <egranata@google.com>
Signed-off-by: Enrico Granata <egranata@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index f49eb1d1e3cd..9c8dc7cdb2b7 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -146,7 +146,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		return err;
 	}
 
-	if (ec_dev->irq) {
+	if (ec_dev->irq > 0) {
 		err = devm_request_threaded_irq(
 				dev, ec_dev->irq, ec_irq_handler,
 				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-- 
2.23.0.351.gc4317032e6-goog

