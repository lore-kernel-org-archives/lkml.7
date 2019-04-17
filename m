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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A27C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFD820872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP6fUeug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbfDQUzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38005 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387553AbfDQUz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so23765408ljg.5;
        Wed, 17 Apr 2019 13:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fibtK0q4WmazgyxF7PT5NVfWwpUs3Ml0gq9+e9gVMLA=;
        b=PP6fUeugqTylgwKMqje/9nA/aLNITd7EaHT28u8W/hhGifSEeU+wtnCSWTDKN/jBOG
         KvG2aPbSExPr0wkKjaPVshAO5r9QwYOGHRL0o+px02H2Ze+ODO31/vVcGgtAY8qNWNxo
         CbByay66dKwwfKoPr9oDhcbHmmzAYfajQgPEgFTmksvMIJqUo5cFGH3zQANMiNpcCaN/
         cM4lndQ/YFhlrqrGsMWeZN47Q6l0FRYog8TeEkCdgVbDp+LtiYscq3ojp2/bSLGsJeoU
         EeCE/5eXS4mal/Fo/+F6esRh6ntAO/DfIaMYwXwKX8mrfr6ms97/LTWFezes0MDc6opO
         HIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fibtK0q4WmazgyxF7PT5NVfWwpUs3Ml0gq9+e9gVMLA=;
        b=oBcLKg1aqPBCzooo3c02pyE5oJpoAL4PoSHylmefdlBex87uB6LqQPXEyw9HtTOWSz
         62AwTVyW4hqxBWu6QZJfQ9riD8RStbuItuzuaMrh+5ZRC1NyQSIXFVjBFUKArXEqjJl2
         75/G6zgvwadCNcdd79NlR9r0psWN1qNRHi8AalauxdSI+PyVteifZpv0uqNIE8HgvNpV
         3dMJwMr9iK8JuQS7MtKLaVrAcW1/A05/ZVyuaJ/GNSQrNkQpDkxWGh60VCceIdj/0wVC
         nv4C5lOmqXTql8iXFmEgIGbXF2mGULEqWphK1uMJTeSm4dx+HROn8ohbmpOm5KddqA1g
         ogDg==
X-Gm-Message-State: APjAAAV9fMK9Vm0mzPgHPI/ePQPRR5ALqmWA6sl2AqOD9Z6lSR9bN2IB
        nZTPXMFzpVa/hXo1vPiJuUTIt7NIbgE=
X-Google-Smtp-Source: APXvYqxQDdPFn6JAFlgfUBzBWWibrOfd1o/DVG6jdDI8/8woVuu/nVbEzlzw7Ptu+kT+3rkq/B1b7Q==
X-Received: by 2002:a2e:2b16:: with SMTP id q22mr52101445lje.20.1555534525640;
        Wed, 17 Apr 2019 13:55:25 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:25 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH v4 17/26] dt-bindings: cr0014114: Add function and color properties
Date:   Wed, 17 Apr 2019 22:54:30 +0200
Message-Id: <20190417205439.17685-18-jacek.anaszewski@gmail.com>
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
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
---
 .../devicetree/bindings/leds/leds-cr0014114.txt    | 26 ++++++++++++++++------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-cr0014114.txt b/Documentation/devicetree/bindings/leds/leds-cr0014114.txt
index 4255b19ad25c..f8de7516a39b 100644
--- a/Documentation/devicetree/bindings/leds/leds-cr0014114.txt
+++ b/Documentation/devicetree/bindings/leds/leds-cr0014114.txt
@@ -11,14 +11,20 @@ Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
 apply. In particular, "reg" and "spi-max-frequency" properties must be given.
 
 LED sub-node properties:
-- label :
+- function :
+	see Documentation/devicetree/bindings/leds/common.txt
+- color :
 	see Documentation/devicetree/bindings/leds/common.txt
+- label :
+	see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 - linux,default-trigger : (optional)
 	see Documentation/devicetree/bindings/leds/common.txt
 
 Example
 -------
 
+#include <dt-bindings/leds/common.h>
+
 led-controller@0 {
 	compatible = "crane,cr0014114";
 	reg = <0>;
@@ -28,27 +34,33 @@ led-controller@0 {
 
 	led@0 {
 		reg = <0>;
-		label = "red:coin";
+		function = "coin";
+		color = <LED_COLOR_ID_RED>;
 	};
 	led@1 {
 		reg = <1>;
-		label = "green:coin";
+		function = "coin";
+		color = <LED_COLOR_ID_GREEN>;
 	};
 	led@2 {
 		reg = <2>;
-		label = "blue:coin";
+		function = "coin";
+		color = <LED_COLOR_ID_BLUE>;
 	};
 	led@3 {
 		reg = <3>;
-		label = "red:bill";
+		function = "bill";
+		color = <LED_COLOR_ID_RED>;
 	};
 	led@4 {
 		reg = <4>;
-		label = "green:bill";
+		function = "bill";
+		color = <LED_COLOR_ID_GREEN>;
 	};
 	led@5 {
 		reg = <5>;
-		label = "blue:bill";
+		function = "bill";
+		color = <LED_COLOR_ID_BLUE>;
 	};
 	...
 };
-- 
2.11.0

