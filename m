Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73562C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF22206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTbgR2Xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfFMP1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:27:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38240 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbfFMLf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:35:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so14805149lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 04:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIUb7QFUL1xRuXHbQmKp0h/Hfg3SUdrT+TZHlG6xJOU=;
        b=lTbgR2Xwu/whe+o46UX1RhLEox3cGUvTjCYuIrWyUWP7B8w2/vqQ1JEwU8d4RzAOBl
         pm1I3n7wUNVsmwb75kOj2f4XgoOo90I16rzzqyzmSNV+d0nKj9uTjdAz7i+a1Nc3vo9Q
         Z1vrTXsWQC6WtLCLAYgRcoalRS/0OaAQJ3alMagVRjXUlIgzjxfqRhCw1nt1XgzncvEe
         /dDaVsbJ3cRCuK8BFtOz6A7FTh7hVfMKxupY9W+GROwzJqgXj7d4kMVgCCsq9RWzOkJC
         OXJBxR4NZTC9KVlGZ5uW2zX38Uy/XhFbnv/cW8w+wHiW+EojI4Y1jgNubNYiwslNSS9P
         rNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIUb7QFUL1xRuXHbQmKp0h/Hfg3SUdrT+TZHlG6xJOU=;
        b=qucZFDutswRmWsJ5e5QVBRu2mPzhbjrS4HEqK03qgWNsoUTMYNm3g+CTcON38HDzSp
         0Fb6+a2h6tFfZfOJ8/KiLMLQxpkaPCr/y6m5xHCX8FQOWHw/3aD7UNjsp+TRffHRGXKf
         b2ImzV3h1LfZIA3+KeqAPHLH3xQ4YbZWPFEJurtKJU4a2lSZSmZ7ByWDwdlSkk2m866h
         LPZP3hsdWLZhteNDFb8aPLVzEwtBanQp2PDWxjyXNkJHcGGmWMIn02foRhFxVZzHJaUb
         lzUz06eMMJ1eXVHi0Imf4Juep6nz8XdRqmQrC9SyFKifFOhRaulsoNEjegIplVRElbuZ
         I89A==
X-Gm-Message-State: APjAAAX+Hca2Mx1oS817s9gJAYpfOgyufkQcOOxjBJcgwmCbG7pdM6wc
        txLLyMC7It1jRBGWi18k3WWVUQ==
X-Google-Smtp-Source: APXvYqwv6wz6nCObWy2ZHT5xYou7pip7nnuJWYUnTo0YChkQcsvkhV1jKxP4YeJMIFfqP2xtnJp7hw==
X-Received: by 2002:ac2:4202:: with SMTP id y2mr26100657lfh.178.1560425724489;
        Thu, 13 Jun 2019 04:35:24 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id r2sm541985lfi.51.2019.06.13.04.35.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 04:35:23 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        linus.walleij@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3] net: dsa: fix warning same module names
Date:   Thu, 13 Jun 2019 13:35:03 +0200
Message-Id: <20190613113503.4839-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_NET_DSA_REALTEK_SMI and CONFIG_REALTEK_PHY
enabled as loadable modules, we see the following warning:

warning: same module names found:
  drivers/net/phy/realtek.ko
  drivers/net/dsa/realtek.ko

Rework so the driver name is realtek-smi instead of realtek.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/net/dsa/Makefile                              | 4 ++--
 drivers/net/dsa/{realtek-smi.c => realtek-smi-core.c} | 2 +-
 drivers/net/dsa/{realtek-smi.h => realtek-smi-core.h} | 0
 drivers/net/dsa/rtl8366.c                             | 2 +-
 drivers/net/dsa/rtl8366rb.c                           | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/net/dsa/{realtek-smi.c => realtek-smi-core.c} (99%)
 rename drivers/net/dsa/{realtek-smi.h => realtek-smi-core.h} (100%)

diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index fefb6aaa82ba..d99dc6de0006 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -9,8 +9,8 @@ obj-$(CONFIG_NET_DSA_LANTIQ_GSWIP) += lantiq_gswip.o
 obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
 obj-$(CONFIG_NET_DSA_MV88E6060) += mv88e6060.o
 obj-$(CONFIG_NET_DSA_QCA8K)	+= qca8k.o
-obj-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek.o
-realtek-objs			:= realtek-smi.o rtl8366.o rtl8366rb.o
+obj-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek-smi.o
+realtek-smi-objs		:= realtek-smi-core.o rtl8366.o rtl8366rb.o
 obj-$(CONFIG_NET_DSA_SMSC_LAN9303) += lan9303-core.o
 obj-$(CONFIG_NET_DSA_SMSC_LAN9303_I2C) += lan9303_i2c.o
 obj-$(CONFIG_NET_DSA_SMSC_LAN9303_MDIO) += lan9303_mdio.o
diff --git a/drivers/net/dsa/realtek-smi.c b/drivers/net/dsa/realtek-smi-core.c
similarity index 99%
rename from drivers/net/dsa/realtek-smi.c
rename to drivers/net/dsa/realtek-smi-core.c
index ad41ec63cc9f..dc0509c02d29 100644
--- a/drivers/net/dsa/realtek-smi.c
+++ b/drivers/net/dsa/realtek-smi-core.c
@@ -40,7 +40,7 @@
 #include <linux/bitops.h>
 #include <linux/if_bridge.h>
 
-#include "realtek-smi.h"
+#include "realtek-smi-core.h"
 
 #define REALTEK_SMI_ACK_RETRY_COUNT		5
 #define REALTEK_SMI_HW_STOP_DELAY		25	/* msecs */
diff --git a/drivers/net/dsa/realtek-smi.h b/drivers/net/dsa/realtek-smi-core.h
similarity index 100%
rename from drivers/net/dsa/realtek-smi.h
rename to drivers/net/dsa/realtek-smi-core.h
diff --git a/drivers/net/dsa/rtl8366.c b/drivers/net/dsa/rtl8366.c
index 6dedd43442cc..fe5d976b0b10 100644
--- a/drivers/net/dsa/rtl8366.c
+++ b/drivers/net/dsa/rtl8366.c
@@ -11,7 +11,7 @@
 #include <linux/if_bridge.h>
 #include <net/dsa.h>
 
-#include "realtek-smi.h"
+#include "realtek-smi-core.h"
 
 int rtl8366_mc_is_used(struct realtek_smi *smi, int mc_index, int *used)
 {
diff --git a/drivers/net/dsa/rtl8366rb.c b/drivers/net/dsa/rtl8366rb.c
index 40b3974970c6..a268085ffad2 100644
--- a/drivers/net/dsa/rtl8366rb.c
+++ b/drivers/net/dsa/rtl8366rb.c
@@ -20,7 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 
-#include "realtek-smi.h"
+#include "realtek-smi-core.h"
 
 #define RTL8366RB_PORT_NUM_CPU		5
 #define RTL8366RB_NUM_PORTS		6
-- 
2.20.1

