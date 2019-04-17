Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F613C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D7D21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbFJFsQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbfDQIpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:45:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32789 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQIp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:45:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so11716367plo.0;
        Wed, 17 Apr 2019 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfIYm/j605WKBg1RtQ7HowTFi1LJUxs+o02oFi+QyBQ=;
        b=bbFJFsQ3NEmMOyVplH95FjefdA41djx2ikgDFYbwqdKBxPNG+FwqduLEkKUwNtsxVm
         NaIrq4zQOuIelTEBtY/mMFUmZy48woND8Ma3HyI5tq7+VgTQ95HqI/f4zOYKX/ERFWTy
         k5frM3FaQuI2qD8y5BG0FfPLh4Mr4e2gXyVHKFIj/+F7uIs5xez0sX1yxRcCUrwsWdVc
         sOOCUwm/A+i5oEU0RQuIvmUNTOr+u1gDRiUaomIMfISO6/gO5m1jSsSNb6baTUGFlgBh
         IfbZ2QItK1XemXIshoYYXm2hc9BSbcmkYRWfSYAKSMz8XR4SRGLdCeGRdKV/xGunwwbb
         WusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfIYm/j605WKBg1RtQ7HowTFi1LJUxs+o02oFi+QyBQ=;
        b=EwAYls34bZyqrim3qi7bpD5rUPFbHL/eyUa8h1FvahN1hQ1QTXy4FzmAmU7TSO+vQS
         ovRDJ2m7v9l1xK9IywyVG56YsDKKQQkmM1HYk6c+4BBlg7toxs+GiW0X6R79f3HrLbDU
         AKVN2ue2GKpKCjclgCT6bktscQlnQOcLG2M9m+Br3MTXQJW0+aneoDzz1L9A+0r41BQN
         qPgxDThBgtwSxYzQNc2IhnCnJStg/6dVFCXN38245n3U4TaFu+3wFqWCrg99nzv2JbY/
         u3CWBmd+pAdYiJzvTIR8eHBG1lQF3ilyW7nqhKhZBYr4KKfZCoDWZjh8VZPplek2vyRW
         7GZQ==
X-Gm-Message-State: APjAAAUHB5HbsjPN/NjlvnriLbu8f5hsIqhKxjG/bCh2Cr1/K/BryvKk
        BOD+aB+AnweWL+mm0yC1323aQZBpcyE=
X-Google-Smtp-Source: APXvYqyQYyu9qBFEEySZ3Vcq9VQDxIwj/rYMcoSGVoLsCQ3NbRwO5poM8WzduysX29Fii8KiKeffJg==
X-Received: by 2002:a17:902:7483:: with SMTP id h3mr31901702pll.211.1555490726503;
        Wed, 17 Apr 2019 01:45:26 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id g64sm124142972pfg.13.2019.04.17.01.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 01:45:25 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Health <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] power: supply: core: Add POWER_SUPPLY_HEALTH_OVERCURRENT constant
Date:   Wed, 17 Apr 2019 01:44:55 -0700
Message-Id: <20190417084457.28747-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417084457.28747-1-andrew.smirnov@gmail.com>
References: <20190417084457.28747-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add POWER_SUPPLY_HEALTH_OVERCURRENT constant in order to allow
singalling overcurrent condition via power supply health information.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Health <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/power_supply_sysfs.c | 2 +-
 include/linux/power_supply.h              | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5e91946731fd..464f4e837601 100644
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

