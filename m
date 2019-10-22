Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDF3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58C62075A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/214hpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfJVEFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 00:05:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43935 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJVEFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 00:05:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so9774857pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 21:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tqVQlmpYbKEQqz/LYnPk32KTCBBbtiav0ASd6VB5NE=;
        b=i/214hpf7wvYxD9v/fgfbdtiBtl5Bs+SnscMBpL/2lzvQWT7sXAZvuLbMTWNlK5xm0
         tvfYC2ImMIeKkKGVf11mSHmyETghwWhWwK163avKwH0SIm7Z30LdQvi3jpY8MWpWCnFc
         Lzc2D5fhtQT09QMN4LpmXerk3fI4vIlqfk8n+CYs9yyIupSC9Bd8GTY//VgaepwTX6P3
         0apgoSNMvvxt+X8NWO5Lzbq9XlnfyJB/sVycfDB3UKi0Y9qoVFOkPuN03ywgjBL60W0s
         aV/4MXYeC/jTd7kfPUmNxZImvE60RFM0jZnuEEyTokZQHUKlThRbrSLhh1PMVXanJyyL
         LxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tqVQlmpYbKEQqz/LYnPk32KTCBBbtiav0ASd6VB5NE=;
        b=YhRjLDiMeyHKXUkXCEwPy5boDKbYO2XtsT4j1+qoZlcXLTnict9fDzO0cY0u6yJYEQ
         1F5L3kxuTqmNct9EjmWtC0dUXWgCjTDe1ohp0XdBhARcRMU9AwYkywB/PdeaOcHml0yi
         uHIIMlzZTVhbBlfpBnPhU9NHy94m94+DAgZoICavcUGc8PUkirTRdyOxKq3dOJ/cnCm9
         3pZVXvpP3HxpKTCrQmyHWdv+Eb3mfbMFYDUvoboHCdns92FRM34cadniqYSLVunQkRm8
         cbwTXDrZlqS+TlZ/TjwkKL3VBwoS9bVtH2ZNfCdlRcssScIuidRBPkwqWvbWoOFfEwn6
         Y7Wg==
X-Gm-Message-State: APjAAAVNN+K+hZ8uNFgBKIWM9/os1L19raPQNW8/cNybHB4RDF0lj+hi
        Oq0d/1XLFTBQmaUN1wPov8U=
X-Google-Smtp-Source: APXvYqxW6RK0vPwcTo1TK3+/lgsKJy8SU7DOqulv97WZbOLknsig5dtUm97efwIv0jkhAu3T4PYraA==
X-Received: by 2002:aa7:8249:: with SMTP id e9mr1754026pfn.46.1571717117207;
        Mon, 21 Oct 2019 21:05:17 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id n3sm18778738pff.102.2019.10.21.21.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 21:05:16 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: imx6qdl-zii-rdu2: Drop GPIO_ACTIVE_LOW form reg_5p0v_user_usb
Date:   Mon, 21 Oct 2019 21:04:58 -0700
Message-Id: <20191022040500.18548-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop GPIO_ACTIVE_LOW form reg_5p0v_user_usb since it is ignored by the
gpiolib and results in a warning.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 93be00a60c88..8d46f7b2722b 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -68,7 +68,7 @@
 		regulator-name = "5V_USER_USB";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio3 22 0>;
 		startup-delay-us = <1000>;
 	};
 
-- 
2.21.0

