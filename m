Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B22C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5412054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfHTPe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:34:58 -0400
Received: from sauhun.de ([88.99.104.3]:37450 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbfHTPev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:34:51 -0400
Received: from localhost (p54B333DC.dip0.t-ipconnect.de [84.179.51.220])
        by pokefinder.org (Postfix) with ESMTPSA id 93A542E354A;
        Tue, 20 Aug 2019 17:34:49 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform: chrome: chromeos_laptop: drop checks of NULL-safe functions
Date:   Tue, 20 Aug 2019 17:34:49 +0200
Message-Id: <20190820153449.7866-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to check the argument of i2c_unregister_device() and
property_entries_free() because the functions do check it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only, buildbot is happy, too.

Please apply to your tree.

 drivers/platform/chrome/chromeos_laptop.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 7abbb6167766..8723bcf10c93 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -838,18 +838,14 @@ static void chromeos_laptop_destroy(const struct chromeos_laptop *cros_laptop)
 		i2c_dev = &cros_laptop->i2c_peripherals[i];
 		info = &i2c_dev->board_info;
 
-		if (i2c_dev->client)
-			i2c_unregister_device(i2c_dev->client);
-
-		if (info->properties)
-			property_entries_free(info->properties);
+		i2c_unregister_device(i2c_dev->client);
+		property_entries_free(info->properties);
 	}
 
 	for (i = 0; i < cros_laptop->num_acpi_peripherals; i++) {
 		acpi_dev = &cros_laptop->acpi_peripherals[i];
 
-		if (acpi_dev->properties)
-			property_entries_free(acpi_dev->properties);
+		property_entries_free(acpi_dev->properties);
 	}
 
 	kfree(cros_laptop->i2c_peripherals);
-- 
2.20.1

