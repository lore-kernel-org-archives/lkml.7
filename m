Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540D1C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C94217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSc5OwYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390231AbfDRT6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:58:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43587 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390174AbfDRT63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:58:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so1570123pfd.10;
        Thu, 18 Apr 2019 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o9fJRFSOZLju8sjZtfd/SYS114IRI/a2eHFNikMSeJ0=;
        b=CSc5OwYjhlpzfCi/xFEhMOqpL44cDXcE/EKUkfp189qVXzK8LSvRQfHA1GS/gdQc6T
         xj5RYFKVWMlWYal6BkaRgJ39Bin8s/MfkWGwqivLDjqzeV6YJkW99z68l/xA70+rxWiG
         q5dbhhgqXk890XuNRQJMZ2gAGrboTwMi+eN4zp+jKLFJBv12/Q4qWLvr8fgqal+d/WGE
         QWkcgNc5a9JyA5KqNFAaaQgw9Oli+9kcSA5C9jlSow4Jx7ntlxf6mldf3WY+rE8uMOC0
         dqhku51RD46LVG/BswRt4t/GvmgK+Xaqo5XuqkB318zsHnvjjJLkRxtSJgjxs6cOg4r+
         wwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=o9fJRFSOZLju8sjZtfd/SYS114IRI/a2eHFNikMSeJ0=;
        b=WEL9o+auIqp7gOSsx5TA0Sd3uXcoaDwUIRj7ftcqiebf3jKIiifeVUST82JdBWexlX
         vQ/YQsrCSlXeI+2QD4ffxxGhkJMeXxWYL2wVL1VcqzKnJjEUkEHLGDsyzkrwJxC70z5K
         NNWCLGMq8lxcRxnYo5PZB/ZGAl4uwmc734wCmJzljT5jEiRn7R5Za194ggBkrb2YNzg8
         HqvNbSsgRF9vcQRTCGovqxuZgjyHEPnpuYx7pBJbjv4+BnDGTog6NxDipbg90EAqnfGy
         GAhl7lWDS5hiIzCx39WHNTD5Z7eK4/1mOwp1vvC9Q/wfPOpmfYRrK/oPj7ucYsoGF6wp
         97VA==
X-Gm-Message-State: APjAAAX2968gcc3ae+qrGtZu1sRB+I3tUe2FuuXHTDKOZKfliVtg28/x
        /MTHozbg1ueV/4EpdmQ0/omWLDETd38=
X-Google-Smtp-Source: APXvYqzyhJqPMn9FBvqGzySGiBJ+Q7z53ajueAKrEkJzo4dOkvO+Mv621oLJ2FDa1foVZKDV8TJU/w==
X-Received: by 2002:a65:4343:: with SMTP id k3mr7139829pgq.384.1555617508148;
        Thu, 18 Apr 2019 12:58:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p6sm3621380pfd.122.2019.04.18.12.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 12:58:27 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/6] hwmon: (gpio-fan) Use devm_thermal_of_cooling_device_register
Date:   Thu, 18 Apr 2019 12:58:17 -0700
Message-Id: <1555617500-10862-4-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call devm_thermal_of_cooling_device_register() to register the cooling
device. Also use devm_add_action_or_reset() to stop the fan on device
removal. This fixes a race condition since the fan was stopped before
the hwmon device was removed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/gpio-fan.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index f1bf67aca9e8..3f6e5b4e3997 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -498,6 +498,11 @@ static const struct of_device_id of_gpio_fan_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_gpio_fan_match);
 
+static void gpio_fan_stop(void *data)
+{
+	set_fan_speed(data, 0);
+}
+
 static int gpio_fan_probe(struct platform_device *pdev)
 {
 	int err;
@@ -532,6 +537,7 @@ static int gpio_fan_probe(struct platform_device *pdev)
 		err = fan_ctrl_init(fan_data);
 		if (err)
 			return err;
+		devm_add_action_or_reset(dev, gpio_fan_stop, fan_data);
 	}
 
 	/* Make this driver part of hwmon class. */
@@ -543,32 +549,20 @@ static int gpio_fan_probe(struct platform_device *pdev)
 		return PTR_ERR(fan_data->hwmon_dev);
 
 	/* Optional cooling device register for Device tree platforms */
-	fan_data->cdev = thermal_of_cooling_device_register(np,
-							    "gpio-fan",
-							    fan_data,
-							    &gpio_fan_cool_ops);
+	fan_data->cdev = devm_thermal_of_cooling_device_register(dev, np,
+				"gpio-fan", fan_data, &gpio_fan_cool_ops);
 
 	dev_info(dev, "GPIO fan initialized\n");
 
 	return 0;
 }
 
-static int gpio_fan_remove(struct platform_device *pdev)
+static void gpio_fan_shutdown(struct platform_device *pdev)
 {
 	struct gpio_fan_data *fan_data = platform_get_drvdata(pdev);
 
-	if (!IS_ERR(fan_data->cdev))
-		thermal_cooling_device_unregister(fan_data->cdev);
-
 	if (fan_data->gpios)
 		set_fan_speed(fan_data, 0);
-
-	return 0;
-}
-
-static void gpio_fan_shutdown(struct platform_device *pdev)
-{
-	gpio_fan_remove(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -602,7 +596,6 @@ static SIMPLE_DEV_PM_OPS(gpio_fan_pm, gpio_fan_suspend, gpio_fan_resume);
 
 static struct platform_driver gpio_fan_driver = {
 	.probe		= gpio_fan_probe,
-	.remove		= gpio_fan_remove,
 	.shutdown	= gpio_fan_shutdown,
 	.driver	= {
 		.name	= "gpio-fan",
-- 
2.7.4

