Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C49C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F0524679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKXaJDUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfLTMKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:10:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46359 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfLTMKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:10:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so9151306wrl.13;
        Fri, 20 Dec 2019 04:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S0pnr3nn0AYuzGua9zuiRclMABFt/sduS8+fdDz3j0k=;
        b=fKXaJDUb6gSLYzCgHpdACzerQMB95lJNlCiFznE8f/Ss7IY6w2rV7BK3Es5TcjAcAX
         CEFs8mwpW19H0jmsTSD6vdZzq6CYXDsqYjan0HJU4TRvpdXddDdoXl/93Vg/EwetxI/g
         aWWjb+YAVTkXZMJiN6QeLQtVholhbOLmhwGQh7PJ1GfHID9XkvFzm9+mK7LU2nOCzEY6
         hJ2eDs6v8uo7b4mHtvh5o701wkZNJZ7FXeVRoiqDQOu81/RjuQSgTI92Vh6Kniqb+CzU
         rklPjP3ZcMREuhbWF3hwSNhYJ7WCW0bAnrCh2VzOPLIh2ar63zh4O9FY4qkeufWnoRVw
         2DRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S0pnr3nn0AYuzGua9zuiRclMABFt/sduS8+fdDz3j0k=;
        b=GpawQ2CcBxbB0u2ntYZO/1Dloc2Qb9jNPJ4APbddiizsmxyruj9hpgAMAGz5T7DiN3
         SBB4tf/9+kMoW1fJQnYzrV611EeMQaXhzadmpFclIu01GMGbUd5yMvG5ZjzTvKM3XRuy
         dnZlVSQjSZSoSVVWu7D0qnHXwQr7F+aZnc3vFXUyDS60foCLfHTTOWtdRZ90tqkk2ozz
         E95ljTCfnlYx8/CcRzgV3LXRBD3SDQXSeltArqhum0VYhEcA0tVNjZ2chVg7KmEPK7Zc
         U+5D1xajkJPR8lqdftM+JdzmNbbzBVTOl5wYXax1m/BuvBhM8AwqoTmJQ2LG5RactF3T
         yL9A==
X-Gm-Message-State: APjAAAVQ/k4U3xxJ3cOJdsUhOnT2czsCKkVb7pp+gXduGmwYEQS2XNF6
        XUPy4TuRRCOGMpr/0HKU/ZY=
X-Google-Smtp-Source: APXvYqxz4JySI0uFXl1jq8Ac0DazRPpLLkKp56hG8npofCaMs8UjmxmgXnTjmZ8VgRgev06SnzD9iA==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5mr14874567wrw.271.1576843814425;
        Fri, 20 Dec 2019 04:10:14 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s16sm9722493wrn.78.2019.12.20.04.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 04:10:13 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: rk3308-evb: sort nodes in alphabetical order
Date:   Fri, 20 Dec 2019 13:10:06 +0100
Message-Id: <20191220121007.29337-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort nodes in alphabetical order.
Place &saradc below &pwm0.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308-evb.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
index 9b4f855ea..e8f15dcce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
@@ -190,11 +190,6 @@
 	cpu-supply = <&vdd_core>;
 };
 
-&saradc {
-	status = "okay";
-	vref-supply = <&vcc_1v8>;
-};
-
 &pinctrl {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rtc_32k>;
@@ -219,8 +214,13 @@
 };
 
 &pwm0 {
-	status = "okay";
 	pinctrl-0 = <&pwm0_pin_pull_down>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
 };
 
 &uart4 {
-- 
2.11.0

