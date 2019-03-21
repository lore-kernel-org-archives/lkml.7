Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D821DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91903218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gYzks3tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfCUVDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:03:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39585 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfCUVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:03:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so5095574pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 14:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5yBQ0M/OhmXb5QCARACM1aOBKJ7mpP5Yekjui5JqVc=;
        b=gYzks3tU05/n/HHYgJIuwP+fdNsCsvz3PmuxB+nb9ITy0NgEKJOSA1yq4WKOQ2ix5B
         tyWRJDkpFKYi9eXUBB0/sJr+wFafOxLqBLQjG5Hfo+alF26EewK+G2t55P1eYM+aKlRP
         ANE86vp46iG2rdCawVyH6ERDj61sJgfR20EXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5yBQ0M/OhmXb5QCARACM1aOBKJ7mpP5Yekjui5JqVc=;
        b=hIvVnOvOY9zIJ7tTHoyMeLja5CQ7w5U7k6ecIY1qIbY858Ae+Yjk4M61a1XKCfF2zA
         O+UsbSKdTiQKGyu9DBYoPNK7kQ6c3x2Hoas3ECpdUyKSSHl49T/0VdmfdXB+IKxfXFAx
         MfdYm6yTd2K3rQZAy44nvm82kekDp1cRA1OWvb/39kgXgEUvmI5hPV/w/tkyVMnUeQQk
         Bc5QPlz0lJNO3PVDEnVu7CM0lUgJjLhhUmGyULqGDapIsofL3bOar4/SVt5UBXS1jE9C
         kMfq+ysHDbzDzZ+wIYW0V8cgtWGG2++1E0SwL7RnSYV1qQrmMCV5wssFH5PiigJTWul9
         WuSQ==
X-Gm-Message-State: APjAAAUFHmBEjwW0JfrrdwWKWASBuOlJZCfg5XU3fJZdMBDQBCSh3WSL
        VM87c3XJB7ewaM1PEuNBO4VXAA==
X-Google-Smtp-Source: APXvYqynyPsBeq1Ii3jygk96zE/VxS3Zv01+6+vi0dPs2X8WCgPYWcP7rXaTaYMLi1LOBiKplxy0zw==
X-Received: by 2002:a17:902:b481:: with SMTP id y1mr5705303plr.338.1553202230822;
        Thu, 21 Mar 2019 14:03:50 -0700 (PDT)
Received: from egranata0.mtv.corp.google.com ([2620:15c:202:1:e209:54cf:7c16:6776])
        by smtp.gmail.com with ESMTPSA id u14sm7441079pfm.66.2019.03.21.14.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 14:03:50 -0700 (PDT)
From:   egranata@chromium.org
To:     lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     gwendal@google.com, amstan@google.com, egranata@chromium.org
Subject: [PATCH] mfd: cros_ec: Only register a positive IRQ number
Date:   Thu, 21 Mar 2019 14:03:47 -0700
Message-Id: <20190321210347.34793-1-egranata@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

Add a layer of sanity checking to cros_ec_register against attempting to
register IRQ values that are not strictly greater than 0.

Signed-off-by: Enrico Granata <egranata@chromium.org>
---
 drivers/mfd/cros_ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 6acfe036d5222..ff8984a2b8c21 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -118,7 +118,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		return err;
 	}
 
-	if (ec_dev->irq) {
+	if (ec_dev->irq > 0) {
 		err = devm_request_threaded_irq(dev, ec_dev->irq, NULL,
 				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 				"chromeos-ec", ec_dev);
-- 
2.21.0.225.g810b269d1ac-goog

