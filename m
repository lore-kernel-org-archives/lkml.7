Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B160C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F44020836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVhZZmb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLKVCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:02:15 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39611 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfLKVCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:02:12 -0500
Received: by mail-pj1-f65.google.com with SMTP id v93so65462pjb.6;
        Wed, 11 Dec 2019 13:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4x089GCW851wB44OMyqqrKLGIDjDoejo+eqllaL+RO8=;
        b=DVhZZmb1Ph8PNvtFOTR1oLnqYgtXOKOimqKsQvbZaNkfqksw9W4XLv+agXbU3UNlqZ
         T0fjMvF9d+WiK5foM9BMC5F8TDRxGQTl59GNQdVK7yAmIfhWwMeVSVjapzIFxVqp/OmA
         zVaJMoLEaFWnenDaaLBMWsB0abNfWzSEEQiAOxhyE0J93Boa4E9KTlH0FZ0pVPorZd19
         hBoe8mWPuAgJi0uR/7X2KLDx7uKyQ+DyN7Ox/0wFrVes1CB9gRl91sjKjRR2zI0zxAhq
         5MPWn9unRJBLrDGyN8zTCZMIVR1W5VOQWPWW/ynoHzAdjC7Zd9QSpEtQscuiXFNWfN7m
         lgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4x089GCW851wB44OMyqqrKLGIDjDoejo+eqllaL+RO8=;
        b=tTX7bEJOgNBCYK1bC76O3bDZdv+h/dmo2UvoEcTJ+vdL8/7ukSbXcpZsUSBwzTlJRz
         DjF0gZUH2jO3lEB4eNbqTymIt+fm/tH2ohzDnHS+MUZyTq9pwlQ7FHdCujoQIbMLZFE7
         0U+OH0HnFY7zNKmWYX9+8SmFueYgLhuqWWs57nx1eQ1wEiO51M/FxbTeS5UpIcXbH7Ra
         NpKbcVaVMQTk4f0luYiAE0HmgysmXEBeDKQbBKLy6Lkh6EE05wSU22v3MAVl2YjJEHUh
         5OvjeFIBokpChSi+LHGZX9dyEzYgj5DarZY+wCIvxFkfW0KI7v9NjBMQKwEC8jxgXxq2
         uM4g==
X-Gm-Message-State: APjAAAVBbod+B6kckPTyYtD4q8qgfbZvPq84OeKWiybKvYblPg7uPsqo
        rUyhF20Deot2kRxDcU36SbsDvwgT
X-Google-Smtp-Source: APXvYqyyY/Dbrnw0FV5dlFmqhznPeyzwP+1Mj66Anb+Yn3qsn7WOSC0uSzUmLG18uUkb4Xk/7GPAYA==
X-Received: by 2002:a17:90a:c385:: with SMTP id h5mr5729970pjt.122.1576098131406;
        Wed, 11 Dec 2019 13:02:11 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g19sm4062137pfh.134.2019.12.11.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 13:02:10 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org (open list),
        linux-mips@linux-mips.org, Paul Burton <paulburton@kernel.org>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 2/2] watchdog: Relax dependencies for CONFIG_WDT_MTX1
Date:   Wed, 11 Dec 2019 13:02:04 -0800
Message-Id: <20191211210204.31579-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211210204.31579-1-f.fainelli@gmail.com>
References: <20191211210204.31579-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have dropped the inclusion of a machine specific header, we
can allow the driver to be compile tested beyond just MIPS.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1679e0dc869b..982897ff074e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1651,7 +1651,7 @@ config JZ4740_WDT
 
 config WDT_MTX1
 	tristate "MTX-1 Hardware Watchdog"
-	depends on MIPS_MTX1 || (MIPS && COMPILE_TEST)
+	depends on MIPS_MTX1 || COMPILE_TEST
 	help
 	  Hardware driver for the MTX-1 boards. This is a watchdog timer that
 	  will reboot the machine after a 100 seconds timer expired.
-- 
2.17.1

