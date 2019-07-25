Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8045FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0C72238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OWEjS7Hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389763AbfGYNTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:19:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53911 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389724AbfGYNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:19:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so44988947wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WPFUtxJDXKra9fqJ0rdgv7MWa5JnMhUuO280IUrtqLM=;
        b=OWEjS7Hf1Kk56zL7T/30GFyMXn6LUQKT6Ts67SfuOj67mvRUIrf4EyBnH0R2RBATWt
         qxQu0AHjxM6cKbcwz7nSqeQ8w/cIT51lxpcfrgGn1B3VJyD1R6dcigM1uO+rfVyDYAWn
         qn58p0EyOqw1zgDvQz+NfS7ZpkZ5uSFzmPnlWXafFOoxhrxk9K9G9HNMOgpveXOsvvAz
         7DWqkBRXFZaQZeamMHaJfN1N4ViJ0Yf9u5IR8jFaNN7KA2l9jsNpHYywHVI4FZrORkQP
         8CkWLwHGyp4qHToMT+0GTGYDR5OAW8+SzzisjCl8fYnu8kDiMJDe+TlOCgK1bBNYQOlL
         nO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WPFUtxJDXKra9fqJ0rdgv7MWa5JnMhUuO280IUrtqLM=;
        b=ZWVkWYyQx+zY17BGN7/8jsb6oGndo8+d2HioX8c+TG2gbVaEXAXebfwcFGhrC5g0oy
         iqh/jzRm9ZpMoV/yPif/+xmo5GfkWsfuoRLcyAGE1RGrCfXT+sduQG+eppeSHZhhmwiE
         SAzUKBtfl7kQvoe4xSexr6xGQzKNoWlg8Wm9HY4Jb9VudSGxQ9ywh8Rb18u6x8i2T7ey
         Lc+PViWqF9iut0UA/VkXHMlnKnH6PVtHJLQxpjgDi9RZSad7v8JQoSLy3zBCcwoUuALs
         LS7/UqZwTSJuOE4yhnVuWTxy7mY7qMIa9YJt9Y7/vNROAUl0S54hWcsS7DSgqbuUKRbZ
         iTDw==
X-Gm-Message-State: APjAAAUwfme6sSf4fstVq/gSW/6Frv+fd3gNaM4eQf50LnZP2zV8oOcL
        BFrMpcnOxru1dx/xcHLr7ZU=
X-Google-Smtp-Source: APXvYqwDivgfLYdB0sN1gN2PO4Z6g44XVRn1LUpNdsylFxeXh0Y0+CckexauNmiwoeRBfnFoB8M5CA==
X-Received: by 2002:a1c:9696:: with SMTP id y144mr79410440wmd.73.1564060388417;
        Thu, 25 Jul 2019 06:13:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id z7sm47119735wrh.67.2019.07.25.06.13.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 06:13:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 5/5] ARM: multi_v5_defconfig: make DaVinci part of the ARM v5 multiplatform build
Date:   Thu, 25 Jul 2019 15:12:57 +0200
Message-Id: <20190725131257.6142-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725131257.6142-1-brgl@bgdev.pl>
References: <20190725131257.6142-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add all DaVinci boards to multi_v5_defconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/multi_v5_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 201237002c65..bd018873e47a 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -14,6 +14,18 @@ CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G4=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91SAM9=y
+CONFIG_ARCH_DAVINCI=y
+CONFIG_ARCH_DAVINCI_DM644x=y
+CONFIG_ARCH_DAVINCI_DM355=y
+CONFIG_ARCH_DAVINCI_DM646x=y
+CONFIG_ARCH_DAVINCI_DA830=y
+CONFIG_ARCH_DAVINCI_DA850=y
+CONFIG_ARCH_DAVINCI_DM365=y
+CONFIG_MACH_SFFSDR=y
+CONFIG_MACH_NEUROS_OSD2=y
+CONFIG_MACH_DM355_LEOPARD=y
+CONFIG_MACH_MITYOMAPL138=y
+CONFIG_MACH_OMAPL138_HAWKBOARD=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_MX21ADS=y
 CONFIG_MACH_MX27ADS=y
-- 
2.21.0

