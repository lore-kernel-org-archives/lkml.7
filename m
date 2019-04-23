Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3098FC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F38218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWqkMKGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfDWVme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:42:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42688 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfDWVmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:42:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id w23so12886547lfc.9;
        Tue, 23 Apr 2019 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xQeefpKrsCdhR8Xs6F2Qda/pkJ6VuhFW4m9YDLw8Nyc=;
        b=kWqkMKGBjlPPZ6fmSXOi+1oWjAJ7kHz6lyaBM/7BY8iwqhhbH2xJHvOJ3dWldB4F34
         EDtDUFFxqHSREoHWq+85X7QbEJ9wZzVffx12CDOxYHXRiPAj/9uqN7zuoMFaUIHMyrer
         iulMsJIuroHmcJ+F41c8UEzsx8YtSfudGA24n1vFrsJCtcp59fVFuv06xZo6SihAndlp
         352ny8youL0VnXlmTO/ieklQQ2WcK1GwcrIpB48bVt5ke5u7DwseW/9Ich428Ma7GkCR
         C+CmDMbexL2/bAZHFM5C1WKhVHs3TqpLG2kBnbIOkDxIWrIqdWQOZZ5iX5SPn2IpG1GV
         H4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xQeefpKrsCdhR8Xs6F2Qda/pkJ6VuhFW4m9YDLw8Nyc=;
        b=atpOR0RKroBOupx1gdVcAxnJpT/bzD3UV00vDlLaJmMv9i/Sh4uA3Ne7Xdig5MAkLT
         Q8aqVvxHcwiMno6Hk0nK/OCDiznNEC+9LdLFMtj2JDBrzk4jOMtUSMdHmBVKYlLbsF74
         gcmYNZDmRgz4Dg4ze8ckEvYkO7BlhyCdRoEtMxN9FdUnDqqyTiq96LrpDfyN/a5bVf+k
         MABe7ffO9+XFtjlut/ZmnO/zmoE5Z3+rnmqglVWfsU/G++rvWPWUEAEpzxhjLT0X/gRE
         /UxGijEDkoXdzeSKCBsnUJQqvklLDzAirLIXOgXOMWuF1kQ+I0YZwVfTy+PwGdvJGVg0
         NwRQ==
X-Gm-Message-State: APjAAAV0R5PSCQ4MByYRqPDIXvXVY4n8SijpfiVVzd4VhGQiCb/vHR4f
        VgFlQI4XU9ozaldJsf07WXq38viOlR8=
X-Google-Smtp-Source: APXvYqyHiauFodvIV3QlEIo4g6vXqaufbckuIo7GyepMO7F7S+cW8jHrqWaQhRgNtJi6zXxL+oav7g==
X-Received: by 2002:ac2:54a9:: with SMTP id w9mr15065821lfk.125.1556055751453;
        Tue, 23 Apr 2019 14:42:31 -0700 (PDT)
Received: from localhost.localdomain (80-167-223-88-cable.dk.customer.tdc.net. [80.167.223.88])
        by smtp.gmail.com with ESMTPSA id j9sm792244lji.35.2019.04.23.14.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 14:42:31 -0700 (PDT)
From:   Daniel Gomez <dagmcr@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     dagmcr@gmail.com, javier@dowhile0.org,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: temperature: maxim_thermocouple: declare missing of table
Date:   Tue, 23 Apr 2019 23:42:18 +0200
Message-Id: <1556055738-14838-1-git-send-email-dagmcr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/iio/temperature/maxim_thermocouple.ko | grep alias
alias:          spi:max31855
alias:          spi:max6675

After this patch:
modinfo drivers/iio/temperature/maxim_thermocouple.ko | grep alias
alias:          spi:max31855
alias:          spi:max6675
alias:          of:N*T*Cmaxim,max31855C*
alias:          of:N*T*Cmaxim,max31855
alias:          of:N*T*Cmaxim,max6675C*
alias:          of:N*T*Cmaxim,max6675

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index c31b963..c613a64 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -10,6 +10,8 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
@@ -262,9 +264,17 @@ static const struct spi_device_id maxim_thermocouple_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
 
+static const struct of_device_id maxim_thermocouple_of_match[] = {
+        { .compatible = "maxim,max6675" },
+        { .compatible = "maxim,max31855" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, maxim_thermocouple_of_match);
+
 static struct spi_driver maxim_thermocouple_driver = {
 	.driver = {
 		.name	= MAXIM_THERMOCOUPLE_DRV_NAME,
+		.of_match_table = maxim_thermocouple_of_match,
 	},
 	.probe		= maxim_thermocouple_probe,
 	.remove		= maxim_thermocouple_remove,
-- 
2.7.4

