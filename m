Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9D4C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE782082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbA+R1Yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfFLQTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:19:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44865 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbfFLQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:19:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so15613172ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Me1o0WCLHrdj4pGzYt4+EVkLIwsOiL3bGNYyI4+f4XA=;
        b=sbA+R1YyTeJkOtusG+mONsqLMlCgE67N74LkOXMJSVZdc1ZcUyjp7BFrdnYC9unTY0
         C2/FTSiAh8qCDuX1bUbS2ctJWPKUrL0q0fxQbblOIxqx+XWcwDW/Pw1N6PWmvhBTOw7G
         wVOUlTHalXYSy5Pu28GzpCxIM68ijW/hBlcT6k5ronpBnUi0/kmkKorTTqzQSqb3GL+x
         qa9RJ26zUAi0B9NFm8jnmODwJ268IwSL1wPMSpgAaX05fWZWwS7pG7S65CynDIZfmvkD
         Ll+aTS+sq6csZ3YKF3eCWakpmWBXhAz/Gvqf5mX4cN/KVh9hStUT2QVhfRSaRzgR/oTW
         udGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Me1o0WCLHrdj4pGzYt4+EVkLIwsOiL3bGNYyI4+f4XA=;
        b=fcJXUgWCvfJ+e3Nev8oIEaxLw0nKOb5/F7ObG5Gup5Cu4gdwZceW+czjXUifQbrTXE
         8v6Up1K1CGs3iPilSNYpofiZNprBsdnXE93C7C51++dNFm9lx9eplpVsSck8UR2tgavv
         QQd+dfKsKc25ItlzcDcxe6XPZlKxroY72akSbwO5wjbYMlV/5olo3favpIbOyE4ctJI2
         FcJTA/gLux7NsshBEypcEqlAiDoxLmYFpPkkvExfshHhJSMGTS72H+zimESZpcZubl8H
         Ni9shUxIsZNL72zTndr3KBooCRCeg63sD1tALlVbw7pINSDMmxjPi6RClg11CXdyo4uE
         M4XA==
X-Gm-Message-State: APjAAAUdel4we/8xVJ806IIL6XHy4MKFlvoQpF/GauAVFwS96gSDV/Dz
        dwXcRl8moFwFgCloPuQIYB3crA==
X-Google-Smtp-Source: APXvYqwKTZnFrwVKVT7cHr8poS62teJC/BsN6HcZCHUV+1IhNdTFRvrZ7N+49ciwBs18E0+L5bZ8WQ==
X-Received: by 2002:a2e:989a:: with SMTP id b26mr15046522ljj.31.1560356382037;
        Wed, 12 Jun 2019 09:19:42 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id u128sm51319lja.23.2019.06.12.09.19.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 09:19:41 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3] media: i2c: fix warning same module names
Date:   Wed, 12 Jun 2019 18:19:35 +0200
Message-Id: <20190612161935.30264-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_VIDEO_ADV7511 and CONFIG_DRM_I2C_ADV7511
enabled as loadable modules, we see the following warning:

warning: same module names found:
  drivers/gpu/drm/bridge/adv7511/adv7511.ko
  drivers/media/i2c/adv7511.ko

Rework so that the file is named adv7511-v4l2.c.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/media/i2c/Makefile                      | 2 +-
 drivers/media/i2c/{adv7511.c => adv7511-v4l2.c} | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)
 rename drivers/media/i2c/{adv7511.c => adv7511-v4l2.c} (99%)

diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
index d8ad9dad495d..fd4ea86dedd5 100644
--- a/drivers/media/i2c/Makefile
+++ b/drivers/media/i2c/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_VIDEO_ADV748X) += adv748x/
 obj-$(CONFIG_VIDEO_ADV7604) += adv7604.o
 obj-$(CONFIG_VIDEO_ADV7842) += adv7842.o
 obj-$(CONFIG_VIDEO_AD9389B) += ad9389b.o
-obj-$(CONFIG_VIDEO_ADV7511) += adv7511.o
+obj-$(CONFIG_VIDEO_ADV7511) += adv7511-v4l2.o
 obj-$(CONFIG_VIDEO_VPX3220) += vpx3220.o
 obj-$(CONFIG_VIDEO_VS6624)  += vs6624.o
 obj-$(CONFIG_VIDEO_BT819) += bt819.o
diff --git a/drivers/media/i2c/adv7511.c b/drivers/media/i2c/adv7511-v4l2.c
similarity index 99%
rename from drivers/media/i2c/adv7511.c
rename to drivers/media/i2c/adv7511-v4l2.c
index cec5ebb1c9e6..2ad6bdf1a9fc 100644
--- a/drivers/media/i2c/adv7511.c
+++ b/drivers/media/i2c/adv7511-v4l2.c
@@ -5,6 +5,11 @@
  * Copyright 2013 Cisco Systems, Inc. and/or its affiliates. All rights reserved.
  */
 
+/*
+ * This file is named adv7511-v4l2.c so it doesn't conflict with the Analog
+ * Device ADV7511 (config fragment CONFIG_DRM_I2C_ADV7511).
+ */
+
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.20.1

