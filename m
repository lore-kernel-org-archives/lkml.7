Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAD9C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D73921473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVr9cokB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfFNHqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:46:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38213 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNHqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:46:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so1069431pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7fks+RHwfpZJQtPWrw5nDoRST3V+5O+GkaVO28nAgb0=;
        b=XVr9cokBZ7NTVicCoyW2Xr5HSHlsN+mc4Dq2RdcuvjLzUt5G8awdcjxJUphdXzJN8u
         elwM9jtqHkzHrSClBryatrNx6NaUnCQf7Hd0xGdnYWXpeutN7/+giHDglndb4H33aLKP
         /TJ5Zae0GHxxAvWhOT6oW/cb/yjSz9jVBIXji9GQ5Ld1AVw4vq82JVrt4KdrBWfeeT06
         hPujR9TLIFc3ONvQi4Sz0k2MflMmXSg9FO45UI188R0vxosXUBuGNHtNwnnirVGEyIH/
         nmGAHwdVjeEAazZIYHBaVz9AT5/05yCMnmY5PApBUKp8y/BhiwN9KZiOAZcjlX6aHrZc
         rESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7fks+RHwfpZJQtPWrw5nDoRST3V+5O+GkaVO28nAgb0=;
        b=kfYfT0ctNEk0YLz9VXgPh+PhJ0TVX8zNcMq84LacvVFuMg/+SSsedFSqQtoXahnh7I
         OvBCUGeaOdfAGNLLoX7MQ9R96QFJwkD9+ImM27AJ/L4lrdIOOM+mQ3JzeNxmXlESoIWN
         AVR8hKLMTVram9OBcrvLrH1CV8ufCOW8kPGP8fDlDlqvGZHzLC+EhbUnrtBD+m/3e1eu
         1LbXKz8pCCv6ircE2M1gE4Sn+osaDCs4FrhwFBKu22U4JbmzrSQ66bl8p16teB1CMzNJ
         E9SilNih1DT4FcEVTo7PIzggLI8YN+lY7zeRS8GmpvaiJjfNvXGgbJlxn8hMX0ykWYSl
         6SXg==
X-Gm-Message-State: APjAAAW2FZas2AVL48sF97RZ8c8vs2Nr+e0G8rKkVXMoua9/L2vYYSvN
        j30m4Oq17dkdAQgMVxvniKM=
X-Google-Smtp-Source: APXvYqwXUksjrE5uUYp8QOxr7xqGP14YvpNzvd/EHyZwKuwFS7omhVqkD/hlPFyaIC9IoeS9Hkglkg==
X-Received: by 2002:a63:2a89:: with SMTP id q131mr34935679pgq.359.1560498367017;
        Fri, 14 Jun 2019 00:46:07 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id b17sm2128349pfb.18.2019.06.14.00.46.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 00:46:06 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: imx7d-zii-rpu2: Drop unused pinmux entries
Date:   Fri, 14 Jun 2019 00:43:48 -0700
Message-Id: <20190614074348.17210-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614074348.17210-1-andrew.smirnov@gmail.com>
References: <20190614074348.17210-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither pinctrl_i2c1_gpio nor pinctrl_i2c2_gpio are used anywhere in
the file, drop them.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/imx7d-zii-rpu2.dts | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-zii-rpu2.dts b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
index 6b8b2fc307d8..4a78ddc7513d 100644
--- a/arch/arm/boot/dts/imx7d-zii-rpu2.dts
+++ b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
@@ -775,13 +775,6 @@
 		>;
 	};
 
-	pinctrl_i2c1_gpio: i2c1gpiogrp {
-		fsl,pins = <
-			MX7D_PAD_I2C1_SDA__GPIO4_IO9		0x4000007f
-			MX7D_PAD_I2C1_SCL__GPIO4_IO8		0x4000007f
-		>;
-	};
-
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
@@ -789,13 +782,6 @@
 		>;
 	};
 
-	pinctrl_i2c2_gpio: i2c2gpiogrp {
-		fsl,pins = <
-			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x4000007f
-			MX7D_PAD_I2C2_SCL__GPIO4_IO10		0x4000007f
-		>;
-	};
-
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
-- 
2.21.0

