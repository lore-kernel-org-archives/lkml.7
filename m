Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB2FC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1738920835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDvNKhXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbfDQRaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:30:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53113 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733091AbfDQRac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:30:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so4349100wma.2;
        Wed, 17 Apr 2019 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+4rEQwoh/x6L1vMEfLnhjWMCaYNdunEelwJgclnNME=;
        b=vDvNKhXwZtw5PYDjhyt86dTdZtFUpLmlgJOxssMQLWVyQeHZE+5hkkZYnXL6ibHvW7
         TMBc7uvC16uiMY+NheCZ1o95XPkUBsVTD6Jc5xvZNC69juqmeo+4EuvgyE3vFw5Z38ht
         BUc+lqiibHAHWaOXPPyjnzqMxRCoXEAD5I2BHI3cZzyCYfA8Px05MkUVudqO7sMmo6CL
         jmLjizSd4P5sqdAKyjSVnez+dVUV3hQEOiFUHbDI+t0Mq+ydDVNfJS47EcV0O6EXVX7N
         9XmXxJoWdT9X+4xGLA7NOSoszrNTi+tEeF21EoeAUUeY1VwQSUP/76Xx7PzANrboKoj0
         6+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+4rEQwoh/x6L1vMEfLnhjWMCaYNdunEelwJgclnNME=;
        b=lg6LzgcCgrEbvjjc9y4N7eoc77bRgLLl3rkyFr7CQImaQM9G7CG06Ir+cSvJL1xThj
         EtkGswG0GWzcB6MRpdnLtMp5HfArRHX2pMWsrqMGWYqnhqGlfT1iEAcKhf6sdu9dzoGc
         rG+AWiKr7iFbfkr+EWfo/48ClH4iYonmevgHowCeoKUeKCA0chmKwcmOomvsC3gQR6Oi
         by0VbYfAes5r8D+Cc/X4tIR5FHF0b7C6duI51kqSAPK4aIzW7ttS7MV5MFgOoPBE4FLt
         /VdeTpXRb34zagzyikEWfaqtq+e40aXzx4vZaMh6z5ZLFIbG9ivbbRMGW2MU+JpGju/l
         lUQQ==
X-Gm-Message-State: APjAAAVhA+0CQ0ZT3/jjzIaJnhc8nGS0l7dmIJdURd20drgq+3GqYr+3
        lT2pKf+S/gnvG5Z9PXa5FEdhdWAKoSo=
X-Google-Smtp-Source: APXvYqzIKc+4VYd4Viz1nXDyxVjuG2PgfFY1iQp8kTuc8Mto6Tm/tMFI/jzxOVc54wE5bW8jbwSDAg==
X-Received: by 2002:a1c:d1c5:: with SMTP id i188mr623003wmg.8.1555522229920;
        Wed, 17 Apr 2019 10:30:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id c6sm2669306wmb.21.2019.04.17.10.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:30:28 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 7/8] arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
Date:   Wed, 17 Apr 2019 19:30:30 +0200
Message-Id: <20190417173031.9920-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417173031.9920-1-peron.clem@gmail.com>
References: <20190417173031.9920-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and add supply to the Mali GPU node on the
Orange Pi One Plus and Lite2 boards.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 62e27948a3fa..bd13297555ab 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -55,6 +55,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
-- 
2.17.1

