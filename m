Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8811DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEDD21841
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sf8A6gyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbfCaRzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41943 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731453AbfCaRz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so8901313wrq.8;
        Sun, 31 Mar 2019 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRhyaqL2A8FcxSwVQxioSKMHZ1Dx0VcVyHzkz2mjWKY=;
        b=sf8A6gyYeLGUOezF8p4k2M7XCSvsRHG31QrffsFFvChrNO55OQUN1wPHIfAtq1G9Dq
         5ekFZfRaMR2AYXyZH3l3S/wY1rAwub+Y7/J1u5B3HlXIFiQypc3Z+VzUiZKGX3CMSbBB
         QQLt+2DjxM1XkS3kjigkzgQ3nk7Zse9tctA9rmPQyl6jL6EG4HIAYzWj5+1hEiNDZiWL
         JRtdKJmjHMN84Fn19iw6rmbgFQTsd1LK6Epk9a4+bOufZkudFoSdgV1wstOtXie+DvpG
         ea4yDVK07U7iPQge+9EiOJednbM92a+89TyrIzTkhseXoRhfYkzocwgmmyPpNn51oG2M
         CoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRhyaqL2A8FcxSwVQxioSKMHZ1Dx0VcVyHzkz2mjWKY=;
        b=FaSHTVgXsJrEv1MQMilcQGimQOgXmt79uI7nFnUp9XY+aRQ9pctZ1JUW4HkPOoP+kJ
         fbfX3l1hRMRs03ri2WZ0/HxBauLnimdDWSnr4rIDu/6Wpvkz028pl3t2R9ZwK57xM5mk
         H8bm4Ru7jjyLkI6RDzxLgsiYOLcZqNEkNxJmVXMzFS8YaLtcS4kEGnFFXVfJPvPvUSv7
         VhU3sch/CyYwqSZoPR07D9REPIzmiBnKvX5DGpFWRXW1j97jQrgy0pvrVJYFmz9Lo8gl
         txGkT5XFJNLyKyT6zohjYTcdp5k4gMNdUqY6JS6vtns+61CCMmjAgPH9L1sniIAtVcnt
         JjIw==
X-Gm-Message-State: APjAAAVaHaCjAf8/Q7+N89uI0nQuzaV5KO9uw3O1u7gABo+oHt+Hg+S4
        mc4TKwjiKKaqNotIswQ267nDdfL6
X-Google-Smtp-Source: APXvYqwj/mUR18kELEXJ7I01jKe66yTehk62uBUByBcObTbAIzfBDSnEKCSgeyuhJUEPPikJoTg/WQ==
X-Received: by 2002:adf:eaca:: with SMTP id o10mr4046384wrn.273.1554054926090;
        Sun, 31 Mar 2019 10:55:26 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:25 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 08/25] dt-bindings: lt3593: Add function and color properties
Date:   Sun, 31 Mar 2019 19:54:44 +0200
Message-Id: <20190331175501.23471-9-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Daniel Mack <daniel@zonque.org>
---
 Documentation/devicetree/bindings/leds/leds-lt3593.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lt3593.txt b/Documentation/devicetree/bindings/leds/leds-lt3593.txt
index 6b2cabc36c0c..24eccdaa6322 100644
--- a/Documentation/devicetree/bindings/leds/leds-lt3593.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lt3593.txt
@@ -9,8 +9,10 @@ The hardware supports only one LED. The properties of this LED are
 configured in a sub-node in the device node.
 
 Optional sub-node properties:
-- label:	A label for the LED. If none is given, the LED will be
-		named "lt3595::".
+- function:		See Documentation/devicetree/bindings/leds/common.txt
+- color:		See Documentation/devicetree/bindings/leds/common.txt
+- label:		A label for the LED. If none is given, the LED will be
+			named "lt3595::" (deprecated)
 - linux,default-trigger: The default trigger for the LED.
 			See Documentation/devicetree/bindings/leds/common.txt
 - default-state:	The initial state of the LED.
@@ -21,12 +23,15 @@ be handled by its own device node.
 
 Example:
 
+#include <dt-bindings/leds/common.h>
+
 led-controller {
 	compatible = "lltc,lt3593";
 	lltc,ctrl-gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
 
 	led {
-		label = "white:backlight";
+		function = LED_FUNCTION_BACKLIGHT;
+		color = <LED_COLOR_ID_WHITE>;
 		default-state = "on";
 	};
 };
-- 
2.11.0

