Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0805C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986D720891
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axyw3Cad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKRLAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:00:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36343 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKRLAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:00:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so18902478wrx.3;
        Mon, 18 Nov 2019 03:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/r/rbSHnQ681j6w5Fd1xT+tCG0CKj+LRyHPCBVvmrlM=;
        b=axyw3CadnYKZZ/gPWsjDxs4XIRVAbwQA2BIPtCkbInP+P5tLbFpCU451G7RuR37Z9l
         ngNfWM+B2QlQT6ZFR4BjTiP5kgxgdwN3Fy2FBXubHDp3BVEgFsTV9E2yFVLgS3Dy5tY2
         mtozqqdqgWFfS7FhuwMK5zdEC7a13CXKFPr7KmRQ861zPsj4CmXlqCyT3+6sEkGiDGuM
         ZLS9Qcw35kxi4bErUZqf9Rl8lHF9jcdCQcO/mPP/rMfVUq3cQ/OhJ6GrlWCsqC0TQx5e
         +4THiAdRNt35MiDPE2SrPRjTHjJgbwI5HHkIEb9vrQ94w/xIk7hpEwWe5eObrAXytAD/
         PNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/r/rbSHnQ681j6w5Fd1xT+tCG0CKj+LRyHPCBVvmrlM=;
        b=RbKH0MHrUsDpkvEz0/yl1AX/8sPXMU2hAYoOK7pBu/Rs9xUr4Yh9XrNZbjxl9HmksN
         VV99EbN7myQ4ZN8sivMRNrQYdoOckbpGkCw3WPH/wBJ3y11ZLvQbrCp49hkYMquwjudG
         m09Dzd8EX+LhFpArlstknZBpFREue96TOI5h+2/x9Q6RTSAlUjwk1BeHtpPgDOSZK6+F
         +RdlaUPY/LHUOCoWbHp9Nh366rgFm0sjy9TgtPojnaFf0+rJGsdu/w6K4oydleLnoK2i
         wFuYEbE2wvt8PzSyd+7TYVzhcj02mts29MMvtxiZFsnV2BpATQJ6dkDUuV1L3Pyc9Vc6
         W/JA==
X-Gm-Message-State: APjAAAXvGG4HIBrqGnYoQv7lsA8wJUmh/LmLtZK+ndPSb8ZHviBd3m7k
        Z3mvf9l/2Eu/uKP0b1qHTjM=
X-Google-Smtp-Source: APXvYqxEFAX5cEn1tc0TWYXeLTvWC45ER2bxKy0vHBbmoO46RYGcBJIFgShG/Z/M5rcmO7fKz2Repg==
X-Received: by 2002:adf:f005:: with SMTP id j5mr28478666wro.295.1574074840489;
        Mon, 18 Nov 2019 03:00:40 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f67sm19873313wme.16.2019.11.18.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:00:40 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v6 1/8] dt-bindings: pwm: allwinner: Add H6 PWM description
Date:   Mon, 18 Nov 2019 12:00:27 +0100
Message-Id: <20191118110034.19444-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118110034.19444-1-peron.clem@gmail.com>
References: <20191118110034.19444-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 PWM block is basically the same as A20 PWM, except that it also has
bus clock and reset line which needs to be handled accordingly.

Expand Allwinner PWM binding with H6 PWM specifics.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
index 0ac52f83a58c..1bae446febbb 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -30,13 +30,51 @@ properties:
       - items:
           - const: allwinner,sun50i-h5-pwm
           - const: allwinner,sun5i-a13-pwm
+      - const: allwinner,sun50i-h6-pwm
 
   reg:
     maxItems: 1
 
   clocks:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: Module Clock
+      - description: Bus Clock
+
+  # Even though it only applies to subschemas under the conditionals,
+  # not listing them here will trigger a warning because of the
+  # additionalsProperties set to false.
+  clock-names: true
+
+  resets:
     maxItems: 1
 
+  if:
+    properties:
+      compatible:
+        contains:
+          const: allwinner,sun50i-h6-pwm
+
+  then:
+    properties:
+      clocks:
+        maxItems: 2
+
+      clock-names:
+        items:
+          - const: mod
+          - const: bus
+
+    required:
+      - clock-names
+      - resets
+
+  else:
+    properties:
+      clocks:
+        maxItems: 1
+
 required:
   - "#pwm-cells"
   - compatible
@@ -54,4 +92,14 @@ examples:
         #pwm-cells = <3>;
     };
 
+  - |
+    pwm@300a000 {
+      compatible = "allwinner,sun50i-h6-pwm";
+      reg = <0x0300a000 0x400>;
+      clocks = <&osc24M>, <&ccu CLK_BUS_PWM>;
+      clock-names = "mod", "bus";
+      resets = <&ccu RST_BUS_PWM>;
+      #pwm-cells = <3>;
+    };
+
 ...
-- 
2.20.1

