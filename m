Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B5FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D30421852
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEXG5Ymx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfGZHVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:21:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38610 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfGZHVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:21:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so24068458pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QHmeFCcRm+yEbC4xEQQF9vpwOjMBYA4nCsJn8Kx1Tas=;
        b=HEXG5YmxiIOHcEwSXuU2aCFlJXGEIpwbgt9Eh0I6hqlvTMAmY7bs1PThjJXaPsx4nR
         tWs/sU+uR+oSelP7fi0/rRv7U1cRNZp4b2VO9fyt9qVNr6vU+mWNc7E1ZBjHpXq0t8KY
         NOnuWuN12MIHXJAMMZ0X/rufu/0PYNPAzj5JmbEfoMTeygNVm0nCYHbRm+tdrikzPdRB
         8FuZEKx+S8364wt6kjASzDF9MDTeIEHFUHfTix6p9j/NTXD0VO5lp4jT0ksN4YWb28Lq
         rdyJK9BJQ9DPemvO9/oD50LIn7mvO3y4rbX6qG10CFupU/m8ZEPspljP/x9QbE+2NS3X
         PcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QHmeFCcRm+yEbC4xEQQF9vpwOjMBYA4nCsJn8Kx1Tas=;
        b=stsAdCbrVgqZ4/hfXEst7oN+12JMp1MAWvU0KOJuULt4X6VjjSKRwLFzyggBhYgS2w
         DK1zx/RoKFOnnABzr5gv7QBWfSSvdqxjTfWWTQW0R8SsMzatCKmn06PR6zMojNqW8XsW
         iCDv13Ms6HzNdZH/TAnVfhDF5uXy1w8TCnCQW6TPzDJsNtMbEGjgc1nsxr84e+NXdyon
         rgww++i/VZ6tnpsR44DmUGdjoyLF6HHMZZD3/E8vFAGYt4GljQx6VyZjXsafe8sdFZ19
         BA9D50P+tN6bxGzujeBC2xdra/ApeTmMGTUX1YKTvdiQided+QMChV/edZ3HpWqTfhjZ
         Vk4g==
X-Gm-Message-State: APjAAAUjZunilKaZHg6otsya/d5XEfslIeM6vKHY9owOGZzZ8ruuwMRv
        CeO0XlfBA/HpHFl5k9RZ3OjU2Q==
X-Google-Smtp-Source: APXvYqwsI7ilGE+Dh1ch3/ZUKEK76Us6PDpSv8/S06k5Wvl1AzJQeM27/zivWFtKVdIH0kp7W0O4Yw==
X-Received: by 2002:a17:90a:2506:: with SMTP id j6mr62610508pje.129.1564125692965;
        Fri, 26 Jul 2019 00:21:32 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o12sm39216152pjr.22.2019.07.26.00.21.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 00:21:32 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     weicx@spreadst.com, sherry.zong@unisoc.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] spi: sprd: adi: Add a reset reason for factory test mode
Date:   Fri, 26 Jul 2019 15:20:50 +0800
Message-Id: <8ae5651e876b527920ff878721a8a8ef47b099ac.1564125131.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sherry Zong <sherry.zong@unisoc.com>

Add a new reset flag to indicate that the system need enter factory test
mode after restarting system.

Signed-off-by: Sherry Zong <sherry.zong@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 0b3f23a..509ce69 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -98,6 +98,7 @@
 #define HWRST_STATUS_AUTODLOADER	0xa0
 #define HWRST_STATUS_IQMODE		0xb0
 #define HWRST_STATUS_SPRDISK		0xc0
+#define HWRST_STATUS_FACTORYTEST	0xe0
 
 /* Use default timeout 50 ms that converts to watchdog values */
 #define WDG_LOAD_VAL			((50 * 1000) / 32768)
@@ -339,6 +340,8 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 		reboot_mode = HWRST_STATUS_SPRDISK;
 	else if (!strncmp(cmd, "tospanic", 8))
 		reboot_mode = HWRST_STATUS_SECURITY;
+	else if (!strncmp(cmd, "factorytest", 11))
+		reboot_mode = HWRST_STATUS_FACTORYTEST;
 	else
 		reboot_mode = HWRST_STATUS_NORMAL;
 
-- 
1.7.9.5

