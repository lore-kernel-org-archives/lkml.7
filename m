Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82ADC17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDDC206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nt1fK+go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKKAw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 19:52:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35058 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfKKAw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 19:52:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id d13so9492123pfq.2;
        Sun, 10 Nov 2019 16:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xYVsNMrMtkwvfwvE55iDXEc/0l3/pWmx2NHWuQN41yw=;
        b=nt1fK+gox6il/z0hOVtieY6g0sPXcUzqeuQj03ZA/asU0uWpnFTgOI4SpKsrPIheh9
         g3NMtgawH6CkXRhIMErwYad5jbVclB4+Gwd6cw5SE8AOQZgdYuTN5f5NkDoxwoDFiDCD
         lxJuto0FER2+NKf2ownfFUrJochZz7baaQ0JXAt5jWOm9e/TSR3xOwYu2of/y/9BcVfx
         ynl0N3SSWzdWTIbSKuq6v/kpMV78Yf/HKEAMRGDTwTHmXmae2hdE5d/MCBY1RC5JC8pi
         NK0LljHTXjKIyXRRub8kzblF8Ks31j2zdt707lEgzMPvzLyRpU0Be/4SUXiGCaFL3Imy
         OcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=xYVsNMrMtkwvfwvE55iDXEc/0l3/pWmx2NHWuQN41yw=;
        b=h8GCJRnIn9vaT/OkCIyaV5Lu1ubU0y7/DZQ5lrStlUKG5OKOQL3EXx8hyEw3GePGtr
         daNm5FztU5xeZ4kv7hb6HBe+VyqkIB95yjteyH3Mm+gWDOSLT97O197TisVggXqUN2kG
         NOz50vjW1aMkRWG3vRhpfwvq0xC6fsj1S63lL0K2aBRaUUN9A0D9v0gWtbqg3rWRFLPY
         b3Chnhal62gYsrCMSe4VLnt/K4ZQwCzFxR271B9Ru4FX+FzKwXpHR1NwsBuFKB9miLsA
         46PK5B1J0TvQ+8OA6v7PlBXihyBVCZN1GI6Igrl/JMPcK08EvtA9v4MkojcZNAJIBmED
         onPg==
X-Gm-Message-State: APjAAAW5qsiYpKvGdwU5jXktvKiKphN5WFcW5iYT2PonVjC/+qiyUMTm
        LTs7qoLk9XykMhW0yMpoer0=
X-Google-Smtp-Source: APXvYqyDnNrIq2s09BxFo2ZrvC/Ca6XsjHDrsYlX4ajb6ZtC25zUb/GHmP8nX9AC8PR3KkOCpUREVg==
X-Received: by 2002:a63:ae02:: with SMTP id q2mr26208411pgf.210.1573433547047;
        Sun, 10 Nov 2019 16:52:27 -0800 (PST)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id e8sm12449215pga.17.2019.11.10.16.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 16:52:26 -0800 (PST)
From:   Kever Yang <kever.yang@rock-chips.com>
To:     heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Akash Gajjar <akash@openedev.com>,
        Alexis Ballier <aballier@gentoo.org>,
        =?UTF-8?q?Andrius=20=C5=A0tikonas?= <andrius@stikonas.eu>,
        Andy Yan <andyshrk@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Xie <nick@khadas.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Soeren Moch <smoch@web.de>, Vicente Bergas <vicencb@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rk3399: Add init voltage for vdd_log
Date:   Mon, 11 Nov 2019 08:51:58 +0800
Message-Id: <20191111005158.25070-3-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111005158.25070-1-kever.yang@rock-chips.com>
References: <20191111005158.25070-1-kever.yang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is no devfreq used for vdd_log, so the vdd_log(pwm regulator)
will be 'enable' with the dts node at a default PWM state with high or low
output. Both too high or too low for vdd_log is not good for the board,
add init voltage for driver to make the regulator get into a know output.

Note that this will be used by U-Boot for init voltage output, and this
is very important for it may get system hang somewhere during system
boot up with regulator enable and without this init value.

CC: Elaine Zhang <zhangqing@rock-chips.com>
CC: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-evb.dts          | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts      | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts   | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts    | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts     | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts       | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts    | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi    | 1 +
 9 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index 77008dca45bc..fa241aeb11b0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -65,6 +65,7 @@
 		regulator-name = "vdd_center";
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
+		regulator-init-microvolt = <950000>;
 		regulator-always-on;
 		regulator-boot-on;
 		status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 92de83dd4dbc..4e45269fcdff 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -208,6 +208,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <430000>;
 		regulator-max-microvolt = <1400000>;
+		regulator-init-microvolt = <950000>;
 		vin-supply = <&vcc_sys>;
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index c133e8d64b2a..692f3154edc3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -100,6 +100,7 @@
 		regulator-name = "vdd_log";
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
+		regulator-init-microvolt = <950000>;
 		regulator-always-on;
 		regulator-boot-on;
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index 4944d78a0a1c..c2ac80d99301 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -79,6 +79,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
+		regulator-init-microvolt = <950000>;
 		vin-supply = <&vsys_3v3>;
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
index 73be38a53796..c32abcc4ddc1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
@@ -101,6 +101,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
+		regulator-init-microvolt = <950000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index 0541dfce924d..9d674c51f025 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -164,6 +164,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
+		regulator-init-microvolt = <950000>;
 		vin-supply = <&vcc_sys>;
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
index 19f7732d728c..7d856ce1d156 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
@@ -129,6 +129,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
+		regulator-init-microvolt = <950000>;
 		vin-supply = <&vcc3v3_sys>;
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
index e544deb61d28..8fbccbc8bf47 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -174,6 +174,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1700000>;
+		regulator-init-microvolt = <950000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index 1bc1579674e5..f8e2cb8c0624 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -133,6 +133,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
+		regulator-init-microvolt = <950000>;
 		vin-supply = <&vcc_sys>;
 	};
 };
-- 
2.17.1

