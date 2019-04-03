Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E370EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D872084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvhzMUAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfDCECj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:02:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35133 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCEB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:01:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so939960plp.2;
        Tue, 02 Apr 2019 21:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJNmAhM2XNyQoO7XUgJsBxESauSJO4qHq5kgj9WqMZU=;
        b=KvhzMUAR2lSW4esbyEYh5b4AsJIl8g7BeQPj98AU4WWMcL4wNMILvGwUp+cvFXv19i
         6GUMKfW7YYTeWKt9t8ZrkjpERjfz95eYwjhslLA19flayKrpd2WU1QG+SdR3LX0EMK1I
         BTdMJb7ilpe41gOaYpbA0cgnxNUJS1ABHSohXp++WfHuTcYOJeNn0OMee38LBKkAOSsc
         Y9zJUdHe2SRrdWz6eWbtuSLv0r64mCGa6F7maJsNTvzFGQs8MYuNSJ81HrEyWvoNhmO5
         LCLszeHOAlz1FT7ngANz7ze8+jMloroG++86ElnFHq3VMmgwXO0GV4o/m4OIiyYpXJE+
         Bj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJNmAhM2XNyQoO7XUgJsBxESauSJO4qHq5kgj9WqMZU=;
        b=GbC9UMZxdjbduzlHWisfF77rz9mU2CMRPs7KZ9DESZmGA1A26y+6cy4FxM6dVxklhK
         WfnOswHA//ldnVvlq6Jfd6vR1r4+BOLZgl+WnXGmuyeZqcHPJaYdsgLqRQatfkGHAsfv
         QPxEaBheyaPsGFvg/M1wFS7XnT71uOA574iXijPTLFdhdUyz8dXe1Up4zGSDPyF35O14
         6d3x7NJpl8365tI2KP0S7Oe7GN9GL+yhCMrPzQUZuwMQ54+zdr1tFOqmFNMP9fe7WP07
         AcMVVN62ONX9TBjFpK0LUltAFHI0MkYYfmP2Ra34h3CmMaRkCIG6gnAjMKXADzhY7mKC
         8YeQ==
X-Gm-Message-State: APjAAAXhzVcMPZhorDzD0NJ1G+RLsiBuxgaEjoQJBTFd+ptlnd5rrtow
        xYwYpfqctJdub9PtULB7ZzqQIPF8
X-Google-Smtp-Source: APXvYqyrdZ271nYyFVZz+2ECRLdtBpFfP4Wa5aB4PcONyIjEHRUVzCkrDIhb2nYD9G9ppwl4+Rc+yg==
X-Received: by 2002:a17:902:868e:: with SMTP id g14mr9916862plo.183.1554264116609;
        Tue, 02 Apr 2019 21:01:56 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:01:55 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] spi: gpio: Drop unused pdata copy in struct spi_gpio
Date:   Tue,  2 Apr 2019 21:01:26 -0700
Message-Id: <20190403040133.1459-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unused pdata copy in struct spi_gpio. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 137f47e271dc..1cff30adc836 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -42,7 +42,6 @@
 
 struct spi_gpio {
 	struct spi_bitbang		bitbang;
-	struct spi_gpio_platform_data	pdata;
 	struct platform_device		*pdev;
 	struct gpio_desc		*sck;
 	struct gpio_desc		*miso;
@@ -415,8 +414,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	spi_gpio->has_cs = !!pdata->num_chipselect;
 
 	spi_gpio->pdev = pdev;
-	if (pdata)
-		spi_gpio->pdata = *pdata;
 
 	status = spi_gpio_request(dev, spi_gpio,
 				  pdata->num_chipselect, &master_flags);
-- 
2.20.1

