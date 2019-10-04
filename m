Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D178C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D50222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I0UP6QjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfJDVno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:43:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38381 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730842AbfJDVnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:43:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so3728501plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAfMi4NSBoja5vxxnTEYMZ6gxDSssSgVHfIbff12mb4=;
        b=I0UP6QjOkuk9029ycIGlBRYjuryADPNl2rs34QcwDy7DnSdfOXcB/b4kY7TUCGXC/k
         IJiGk5ETewSWBrF7ld044EOqYn1Pdu43lwCaDi9y6kk9EwIJtcCsSJvqR9/L1EzcsfJT
         uqI7gqcYOF9lRF314+CkfUmQdzqeJGSTbKmVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAfMi4NSBoja5vxxnTEYMZ6gxDSssSgVHfIbff12mb4=;
        b=rO1XfKyhG0081QFdzf3uTcpwbZb8JNIZVIZPD8fvl3WlCHz1JwVmiaLQ72ElxGOq31
         kjDUzpGbs1wNlL7NFwWwhXgHicC9kg1SBc7fyD+9b7pGGDT/hvxphsz3688Iy1MbisYz
         XfdDGHGMX90jci3EQ4Hrfxe87qQ2VohG97VoJhCuOOCwjz51V6JmCwpvxBSsdCxkaOzx
         h+7mDT7A+GHrl6DdCDn3UM2Ysv5WYHkfhGhQpZXr6ynx3q8pVrimMGC/BmM1fVkWsRyZ
         aq5r8RlFFgxz+GNTTTbqCgwtMUTBA+2wlAjKEW1Mo2QUn/HdY+R24Y1ucHUas9ltafaD
         hIaA==
X-Gm-Message-State: APjAAAWH0cJzhb2CXGIE9n35Puku5DBGSQKlCCvm8qS5DawK6ZWL7vxQ
        7YsvmJWLqOUVrYjxN3hsGWMW871mOeQ=
X-Google-Smtp-Source: APXvYqxihsu1cUaj4qIQSJ2iXk6r9CdGaCYQYuCvV6SJdCiuuuOPIC9sLcbvOHlmoausFB13h9lJTg==
X-Received: by 2002:a17:902:5987:: with SMTP id p7mr17651026pli.242.1570225419271;
        Fri, 04 Oct 2019 14:43:39 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a11sm10446799pfg.94.2019.10.04.14.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:43:38 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH 03/10] rtc: armada38x: Use of_device_get_match_data()
Date:   Fri,  4 Oct 2019 14:43:27 -0700
Message-Id: <20191004214334.149976-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004214334.149976-1-swboyd@chromium.org>
References: <20191004214334.149976-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the more modern API to get the match data out of the of match table.
This saves some code, lines, and nicely avoids referencing the match
table when it is undefined with configurations where CONFIG_OF=n.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-rtc@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please ack or pick for immediate merge so the last patch can be merged.

 drivers/rtc/rtc-armada38x.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 9351bd52477e..94d7c22fc4f3 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -74,7 +74,7 @@ struct armada38x_rtc {
 	int		    irq;
 	bool		    initialized;
 	struct value_to_freq *val_to_freq;
-	struct armada38x_rtc_data *data;
+	const struct armada38x_rtc_data *data;
 };
 
 #define ALARM1	0
@@ -501,17 +501,14 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct armada38x_rtc *rtc;
-	const struct of_device_id *match;
-
-	match = of_match_device(armada38x_rtc_of_match_table, &pdev->dev);
-	if (!match)
-		return -ENODEV;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(struct armada38x_rtc),
 			    GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
 
+	rtc->data = of_device_get_match_data(&pdev->dev);
+
 	rtc->val_to_freq = devm_kcalloc(&pdev->dev, SAMPLE_NR,
 				sizeof(struct value_to_freq), GFP_KERNEL);
 	if (!rtc->val_to_freq)
@@ -553,7 +550,6 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
 		 */
 		rtc->rtc_dev->ops = &armada38x_rtc_ops_noirq;
 	}
-	rtc->data = (struct armada38x_rtc_data *)match->data;
 
 	/* Update RTC-MBUS bridge timing parameters */
 	rtc->data->update_mbus_timing(rtc);
-- 
Sent by a computer through tubes

