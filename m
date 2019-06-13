Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF8DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03D8206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DNY05Lim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfFMPlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:41:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44374 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbfFMJvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:51:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16so885707wrl.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6Z2dr5bGR1kZw1yfM5fScRi9BMJhzIO4sHAC3hw4oA=;
        b=DNY05LimyHtGQJrqNgqECLcrBxTAvCjomeobHqiJahS3lSERObMQmA0qLcgV07O8P2
         f0Jl1sRsHbxwoOAxKn6wQN1rKcbwvvpzQv8uE+mpEDMRCS916FZCF2IpZnIggGSF09DF
         qzZmNXMMwttzhYs4SiTPyw+FmW7H9rYeXHwokDYUIHlgMdZaganu+tQ8SJC930BWr0NP
         y3uUFxtk7cmtNcEa1gTXVX2JnwfipvtoIx+VondFT/pZh8v0AD8STqk3dSs99mOa4+K8
         y/0EtUnkKom0WTOYdPGcJ93hadC4w0U1HPPhIAQ28sFTEjQhXmLK1BWwIysHIA4NzZ4X
         N9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6Z2dr5bGR1kZw1yfM5fScRi9BMJhzIO4sHAC3hw4oA=;
        b=pwMWZkIg+gjqAy2z4zJScnsjl/697PKVk8shWz7yX20/g/8RRsviRayvDzzLTI+HHE
         smtScyOtpZBRfwiYgDIvSTw2JU6L7hpv3SqyVjBYdXz9Q4Dp28tjzTNuYqQIx7aZzqjG
         pplYsDQjiDLWcdjgvwE3DpxQvTPEIfCxrIQELYHhXf6bdhAWqyIppGNTnTJG0d+Y2knw
         rnNE95awSdh0M9vUkL6oOvgLL61V5pulb0wgJdvxoKePQ3Ghh/JVnawK35DAoEJ33wO1
         HJ3Sm7N9Z1/uX3OxEDDv8lRkp4pv5QMi025TfLIq+qokp+7Raqxp5Z3WM1kmsJ7JD0LQ
         Fg7Q==
X-Gm-Message-State: APjAAAXx7iphujbTxthK8tGwdt+6ZbmG29Ah1zQRwYLba+zGsasfgplr
        v04neejXDHq7nZap7jMZUUgq9w==
X-Google-Smtp-Source: APXvYqwJcbREN4JuE0cKuxBqCDv3nlxOH4+rl1IqL1ZE03A6gU9jaFDWpHFTWjmb+6wz8mg2//Zm2g==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr13078217wrk.229.1560419464808;
        Thu, 13 Jun 2019 02:51:04 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id y9sm4732681wma.1.2019.06.13.02.51.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 02:51:04 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] media: MAINTAINERS: fix linux-media mailing list for meson drivers
Date:   Thu, 13 Jun 2019 11:51:02 +0200
Message-Id: <20190613095102.7363-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both MESON AO CEC and MESON VIDEO DECODER point to the wrong linux-media
mailing list. Update it to linux-media@vger.kernel.org.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad2bf808b02c..58923e29244c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10219,7 +10219,7 @@ F:	drivers/watchdog/menz69_wdt.c
 
 MESON AO CEC DRIVER FOR AMLOGIC SOCS
 M:	Neil Armstrong <narmstrong@baylibre.com>
-L:	linux-media@lists.freedesktop.org
+L:	linux-media@vger.kernel.org
 L:	linux-amlogic@lists.infradead.org
 W:	http://linux-meson.com/
 S:	Supported
@@ -10237,7 +10237,7 @@ F:	Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 
 MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS
 M:	Maxime Jourdan <mjourdan@baylibre.com>
-L:	linux-media@lists.freedesktop.org
+L:	linux-media@vger.kernel.org
 L:	linux-amlogic@lists.infradead.org
 S:	Supported
 F:	drivers/staging/media/meson/vdec/
-- 
2.21.0

