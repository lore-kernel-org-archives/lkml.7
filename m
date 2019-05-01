Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510F3C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 03:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE4C20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 03:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQmey3bD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEADez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 23:34:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44531 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfEADex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 23:34:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id l2so4912099plt.11;
        Tue, 30 Apr 2019 20:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvLp8pJfiLCObrociBr60wf6IDx1C/miZORcSamDQ60=;
        b=fQmey3bDrYXE9IXRFsyoZhjpaI93CML5FdVu+esAqlEX8anq/XS0R53fOzqN6KRAO4
         H+5xxApFJaMTdLdMjUIB5hA3nAlwu2LOM7MZwxsrDFAWP9E/NesS+bR2VgYpopPByHJp
         ype3HhOC0p6jhQAy6k7qIJIxLGZ1Q2oqSnCmBZJPX7VkxwG+3Svj1tNAHZmOwdVSanV3
         By8ksYA/i6AD5uOvwsWyWHki9bp3yJQCkXftQHcT0xhoOtXUlhmcrqrmdoJVHDZvxuzO
         Z4PAhtaqnbEmB43Ka6MRxGPCM26uxN2dRmQnQ1RXrNiPkoNFj9aIJyHueoeOAjaRB1ua
         f88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvLp8pJfiLCObrociBr60wf6IDx1C/miZORcSamDQ60=;
        b=mA9cyifxTSfmKN9tyijTOS4lIDmc+Fbw76NBiGRxDUZE1v/RLeoExQAfQxvWkmeiMH
         8T8i5cwqYy5pDFIpfa/C+Z5aaLtEJjZCFeVwzTvyeNT4eEqvqlQOQDShdi3pjtbLMHNQ
         pTB0NLy6PfywZRN0HgYGJbka6T4bEZQnVE83gXSxnq9cboQtdJh8i0xHzqNq5wkkA/uW
         mLuNFXaDFic5upTsd9PpvbUz4nd1xpw/lUg1qmJf7nFGeKnGL6bvabfXbfzleVcmgW6k
         vqf0sAkewCRtzGDyFOUWMNimB0eZlYQyUTR/CMhoBXDg7F8Z042cBZCRjyCOwj25e9Hg
         cKYw==
X-Gm-Message-State: APjAAAU8U8Xfuy3e7wFAn2lozvD3htO6VSPY7m0xtbg7KkXT+kqAoTfC
        6jF2nOqPensMbOyMG62+uktsfTfNKDw=
X-Google-Smtp-Source: APXvYqwsDGpSUFgm4b31SzmKvLWUhxQgccsudPOFyJ8pGQSo66j7FwXJdWJPRDPnO1KMEYW/cOuOHA==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr7760658plo.32.1556681692012;
        Tue, 30 Apr 2019 20:34:52 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id r11sm47421067pga.87.2019.04.30.20.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 20:34:50 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] power: supply: core: Add POWER_SUPPLY_HEALTH_OVERCURRENT constant
Date:   Tue, 30 Apr 2019 20:34:32 -0700
Message-Id: <20190501033434.18548-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501033434.18548-1-andrew.smirnov@gmail.com>
References: <20190501033434.18548-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add POWER_SUPPLY_HEALTH_OVERCURRENT constant in order to allow
singalling overcurrent condition via power supply health information.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/power_supply_sysfs.c | 2 +-
 include/linux/power_supply.h              | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5358a80d854f..153f4a6ca57c 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -62,7 +62,7 @@ static const char * const power_supply_charge_type_text[] = {
 static const char * const power_supply_health_text[] = {
 	"Unknown", "Good", "Overheat", "Dead", "Over voltage",
 	"Unspecified failure", "Cold", "Watchdog timer expire",
-	"Safety timer expire"
+	"Safety timer expire", "Over current"
 };
 
 static const char * const power_supply_technology_text[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 2f9c201a54d1..bdab14c7ca4d 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -57,6 +57,7 @@ enum {
 	POWER_SUPPLY_HEALTH_COLD,
 	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,
 	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
+	POWER_SUPPLY_HEALTH_OVERCURRENT,
 };
 
 enum {
-- 
2.20.1

