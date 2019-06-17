Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F82C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60BF21670
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfFQMiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:38:17 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfFQMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:38:16 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MxmBi-1iYXoH0lbi-00zDkM; Mon, 17 Jun 2019 14:37:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (max6650) Fix unused variable warning
Date:   Mon, 17 Jun 2019 14:34:30 +0200
Message-Id: <20190617123746.769592-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Xy0G7nWZ1HhgposubGBIrjh7xHfAXCOeUEsKRN+33mNSf+GOxBQ
 LQoZlRmRXLntetmq3aPVZypOWkGAdNQLVjheLbVoyxagXm/gMi3m024uu6e5rxypfo0IRUu
 muZHjzdTyTCQJWUjTdlcygCfLHQA7Y9sNJznEhdU1d4ZSISGIQF1vVuQoIeFlkIwUDu+I4r
 M16Woaf4WZX3ajtxEA6IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/m+Ii4DQw8k=:bOZsuOyOr8ovi8tCCSSyhg
 TIW2NBWXS7CPVRgltVYsde29SNEk/8rMs7drSGlZoWD59qixqTTI+3mE2fbaeSBzn+jM1W88b
 E0UuWGz47TR9bz3lstdTWnsRvndbJvOtqVFF9FPVKejqlN0lvW7+fCzeRuTAoc8F2ddM7ekhV
 FsYQI7dTtPHbgpR7sfgTQfhR1nAs9aDGg99CFBm58zFXb9zysG+1kPvY3MrXQqoSIWHIrQTp/
 frwBVMbZkcML53RD+3ozbz8gbGnNuf9cs+GWD/x+X6P+/3JadT7kRTSmUG+aHx8y3AWVzgbkr
 /FyK+1VE8m/VRIPoq0PMWUGbWu7VhPsDdBpzdQFs0zh7iXmwVGLeWS+Eb+at+5XiE5hPXI3bb
 qxx3EvqXyZMLWMWnpzN9ppeQTqPCaausmEwbEYlQXx2o29WzT7dZ/45GtQ148w2TFC2snjd09
 W9EcjLSB2uf7sC3+edX5TJ8bGo7hGLd/IAqYoJ5b20yvJNCEmzaZnPkHC/iSHMBPy7C1wVXzh
 8YiI+Kf859AQNeleitruWrODjoB5brtNEoFegJ5tQFD7UxqNFnC8M0jpTVVn2c7+yh8J+DKwN
 5HAZhLhA0NyyjIK4nZp85Jt5nPaZPxpTT54yc0pXK3BidKVV8LERg41EBxqY3Zh1LdAiMV9Jl
 4a66hA8EEoWeyraewbyH3ytLFzX2USsEVZGNY1kmju1AR/UHzuOuAQ1aP2aUmFllRo9KywOOr
 9NS4Fq0Bw6kduit/8PX2AzDjk0xxs5rxomt65w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added variable is only used in an #if block:

drivers/hwmon/max6650.c: In function 'max6650_probe':
drivers/hwmon/max6650.c:766:33: error: unused variable 'cooling_dev' [-Werror=unused-variable]

Change the #if to if() so the compiler can see what is actually
going on.

Fixes: a8463754a5a9 ("hwmon: (max6650) Use devm function to register thermal device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwmon/max6650.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 5fdad4645cca..3d9d371c35b5 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -467,8 +467,6 @@ static int max6650_init_client(struct max6650_data *data,
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_THERMAL)
-
 static int max6650_get_max_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
@@ -517,7 +515,6 @@ static const struct thermal_cooling_device_ops max6650_cooling_ops = {
 	.get_cur_state = max6650_get_cur_state,
 	.set_cur_state = max6650_set_cur_state,
 };
-#endif
 
 static int max6650_read(struct device *dev, enum hwmon_sensor_types type,
 			u32 attr, int channel, long *val)
@@ -795,14 +792,16 @@ static int max6650_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-#if IS_ENABLED(CONFIG_THERMAL)
-	cooling_dev = devm_thermal_of_cooling_device_register(dev, dev->of_node,
-				client->name, data, &max6650_cooling_ops);
-	if (IS_ERR(cooling_dev)) {
-		dev_warn(dev, "thermal cooling device register failed: %ld\n",
-			 PTR_ERR(cooling_dev));
+	if (IS_ENABLED(CONFIG_THERMAL)) {
+		cooling_dev = devm_thermal_of_cooling_device_register(dev,
+						dev->of_node, client->name,
+						data, &max6650_cooling_ops);
+		if (IS_ERR(cooling_dev)) {
+			dev_warn(dev, "thermal cooling device register failed: %ld\n",
+				 PTR_ERR(cooling_dev));
+		}
 	}
-#endif
+
 	return 0;
 }
 
-- 
2.20.0

