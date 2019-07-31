Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BB2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FC920651
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jH3yCYNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfGaK4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:56:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42912 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfGaK4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:56:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so65136054lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWUtb7zcpjriA4PXCl0a7ByZXS09QukiEbZhHIw2Fjk=;
        b=jH3yCYNA8+Yew2LxOI67IHkIjKIsIvFHYzr03cz0THjJFGu0OSsiDwfWUan3chbQpm
         mZEmEi3yMQkW1v4HReuKE3j4j9p/8Wx1FKkBKXDmoKkeeNOzFy1e48b9yGjieDjSvsLl
         q6eJ0Q3q7/4RU5n4aXwx1Il4o8xewvLD3mclXDsKyWQwmw6bds/boYFyVWwpAL1NV7N6
         P3d9H0F6jh2iWh6vDuzyv9gWB6jawLP/p5I8bS9gfxJ4IGJzLQUx1/wwy2IxRGylUo9x
         Mqx/a4sZNY16xHx/NQ2Se9O54+kiXJrC7MQtmbgVdCRhev9A/ltJvrS1pJnXqlQhKfwl
         xyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWUtb7zcpjriA4PXCl0a7ByZXS09QukiEbZhHIw2Fjk=;
        b=b5riUviBgBerzDlda2igkLpqwD/lQLddNBlya+dkiUl+xYCFMfLTkwLI6PYB0+BLb9
         P9m3WPZ+qCLtzy5HmlqgDU0FFos+gt//fD7YYW9HoZtXeqQMhRciCbgMPojyU7D23oR2
         XAcLazO71qNjQrIYvLg167zBTQIrtbIhNkUroxDIlsg4LHHz6UyTeCcRm7sXeWJoF+03
         1ASs5I0f8XRW24NUlATUSlfHjIpQFxLQ5KVqjkvmREQ0vsutaazVnMegiXkOTb4Xd1JP
         G5ETpMCRBVKhIIV4USxGo/7RBtYoIZDgCpc61V0zWdinJYpqu5MQXa55ZhnXqHydfNiF
         dPtQ==
X-Gm-Message-State: APjAAAVmLqiKG5LSovH1AbkHCpqDUMq4yw8pzKoHTGGQLQZOeREMZS74
        zNHQckUTUQW1FoMAm3LywRDNww==
X-Google-Smtp-Source: APXvYqxyeEQO8uE5Fdhzw9ds+s0/2GTAh6VgDFeXsuRN/l7VM3timHKnAv7SQw94o9XSRrHPLEphKA==
X-Received: by 2002:a2e:b0e6:: with SMTP id h6mr12041708ljl.18.1564570610667;
        Wed, 31 Jul 2019 03:56:50 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id l11sm13191843lfc.18.2019.07.31.03.56.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 03:56:50 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc:     linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] i2c: core: remove unused function
Date:   Wed, 31 Jul 2019 12:56:42 +0200
Message-Id: <20190731105642.29664-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC warns taht function 'i2c_acpi_find_match_adapter()' is not used.

../drivers/i2c/i2c-core-acpi.c:347:12: warning:
  ‘i2c_acpi_find_match_adapter’ defined but not used [-Wunused-function]
 static int i2c_acpi_find_match_adapter(struct device *dev, const void *data)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Rework to remove the function 'i2c_acpi_find_match_adapter()'.

Fixes: 00500147cbd3 ("drivers: Introduce device lookup variants by ACPI_COMPANION device")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/i2c/i2c-core-acpi.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index bc80aafb521f..bb6b39fe343a 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -344,17 +344,6 @@ u32 i2c_acpi_find_bus_speed(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(i2c_acpi_find_bus_speed);
 
-static int i2c_acpi_find_match_adapter(struct device *dev, const void *data)
-{
-	struct i2c_adapter *adapter = i2c_verify_adapter(dev);
-
-	if (!adapter)
-		return 0;
-
-	return ACPI_HANDLE(dev) == (acpi_handle)data;
-}
-
-
 struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
 {
 	struct device *dev = bus_find_device_by_acpi_dev(&i2c_bus_type, handle);
-- 
2.20.1

