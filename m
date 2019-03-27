Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30146C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F181520811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRSKzvq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbfC0Giw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:38:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38192 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfC0Git (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:38:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id g37so2844868plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pkYcRhaf/UdfvMg3nL/yoq4ZD1aCpqg15tHnoz5T0Wc=;
        b=rRSKzvq15w/+Y+tTb3AJ4bYoYS5e2ZhFgZpUa7CQ0FJ3CgNagl7EnE6eQ8aUq+IEvT
         BkPr9i9Oif2t9xNYVWEY5onruu9KMtjUKRxvUMR+dJTzWa0ntAOBd9+TKRPLymIKGQ8J
         4PJLvbdVTVE+Y2R4clHEX6l0mdmZaA03DBXtpg5Xlv8K0EoH61YqR58fRsRonwSeUpQY
         SkqDIpmLyn5l2NVaK5UpVdCyonW+kpYdNLltBMN4rM5BGpUADQu7Xod0nlISu0gAD7hT
         BRyJt4sXZIzVu2zSwfuLa8YveoXou8SfZKiOfL8g80rJ8aNAL23LwiF7iUKJsLAxC52E
         AZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pkYcRhaf/UdfvMg3nL/yoq4ZD1aCpqg15tHnoz5T0Wc=;
        b=CCW0jkcAJFfMoub/VEO6aT7IVDWDiAybQrn+CDP/+Nl9Rc3SurA1pS4Q9AzP68ZKI6
         UeVKOYvuoc+IaOQnJ/Obyn0wHjpeRsRu81VBXYu+8Dp0TJ4KoZPe0KYWay/nbTd6k3gT
         hnAoLwc/OY1koHXKUFcqqkeAaMpQELzUxcVowwRoNcW6efBbtKtmgavPe9dvGicjG+5K
         oQ/S2dSNCwmJQrNhaRw7gUPWI6HINuyF4vI8zbVzuWr9mpRq5YY5FhDZ1Xn1GG+vSZoa
         /naamhcgWoNp6CSZJJvxxWjjLBYDTQ0nYmoly0Y0IDXxXhGewtGVSVkIQmhbMPESRSqA
         YVmA==
X-Gm-Message-State: APjAAAWdPSCwLcmc/j/ZNebsJrXchyPonazNJ+cFOwhpJ2DgptP7ZyiN
        u7JCxpaAKJ1NijRNxh8JtwE=
X-Google-Smtp-Source: APXvYqy6VrX2YadO0YqCo2/zq0QR6CBIFcTpT9r9TjL8e7NPnIOjgVFGr2P6SLqiA4L+rK7omJWXxg==
X-Received: by 2002:a17:902:523:: with SMTP id 32mr34475581plf.249.1553668728880;
        Tue, 26 Mar 2019 23:38:48 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id y37sm36866116pgk.78.2019.03.26.23.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 23:38:47 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: imx6qdl: Specify viewport count for PCIE block
Date:   Tue, 26 Mar 2019 23:38:41 -0700
Message-Id: <20190327063841.28350-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327063841.28350-1-andrew.smirnov@gmail.com>
References: <20190327063841.28350-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6 comes with 4 viewports, so configure PCIE node accordingly so
that the driver won't assume we only have 2.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 354feba077b2..e2e982f9b333 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -291,6 +291,7 @@
 			ranges = <0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
+			num-viewport = <4>;
 			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
-- 
2.20.1

