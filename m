Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E98C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6590A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IumOWtCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfCZGc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:32:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42831 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbfCZGcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:32:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so7606149pfn.9;
        Mon, 25 Mar 2019 23:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=An1Thak+N2uo1Phe27RlwcvBy0GTCEB9vKmEbtfAA5I=;
        b=IumOWtCrCYn7jrssenXt6Ye3iJGcE2+LT8JMSupNqXpq+/VvySfzDrqTHiLCB/64O5
         395Km895fkuCzEouLMm9opo3XEvGAQauJJwwWmHz4Atiavnw4Po+fKNXs6deU9ROhvx7
         +cmtrBuD5BexyVMPYAPieDuONGrZAG/yHKH9GgxSzVQiRwW4pHMXLTOfvoxbGI1JxkEy
         w/ATvnwCcI7gZgqegBzu4pMyMrXusmnqrNO+zYzt3NXAFI0mEptJoxiniXvqLoZynQcR
         gbfkty3+UTL1bT2B6ZMt7/IifY3pQocrZQ9a+WZRL7p/3WWSpgZ3vv9GDoB/aymlFZq6
         b3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=An1Thak+N2uo1Phe27RlwcvBy0GTCEB9vKmEbtfAA5I=;
        b=Y74WtFxSopK1EWwGebyw7wW4daPGw2CuedVR78t33g+okktJK2QyI27zV2pnoQqi4B
         w+hEkIWJ3TyAPz4kfTgjZM5xfZdnmdYyU5N85nKq5NS5CWpUqD7U/wlCVnQDsYKeueuT
         8IypCSqfefURasmTdTkB85s+0YOtFksu9t+sJkmj/8hXm7o7MQxvLNMqVXbJAD/ujx6R
         GbIdHcZzts5A/V5g5a36Ht1WqZRxlkZKgQ8cLOYDm2gAsyVRN1I7NJMd1/oaqE1xMiAI
         hjeJb6T3iJK8rF/pjlqxKnIGnPPHcLvHDVA36cC3Ib6nMadtAMW2pqtqzBqRMHS6WSXW
         j1/Q==
X-Gm-Message-State: APjAAAWw3ZReBaURZNwCZkBf+tp9FEEVjlnsLt4CMm9n1bldR6g0hOC3
        lDWeptQOB3auV6meQaJQ8E6pACUB
X-Google-Smtp-Source: APXvYqxFFr8prXTGu7AtoO5Oey1riO8Z6fRE/+oD99PQwWiMZI3GTqV0Sm9ZKwI0IMrqnA/Gj95Qjg==
X-Received: by 2002:a63:1247:: with SMTP id 7mr23086747pgs.352.1553581942253;
        Mon, 25 Mar 2019 23:32:22 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id m10sm20096573pgq.42.2019.03.25.23.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 23:32:21 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] gpio: of: Check propname before applying "cs-gpios" quirks
Date:   Mon, 25 Mar 2019 23:32:08 -0700
Message-Id: <20190326063209.6421-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI GPIO device has more than just "cs-gpio" property in its node and
would request those GPIOs as a part of its initialization. To avoid
applying CS-specific quirk to all of them add a check to make sure
that propname is "cs-gpios".

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpio/gpiolib-of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 8b9c3ab70f6e..ee7f08386a72 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -120,7 +120,8 @@ static void of_gpio_flags_quirks(struct device_node *np,
 	 * to determine if the flags should have inverted semantics.
 	 */
 	if (IS_ENABLED(CONFIG_SPI_MASTER) &&
-	    of_property_read_bool(np, "cs-gpios")) {
+	    of_property_read_bool(np, "cs-gpios") &&
+	    !strcmp(propname, "cs-gpios")) {
 		struct device_node *child;
 		u32 cs;
 		int ret;
-- 
2.20.1

