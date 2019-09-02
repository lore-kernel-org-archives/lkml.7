Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A8AC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3E520644
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2zSEeCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfIBI6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:58:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39684 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbfIBI6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:58:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so7159155pgi.6;
        Mon, 02 Sep 2019 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VeTPzJ+ApN7GKUp8q8Zb3MQjmxhoQ+Z6J4rIQfIPMcs=;
        b=p2zSEeCQMIN4+TtDuAUx64/2zNyixZ4CxGIdpAHhzWN+3pwCTpR7LsNV6lBUQ3vluz
         AhbTmBUZBOdmlyeYnVOldMkWPPpso+v6z0yjAJ4yeTmjDkPDLvOJFIlb8zklQwQa4T9l
         MlBbkT+VeHsI/eCPR3d17d8QhqzVkvI+UPvTqaFcStDUnLXjDeXsZWbbAYKopdRODvz8
         PLnEKtVV57rKYlY9sAUuCnD0/6nIwO4uyWZRa8P4eTWkxin7L2FR1ZPOZIopaq6dg1Rn
         b9xgoXnICPA1+xLa5vEoiC4oU5xBtj+o9ymVs4C7GTClg6dTyQLQkuOdSszTTQE3Eoyn
         cY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeTPzJ+ApN7GKUp8q8Zb3MQjmxhoQ+Z6J4rIQfIPMcs=;
        b=N7NqcdcGA+qavfywh/+w2OL8EwirUU7vj1YBNqz2QvXXTI4v5Udx3gWqIAxk5xjczG
         2Mhwesg3QX7C0WKxgcwAfp37Zut7igVi88KXLr+HHkqFyhdW6ziHQrpsAZdeiiwomPAv
         TFsYjTcCBcoWdZKLPstL+vwBMs7sR8y88+oDgntVdP3KyyCnt2SNhZLAfJBUWtu85pWm
         XuA/NiZWBO5VcN+jKR3jPE6gKvC72ObU6YTBhGnM2EaJE+0g52llQrOjg69BVJwdaD92
         coo5vVFfFvdZz3EehKkYH/F/93nKlc9RCjvNB22ju88oSz1znBni4SePZTGpLm0QRH1u
         mBqw==
X-Gm-Message-State: APjAAAVK6Hysu18eogbjUbZduR/8RgVFjpf++sSc0E1QG+Hw9CfcKgvA
        gook3E6wAX1keP13PhfBahU=
X-Google-Smtp-Source: APXvYqz/XVIL92q6ROyMvLN8edaMCL4kFQPd9X397P59sX5o4g/F7kM5IfpBBD+l5eYNHQWRp0spVw==
X-Received: by 2002:a63:5c7:: with SMTP id 190mr23692838pgf.67.1567414724496;
        Mon, 02 Sep 2019 01:58:44 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id y6sm6313117pfp.82.2019.09.02.01.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 01:58:44 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2-next 3/3] arm64: dts: meson: odroid-c2: Add missing regulator linked to HDMI supply
Date:   Mon,  2 Sep 2019 08:58:21 +0000
Message-Id: <20190902085821.1263-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190902085821.1263-1-linux.amoon@gmail.com>
References: <20190902085821.1263-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics HDMI_P5V0 is supplied by P5V0 so add missing link.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
As per Martin's suggestion added the HDMI_P5V0 fix regulator node.
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index ef2c3b74415b..a520ec0d73ff 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -66,6 +66,15 @@
 		regulator-always-on;
 	};
 
+	hdmi_p5v0: regulator-hdmi_p5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "HDMI_P5V0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		/* AP2331SA-7 */
+		vin-supply = <&p5v0>;
+	};
+
 	tflash_vdd: regulator-tflash_vdd {
 		compatible = "regulator-fixed";
 
@@ -220,6 +229,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	hdmi-supply = <&hdmi_p5v0>;
 };
 
 &hdmi_tx_tmds_port {
-- 
2.23.0

