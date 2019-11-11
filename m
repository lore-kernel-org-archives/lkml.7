Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E42BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB47206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxXNkML5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKKAwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 19:52:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43416 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfKKAwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 19:52:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so8296154pgh.10;
        Sun, 10 Nov 2019 16:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XhEDQ/cgXNxaPI54oMDT2IYwpDZQqZFGM4s4NbwaGJc=;
        b=hxXNkML5DhAHSk5FcxWj03eIt/Jw36dBl5uQR9uDzl8ilQmjZo+ytxQnf9rwhhTSaX
         xWlRWvv/72Bnc+AfP1T2GQOa9+pvMIixcBQ93m+O2ukW+YaFxU4E8SZ9cPTOAZby/bTH
         +NRp+WyGD5jPsvBVTt6Ijs/CMB4pieWzSHqNNJSZa/64gcuvaLtVl75KClxkedIPl2IR
         gImQQ/xw0ZnStJ0t44VKS11St/DplbnQxysRIiSwVluprlZX4jaY0oAQXyKhmbkpHWgv
         QnRu8QGsAkAZHGNAUyzGud1lV2X8yZQN9BfjD7f+Oaeg61tp1F+LTtLi9rxD9fvvnyLX
         R+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=XhEDQ/cgXNxaPI54oMDT2IYwpDZQqZFGM4s4NbwaGJc=;
        b=qC0xbR/XfWMWxjcS0KIsT3UjcOCMcFeLLcwrWqJCQ9rzy8dHs+pWfeLwu7SExKZj4/
         Oa2ZdtJ7B4Aun6PMQkV4GcNine6grIq6ehhhcc1Fg7x/O5MBPbfOV1yiO3CNNdBdTjXH
         yG2JTBZrS4Y6+rSblgmlTVMzrTw4vMv7z6OzpFdDEmlp8smjyogHrFfqybYGq5FY+9W/
         tw58PPQCop8fpgyTXTDEgs3LMHM80K3e2uToz/oRDJ6NDWefCLmmV3nFBxSj96JAKC8p
         SrmUWX4SKLaFsi+APnl8X0RYPmkYH0JqNkDahahGZg5Lh9TVrZJ6ahj5zwuh92Pv34Et
         77hQ==
X-Gm-Message-State: APjAAAXOqS/ewycHHg7Fs2Oy8DE1UXuyeVsMXh15PsEncbNeonhsFSe4
        kURrU5bNApkqSTbMKd3ipio=
X-Google-Smtp-Source: APXvYqwuCk613FSB8w3di7lR26kVpBOHSMi2M6Z2z8SQ3OJOvPTxhs1BT4B4P/dgdpMmYBqgML2SdQ==
X-Received: by 2002:a17:90a:a58b:: with SMTP id b11mr4186806pjq.46.1573433542041;
        Sun, 10 Nov 2019 16:52:22 -0800 (PST)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id e8sm12449215pga.17.2019.11.10.16.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 16:52:21 -0800 (PST)
From:   Kever Yang <kever.yang@rock-chips.com>
To:     heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Akash Gajjar <akash@openedev.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: rk3399-rock960: add vdd_log
Date:   Mon, 11 Nov 2019 08:51:57 +0800
Message-Id: <20191111005158.25070-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111005158.25070-1-kever.yang@rock-chips.com>
References: <20191111005158.25070-1-kever.yang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vdd_log node according to rock960 schematic V13.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index c7d48d41e184..73afee257115 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -76,6 +76,18 @@
 		regulator-always-on;
 		vin-supply = <&vcc5v0_sys>;
 	};
+
+	vdd_log: vdd-log {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 25000 1>;
+		regulator-name = "vdd_log";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-init-microvolt = <950000>;
+		vin-supply = <&vcc_sys>;
+	};
 };
 
 &cpu_l0 {
-- 
2.17.1

