Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16316218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfCVQSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:18:20 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55441 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfCVQSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:18:17 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MGz9p-1hC5qR2OBv-00E4Nl; Fri, 22 Mar 2019 17:18:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y 8/8] power: supply: charger-manager: Fix incorrect return value
Date:   Fri, 22 Mar 2019 17:17:23 +0100
Message-Id: <20190322161727.1153278-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322161727.1153278-1-arnd@arndb.de>
References: <20190322161727.1153278-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6ScF2cDbBBtmdzkHdRlSrHcxdLZn0+JBp7AxazAA+HUIu4cU7BF
 O6YY5JWQPNLaP27RU+gIXmAhUSQBpbwKHBtDu3q7eyqppgM9upVOG+je0fogwPvrvkhPrrH
 yYw3wfTIoAIREC88a6DD8sYR5DvxGLFOzGmMmDXUvBb6OpnCQN3dN68veWv4A7rGcNd9xG5
 R/birbHdbDrlg/ZhDHCSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BYxt3WBL1qs=:G8aBjDBAzJ9p+b57cHYdFl
 R70dmBuroo7xpL7qA7YWV9ve5VBE3NOoiRhGcdAg5roJULVzNtkwsCn9AqZc8qpg/stivFZAf
 HUXTjAkkMWGNFQ9qLa0JFIAUcqjYQenqaEuwvEfQyw3HFbEgAc7PhydSobEdZakCKZ5OX4PAi
 DoMRYvzDWaHUHc6d0F2tnRWWXSIpThiq6I5ztyLNSRtbAtuSZNBaFGOXDuMgegxReu3tTp4Us
 aqRFbdsi4DrL9eMPy5hBzOZZzdh5ve/D0+Tc2pJ1UkRufwGFaVyQEDjNxtTJvBlka2GrKZrSF
 SFOJ5rK5bmCUhQv3BrBYFo0jKJckW6lRbcwA25uYkVwnxVOy1dQ9HIvwJQe4fP0RjpSgmM5ka
 p/iLHCFYS0TahHNTo9WdY4fidqJaq8hwrIRV3RJ+Fl+KYsD6xXTS1UJcvl0MY4Kd+z6BqxTyN
 1b01Po0oDvDG2gIUhtdidWpUlpVBPRkKUMTWeeRr5v80PgeSXWIeITeDD7F9O9QqCs14/fISW
 j5v5U0Buc6dAKiIYep61lMu5rRbSlQTvjls4LKHc3okTa4J6p7CDqDe1UJaEoMTk0UP35pjnB
 DZip7WXsVgewXatRUrtnTFElSmLXOylQiewH4CmJwb2BV/B72aAB3zKhLWH0tzlR9231sru4O
 jCGRq5nnqps08UQcQ6tBQtcYHK+u244RfWTkDiYDzaPt2lEKcoyKSVqOikIL47cc56utdAg0m
 ePh6i5X1cSPFz+GcaHD9UPaP2Iv1LTYvbdBIaQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

Fix incorrect return value.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
(cherry picked from commit f25a646fbe2051527ad9721853e892d13a99199e)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/charger-manager.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 6502fa7c2106..f60dfc213257 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1212,7 +1212,6 @@ static int charger_extcon_init(struct charger_manager *cm,
 	if (ret < 0) {
 		pr_info("Cannot register extcon_dev for %s(cable: %s)\n",
 			cable->extcon_name, cable->name);
-		ret = -EINVAL;
 	}
 
 	return ret;
@@ -1629,7 +1628,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	if (IS_ERR(desc)) {
 		dev_err(&pdev->dev, "No platform data (desc) found\n");
-		return -ENODEV;
+		return PTR_ERR(desc);
 	}
 
 	cm = devm_kzalloc(&pdev->dev, sizeof(*cm), GFP_KERNEL);
-- 
2.20.0

