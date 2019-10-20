Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFECACA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93372218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5m+2UYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfJTRAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 13:00:40 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45042 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfJTRAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 13:00:40 -0400
Received: by mail-vs1-f65.google.com with SMTP id w195so7311314vsw.11;
        Sun, 20 Oct 2019 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jChDDBy/9+W5GZtGAP1vvb6UndWx2h0r7qmx1nXdLZQ=;
        b=f5m+2UYdDT6A2PtBNADex63H4WOtWOUoUWxFm9ldPVKHU1Rkv1uKwyyioIjWge5b6e
         ESZ1z9tFKDZzDF93ukQQ231EJLmEdYjpFigFvj8lkIlxWC7Im3rm6FFLk0/ogVM33to1
         ybD3ugPl55Vj0+6pv2orTMu2IJOpCkxybZHixG3QfI1ZwfAhr5SnAjb7vx0MglhnWHF6
         WZRq9MiGO8tZlhVZeiwa1thERdtOi8DW2z7H12r/R12wYrHLNXCu9VNt/ctDocYBtJlQ
         WVGNh+pC/WrnpxXW8L1zKeLn3vurOkyec0AdjnraqaFhZbBeAHrfze/Vrsm8cXwxV6yc
         APxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jChDDBy/9+W5GZtGAP1vvb6UndWx2h0r7qmx1nXdLZQ=;
        b=HypjIO0uYqNMzahVR0/XqQBrA7Qv9NWikBD5XOGAlWE9STTlv3+3q47Dr3aBbwjfIr
         D5l92IXpHisAahU0grDRBMd5UNz2es19RCLd4W1YP4togSLs3XcAgcZRA4pLNTiYmUAQ
         IRN7FOlcdSDynWpFu0zQwqrfOpBeGID/qWqN1RRpDwrj3xdbzti/mZyLN3sFpsd2XiYn
         wFTghRFTwkAezDK1VRQFJqeXyPA6k9F8U83tPl3LGJJYydsDJiRBD+hOUFcnkZ+4RPAk
         XCL9Ahm9J4+C5mFzYKf0YF+DpOQ5/L3H1E18r4Q1w8gQ3Mg2TUp/nX63ATcoJtQo5ZDM
         /zxw==
X-Gm-Message-State: APjAAAUHw6AOVjnRPUP7hMZFKYobEy9S/tYvINBqh1dxVCAduqgjD9s2
        FPwV1XwLLijOFTPezAyKbg==
X-Google-Smtp-Source: APXvYqx5TQEy2L3c9lr8dqAHe47qFy3qlGAAz9XIOKD7z90IRbBeOqDpRXCrqnWOfmJhl3du3H0gkw==
X-Received: by 2002:a67:8841:: with SMTP id k62mr11423664vsd.101.1571590839137;
        Sun, 20 Oct 2019 10:00:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:901:202:18cc:820:670:dd1:f572])
        by smtp.gmail.com with ESMTPSA id n126sm612962vke.51.2019.10.20.10.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 10:00:38 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Mattias Jacobsson <2pi@mok.nu>, Takashi Iwai <tiwai@suse.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kbuild test robot <lkp@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: huawei-wmi: No need to check for battery name
Date:   Sun, 20 Oct 2019 13:00:08 -0400
Message-Id: <20191020170020.26251-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020170020.26251-1-ayman.bagabas@gmail.com>
References: <20191020170020.26251-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to check for battery name, we already check if the WMI function is
available in huawei_wmi_battery_setup.

Fixes: 355a070b09ab ("platform/x86: huawei-wmi: Add battery charging thresholds")
Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 26041d44286a..7373a65a61d3 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -471,10 +471,6 @@ static DEVICE_ATTR_RW(charge_control_thresholds);
 
 static int huawei_wmi_battery_add(struct power_supply *battery)
 {
-	/* Huawei laptops come with one battery only */
-	if (strcmp(battery->desc->name, "BAT") != 1)
-		return -ENODEV;
-
 	device_create_file(&battery->dev, &dev_attr_charge_control_start_threshold);
 	device_create_file(&battery->dev, &dev_attr_charge_control_end_threshold);
 
-- 
2.21.0

