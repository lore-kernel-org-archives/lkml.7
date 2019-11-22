Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2560C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D311C20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKVKWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:22:54 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60345 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:22:53 -0500
X-Originating-IP: 92.184.97.94
Received: from localhost (unknown [92.184.97.94])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id CDBBA1BF20F;
        Fri, 22 Nov 2019 10:22:50 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/8] rtc: ds1374: remove unused variable
Date:   Fri, 22 Nov 2019 11:22:06 +0100
Message-Id: <20191122102212.400158-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191122102212.400158-1-alexandre.belloni@bootlin.com>
References: <20191122102212.400158-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning:

drivers/rtc/rtc-ds1374.c: In function ‘ds1374_wdt_disable’:
drivers/rtc/rtc-ds1374.c:442:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1374.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 367497914c10..96eba7606523 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -439,14 +439,13 @@ static void ds1374_wdt_ping(void)
 
 static void ds1374_wdt_disable(void)
 {
-	int ret = -ENOIOCTLCMD;
 	int cr;
 
 	cr = i2c_smbus_read_byte_data(save_client, DS1374_REG_CR);
 	/* Disable watchdog timer */
 	cr &= ~DS1374_REG_CR_WACE;
 
-	ret = i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
+	i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
 }
 
 /*
-- 
2.23.0

