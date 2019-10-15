Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246D1ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6562086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewW4jt+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbfJOP1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:27:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34248 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733076AbfJOP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:27:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id k20so5004797pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xG29MGJ5CXLDB3OOeAsHPCpV9V/he2gmaGhRj12zAvM=;
        b=ewW4jt+Rm4ILwy/V1r4b05l/ehBuqPG4B7JYkFZZxWSmMHSQPlj/qWixRJ3DmjydIt
         x9wVWu6qUn/JVnaq+vCsqB1g7GeyN2KIvmP5h1xUlPBlfrfh9qy0XCWRiaD4WJ9c0agF
         3thAVlnBZ8htxJRy/B7m21Ba8ByKuCsiPO/zNzpGcqObsRgjMxl3ZMfiLiwf+j2lIblw
         jcqyx0VOkrV2kL0ZvGjxJXc2WXNqvius5aOBPVoPM0MuIMV5kkSkAL93nCPDcPLiu4xn
         lwDLS6aX5fHH6/WXdW2exIdEc0eTG+xXgLsWuUZnsT4uH3Mdmmn0lwuXrQCa2wvLXeD2
         Mk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xG29MGJ5CXLDB3OOeAsHPCpV9V/he2gmaGhRj12zAvM=;
        b=pwEZ/JKXK4PTXLQhAtUI03RGpal/4Px4Nq1ynZ6IQKtZG0UoKVqbZIhHI9NXAXRRg2
         XzPtaAkSI7/6hXPQhvsTdbvgGBa8EWBi+ti4OoDLnOmDyW4rvsXyIyBMT9dixxkiOrNa
         IgRWHdaCq4HH30SqHxZiUQEdRRtQJHwWuPCs9UC0Z6lBzaqArT2ndm0zTOR+9PwkwidK
         lGPTeKvqw1lJtF+keyjUPFVQI1LOyH0qlKtFtEKmbW/mL0VP32sPSjOIBfpnhNn1dymA
         pbe4i1zhomnCzV3YoOA3yLNi7rLWE9PBpQ/QpWXzaSX4aDrCIuEMrSaYSKwKHWmBHY5i
         rnpA==
X-Gm-Message-State: APjAAAX4oZjlDyRix5ReDTykE84o2zamVjS8WDr4P26ttQDqa2+RO12j
        iii3BaZJRrjA4x1G6Kz3EEeyFGIO1nA=
X-Google-Smtp-Source: APXvYqxVh/cl4OUEupiwqXnRInN9WWLmr51jkzllV8dQR7RJIlChmXn+S0+rq2wiFk3+GmRjBQs4VA==
X-Received: by 2002:a62:685:: with SMTP id 127mr37228208pfg.227.1571153245811;
        Tue, 15 Oct 2019 08:27:25 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id w11sm21158957pgl.82.2019.10.15.08.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:27:24 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: zii-ultra: Add node for switch watchdog
Date:   Tue, 15 Oct 2019 08:26:54 -0700
Message-Id: <20191015152654.26726-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015152654.26726-1-andrew.smirnov@gmail.com>
References: <20191015152654.26726-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C node for switch watchdog present on both Zest and RMB3 boards.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 8395c5a73ba6..e058ad908b2e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -400,6 +400,11 @@
 		reg = <0x2c>;
 		reset-gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
 	};
+
+	watchdog@38 {
+		compatible = "zii,rave-wdt";
+		reg = <0x38>;
+	};
 };
 
 &i2c4 {
-- 
2.21.0

