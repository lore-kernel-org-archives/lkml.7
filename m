Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC8CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690FE2184D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUbYhmWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfC3J5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:57:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44880 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730644AbfC3J4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:56:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id x10so4035748edh.11;
        Sat, 30 Mar 2019 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/AKQKa3JjPkRsfvuDYHtTdoCUqlSTKdXae4Ug3iovSc=;
        b=qUbYhmWRK5fAxntcmQRIXG7tBMXmzQd3pBMDslS9CPVLEH/wsSrfuE0yqyxJXPEn/4
         sZVQxDRxopfm16ZiE/qBGlz23SamgFGFesnkROe7RV9LnVkzh2QPmbLswwlxqo113Vrg
         51fwZ2qP0rnAW80LyRYKTvu7XaiiCWWNgF6bc8fv4xXgttuY1VbBJhz6whHuarYriQTR
         /ef83qbbB3S2JxFu5kQW+EzGoJkT8jrdwH4Ws+dtl58UHeH5kyvoT4AFczEp/e0cb7Ow
         FWh1U9CiZhB4EPkZtbHbDr5IkAdeAAesH3LuYI0x+JoYso0i3bte/9Et9z6fF7KQ1fT1
         DY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/AKQKa3JjPkRsfvuDYHtTdoCUqlSTKdXae4Ug3iovSc=;
        b=m5fM7CMOSVmRRNYgyJVdfdofw9ue93y+y8MQ9xNE34H8woGVuEMbAnwtxxRxK32Ct7
         QTsnWHdkLW+HsHQST3MeNKRbe/E0Qn80OwUyhCne4mdDo6UcCDhCeh0ZHii763oaKL+q
         AwKp5SA9dyn9Z1075oHvq6kPn7+hBY9QTN2dNSL7smZTPekOoFKzQlhZUi0ElVv+Gijl
         Vpd0V/hJ6YPUVScqSOLW9XEmAsamV8lMDTS6YU2kNQxKT9K5p/U74a3ngH6unvrSFWaO
         7/2UdsKeduHqquHttH+YGPbFhhJpNeNg9C/mbBUcFKyiB9YuXGW/yw8L/rjQFM2L3Ldn
         sW9w==
X-Gm-Message-State: APjAAAW0KpsU7Etf2OFeYqJ+Sf3R99ioF1hKgPrzzAmqICAIZtxKvrQg
        jUuJjCJF3zxq9uyd64pLi5w=
X-Google-Smtp-Source: APXvYqxbCnu9LXuTk23/NBRO8JXFlbLlGTs84qpDdrQDpaC4IMIdgl/ktUD1HyITevZRhJJUAtO1qw==
X-Received: by 2002:a17:906:28c7:: with SMTP id p7mr30497116ejd.235.1553939812615;
        Sat, 30 Mar 2019 02:56:52 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b34sm1087921edd.24.2019.03.30.02.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 02:56:52 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] ARM: dts: rockchip: rk3066a-mk808: enable vop0 and hdmi nodes
Date:   Sat, 30 Mar 2019 10:56:38 +0100
Message-Id: <20190330095639.14626-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190330095639.14626-1-jbx6244@gmail.com>
References: <20190330095639.14626-1-jbx6244@gmail.com>
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

