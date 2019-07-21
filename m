Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14A3C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9FD2083B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfGUKQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 06:16:15 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:16955 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfGUKQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 06:16:15 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d33 with ME
        id fNGB2000F4n7eLC03NGByz; Sun, 21 Jul 2019 12:16:13 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 12:16:13 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] hwmon: (pmbus/max31785) Remove a useless #define
Date:   Sun, 21 Jul 2019 12:15:53 +0200
Message-Id: <20190721101553.20911-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in MAX37185_NUM_FAN_PAGES. To be consistent, it should be
MAX31785_NUM_FAN_PAGES (1 and 7 switched).

At line 24, we already have:
   #define MAX31785_NR_FAN_PAGES		6
and MAX37185_NUM_FAN_PAGES seems to be unused.

It is likely that it is only a typo and/or a left-over.
So, axe it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hwmon/pmbus/max31785.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/max31785.c b/drivers/hwmon/pmbus/max31785.c
index 69d9029ea410..254b0f98c755 100644
--- a/drivers/hwmon/pmbus/max31785.c
+++ b/drivers/hwmon/pmbus/max31785.c
@@ -244,8 +244,6 @@ static int max31785_write_word_data(struct i2c_client *client, int page,
 #define MAX31785_VOUT_FUNCS \
 	(PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT)
 
-#define MAX37185_NUM_FAN_PAGES 6
-
 static const struct pmbus_driver_info max31785_info = {
 	.pages = MAX31785_NR_PAGES,
 
-- 
2.20.1

