Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2367DC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 15:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60C820880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 15:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJPMM1tT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfDGP3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 11:29:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44535 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfDGP3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 11:29:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so5806457pgj.11;
        Sun, 07 Apr 2019 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qc8RW6CpcoQ2/qAkI36Ns4xpMv2BoUq35CbWC2iZnKM=;
        b=sJPMM1tT4ANpP794QCR8yQZRtlQa4dMaes4RMAW5DlomLscomoHsQeTrCbarRJHuTU
         eVuUQ0BXMRKVtIDgerWBp2MRKefeIoTaZBPedC+HLItl3SgxUS2Fw/ZQNFA4IxPj37Er
         /7iDrdwCaM3ULSBGeKG36E7oMgKb7WOBdzdz0QS17veZFKMlLt7bpPxqoTvZxi9Q5cow
         wd2JWe1ZS7cyU+lBVR3rGGfllfluvOZCjRiklHiP/GcTsa7JUN4O2Q8k0okxwt4Qpd3X
         TFeqdYbrvaI1UZmzabK4mWXyUBX/5i7T+fXuxUdi0Jaa9l/0x3n51hrwJ6eKr0maaUFA
         /7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Qc8RW6CpcoQ2/qAkI36Ns4xpMv2BoUq35CbWC2iZnKM=;
        b=GPdB6aU6Gi9rwSN5oQr0GD0B+uXegJcswXf/Ox7wq90HufzC5dhKUAPcDaJ8w399yN
         FHoahPi3fyynOGrnkH25MpbR1cXgj1fkbcJT6xSKAKEc5xfBV/J1IcY9yBT062pRS6Ru
         O7RkgbK44b4J5OR8eXPnPqTpxjbhut62/hnOYlUw2lMF8Hp4eqKJh8cWLq22Qlob7y7e
         aRNxTJnU6TPd8iNWskfIy+FkwqEgpgFpFzW/MVYuxyEp1JibBEIVh1bS9MFiPnUdOsxs
         JjWw5dJClc1v8Y6KRbHS2mO7gxals9cpI+qjuCJXw9ALB2c14eL3EAik8XFAmDtrv9gC
         qOkw==
X-Gm-Message-State: APjAAAUaSmdFu8Yyai9gJnVaojrzMu1lrmGVfRUS6QOdJZoiWlTLmuHU
        FcBQOVaSDBGaXnUIIXqRviWU8jew
X-Google-Smtp-Source: APXvYqxecWQKalgCTLOtlgVUx7eOq970sjG6EjugtT9l81e+ktlOINAE23F3medFUH/1zlLmQcNsew==
X-Received: by 2002:a65:62c9:: with SMTP id m9mr21788208pgv.309.1554650979592;
        Sun, 07 Apr 2019 08:29:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q74sm23509569pfc.111.2019.04.07.08.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 08:29:38 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH] watchdog: rtd119x_wdt: Fix remove function
Date:   Sun,  7 Apr 2019 08:29:35 -0700
Message-Id: <1554650975-15326-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver registers the watchdog with devm_watchdog_register_device() but
still calls watchdog_unregister_device() on remove. Since clocks have to
be stopped when removing the driver, after the watchdog device has been
unregistered, we can not drop the call to watchdog_unregister_device().
Use watchdog_register_device() to register the watchdog.

Fixes: 2bdf6acbfead7 ("watchdog: Add Realtek RTD1295")
Cc: Andreas Färber <afaerber@suse.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/rtd119x_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/rtd119x_wdt.c b/drivers/watchdog/rtd119x_wdt.c
index d823c9def36f..cb17c49f3534 100644
--- a/drivers/watchdog/rtd119x_wdt.c
+++ b/drivers/watchdog/rtd119x_wdt.c
@@ -133,7 +133,7 @@ static int rtd119x_wdt_probe(struct platform_device *pdev)
 	rtd119x_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
 	rtd119x_wdt_stop(&data->wdt_dev);
 
-	ret = devm_watchdog_register_device(&pdev->dev, &data->wdt_dev);
+	ret = watchdog_register_device(&data->wdt_dev);
 	if (ret) {
 		clk_disable_unprepare(data->clk);
 		clk_put(data->clk);
-- 
2.7.4

