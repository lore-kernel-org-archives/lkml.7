Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955A5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642E120700
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="jzwGLMyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfCaKHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:07:55 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:17955 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfCaKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554026859;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=AccDNfcwa/WgjJCtRZ3qvk/xAv4V+exLGFsGCMWL7zM=;
        b=jzwGLMyVKn8hPSNuYWgdOr+Cue33NGs7SpvLlye+asTrlSk2URaCtPvku82Uu/hXsp
        Gr5mui9NCeMmHUQLO0/zlLKmKt4VkEV36ywolz60FoOeyA5uHuMcTG64FcTYATEWnhhs
        1lEwTW/Qfg0BAO7fDvdLdUkr9MNYSP1tPK6EJ7ciVIK0IWNBrGwtYE2RidzwTa13s+4M
        hj0YIiYtUi9h2HWsXJ1mbtJMERJS/D1/URhYuS3mVYw0Ge9UHb4O60P808nI9vNgt2aB
        qoRV7bBgbMKw77d1MT+dRkb0uqQjwYaYG442oa6KZrMZHXDvyWg06PIoNFwSoG+zybQy
        dFoA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2AyPQjXtNgX"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id K07648v2VA7PX1p
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 31 Mar 2019 12:07:25 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [BUG/PATCH 3/4] gpiolib: make legacy handling for spi-cs-high optional
Date:   Sun, 31 Mar 2019 12:07:22 +0200
Message-Id: <83b5c3ddee26c6f5e4b3b21d8a4346da5956de11.1554026842.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1554026842.git.hns@goldelico.com>
References: <cover.1554026842.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to make legacy support a config option instead
of requiring non-legacy device tree files to be updated.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/Kconfig      | 8 ++++++++
 drivers/gpio/gpiolib-of.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3f50526a771f..1a82619727c1 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -39,6 +39,14 @@ config OF_GPIO
 	depends on OF
 	depends on HAS_IOMEM
 
+config SPI_CS_HIGH_LEGACY_HANDLING
+	def_bool n
+	depends on OF_GPIO
+	help
+	   This enables a legacy handler which decodes the boolean spi-cs-high
+	   property found in some DTS/DTB to correctly work with cs-gpios
+	   with GPIO_ACTIVE_HIGH.
+
 config GPIO_ACPI
 	def_bool y
 	depends on ACPI
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 8b9c3ab70f6e..a22d2233458b 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -114,6 +114,7 @@ static void of_gpio_flags_quirks(struct device_node *np,
 			of_node_full_name(np));
 	}
 
+#if defined(CONFIG_SPI_CS_HIGH_LEGACY_HANDLING)
 	/*
 	 * Legacy handling of SPI active high chip select. If we have a
 	 * property named "cs-gpios" we need to inspect the child node
@@ -158,6 +159,7 @@ static void of_gpio_flags_quirks(struct device_node *np,
 			}
 		}
 	}
+#endif
 }
 
 /**
-- 
2.19.1

