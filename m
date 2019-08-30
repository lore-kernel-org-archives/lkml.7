Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E5CC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624E42343B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lu7ZUv1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfH3XOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:14:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43914 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbfH3XOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:14:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id u72so65581pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DblqVMf34hMNyXOCfqlu1+pxq8Y4o7xFhCvha+18heY=;
        b=lu7ZUv1P5KNPaRgCwN1OFp4eqid6v04uKqKyMBxti9T4ju6aY3AZlgADmWgRV3GBEK
         Oy+kpKcNV6B6gzJTjzJWZ1R9jAk4YwFhLImwWoxnPESnwW2I99fUn4NEPEBhGngeOxcp
         Biq5GnAMEheK6y4A5Cx0LHSTYKv8irzJ99g9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DblqVMf34hMNyXOCfqlu1+pxq8Y4o7xFhCvha+18heY=;
        b=KwzljSKnDvGKUDiekPQCJ63AyOs9ySOFWjEryo9Czg9o7xRyVXeSisbfdt2gqb+BcE
         ERYL8u1hMonG5Mo/8dDYiMusXkJWA8Uwk9HpEVwJk5W+lD3917xKGSZCJO+ui3G/dLM8
         z3VnJxi9eXuqQs20omgkEUbIbKpvPra0eavWXY4A8vuGWnK5uKkAuDyU9s93AJIBz3Uh
         1YjNe5Dg9sPwyYuftXdsdG961UP3ChUeEL3ifrCVROyegIseDNXsCVi4WePItl4tsQEq
         cQZWuNL/3Ynxl8sHIeiryM9cTXLA15X9Tc+sKF0I83MSCRjpqzXN+ahQwkp0DVRKSrzQ
         oCOg==
X-Gm-Message-State: APjAAAX0Fd4ZhlJW+6xHmKkIJHmuL2kDoaGfolQLgZecUZxyXrA/9yd3
        o5JtlMrPvItXYxX2qko14eERquae0F0=
X-Google-Smtp-Source: APXvYqxgjH+OzJ9CZ+QTRRBlksQxNC8qDDvwpBIO4uxfxc2dxO32ib6d1qLQ0tpEjk/I+b+9I2pkAw==
X-Received: by 2002:a17:90a:4483:: with SMTP id t3mr542682pjg.59.1567206848320;
        Fri, 30 Aug 2019 16:14:08 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id u10sm7741154pfn.94.2019.08.30.16.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Aug 2019 16:14:07 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        swboyd@chromium.org, tbroch@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH] platform/chrome: chromeos_tbmc : Report wake events.
Date:   Fri, 30 Aug 2019 16:14:04 -0700
Message-Id: <20190830231404.60005-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark chromeos_tbmc as wake capable and report wake events. This helps to
abort suspend on seeing a tablet mode switch event when kernel is
suspending. This also helps identifying if chroemos_tbmc is the wake
source.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 drivers/platform/chrome/chromeos_tbmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
index ce259ec9f990..d1cf8f3463ce 100644
--- a/drivers/platform/chrome/chromeos_tbmc.c
+++ b/drivers/platform/chrome/chromeos_tbmc.c
@@ -47,6 +47,7 @@ static __maybe_unused int chromeos_tbmc_resume(struct device *dev)
 
 static void chromeos_tbmc_notify(struct acpi_device *adev, u32 event)
 {
+	acpi_pm_wakeup_event(&adev->dev);
 	switch (event) {
 	case 0x80:
 		chromeos_tbmc_query_switch(adev, adev->driver_data);
@@ -90,6 +91,7 @@ static int chromeos_tbmc_add(struct acpi_device *adev)
 		dev_err(dev, "cannot register input device\n");
 		return ret;
 	}
+	device_init_wakeup(dev, true);
 	return 0;
 }
 
-- 
2.21.0

