Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265C8C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0434A22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfHSVAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:00:08 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40221 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSVAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:00:08 -0400
Received: by mail-yw1-f66.google.com with SMTP id z64so1378945ywe.7;
        Mon, 19 Aug 2019 14:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qvztveGCP8rAVOCE3TihtUu+wJQiIJmbl19Afmtoalk=;
        b=IGOn9j5Q+EOSySGrJfPW5GUAA964uMzTzOIFs/eR5NnC3Scz7O+4CGJgXF48zvvVqE
         G/tkbFjQX0PcNnjsqGZ0SJAR6C2cD7pW7iAGeGh8ydRjVybGs3kvPIOA6CGqJlX2n6sL
         N/1zet0hGuyYuP21EygKJaCrjVdajqnrpRnEIAaD29r+7mynGUItc9pI+ZbYvB8DbVRF
         mofj+spVyV6co80tm8UNWRkhIIFRA2IRar1ajOH1A597Phk3339I+MKgPahr9oi9TTui
         w99YoD8iyq+wyrtIPPpzexS+5UcZULmqM/hCzDhX7O3xMCUT4FR+kdKnya6uN75/G4up
         GX7w==
X-Gm-Message-State: APjAAAUM1xX2lgAd1eUcL9ZL3LKnJIL1V4JmlSocMJ5+lhG8jx/E1u1d
        rHRP3LDjSWNjz8QO0qBEDAoDyEjOgMuCFA==
X-Google-Smtp-Source: APXvYqxJyHyzcdoCsBl4lVsAmwLRPbSxcrT4RLy8JeizYa54yMDsl5Z3M6+3dhSh7g/LAvkzx9q74A==
X-Received: by 2002:a81:918c:: with SMTP id i134mr8802953ywg.65.1566248407313;
        Mon, 19 Aug 2019 14:00:07 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id l71sm1564543ywl.39.2019.08.19.14.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Aug 2019 14:00:06 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org (open list:CORETEMP HARDWARE MONITORING
        DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] hwmon/coretemp: Fix a memory leak bug
Date:   Mon, 19 Aug 2019 16:00:02 -0500
Message-Id: <1566248402-6538-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In coretemp_init(), 'zone_devices' is allocated through kcalloc(). However,
it is not deallocated in the following execution if
platform_driver_register() fails, leading to a memory leak. To fix this
issue, introduce the 'outzone' label to free 'zone_devices' before
returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/hwmon/coretemp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index fe6618e..d855c78 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -736,7 +736,7 @@ static int __init coretemp_init(void)
 
 	err = platform_driver_register(&coretemp_driver);
 	if (err)
-		return err;
+		goto outzone;
 
 	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hwmon/coretemp:online",
 				coretemp_cpu_online, coretemp_cpu_offline);
@@ -747,6 +747,7 @@ static int __init coretemp_init(void)
 
 outdrv:
 	platform_driver_unregister(&coretemp_driver);
+outzone:
 	kfree(zone_devices);
 	return err;
 }
-- 
2.7.4

