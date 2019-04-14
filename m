Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB9DC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2F82075B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFAVI+1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfDNSgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:36:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41782 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDNSgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:36:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so7464892pfd.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQ5tNU+tULfpJP7FQ2kX3oNDyXYEdefvp/NORRCRFx0=;
        b=uFAVI+1cZlxjsPuYLrr6NxgZPM1uBVaBSPIJAZtd+6WMumxTKyG6sNBrGVaZfAXogy
         ihSUH6UhshNI9R+vs9QAXZ5McdXbqu8aL+pXoufPJh2bvc1JWAx/YDNWq7W3BRlmqtlD
         K9LQx2QKgsxEAN0G8FXshEq67wRK99mN564bOfXkHjq58KRy6OWFXu8xzkkAlbuHXF9u
         Ktr6C+EJXTwbzTCKYj37Cpz9OP5JDPwtrncsg6GCm3ADpieYaIDGn7CzStBV5H6IHrJR
         8h2gKAPRuVFbd5oMlTQXgUE3szXKxxzfK4mq6dchqqJZxgdx8DN5KukQCPWwPUQjahT7
         QSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQ5tNU+tULfpJP7FQ2kX3oNDyXYEdefvp/NORRCRFx0=;
        b=Q2OEvzr/7FSZwiJE6pVzYGG3gGlGk01ml0LpYEEcRg6G4OW41pxtoH0urZ2c4h4JX4
         82mBga5LvW60WRX2G09sb9G/Enw8tHanlhh3QVAHsU0l+1+Hdx2ydRNET3RrxJUmjF1J
         hRe5NWuncvYQjVDd99iJA3nQjB/PkkGxP0VYaulEnitkQya6Lj3wSc11MglBaerbeTqM
         UZm2O1EzweicPO/DkXVEm1jVkcTxMkdF3XGW6/HnNzE8IQF4T1shhdYRQVliCJoXmsWU
         nm8u4/8U/VooKFJzu+w09KcBW414Q2z10Sk0xxSGv6DwTVhphTyUxS1Ci15v3lupgiLA
         3lAA==
X-Gm-Message-State: APjAAAVlcitrFSanld/NNJxeeUAv/AWgPhGzXasBPfbjsaUYLW+QfpZg
        yvsQu9LQtWS8oBzSeRa2wTc=
X-Google-Smtp-Source: APXvYqyVfG4+eI4GLbOtnY2sW3vD0EkLZUSNC2iWU7PHOo29psv2bcZHUB2/4MS88gqTciKRj3ay0g==
X-Received: by 2002:a62:1701:: with SMTP id 1mr71353999pfx.120.1555266965437;
        Sun, 14 Apr 2019 11:36:05 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v43sm45473300pgn.57.2019.04.14.11.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 11:36:04 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: vf610-zii-dev-rev-b: Specify CS as GPIO_ACTIVE_LOW in spi0
Date:   Sun, 14 Apr 2019 11:35:58 -0700
Message-Id: <20190414183558.25750-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190414183558.25750-1-andrew.smirnov@gmail.com>
References: <20190414183558.25750-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify CS as GPIO_ACTIVE_LOW in spi0 to fix the following warning:

m25p128@0 enforce active low on chipselect handle

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index bd79e00bf615..87b4d2cbe106 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -334,7 +334,7 @@
 		gpio-sck  = <&gpio1 12 GPIO_ACTIVE_HIGH>;
 		gpio-mosi = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 		gpio-miso = <&gpio1 10 GPIO_ACTIVE_HIGH>;
-		cs-gpios  = <&gpio1  9 GPIO_ACTIVE_HIGH
+		cs-gpios  = <&gpio1  9 GPIO_ACTIVE_LOW
 			     &gpio1  8 GPIO_ACTIVE_HIGH>;
 		num-chipselects = <2>;
 
-- 
2.20.1

