Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B9AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFAC20850
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PELb+UfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfCaR5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:57:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43529 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731229AbfCaRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so8882754wrx.10;
        Sun, 31 Mar 2019 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iEhJTflmg7KQbde2xxTokDIVhFAkE+Q29EtuKzQtszg=;
        b=PELb+UfJ8HoI9ookcICAo3IwkUY0c2tLvZ7urw0BMaDJYgwyqZt6ySJMyUptzKOu6C
         GhZ9Uegw+yjDHgmCA/6yYirywG4h9Pa++S736ffa8HKVsLiETmoxVQRADwSdBFsFoS7/
         uIt+vJO5kt9XW9WMVr5tIYpyoFpZnPG0ZlUZMb0ecTSUoMC4QX21+dODfij5Aj1Trz3M
         RDeySQpHuOfIlZ5+B+tQ3ZfU4bBERu3bC3xwQs7T4axfPp1PDcpErA67drmp5/6oab0u
         uKzGMTkanJCp1mfjrixLTUsga2eLKRWhZz2FAatgtyMwR9mv3QnfHQVvLEF5p0abYvi7
         9pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iEhJTflmg7KQbde2xxTokDIVhFAkE+Q29EtuKzQtszg=;
        b=Fo8qmNbCiOIV/iA6r3E97Mm9DK1m00JNszKZf/BQCfZM9gOhO+LmQp1aRHsDi9REch
         q/FBm66lW+L3jIyqy/FDcmgRgePxgpYWrK3tE/liVyoj3jpfn0LnZTOsNziJhV4ktoG5
         pKnMdDJeY+TW+XYpK6wPqLqddgkcsODasRg8wHrh6DXnE3EKLPZbkwGuIL3KQy8DXCEW
         o3XWoiFGvLOCtM/UfOEvzYw6eyXm29pc9nD7s2ECYEz6dKIC22A2bcS1zJJUAiSVoCle
         ZLwj9lUXiLIV/Lk5awo5p1x0P5wLZVF7yFAcR+GdbkBvnIi9c6UtEUIINk9+9W1Z09Qu
         6t4A==
X-Gm-Message-State: APjAAAUe2+19uMEHCZoSEd7VmkrONrOqm25F+2QlvZEEHDxKVFb7YIsw
        fn5FGGL3FEVmnMPxTypgVsrUgD0j
X-Google-Smtp-Source: APXvYqxLVwIlMD82Z6tKL/QpXUkFSh0hCGKd2WTKmv5DVqmWwZfitd/X40Ugk7FieA4UzPnZopJYUQ==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr35739579wru.266.1554054922883;
        Sun, 31 Mar 2019 10:55:22 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:22 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v3 06/25] dt-bindings: sc27xx-blt: Add function and color properties
Date:   Sun, 31 Mar 2019 19:54:42 +0200
Message-Id: <20190331175501.23471-7-jacek.anaszewski@gmail.com>
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
Cc: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
index dddf84f9c7ea..df2b4e1c492b 100644
--- a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
+++ b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
@@ -14,7 +14,9 @@ Required child properties:
 - reg: Port this LED is connected to.
 
 Optional child properties:
-- label: See Documentation/devicetree/bindings/leds/common.txt.
+- function: See Documentation/devicetree/bindings/leds/common.txt.
+- color: See Documentation/devicetree/bindings/leds/common.txt.
+- label: See Documentation/devicetree/bindings/leds/common.txt (deprecated).
 
 Examples:
 
@@ -25,17 +27,17 @@ led-controller@200 {
 	reg = <0x200>;
 
 	led@0 {
-		label = "red";
+		color = <LED_COLOR_ID_RED>;
 		reg = <0x0>;
 	};
 
 	led@1 {
-		label = "green";
+		color = <LED_COLOR_ID_GREEN>;
 		reg = <0x1>;
 	};
 
 	led@2 {
-		label = "blue";
+		color = <LED_COLOR_ID_BLUE>;
 		reg = <0x2>;
 	};
 };
-- 
2.11.0

