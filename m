Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABBAC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169C6214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCzyutxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfDHPYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:24:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37459 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfDHPYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:24:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so15180967wmf.2;
        Mon, 08 Apr 2019 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SxFvkVpa8VWLBDyRAQWldAx6uUHt15CBoCTIKAb2fTY=;
        b=tCzyutxIrAgCHpu1Hr9HE6eFoM63Wc3IzwroLXL8BQAG8pswu+Y8QwxMhFIA9L2TrP
         WT6WpVAd1FzP7T/vZUtrHtpF2bj8nLc8AxKNfvBSBCnTc9pYW2suWxfNgO18Z+LVxKjA
         lHFUqlv1O8QenK6gglYyo3YPv+P0aQpX0hsysJqzt1RL00AuYEho5GQUyNSiFVmBwBns
         3rMyHZgRgS6SQiePGbAjDZpmw5Ic00omSAU75HzhIrybrFoXlB1q10RVNr94owsnj1op
         kmGXWwboHQLLQp5x2I+7CCygwV0UZfk7v27KCb6PttzVi9dNW32MXdYjogiBijmUfjnO
         Jb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxFvkVpa8VWLBDyRAQWldAx6uUHt15CBoCTIKAb2fTY=;
        b=mcx6XCSLKPIznksyAdnZqvhAJr3vg7mIzpyv22porOIsAtA1J8UIp8mFmzgbLeTP46
         Zo9dfaMCQw4IXVq6FtHCkUNgJbExgcxyNEWeP9maY1jDcUxY8uL0G+NWK9nq0b9E4w8a
         dtkl4s/uNzs6a7mRa5fVL7FongmWk0y3gK6DKs97gjVdOcNDZqoT7e/RA6cSdAyVGTTy
         lkv+9UVhlWKCfnhJ6GbA88LdNTCEnnIJl28wpPya0AQLkmQnwkkeIcCA2pPK62gQ/ztj
         u6zP8RRwSplSwx8plsqyNeZmN80FH1mcRt6YkzVCZg1wQruChOLi1xS4VTxeuAmY96VT
         6z0w==
X-Gm-Message-State: APjAAAXMdB0zfFZWWyzsarK3+hcYNM246gmoVc2N1OyhcKqyzgC6KVRq
        htlOXrwtjtK2gXA/EKUAQQE=
X-Google-Smtp-Source: APXvYqwC0Tx2migf/c6z30xuu6HFdRoRhqjUYKAKqT2KqD5TTTxo4J7xGoSW+zaYHZcJI7VGNruqmw==
X-Received: by 2002:a1c:1b10:: with SMTP id b16mr19238519wmb.90.1554737078211;
        Mon, 08 Apr 2019 08:24:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id o12sm32137298wrx.92.2019.04.08.08.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:24:37 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 5/6] arm64: dts: allwinner: h6: orangepi: Add PIO regulators
Date:   Mon,  8 Apr 2019 17:27:54 +0200
Message-Id: <20190408152755.17405-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408152755.17405-1-peron.clem@gmail.com>
References: <20190408152755.17405-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OrangePi One Plus and OrangePi Lite2 use the same PIO regulators.

Add this in the common device tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 62e27948a3fa..4044f2dc66ac 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -70,6 +70,12 @@
 	status = "okay";
 };
 
+&pio {
+	vcc-pc-supply = <&reg_bldo2>;
+	vcc-pd-supply = <&reg_cldo1>;
+	vcc-pg-supply = <&reg_bldo3>;
+};
+
 &r_i2c {
 	status = "okay";
 
@@ -189,6 +195,17 @@
 	};
 };
 
+&r_pio {
+	/*
+	 * PL0 and PL1 are used for PMIC I2C
+	 * don't enable the pl-supply else
+	 * it will fail at boot
+	 *
+	 * vcc-pl-supply = <&reg_aldo1>;
+	 */
+	vcc-pm-supply = <&reg_bldo3>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.1

