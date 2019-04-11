Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6158BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBB7217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jI/91yI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDKMnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:43:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38578 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfDKMmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:42:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so6493326wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thktmtrBxCOzAR5GwyGXSpdkH1/7+Qf2imSJbDAJhEo=;
        b=jI/91yI3JR7wB3EdmgFz0vMNuocykerMGWB49lRaDKaO7vFd3Lglu9tXlOVvXxMxfs
         Y/Cw4MJGM7tZLECX03/M4MLQERdnuWJUybZaiE6Hb4xRD54XfXY+/asMx8Y2E4nP8W82
         oNrL6Q7jQcNON21vfL6KFu1jPKg4htdUTuHDflGaNnQSzWyHE8fOR+efj+sq4R+MPTB5
         KZDBgIqeAQ1cTAyKwPffCS5bqdjBno/DANqjD3XZXQ1qSkNVnz3uU8HnX3T+Fs9Y/zfx
         5WWKm/ESljDk/vdSQSpF409DP2JTR0CAE6hrGKpUucR1nnLWrwJrsUJ3JoakrYPNTCqr
         BTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thktmtrBxCOzAR5GwyGXSpdkH1/7+Qf2imSJbDAJhEo=;
        b=q7LLyzAiAXn9d86ugIwFUx9hE9BcF5Fj9WQ4EhVgncBGUXkCIdV8Toyq2ln3275WYZ
         ngE+kNVW7d5mszMGBn+Yu69v9xqmuG6xTq3HMQyM5BIS0BEsZAN0aFpFwZcvE7GlGk7K
         6867MR9i+nw9V+eVodyNuccTmTclVxa5SmMAizbI6fPPgPXZvPINfOM0q4LN47OvWh2D
         IQgYYunYmaYzVA5AU14h+H3/CG4i0ecRSeOA17CTyD6mA8ONfBwjoZBngj5knlegiRv8
         ix0kbyMmWQN45Lgjqbqi5AGh749hzA1PeE8W+y/mbYJUDohwZRwxPsbYis8neVQv1/Sw
         hFiQ==
X-Gm-Message-State: APjAAAU1BP+SWLcldR0vGag37BWC01NAleTABs/Rw08AFYZc8faxIqnN
        HmaOQAJKQTkyw7OA+W2e0watIQ==
X-Google-Smtp-Source: APXvYqxsFyI0BkvQcC7kZTrnrKzM5dpg0VvpNJzhKOOqlnn3UNp0/BucnlztwvyCdY24UfJU29BJfQ==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr6185849wmh.81.1554986542736;
        Thu, 11 Apr 2019 05:42:22 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id d4sm32894510wrv.42.2019.04.11.05.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 05:42:21 -0700 (PDT)
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v9 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date:   Thu, 11 Apr 2019 14:42:03 +0200
Message-Id: <20190411124212.7612-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411124212.7612-1-brgl@bgdev.pl>
References: <20190411124212.7612-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the battery charger module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../power/supply/max77650-charger.txt         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
new file mode 100644
index 000000000000..821a2240e70f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
@@ -0,0 +1,28 @@
+Battery charger driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The charger is represented as a sub-node of the PMIC node on the device tree.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-charger"
+
+Optional properties:
+--------------------
+- input-voltage-min-microvolt:	Minimum CHGIN regulation voltage. Must be one
+				of: 4000000, 4100000, 4200000, 4300000,
+				4400000, 4500000, 4600000, 4700000.
+- input-current-limit-microamp:	CHGIN input current limit (in microamps). Must
+				be one of: 95000, 190000, 285000, 380000,
+				475000.
+
+Example:
+--------
+
+	charger {
+		compatible = "maxim,max77650-charger";
+		min-microvolt = <4200000>;
+		curr-lim-microamp = <285000>;
+	};
-- 
2.21.0

