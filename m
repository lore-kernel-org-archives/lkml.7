Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6C9C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F6F2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vV+7SSNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfI3JAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:00:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42912 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbfI3JAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:00:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so10260102wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 02:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W2J9dQLufx+5N7H9fryJdO9qXSOJj2gGDtR8zr4hxQA=;
        b=vV+7SSNuoWy2nD/NSk6a4zQk+Zmjz9+WFa7kEkZKz4crgSELbG/yfjuaYGiAjFTqHW
         qNpI/6zWWNVgvpYl1rjA5oNFseC3xl4Y65yfrka38zy/cQBNhxaLKvfsYC8Url3ZDz5Z
         CnJs323Gj8vWu3S9MrMjc9WgI3hoY+0k6kiPZWtopFygAkkGVndhm/EV8wmQyk9o7uAz
         84YlcwI4FLDNf6wP3bMDUetDf2wJGFyJHR0sCxsMhx7CeFMUUuVT5ZRK49UerH0QKjW5
         w3yW0TL2vPBYeKtqyya1W/nwpA9puAIv9FvD/PVzsYDiW8Gi5uGSAP1zyRUvhgNfWdvW
         fQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2J9dQLufx+5N7H9fryJdO9qXSOJj2gGDtR8zr4hxQA=;
        b=YvkL9FrbQyGKgICoHQkk+3UySz8UC34svjIz2d7YBsX6LMex/hdeLN6tumOlDnCjUw
         1350UNunAUJ5LKYqsfMBxWCgQ96tXsVhxF/xrSDFxAZlUcdX3IhlDmRpHphELkoPjEcK
         hhiEISE/mIJj7ji/zoBzv77iSgfeOoBqj5m6IN1q3eKsHTK6G9pd0yiLI7zXI4cNQAAI
         ipLHyM810t96JVJEER4UuwpjOpHqqZsZZPKzYojyKCS7Xc6fXjp+/ne01M9xOP5V5gEB
         YdViTnAAZsp7Fg5vY9dL9fRI7bxZ4tq/M1ckXKhZU8gG6oiFPQs+f3eHe/W1gI0n9AVb
         dfsA==
X-Gm-Message-State: APjAAAUWkJLNjiCi9oiAR+3bWsaamiTq9Ih7sc+iaFTEI7oX9PlVs4ZV
        cTIrQ04RJeqV4JTDEPY3Yhy3aQ==
X-Google-Smtp-Source: APXvYqxlgFC3g+ldXyGgTFB5IwYzp78K/41Y3/oxmHVqlh5ubFWKckEipyQ9STUd1SmjFF28YIZp/A==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr12507385wrr.390.1569834003779;
        Mon, 30 Sep 2019 02:00:03 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id m18sm12665723wrg.97.2019.09.30.02.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 02:00:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/2] dt-bindings: at24: add new compatible
Date:   Mon, 30 Sep 2019 10:59:57 +0200
Message-Id: <20190930085957.2779-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930085957.2779-1-brgl@bgdev.pl>
References: <20190930085957.2779-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

arch/arm/boot/dts/at91-dvk_som60.dt.yaml uses the compatible string
'giantec,gt24c32a' for an at24 EEPROM with a fallback to 'atmel,24c32'.

Add this model as a special case to the binding document.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/devicetree/bindings/eeprom/at24.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
index aee0890d3b7a..db365e913d3b 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -101,6 +101,9 @@ properties:
       - items:
           - const: renesas,r1ex24016
           - const: atmel,24c16
+      - items:
+          - const: giantec,gt24c32a
+          - const: atmel,24c32
       - items:
           - const: renesas,r1ex24128
           - const: atmel,24c128
-- 
2.23.0

