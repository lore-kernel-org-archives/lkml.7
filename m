Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98275C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D9420823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="T0fK8fB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbfCZRda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:33:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34402 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbfCZRc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:32:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so15417956wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T1F7KCZQllI8gey25Uaoq9o2WFLfikAjSL+Gi1a9B5o=;
        b=T0fK8fB2fBY6RWA67zKWISoj1RTZ2iwfykSypKUPezvSZ8yY5gg8gl4/L7JTXBrZ5H
         w1tH1dRjR6QgRaky/7E3z08GdAVqnEc99Qbbkbli2ta8f5KUMWoPpCSg9Baj4RSkoRKw
         JfUtjoXiN9rg3tCFOJIv5SL85NJK8CA58I7SsrvxLSye6IQE3XA8lg7tzycantI8dFVl
         NDjk2D0EgXG7LI7+7+36eQ/kIJumsZU68XhjloVFdZ3v2JPXoyD2h10i2nk5altjiFv8
         nknoii9PDXEtdjLI3HaJzUS/NY36ZkhrISRNahZSoDk82kPW3mG4yVQXGY3ic7071HVg
         Bd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T1F7KCZQllI8gey25Uaoq9o2WFLfikAjSL+Gi1a9B5o=;
        b=qEGaAhHIp358lw4639+lUlERizuABO4vufXeA1a/c8T56FNV4AG1AMHe5rGsbLA4a2
         WaxBW+V3eiaHbBYu8e1t3k1Evzzkvu74CiU8QTP+oSJ8owdavRvGDLAJwheHcdxIzmKv
         prIY0LoWJ5UR9bl1keS2fBBdTuQzIHCm5HHx7XSlzJo2/KYbCtqJXGRMa42d17ZRtmZI
         pUpWICqoVjhFUohpZdV1EqZR+NnNpi9vwBvsyUjE1lqU4Ub7LoUw6VYJHTo9ea5ULG2w
         mpmcEy3q8f1DeIQSPRalP23JE0+9XecI0MFcmePs0fpP5vhldvm2ahFme9V5bpSswWnN
         5AKw==
X-Gm-Message-State: APjAAAXMm4c6ipFZDGpoMes/cpymCdbVtqwZLHkmARCrQ6uyWuHOaDe7
        NFKKzSvaqxS8ftIKER+flIP5cA==
X-Google-Smtp-Source: APXvYqzMS3UlFWKlsV8LAucBD7uTDvG+qskaGhPxUTsLoG1gNuF1jBvaMMqiP6SXR0AeGUgCAd639Q==
X-Received: by 2002:adf:b651:: with SMTP id i17mr19190021wre.108.1553621546597;
        Tue, 26 Mar 2019 10:32:26 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 4sm2534541wmg.12.2019.03.26.10.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:32:25 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 04/11] dt-bindings: input: add DT bindings for max77650
Date:   Tue, 26 Mar 2019 18:32:01 +0100
Message-Id: <20190326173208.30614-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326173208.30614-1-brgl@bgdev.pl>
References: <20190326173208.30614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the onkey module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/max77650-onkey.txt         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.txt b/Documentation/devicetree/bindings/input/max77650-onkey.txt
new file mode 100644
index 000000000000..477dc74f452a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/max77650-onkey.txt
@@ -0,0 +1,26 @@
+Onkey driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The onkey controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-onkey".
+
+Optional properties:
+- linux,code:		The key-code to be reported when the key is pressed.
+			Defaults to KEY_POWER.
+- maxim,onkey-slide:	The system's button is a slide switch, not the default
+			push button.
+
+Example:
+--------
+
+	onkey {
+		compatible = "maxim,max77650-onkey";
+		linux,code = <KEY_END>;
+		maxim,onkey-slide;
+	};
-- 
2.20.1

