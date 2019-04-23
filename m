Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01061C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7480217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DgMeK+Bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfDWJFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:05:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47103 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfDWJFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:05:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so19104344wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Xr1jsD375oor0bo92jhZRFG0f8hjG44jwYFFHmorH8=;
        b=DgMeK+BwaWjcPMtn6kGpNMuyIYj+9K7mZAkhxOVwzqSNfPcylgvRWjyQeEbjGdNnem
         GAKBqIYG2Lyri3B1ymLcix43P/mSt908ega0cQKyn3vwDe+R/+xCL8tVBO1HxegQSTAj
         u1IroUfV75BxJ6SjjukrZDfNjqxlLmI+lZcn25y9V7N6A6XRAC8SzXaFgxhRNi/bVKPY
         uEJS5fCmw0ZLKpztXQ+yaXDnMthZIx5Tm41zyOYKxmEgGiMPhPpk86aPFwvlVW85qSDw
         mSYfWJns4vEN+VGYbOVDL6foNYHKAppHkK9JkeAqZTBNY8UbniVR7Bt7D5fQjJtzV3Zh
         f4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Xr1jsD375oor0bo92jhZRFG0f8hjG44jwYFFHmorH8=;
        b=qUaLDnSutvm0KATY+Qjub3glReCyYnu44v+MQ6I3+CpFdVMHxguBqafDKmrPB0Zclx
         CwzrywaO+KIyQrp8yB5o95UN8IMNkKgsZMDViHs5Je2EI4wZX3HNFzykGD+xgjgDJrkD
         2pXoPCoeE0I45gFV7zxRMoHrOVfOn9ItOP+I4wI1WrNL2F8I1JmCPW8ynCxX/TyO7zL7
         fG11ZovLp/ETDwYdNAQNHjc5n9NKl+QJxts47Eu7cJ0ioOm03O4cM59Gb0gLRgvFUqpw
         g4mO250ysXa4qAxYvh4ZWTehv9DcERlwApBo0BcH8IyOnUMcqWmkDsP2GZUwaRI51BYQ
         Hkfg==
X-Gm-Message-State: APjAAAUw6vV8ApHL/3srhfGk1yF0JVHLyx+im4Xp6s0WfnMiH5qwWpiJ
        wv10uTTVvgUKPRYMZcSzVlSJgw==
X-Google-Smtp-Source: APXvYqxwy3DIhp7siawS7mDWT/JHN5hUdzISvF5ahPbgJzmFLp9VajhBy8lPArwwQKdeT+onKoCV6g==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr3323308wrq.242.1556010304572;
        Tue, 23 Apr 2019 02:05:04 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-25-101.w90-86.abo.wanadoo.fr. [90.86.250.101])
        by smtp.gmail.com with ESMTPSA id v190sm15360434wme.18.2019.04.23.02.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 02:05:03 -0700 (PDT)
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
Subject: [PATCH v10 04/11] dt-bindings: input: add DT bindings for max77650
Date:   Tue, 23 Apr 2019 11:04:44 +0200
Message-Id: <20190423090451.23711-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423090451.23711-1-brgl@bgdev.pl>
References: <20190423090451.23711-1-brgl@bgdev.pl>
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
2.21.0

