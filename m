Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7559EC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3C024683
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MslHLb5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfLTMKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:10:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36519 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTMKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:10:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so9214901wru.3;
        Fri, 20 Dec 2019 04:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X8fFKkVj4hVB9s3VYcXKcrcscgrJeT7dVkyworQG7Xs=;
        b=MslHLb5TC48pWyXB4rVGeaN6vAkMcZk2Fa4J70Qk+CY3wY0hUJFGBwlni22LS3h6Nh
         YkEn+fR3yKhiWZV/zYs/7cdNCwZdC3CEc7CFIkD7IE1PmA+1/49VH5dgYWCCh3bgxxc1
         16tOH2klG8c+0QyUK69jc8x865EfIyboJPlg1r1t7TwOsHZTdor/R9G4DjIX6iWIEHdH
         gmwZNGoKGXc1hORo8+WyQSxyFqD5K99YNELnymcSSgj5B5qkQ4FbDqUG2cFgm0M8uCdh
         FtqEuPccZNS/5NTvodhMjvp0v3mVL6WWdOI382nHbqYW7X3stO92+huOi6gyi6oMWT14
         3Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X8fFKkVj4hVB9s3VYcXKcrcscgrJeT7dVkyworQG7Xs=;
        b=DI8RRCW6ev9b78JusOR2c/JUZ1TVIScbmzefTX1hKv1Dw5RnfTzv8kRw9/Rg9BRTcy
         nZevSiWrDo8ickUIeHlPaqckNGAFm/PdoS70vpDCIhfVp2ObcksfqSCa4DEjUFUCvoe9
         BW5goXHRYxGsbMvJ1a5SbSxM2p5ifmvmhyH/MhO7u6bNPdzaHJujDwFeQv+Ouz5VbBKL
         9moN5wSW8exT9HjrUbXFB/dCp2EWuiACpXQzpI02uwAFu+ZsPiPmTiiOiPa6R0UHvius
         W8oYAtAsJ50Vo9T6PHGj2XTXOiU6b3FyErfk/xTTklqDFk3zq4RrrF5zsxj0rE4Xww/A
         t00g==
X-Gm-Message-State: APjAAAX++bqJGtqcGawmECY5tcgbE0aGQWjyDqVLJ/Hf2ms6ARQRK774
        h1yzhXAc8ndFBvTbRVFSnYg=
X-Google-Smtp-Source: APXvYqxu69/OA3v3zdnCC+w0hFNzMJZksszafbk/ti6SQ/UDJYSqsScNIR4ZDvM0JKvWKNarB+0Fwg==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr14428940wrn.245.1576843815297;
        Fri, 20 Dec 2019 04:10:15 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s16sm9722493wrn.78.2019.12.20.04.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 04:10:14 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: rk3308-roc-cc: sort nodes in alphabetical order
Date:   Fri, 20 Dec 2019 13:10:07 +0100
Message-Id: <20191220121007.29337-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191220121007.29337-1-jbx6244@gmail.com>
References: <20191220121007.29337-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort nodes in alphabetical order.
Place &pwm5 below &pwm0.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
index 23527daa7..14ba4c152 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
@@ -141,12 +141,6 @@
 	};
 };
 
-&pwm5 {
-	status = "okay";
-	pinctrl-names = "active";
-	pinctrl-0 = <&pwm5_pin_pull_down>;
-};
-
 &pinctrl {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rtc_32k>;
@@ -165,8 +159,14 @@
 };
 
 &pwm0 {
-	status = "okay";
 	pinctrl-0 = <&pwm0_pin_pull_down>;
+	status = "okay";
+};
+
+&pwm5 {
+	pinctrl-names = "active";
+	pinctrl-0 = <&pwm5_pin_pull_down>;
+	status = "okay";
 };
 
 &sdmmc {
-- 
2.11.0

