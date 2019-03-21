Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5614FC10F05
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236E5218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lkgkq0bP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfCUAP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:15:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40515 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfCUAO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:14:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id h22so3565248edw.7;
        Wed, 20 Mar 2019 17:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/AKQKa3JjPkRsfvuDYHtTdoCUqlSTKdXae4Ug3iovSc=;
        b=Lkgkq0bPkXTIV+5Rkmx3c0NqOfH/RUUqCcZ6L0XmJF0m1JRzNSya7DPCzgRQaL/SQk
         XXTiCgqa0clWZyQk8PmMeZ3Vktzj2gl6RqyOHZ0fCj5f1oxKafjHyNNDxqjZWtc5CpIs
         5nZWY6/eVibqIMF6vzvf2VIoy1JgnX3E39Z5zwxk/SRiNTOlKCu4liym1wlKGM8Hg4/z
         rOhMpZfpTZHYoiFSqHFSrvKVgAR7hAL3cJ1gjTq3H0sTVhK+gfVLpTmIW0Oyu1zzoV1x
         sWeRHqWKPzpKIKGN9np3XW/rFR4qHjUra716FNWgm+Q/VNlGFbV6C5PfY97Cl1l+VyU1
         S3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/AKQKa3JjPkRsfvuDYHtTdoCUqlSTKdXae4Ug3iovSc=;
        b=H0Lx8DwaAPNqHCo/SVokyVaIOQ1vUkLhMxDncOLnnb3LcvPLGMWocbtuZVKeb/Rw3Y
         5Jg4NMLQ2y5W6K6PNjpZUdP6jARNAeBGFc8yC4HBuo+Fz/sQn9NCyQxJ+Om6elBPm5s7
         NHQC6PfOAaisaWyOnEIgDaiKpvKF2/biC+oLsUu/eCj2/na9x/AqkBxecfuc0wlzZd3E
         jU3LKupifeN005H+pWa8sULbbuSQ5340xaQxqAppcq3dqdXakYnwUr/HiDtrw66QncdC
         ceIXDXj/hGjoyPsEe6sFAZguelQBaJ0HgCHusZXlWXw8D/oTjD9uZ0a68kgrE2RuwPN6
         jUXQ==
X-Gm-Message-State: APjAAAUmx9EyrolQ7nc199MKXq1t0NAPIgwZxeTxLydNmBjzrahOfkVG
        7RCQOfVMQkB2xMf9e3x+6M0=
X-Google-Smtp-Source: APXvYqxd0Pf7iXog+sNWSe6Xma3UTjoOhv9xO+18uzScHWwy6XdaV7qBIsR6XeRbpWQeoRDFYVG7Fw==
X-Received: by 2002:a17:906:3fd1:: with SMTP id k17mr509890ejj.87.1553127297549;
        Wed, 20 Mar 2019 17:14:57 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j34sm1107660edb.30.2019.03.20.17.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:14:57 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] ARM: dts: rockchip: rk3066a-mk808: enable vop0 and hdmi nodes
Date:   Thu, 21 Mar 2019 01:14:38 +0100
Message-Id: <20190321001440.31057-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190321001440.31057-1-jbx6244@gmail.com>
References: <20190321001440.31057-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the vop0 and hdmi nodes
for a MK808 with rk3066 processor.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index 9d2216d71..8bc259d3e 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -30,6 +30,17 @@
 		};
 	};
 
+	hdmi_con {
+		compatible = "hdmi-connector";
+		type = "c";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	vcc_io: vcc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_io";
@@ -91,6 +102,20 @@
 	};
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_in_vop1 {
+	status = "disabled";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &mmc0 {
 	bus-width = <4>;
 	cap-mmc-highspeed;
@@ -150,6 +175,10 @@
 	status = "okay";
 };
 
+&vop0 {
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
-- 
2.11.0

