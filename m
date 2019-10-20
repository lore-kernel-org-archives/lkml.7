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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55281CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280E221897
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqpjWLD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfJTRAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 13:00:53 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45227 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfJTRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 13:00:52 -0400
Received: by mail-vs1-f66.google.com with SMTP id e19so7309836vsb.12;
        Sun, 20 Oct 2019 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z3rFbdU+SplPcjhPOqnh6Ex901p18xA+QjA1SeUaWkw=;
        b=LqpjWLD8LLWxBJgS4hvN2oCSEiU5rjiaPgS+Dzz8QcV2skMzKalLhWugfPSCZYlugw
         9B4RIMV3npSVJ7O/DXNuErQT2KlGOcBxmnDfX/Fsi/3r2J/jkekCmsdFMB1GhAwl69xa
         bVvr3nobbXQ5A2f49tCEO9Eiqbu8XIKbBfHgIR/TZ/3A/vZheBpk3eObUrgSOOkN/Gaj
         jNJ6I31J8AzzayGDeOaRYg7jpEhJlVKer1Actg1Q9aZW7BDspap01pZcqklx5OePC8RY
         tRF2v62tLIdfZey4bg7eAVw6xcv+VHfwoQy8SrruzC5UK3s7yNB2bAo1ZB0eAbTnq0cn
         krdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3rFbdU+SplPcjhPOqnh6Ex901p18xA+QjA1SeUaWkw=;
        b=Ir4r3DXwCbQa+q22D17GiAz8qttr+1gBhN7lbs9aqVjmWCzYLo1JoGXN77KKjZJ+HT
         5IkY0gAPlP3dXtMTI4N2ve4Ug8fJqR0uQKnl5Rx7dcxpdJ4nvoj+B8A+NZ72h07k3eLl
         nB+NebHikt9Irf4QAuStt++VWCnuIxVWLnhyQgktYrvygKc3EpGAjK7yXxD2ih704mzB
         0M8zQvcku540I79QxP7xU2Gax2VIKN1xrsFqUyTAzTW9Et96C7EExP4mE+ec9u1/Z064
         TKt2FImLjy14HBIOKpu04IHzh4wlnIgUjt3bIUa6VJjmcq3H93+3sM5GVAlTLMSdKDZr
         ovsg==
X-Gm-Message-State: APjAAAWpYJWNy2h1ES3hsoY/ZxicYrXB6WisOx7qhfl/60wPBD/ElyQE
        KtSqCf24ZEw+rzb2+yrSQw==
X-Google-Smtp-Source: APXvYqyrs6R30s8uibpzuM+64Scem0970K4MY9fjtJ05Zk0lFUy1F+qOyu6EY9rlWKrHNWV80Hct2w==
X-Received: by 2002:a67:e3da:: with SMTP id k26mr10838781vsm.81.1571590850153;
        Sun, 20 Oct 2019 10:00:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:901:202:18cc:820:670:dd1:f572])
        by smtp.gmail.com with ESMTPSA id n126sm612962vke.51.2019.10.20.10.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 10:00:49 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Mattias Jacobsson <2pi@mok.nu>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: huawei-wmi: Remove unnecessary battery mutex
Date:   Sun, 20 Oct 2019 13:00:09 -0400
Message-Id: <20191020170020.26251-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020170020.26251-1-ayman.bagabas@gmail.com>
References: <20191020170020.26251-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

battery_lock mutex is never used and not needed.

Fixes: 355a070b09ab ("platform/x86: huawei-wmi: Add battery charging thresholds")
Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 7373a65a61d3..a2d846c4a7ee 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -67,7 +67,6 @@ struct huawei_wmi {
 	struct led_classdev cdev;
 	struct device *dev;
 
-	struct mutex battery_lock;
 	struct mutex wmi_lock;
 };
 
@@ -807,7 +806,6 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
 		mutex_init(&huawei_wmi->wmi_lock);
-		mutex_init(&huawei_wmi->battery_lock);
 
 		huawei_wmi_leds_setup(&pdev->dev);
 		huawei_wmi_fn_lock_setup(&pdev->dev);
-- 
2.21.0

