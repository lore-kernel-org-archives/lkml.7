Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933E2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B27820882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9KUxFX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDCEBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:01:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38237 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCEBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:01:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so7609521pgl.5;
        Tue, 02 Apr 2019 21:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktalrU7lzEY152yeF8ZuBQGbifejPdnTZhkabhS1hK4=;
        b=t9KUxFX0gu4WSgsOITBpSRXx2mZvjAXkPDLjwtp3bh7igjgCsK4jWa/YYyP4GPYliR
         3qSce8Em6Rma/t1/80OQH+tqAMjsBav6eHHn0KOK2Ge6ZJsSDjRogQl2X6KDrDtgsLTD
         XuVf8wLfWPzkBaPX3ANZ162rs3txZI7ZGjlLgMff9RkNp0FpZ/yD4rNnOaWfZe9EHWFJ
         5jtmdcJF5Z71FnR7Hiz0ZP64cyx36TDPCHUdT9I+h27z1sCzoQPacAZG6NE333sYjWTi
         8SxRfHqoawoAXkO1c1PCh7tqov274XKELvrR49QmGOBqBr03IZ1b9Hc632j9bhk2WvRH
         7XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktalrU7lzEY152yeF8ZuBQGbifejPdnTZhkabhS1hK4=;
        b=STZ6O8CE88w/4imD6rfEab5J8yKCir0E9YfhxDF/Fl/nQoM0Fbw8z/7DTMy2pbR+3/
         8iIQv0iqfuNYWv66m52isdWm41rOsXBjUb/VPqiDpZFBSJzeBbcJKFJUQ6DboJgE+eXB
         Y63en5evLOdanIcZM5pXdrQtSxCXPGpuwz8/LIGPfZufw/XZQhXVKfnZIHIyVMaNZkFZ
         MDEj5nyElSGoaxe7XVV/4cqamenYgz9PWNviPk9DjJQaHUI8kTqbVqxvXhZ4wHErB8zw
         6FQK54RmEULslObojGkVGDy97mp+Qgz5gtvFPJDMkLamoHS+cMgLFdhDAITuF6CfQ3ZT
         vAvQ==
X-Gm-Message-State: APjAAAWLB4zCaOK3+fnmZQlIP00GtZJ2baWnnYQCFFk+5G51vCiH6g7s
        uao6J3uDti4wZsPV/9epeaol1LZ7
X-Google-Smtp-Source: APXvYqwC39yYkO3uLgjz1mDhkVoRIUCGwX+dkYpHqzFoVEsB0FkIRIlQF/mhfNwxRJzQKPCKqWSllQ==
X-Received: by 2002:aa7:8ac8:: with SMTP id b8mr10430910pfd.234.1554264111336;
        Tue, 02 Apr 2019 21:01:51 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:01:50 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] spi: gpio: Drop unused spi_to_pdata()
Date:   Tue,  2 Apr 2019 21:01:22 -0700
Message-Id: <20190403040133.1459-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spi_to_pdata() is not used anywhere in the code. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 53b35c56a557..675fd65ebf1d 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -96,12 +96,6 @@ spi_to_spi_gpio(const struct spi_device *spi)
 	return spi_gpio;
 }
 
-static inline struct spi_gpio_platform_data *__pure
-spi_to_pdata(const struct spi_device *spi)
-{
-	return &spi_to_spi_gpio(spi)->pdata;
-}
-
 /* These helpers are in turn called by the bitbang inlines */
 static inline void setsck(const struct spi_device *spi, int is_on)
 {
-- 
2.20.1

