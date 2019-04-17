Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E81C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD47217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzO9rCkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbfDQUz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45378 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbfDQUzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so23719644ljd.12;
        Wed, 17 Apr 2019 13:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZIq6j+6IS1KOZkUIM5hYoUOu/DqX2iyXvykiBiDhRTM=;
        b=nzO9rCkc4JlaPII2n/ZZOOTDvfP/IGZn4W/DNKsqgoU+USl8HlYpv6gcxKXu7XwIkN
         k/H7vGk1Ai2ExRQDFS1uFSreBwC17BHwTMw1CHFlgphQFYNUtBhe4nYZxjaFf7jDiMXo
         ID3GtyXiypiv6Td1QnRXmJwufNaQj7L1VBhbBT8xblDso7aKgV6dMl44jr3bGhoMo0GL
         fMy6d/Q07JZjbeaDjVEJaIMVReBFTPDZ2m+A0Q9RklDTj34cs3HjFmp2W2yQAGFi1EHr
         TsLHLKW+o6W1XhmgPDJwD1eAcbluSaR+UKlDVkW9hR0sgr2AXclvUrIgbbo7MYtaUbR3
         NZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZIq6j+6IS1KOZkUIM5hYoUOu/DqX2iyXvykiBiDhRTM=;
        b=FrkFS/RxgGg9UufMxSNNxZUVWdYcWsJ5tBxB/upeOAcSUxvWmD0mmZ389QZRdGXv1E
         7Bie5WlgVrNqX5PStQXpd2AJTJBcdV/I8nt7j2FZAmwEaAA3e49vfSlaqswRbtki0xHv
         V3PAp7NobPgFlJEMRbE9gXeyO7MVDWY9HKYGZ347hM/zK5RtXp9nbkK6iraIinu8AQtA
         iTNkWOJXbFW/VLCxdXD1qu4M4W5cSgdQDazhPrIGpkcmhPvxhbNiP4h9jFtQNrAss3cG
         bHZdVaKT5eZ6MdsHHAdMQ5/ns9HwbXK67AweaZb3chbuUexgeEUFGgT9W1qjIHLKjTFB
         H6fg==
X-Gm-Message-State: APjAAAXAecmKGS/VzbG2WwRJuMlWnoC3yLaUpPNRnQJSXZmp41C3XQ3y
        2Y/Q2f1si2DcH1CFDJVrDYz0xlgmN3I=
X-Google-Smtp-Source: APXvYqzHW/UEYbj34W2FrGuNG+ZlSbOIx1N7OYWzbNA8RR5Mj+C5mcr9isWS9rEnlpZMSjyFPvw3mg==
X-Received: by 2002:a2e:204e:: with SMTP id g75mr14777847ljg.92.1555534521993;
        Wed, 17 Apr 2019 13:55:21 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:21 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 15/26] dt-bindings: lm36010: Add function and color properties
Date:   Wed, 17 Apr 2019 22:54:28 +0200
Message-Id: <20190417205439.17685-16-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/leds/leds-lm3601x.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
index a88b2c41e75b..095dafb6ec7f 100644
--- a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
@@ -22,9 +22,14 @@ Required properties for flash LED child nodes:
 	- led-max-microamp : Range from 2.4mA - 376mA
 
 Optional child properties:
-	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- function : see Documentation/devicetree/bindings/leds/common.txt
+	- color : see Documentation/devicetree/bindings/leds/common.txt
+	- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 
 Example:
+
+#include <dt-bindings/leds/common.h>
+
 led-controller@64 {
 	compatible = "ti,lm36010";
 	#address-cells = <1>;
@@ -33,7 +38,8 @@ led-controller@64 {
 
 	led@0 {
 		reg = <1>;
-		label = "white:torch";
+		function = LED_FUNCTION_TORCH;
+		color = <LED_COLOR_ID_WHITE>;
 		led-max-microamp = <376000>;
 		flash-max-microamp = <1500000>;
 		flash-max-timeout-us = <1600000>;
-- 
2.11.0

