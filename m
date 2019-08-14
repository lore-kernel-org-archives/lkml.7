Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D53C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 19:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6685D206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 19:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fff1Z/ZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfHNTf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 15:35:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33941 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfHNTf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 15:35:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so93553pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=udDZ8D9z63VnH0o8q5In252RZUS/LTZzdCyQGXY/J2E=;
        b=Fff1Z/ZD0Hv+bKtJnXFqq50wIuzHFp3AXytMpSlaaJZbN06XK6B817tEmN0ZUEP2uf
         9MGWCXKz7+S9nqSrJTQ0196lyQcNkE6wewZ1xt5ak1ctXe2NfNPM1DkQCGNCG0p0gUPI
         ix4+LlweVk2xl/s3yBlVy7boCEwixJCzHsOFVa+fSa9+JEIIrRLMkKUTwQMl8U7KaVD2
         /ff6sQwpv1Kf5sCI7+6nafww2K/rWzN72EdzC/5O0t8kNtodj8DstzkSHnKPVTnFTHCj
         21pG/NiSP1Lj9VjeEEzfkwcrAiun7lsgkmKq6aqcqIZWqiSoq7gUksbFL9eqfFMBoA6X
         dQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=udDZ8D9z63VnH0o8q5In252RZUS/LTZzdCyQGXY/J2E=;
        b=TiIhvtI4FCv9gMJi7uO6f96xAJ/7RLLrjxetU9vWVeh/uax3CTS0MTEQP+KQ0lqV9X
         1mj+YsayfRntg6LzNGqmPoUewCQ4vekIJsq3pZ+0ZOJcgQhLewq7HloDq3N4KtWBvpgz
         1bgEZ08VyejVB1nKwzudyze/Or6rORegx6zdb7KjXoii+UOqeGEOY0orKNOmOOc0ZxJO
         7wWBP7iVXhVcmTPG5Gt2HX0uSa8LuvB2ulxGKc7Y5cmrYA9QJoa2H40OCpzvr0Ty/VDS
         5re1lZ6XWt+2k4Kg8gX2kOwlSp1F0BVjMEThALgm6BZKBi3y+PG3lhVCZvAtJldq1f2w
         1+aQ==
X-Gm-Message-State: APjAAAWyAciGkIH2597d9V5uiL9NxCNPTfJgtrXqdeu9a17zi1FSTOLj
        hXpFLmnUf07QA74dAVsXe7c=
X-Google-Smtp-Source: APXvYqxl0zd19U3LmCJmi5GqGOBpJVxOUNDFJEFY5MkCV956G150A4Jn9Ws8eqMoJOlCdwTgRIYElA==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr670277pgc.20.1565811355927;
        Wed, 14 Aug 2019 12:35:55 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:8066:4c72:352b:229:44d:ae69])
        by smtp.gmail.com with ESMTPSA id r75sm656791pfc.18.2019.08.14.12.35.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 12:35:55 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: vf610-zii-cfu1: Add node for switch watchdog
Date:   Wed, 14 Aug 2019 12:35:36 -0700
Message-Id: <20190814193536.15088-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C child node for switch watchdog present on CFU1.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Cory Tusar <cory.tusar@zii.aero>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-cfu1.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index 7267873b5369..18c19c092dd1 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -239,6 +239,18 @@
 	};
 };
 
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	watchdog@38 {
+		compatible = "zii,rave-wdt";
+		reg = <0x38>;
+	};
+};
+
 &snvsrtc {
 	status = "disabled";
 };
@@ -324,6 +336,13 @@
 		>;
 	};
 
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			VF610_PAD_PTB16__I2C1_SCL		0x37ff
+			VF610_PAD_PTB17__I2C1_SDA		0x37ff
+		>;
+	};
+
 	pinctrl_leds_debug: pinctrl-leds-debug {
 		fsl,pins = <
 			VF610_PAD_PTD3__GPIO_82			0x31c2
-- 
2.21.0

