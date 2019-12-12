Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC815C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C995420663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfLLLYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:24:18 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:51993 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbfLLLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:24:18 -0500
Received: from orion.localdomain ([77.9.34.244]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4z2Y-1hh2kW3lTw-010q0l; Thu, 12 Dec 2019 12:24:17 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     info@metux.net, platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: pcengines-apu2: fix simswap gpio assignment
Date:   Thu, 12 Dec 2019 12:23:48 +0100
Message-Id: <20191212112348.15616-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:YSNTNVv7ShMqaJnYCglvuW6gChkibYrpiRsmD+tx6evE5GatyMw
 tihgFkboQuxf8cyrmYdOJJHLmYvCrap4p6gb5wtPDEvdi2d63TmpI9mSGpyLiPpUVKlmJPa
 swzLj5cKmKCvQ75wCS/nJBaQ3yeRITd7VEG+R6h+CEu7kAhE2ZXTV2EOLC2vaPkMVyLfiXI
 /Dczs2zpqQOOCHFcR8U6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kB8jefRFHkA=:fv0MyzKs6SgEhd5TWkrgC3
 zjgCWWPepUtQt7xR5jde4+RmtPm+mWKoLoNRedemiZSbV32w76MDRDFxHBI45EKZIoLZcjwRI
 ufpwL6YzC43cq1kp5dB5kealuIP8LTjdUGQQhMVwalEhOEIQY9VwiSqwjm/Gdiz3UCVPLr2Mk
 tvgAdX4Ce2kSjuLwwlaGBQ05MaV/85u7iFdPJKeY7f60DjYHtAn9tWdyz1GLsac/EtYeLn/w2
 d1njWK9wehMOUClA23Z/4qCkO8FvEjn4BkGGmEH+k3tY2kEDxPVIueuYAlOaR/WvnDhVIbtp/
 31ZaZxCVBvdOJXKb03bznKkE0yZ6+GfQFcHvgl54w07erhlmkCN7Zo5iYqYueOQ2842HAtIM3
 6mb1k/eBAI9onmA0//fkTn4RWGBSBGFzmyougEmOYksXOQvFlL+4oFdLJw4r7/TV+oLijwoGP
 YcGfs2ijSLN7f8JmvJJOHqRkj7eNkU3+bVd/TQzdeAHqIdlXto21j9X3vcr7opZVEB2GYiCB4
 YbVwpWClJzxiRJgPsApvO3BsGyJVG7ha5l5uhGBnQHyNVTC80isHce+VL/HA3yuQIZA0CZ9Si
 uaByavA1UvGHXIypki2DJZWf06wOA5aQb5YVF1EXDz2+zfJNI85gVKZzcU5SLQm+Z0IjeQ3BI
 sV2p64BzU9Uc/Z5As4hoMeFZiLAXKIQoKF6zyvVYdMt6SCvEpJ17yUWDPy+twxqO7n/b3l/nK
 QqNCRnEY8XFdsyi4JODjytbfrsrVlZns++wcm56cOIC94H1P0bm5AyizK+4baiWPMm6snFrX0
 EOQ5rwsovrh9XDKDh0e1Yfu2fqAxgG6a0te+lMIUDlNxnzHgVwGcDeYrncffH7GDWpMHJb/73
 GTL/6zV0JgRr1zh8Vi+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mapping entry has to hold the gpio line index instead of
controller's register number.

Fixes: 5037d4ddda31 ("platform/x86: pcengines-apuv2: wire up simswitch gpio as led")

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/platform/x86/pcengines-apuv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index 48b112b4f0b0..c32daf087640 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -95,7 +95,7 @@ static struct gpiod_lookup_table gpios_led_table = {
 				NULL, 1, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED3,
 				NULL, 2, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_REG_SIMSWAP,
+		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_SIMSWAP,
 				NULL, 3, GPIO_ACTIVE_LOW),
 	}
 };
-- 
2.11.0

