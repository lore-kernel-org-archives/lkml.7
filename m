Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AE9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968032171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vapq07DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733250AbfB1PAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:00:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45125 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732582AbfB1PAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:00:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id d24so17135189ljc.12;
        Thu, 28 Feb 2019 06:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yq5wxwSzSOiQKae/Fl8cjis8j+TFJgO/dAYMPjapJ44=;
        b=vapq07DCzt/XuHKwUMYq39NLuiN6MIJrGJi/YQynoUcw2RkShWrcfeAH08TgDTUdy4
         3qfAi2WYlkz37e43TF9y2cKPLqXr0ZH8ONph1/UKESM/2tATvG83qWQjqzI6M7P+nWsF
         mirnsXgAKUIMcHZit0WBLCNtJYjNhIiIi11UcPrR8+2TzSV56/NXs0rxrKULZB5M4HBH
         5gliRwjr6tZZDYMmoaHLN3YM+k0qULpcTiLtLGZKYLFPqZhtnHfzTfUd/oj4ibZBRj6b
         omcB2YF/nOw1iAWzNT+v36u4Q9z0c/iUzYPzoJCIUqCswvyTPPP5BIpUeLS59M8pRqSu
         gSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yq5wxwSzSOiQKae/Fl8cjis8j+TFJgO/dAYMPjapJ44=;
        b=Yqzn0BmZFX0DZ7SOV3KnLVT/za0yh6J34Ef0GU4l53v7d4kMWwIfK6vhL1BbLwdI9R
         xZdLypmbWCxcyEQWX5xTpKGMFwTSjIVE5e9TNB4py/p8CfJ5HN3OzJWCp8BuiqEk/Qr4
         TSyTg53GfvhJLGcVfQQ8mjGJ9JAFPh3d/NTL9n2jMJoLFprhBuElv9AWUSGnSLPkXAAK
         SqRMQLac1v6VhSqrphej1wLQurkMYtpUA+P6ida2hZu7YNEBVHB05eGGAS0CVoFCjeEL
         yl66onqZZo9+9Me/k01hCUAgKO6U4eNw47ko4AlUu7jUX/rbDEQOK+19oBpTCcl1h1qQ
         wXZQ==
X-Gm-Message-State: APjAAAXgGQCQtidTjWft7iDcxIOpTtD48VkwFuw14+SabEjKrZAUVZZq
        8su++6Q9onfVQ+g36roodbU=
X-Google-Smtp-Source: AHgI3IZLAKxr1KJdATd/RrvVn8C3pqGkGnWFrI6WL0uzTwBqgj/kQsez/SDFR+Oy/LH1AQ54yIebtQ==
X-Received: by 2002:a2e:9105:: with SMTP id m5mr5140864ljg.100.1551365998139;
        Thu, 28 Feb 2019 06:59:58 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id z20sm4728309lff.87.2019.02.28.06.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:59:57 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/7] ARM: tegra: Set up L2 cache using Trusted Foundations firmware
Date:   Thu, 28 Feb 2019 17:59:34 +0300
Message-Id: <20190228145937.27725-5-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228145937.27725-1-digetx@gmail.com>
References: <20190228145937.27725-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tegra30 L2 cache should be initialized using firmware call if CPU
is running in insecure mode. Set up the required outer-cache write_sec()
callback early during boot using the firmware API, it is always a NO-OP
on T114+ and is NO-OP on T20/30 if Trusted Foundations firmware node
isn't present in device-tree.

Tested-by: Robert Yang <decatf@gmail.com>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index f9587be48235..1e89cfefbf68 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -38,6 +38,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
+#include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -74,6 +75,7 @@ static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
 	tegra_cpu_reset_handler_init();
+	call_firmware_op(l2x0_init);
 }
 
 static void __init tegra_dt_init_irq(void)
-- 
2.20.1

