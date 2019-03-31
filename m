Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC08C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825F6218FC
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhLNdzpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfCaRzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40502 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731499AbfCaRzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so8881287wre.7;
        Sun, 31 Mar 2019 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fibtK0q4WmazgyxF7PT5NVfWwpUs3Ml0gq9+e9gVMLA=;
        b=mhLNdzpm+YpTis0Q3/ytnq9JNexsXp6isJPTlVrZvKK65J4w5s4n8bX3tCid4WN5+G
         d7FxTKFf1jrCOmbFrFCB47V8yau5KZ6YiKlE7XOj8NOexn/v9FxTDmjgNnNQXWIx6KRn
         SW6NS1Y2wU0PQWIgrV4X+b9dHG0q3jSnSHwIIjDGsCKjD197/nYOnboLkAqXaDKLV1J9
         hwGHxX9WCUbmP5A+9aFd1tygari4HmtSQX7LV2kksR7hP8lc8r9FCMgNp47y1kAi7nUM
         7pqtBmnIqwB/wNNuuRMLLeK6rUHtFfVtQIUkN2rEjXEqksUBdZe0mcfqsMw6EBPIQSfU
         eErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fibtK0q4WmazgyxF7PT5NVfWwpUs3Ml0gq9+e9gVMLA=;
        b=djPXLjoR8VIEjU3mIXssZHbg3Bxu8LoyQgPHRmkQnqcnTd9mkXEV6Oy4fXIxIQiOYq
         8wvvBSCGelBdhf7RtwKizX9h1UKRaSRjy4aLCs3FXeY+ZsRwGYR7j+SWXITn50KgPBm2
         HqYfzWnIcCmdl8OSAG2tV7nUmKWkN7M9LtpvKTlVC6MrMTUcKynQO5J0l6ZoGhAC+g7B
         qEZJDUfNu7mz6PVGCRkLqZsV50gIkutY5wDXja+2razvwLmK7PCqih/3G34TtS1s0SyB
         S+UEPZWYSVyJrE3RwwKD1pgKdapFxFlAwMn5XswaLdQcpVucT57JZdFj3MLZwhVdjg1V
         yu5g==
X-Gm-Message-State: APjAAAVQo8uYDf156zQLls7SnaImndnwTt2N20ZdAyfx/4+usEF2fRkX
        CLX7O8XNrvBBzYAe3lTwjnjRZ/yD4kE=
X-Google-Smtp-Source: APXvYqwOBGQ8LYqe/ZFR3HyEsXsqLg74Biz175wAjvntL4YHxgkZA0w7Kp/0wDZyV3nrNp1r4OoiTw==
X-Received: by 2002:adf:ed86:: with SMTP id c6mr39187261wro.146.1554054939477;
        Sun, 31 Mar 2019 10:55:39 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:38 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH v3 16/25] dt-bindings: cr0014114: Add function and color properties
Date:   Sun, 31 Mar 2019 19:54:52 +0200
Message-Id: <20190331175501.23471-17-jacek.anaszewski@gmail.com>
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

