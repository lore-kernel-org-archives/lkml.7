Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA32C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F32120843
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgDW3yUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfFITJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 15:09:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33285 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfFITJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 15:09:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so7019137wru.0;
        Sun, 09 Jun 2019 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bLCSRColGizNu31TK3UQpaPLxmeS9gz/psiGlsjJuZw=;
        b=KgDW3yUAqGBg8E4HIS/0FqGIc2tIlR4hQc51nyjnoMdi/JXG8bVGKHCIN2sYaMrcRE
         w6roAUbEviGjT2VXDawakDImkN+HXOuPGCUyAz0YC8GXZkAofFJIZbUDf2sFPKsD00iL
         YoryMiuGP43Dc0B3tBzsJX35ynUdyXPoIzHW+M6Bx4FEQ3X8f5GUz8lpFmjcIlH7ryyQ
         hhdK/o7D0pEBbQ9g8+rcHPIIsQ98lKSQ1Ru6Bbr5dFzLHBJATO+Sq5UO6P05GKe9oDu6
         7syWo5tw4uJEjbpLkITS7XI43L6KcGa/bmpbxFkFJzVHeXTvynTBNrKEGAu14J6z2J2a
         WEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bLCSRColGizNu31TK3UQpaPLxmeS9gz/psiGlsjJuZw=;
        b=LvVbnf3fc5p9vQhOSrAnaVhX0gWmWGbdMjX12mevP+CgsHKnRDPPTbhWSphx1j/Vj1
         613sZQ+iqcura1Y2niLyUkGq9uEbKg62vNNn7/zJaTBIgXTJcawhu7JEJaXdC/FaAo1L
         vKznstBVhhNapE24oUwC01WVFd0GLdjHSgH8/UFG2tQ4km4sO6u75mbOVNrQalHVzGMW
         Znlw13iTrE2TR+GkVtNe+VcJRsjMtMoFAs6SHpHRy0ZU48eZiNSS0Fk0rQ7QWu/4i9nm
         5ObgW9FXpptRlK66kkwWETsch/Tn2lDUZc1RZxUTWJBnmOhWaoB0NtXrwXvLYuDpdNqC
         +JzQ==
X-Gm-Message-State: APjAAAU11NgWtSSSyWirBGlIvhHm8V+Ji2y9yy9gTf3Y/nRvEtJrmmP2
        xeNlqF2gW69zvtEoI5Dg+MktTu//
X-Google-Smtp-Source: APXvYqyMuUk9eFZnvPmQJXo1jsdK1s4Lkz4cG1e6mV0cl99hB0CqCR2yn/dnCKPr6A62PSIOnH06kA==
X-Received: by 2002:adf:eb09:: with SMTP id s9mr40930236wrn.127.1560107350802;
        Sun, 09 Jun 2019 12:09:10 -0700 (PDT)
Received: from myhost.home (ckm12.neoplus.adsl.tpnet.pl. [83.31.88.12])
        by smtp.gmail.com with ESMTPSA id y38sm14725041wrd.41.2019.06.09.12.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 12:09:10 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        dmurphy@ti.com, jacek.anaszewski@gmail.com,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH v5 24/26] dt-bindings: an30259a: Add function and color properties
Date:   Sun,  9 Jun 2019 21:08:01 +0200
Message-Id: <20190609190803.14815-25-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190609190803.14815-1-jacek.anaszewski@gmail.com>
References: <20190609190803.14815-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Simon Shields <simon@lineageos.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/leds/leds-an30259a.txt     | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-an30259a.txt b/Documentation/devicetree/bindings/leds/leds-an30259a.txt
index 6ffb861083c0..cbd833906b2b 100644
--- a/Documentation/devicetree/bindings/leds/leds-an30259a.txt
+++ b/Documentation/devicetree/bindings/leds/leds-an30259a.txt
@@ -15,10 +15,19 @@ Required sub-node properties:
 	- reg: Pin that the LED is connected to. Must be 1, 2, or 3.
 
 Optional sub-node properties:
-	- label: see Documentation/devicetree/bindings/leds/common.txt
-	- linux,default-trigger: see Documentation/devicetree/bindings/leds/common.txt
+	- function :
+		see Documentation/devicetree/bindings/leds/common.txt
+	- color :
+		see Documentation/devicetree/bindings/leds/common.txt
+	- label :
+		see Documentation/devicetree/bindings/leds/common.txt (deprecated)
+	- linux,default-trigger :
+		see Documentation/devicetree/bindings/leds/common.txt
 
 Example:
+
+#include <dt-bindings/leds/common.h>
+
 led-controller@30 {
 	compatible = "panasonic,an30259a";
 	reg = <0x30>;
@@ -28,16 +37,19 @@ led-controller@30 {
 	led@1 {
 		reg = <1>;
 		linux,default-trigger = "heartbeat";
-		label = "red:indicator";
+		function = LED_FUNCTION_INDICATOR;
+		color = <LED_COLOR_ID_RED>;
 	};
 
 	led@2 {
 		reg = <2>;
-		label = "green:indicator";
+		function = LED_FUNCTION_INDICATOR;
+		color = <LED_COLOR_ID_GREEN>;
 	};
 
 	led@3 {
 		reg = <3>;
-		label = "blue:indicator";
+		function = LED_FUNCTION_INDICATOR;
+		color = <LED_COLOR_ID_BLUE>;
 	};
 };
-- 
2.11.0

