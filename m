Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB046CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726E220874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c556bP4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfJ3PHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:07:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40461 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfJ3PHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:07:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id o28so2708235wro.7;
        Wed, 30 Oct 2019 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lW9R1Kjh4RqLaQFjxo3y/Pqm10kL9MGXivj+gFRn3PI=;
        b=c556bP4DDtkg+ELPCznE0M/Y+gf6kR7x6CVyAA6DIBn5fNHWQbggK+owE0IqN9u5IP
         YGVPGBsRUqsSbr1HUP1eQdyXtcYoam8ytGKbYWsuzVzo7GhhrQ3NZJnEHLySORbw/2b0
         25UEJasNAZ4N6cNTNYGcplRLT4HysyKrUxNHbL9hziyIKKnVJjON/5O5hufIPQxQvcG7
         YABcBHQkCDo/ZljUXJ6Z1ShXxudkQ2+p4HsPma34mWCwxSztaPRHCHlDsjWklLNOOYBx
         pgkdsVaRsZfPT2j/uzPJt+Y67oxCzkl4XeE3zeYpR6olZax12Nu/9YONf/6vNOTdMN06
         Knbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lW9R1Kjh4RqLaQFjxo3y/Pqm10kL9MGXivj+gFRn3PI=;
        b=QXQLql2t7NS1Nwpeo9XO0YybgvcVu3Moc4w9Q/CtNtk8c0jHqtJRN9NRIiIaalaVqK
         +MjGhWMyizIVMtKLm28z8MT2WcQ+MF8Utx7FDUIm2rxJ5zRpnckHK5MbQrg+dbXqw0OQ
         hZXpt03052Mu/liR0V1AlORN9zg7is53ZU8uoPrNT4NJlM1mcMjUnwvjsWGTjcOWPB/P
         NJULzxO4hyeKZuAiuaXhBn2RRm5CJ03e8UqDjyMEUsr3klIH79rTdUQjvae9rrt/LOjz
         lQAV0F3kbBi3METglzzvEEYfg8ShJHfw0N8ASqiRfZnfVprqZXz2/j99aVJTYTt/fCBA
         lWlQ==
X-Gm-Message-State: APjAAAUq+56UfTYA7JsCp6SAW4zT9S7QX50/a62Jys/Cn759xwSgLDIT
        RvkHyQgAIAxahkcxPxFm/Ss=
X-Google-Smtp-Source: APXvYqzy7lMkIQLrrDyKXi4Da54CMcnQllR3Q6YYCu8EDXUhAAooVuppJ9HI7xIDZiqeViRj0d9IyA==
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr271231wrx.349.1572448069737;
        Wed, 30 Oct 2019 08:07:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id 11sm278074wmg.36.2019.10.30.08.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 08:07:49 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v7 2/2] arm64: dts: allwinner: Add mali GPU supply for H6 boards
Date:   Wed, 30 Oct 2019 16:07:42 +0100
Message-Id: <20191030150742.3573-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030150742.3573-1-peron.clem@gmail.com>
References: <20191030150742.3573-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and add supply to the Mali GPU node on all the
H6 boards.

Regarding the datasheet the maximum time for supply to reach
its voltage is 32ms.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 6 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts  | 6 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi   | 6 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts    | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 1d05d570142f..e5ed1d4bfef8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -89,6 +89,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
@@ -225,6 +230,7 @@
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
 				regulator-name = "vdd-gpu";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index eb379cd402ac..f5ae5182f0c5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -102,6 +102,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
@@ -237,6 +242,7 @@
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
 				regulator-name = "vdd-gpu";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index ec9b6a578e3f..df4cbd7ef96c 100644
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
@@ -163,6 +168,7 @@
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
 				regulator-name = "vdd-gpu";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 30102daf83cc..74899ede00fb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -85,6 +85,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
@@ -221,6 +226,7 @@
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
 				regulator-name = "vdd-gpu";
-- 
2.20.1

