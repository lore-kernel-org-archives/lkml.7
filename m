Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276F5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA5A21873
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT20Rqts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfCaRzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39392 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbfCaRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so8911185wrn.6;
        Sun, 31 Mar 2019 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BeY3MMEMJ23Yp9Mx+6kkRLx02Q/ZdB/Mf0O7JUrmHvU=;
        b=bT20Rqts220YPKqaXzBEnf2ovpO1ue8cHVsat97mdauHF/XXImCacbxBzNGSyJWhvN
         54lcWU9vbTeVow54mXe927vYSmRhzyUlMaNQAaGASExoQM9SVNJ2lM6if53svYQPqQ3i
         +fCzB3alyQbjoWlDnRPSkkdI7UaQ8Vpaykuh2onTxKXV8T3dExUFfyu5dNfEJj1q8yjG
         E3RT2W9P6gh6S4f8X9OezdZLOTcYNLS3brioiv9ER68lsDBhCR7ltSS+zK7PID5QZYlD
         UPqT2wY4iSMeqMFz3hBdb98wvm0QKpSjd5mLZ1G1pb0+rDVprw8HJv+5vdbvGutTGBwc
         xqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BeY3MMEMJ23Yp9Mx+6kkRLx02Q/ZdB/Mf0O7JUrmHvU=;
        b=nnx5HAbhMv7XVhsz57cPoR1d3NWo5U6KUC7oj0mMPqO0f2B+SKsdQ0ueQ0Kw50f6WB
         i0C7+d0FnNUjQM2P2Msn7XiMduGpkW8Wl8dvzjYEHpeUGqILajaBdlEg5z9DrcSfjUF5
         UKefiic2Pqu3PKUsBVITsDsUKQaVi+E4uLGWkAa6eYnl1PGCDvqLlTANNekLdsCYXls0
         lNfsUhlZHuf9Y8ZQ35jXjqf9UFfAEDnJO5i6Rc4qCNhaOGJJAgZ0HKpji+ONoSxhM3rB
         gT43Ai+7x/ek+VqEuL3d4+ymtpOcQOivSu4bdk5pOvpexovxZGeiba9CPG+JDdmavxlf
         OSNg==
X-Gm-Message-State: APjAAAVeWotQCfiPIkwqxtkMEih5I+TeLDwBB6DrKMfxAFvdrmPGixzN
        fZKn3zQN6iCuLy1+SPyGYCiTPibuBeA=
X-Google-Smtp-Source: APXvYqxRvF6480vpWns/TYT9Q4Rfo+h+7zzEh6yJxgu/MjXy/2hqV2XLzpI2a9u+mDyfVtiL4qlqIA==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr29802272wrq.94.1554054942542;
        Sun, 31 Mar 2019 10:55:42 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:41 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH v3 18/25] dt-bindings: aat1290: Add function and color properties
Date:   Sun, 31 Mar 2019 19:54:54 +0200
Message-Id: <20190331175501.23471-19-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 Documentation/devicetree/bindings/leds/leds-aat1290.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-aat1290.txt b/Documentation/devicetree/bindings/leds/leds-aat1290.txt
index 85c0c58617f6..62ed17ec075b 100644
--- a/Documentation/devicetree/bindings/leds/leds-aat1290.txt
+++ b/Documentation/devicetree/bindings/leds/leds-aat1290.txt
@@ -32,15 +32,18 @@ Required properties of the LED child node:
                          formula: T = 8.82 * 10^9 * Ct.
 
 Optional properties of the LED child node:
-- label : see Documentation/devicetree/bindings/leds/common.txt
+- function : see Documentation/devicetree/bindings/leds/common.txt
+- color : see Documentation/devicetree/bindings/leds/common.txt
+- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 
 Example (by Ct = 220nF, Rset = 160kohm and exynos4412-trats2 board with
 a switch that allows for routing strobe signal either from the host or from
 the camera sensor):
 
 #include "exynos4412.dtsi"
+#include <dt-bindings/leds/common.h>
 
-aat1290 {
+led-controller {
 	compatible = "skyworks,aat1290";
 	flen-gpios = <&gpj1 1 GPIO_ACTIVE_HIGH>;
 	enset-gpios = <&gpj1 2 GPIO_ACTIVE_HIGH>;
@@ -50,8 +53,9 @@ aat1290 {
 	pinctrl-1 = <&camera_flash_host>;
 	pinctrl-2 = <&camera_flash_isp>;
 
-	camera_flash: flash-led {
-		label = "aat1290-flash";
+	camera_flash: led {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_WHITE>;
 		led-max-microamp = <520833>;
 		flash-max-microamp = <1012500>;
 		flash-max-timeout-us = <1940000>;
-- 
2.11.0

