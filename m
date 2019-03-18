Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5014C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D4F20989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Doq4FbmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfCRQaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:30:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46393 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfCRQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:30:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so11716890pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjJCSLoV0IV7bvoksjMQJg9kvOj0Yf0kTeZm0+Inl/g=;
        b=Doq4FbmRxGlDjExFYdZTH1rZHFxiKHAszlhARZuWH+yzCyj57zREC7jJhtPOa2wgmt
         +Cy3Om5hys3dQE/XJmFcaW61lb49K9P4lEA0MzbjQWkoziXReWFPK7Aak5sNLJ4tkRZv
         ZuWToKpWTOS3fkSFMobAr0nxvel3sKqqbOvFGrYNx2DIAW1qJskJLhjENG887F56F8Sc
         +NBKwY07wSrMn2Q1JO37bC3i4uGlQFqRVL+IWi0yPxjp7Vn4lJkJrTL8mfQdAFhr5nlr
         oHcsntXbfV9Y9NHSwWTanQ/vGKkubCjIJuDXvT8MsDkhCjV2TR0JXsObW+3wchuaErRo
         uZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjJCSLoV0IV7bvoksjMQJg9kvOj0Yf0kTeZm0+Inl/g=;
        b=e1KmApGKE+9WLOXerQa/15+J1Iy0ok5WHgXXcQnyGjLLF6hN6QVnD/b+IB4OyUTwvk
         7/Ts0XRWVjCP4YPIruetoTxvDJ533s+jk8qJ55C7RnZq7AR1nAOGo0W4cmwj930Q79Vq
         XFV9Pm4Fo6UdNqZ/OVk9VqDl6O66/2wYrG8N0uBkkNt67FZ2tXRSxE55tylds24jqrHb
         cJUKZY0pMf/ErNcL8RyQ6tkjCR2TkDlzLcdgojyXuL+3Ecr+pgjCLiBZuwMzpnqT6p0J
         VY/ca2C8sRWRbo6YO2OFPf8GQQI1AgsdKx5Vrc6x7uEQl9R0dXGtDGX/g7KPt8IOokIL
         6v+A==
X-Gm-Message-State: APjAAAX1YyulC/0o8N/byqlnPC8q/cW61oW7ekmE+Cks/+785VxHkOVY
        x1p6DzGP7jAF4idvfIDr1bvNRyEy
X-Google-Smtp-Source: APXvYqyEZnt/dgg82echlzuAfUtAMwq+4wApj1ie6dYBBBbX19HkHECwI8ljE+YeAOTZ8mq3jWPpWA==
X-Received: by 2002:a63:f412:: with SMTP id g18mr18541105pgi.444.1552926617052;
        Mon, 18 Mar 2019 09:30:17 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id k27sm21926727pgb.70.2019.03.18.09.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 09:30:15 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 99A3F2010E7; Tue, 19 Mar 2019 01:30:13 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ARM: dts: imx6qdl: Fix typo in imx6qdl-icore-rqs.dtsi
Date:   Tue, 19 Mar 2019 01:30:09 +0900
Message-Id: <20190318163009.5093-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.21.0.135.g6e0cc6776106
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 1d1b4bd0670f..a4217f564a53 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -264,7 +264,7 @@
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
 	vmcc-supply = <&reg_sd3_vmmc>;
 	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
-	bus-witdh = <4>;
+	bus-width = <4>;
 	no-1-8-v;
 	status = "okay";
 };
@@ -275,7 +275,7 @@
 	pinctrl-1 = <&pinctrl_usdhc4_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc4_200mhz>;
 	vmcc-supply = <&reg_sd4_vmmc>;
-	bus-witdh = <8>;
+	bus-width = <8>;
 	no-1-8-v;
 	non-removable;
 	status = "okay";
-- 
2.21.0.135.g6e0cc6776106

