Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69D4CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 10:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A36121479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 10:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ja5Mjdpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbfJ1KLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 06:11:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44784 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388168AbfJ1KLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:11:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id q26so2962651pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 03:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TSybe+dFKlqevnmjqNjuekSQWHSuKSnD0nflXZ2xCj4=;
        b=Ja5MjdptNY5444q7novwsPVMwKvLwr3tN+AhIwAlDX1p0OJEkudGvvoBJF6cDPWhiE
         cThwQ4pXjy69i1A5DQxz+oW5vrUzBGW279fFN21/S85xIxfSi9bddBSWxWWPrTZUShoD
         if4r2aNp80WuNFZk4r8i2WGUJhG+OlO8os7hgrp3sdBR4f2QromHByggmPO/jVhaDUgr
         EFfjr+aAC+ElJ0u3IgdEbh3uKVvmpeVh9mQAbsOsUHMIhO5H5BdQwCGxEy4YsK/vlu9J
         EMjbx9CBtcHVdPUHuv/FJ/ITLC0IXGD9DA2KfCD16Rt0bukMkHb0QNr4oVRm3PVkr8G7
         Qd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TSybe+dFKlqevnmjqNjuekSQWHSuKSnD0nflXZ2xCj4=;
        b=gnWyHPrsf1UrRUBb2xotlNY5VGYPGpIli71vWlWFU9SLb3E/HO/3Odu1TzcOafJtxz
         5LAcme0YVkSelXHoYocyX+TLdDOn4Kma4BPt+C3e5nzLOL2L1tDMYF34qtJKhc5/orc6
         JdxJYVFX0td+F5MG4/vZuKgiPVB2t+YxW5PchRU6P7N40oIzJGqEfWETz0LCp7vSZAl7
         BvuIn01c7pOpiTJr8CZ0maA8bCy90ojY/+um4VA33nKietEbNGLW2RdZJfREUclExFov
         eb+NUC/nk0kNo/gJIq5OE4qPwxd57LFLgUyGEeyfSd8emYh7RacmYtGJl0DeiLIruFgq
         c/ug==
X-Gm-Message-State: APjAAAVonQiybJCEiuiRdUMCKobOt0fElVVpTiG/fpt/z7bMig0iJwuH
        eohHbfs3SlB7HyFCnAXdbe0k0g==
X-Google-Smtp-Source: APXvYqyHgWSXAJOFrFZjXigKAOtcpWME0TG39UASF+T0yEKF0Dn0kf9T4eqYfNOumc9ZwvUcvBk9Fg==
X-Received: by 2002:a62:1646:: with SMTP id 67mr20094313pfw.183.1572257482219;
        Mon, 28 Oct 2019 03:11:22 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m26sm3071872pgd.87.2019.10.28.03.11.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 03:11:21 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, ling_ling.xu@unisoc.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] spi: sprd: adi: Set BIT_WDG_NEW bit when rebooting
Date:   Mon, 28 Oct 2019 18:10:31 +0800
Message-Id: <5655318a7252c9ea518c2f7950a61228ab8f42bf.1572257085.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
References: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
In-Reply-To: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
References: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lingling Xu <ling_ling.xu@unisoc.com>

When rebooting system, the PMIC watchdog time loading may not be loaded
correctly when another system is feeding the PMIC watchdog, since we did
not check the watchdog busy status before loading time values.

Thus we should set the BIT_WDG_NEW bit before loading time values, that
can support multiple loads without checking busy status to make sure the
time values can be loaded successfully to avoid this potential issue.

Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 9613cfe..87dadb6 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -77,6 +77,7 @@
 
 /* Bits definitions for register REG_WDG_CTRL */
 #define BIT_WDG_RUN			BIT(1)
+#define BIT_WDG_NEW			BIT(2)
 #define BIT_WDG_RST			BIT(3)
 
 /* Registers definitions for PMIC */
@@ -383,6 +384,10 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 	/* Unlock the watchdog */
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, WDG_UNLOCK_KEY);
 
+	sprd_adi_read(sadi, sadi->slave_pbase + REG_WDG_CTRL, &val);
+	val |= BIT_WDG_NEW;
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
+
 	/* Load the watchdog timeout value, 50ms is always enough. */
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_LOW,
 		       WDG_LOAD_VAL & WDG_LOAD_MASK);
-- 
1.7.9.5

