Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF24C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCF5214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZDdPA19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfDHPYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:24:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46141 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbfDHPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:24:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so16867026wrw.13;
        Mon, 08 Apr 2019 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/l3LkI3W5rGWEVlxH7QSopgh6fyIfDuQSQVjTcAbuE=;
        b=GZDdPA19naT8wo9Zy7eu7rU1xIPMv/fFicXFoYhmjsMZsIzzTW6d5jtBzrXeiNqDGk
         6EioZ+REXNSNiqEE7KbkLJAo4fVhicJxFW4uvS/AnCtiOuDrKyczToLDrI/jYaRBgweJ
         2ZbkBOg8beqognOrj4tYVXAu89/tMbCyVzHJ+qxBGBEZsd7gb9oWz+ASsAmw+yWI0u+Q
         /AzRdMugPDE6AMbWjQjXRP0OX4138svAcHaa2nyzLHLVj18xjHJWfaHGgWOa+Rg4pWNi
         Ubg3gy1iAoo4cFBCdbiDC7xdQcqgmkfgSfRKfbDKLMgxKEFp9KwTkDSLaCyDPkoNsXId
         R58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/l3LkI3W5rGWEVlxH7QSopgh6fyIfDuQSQVjTcAbuE=;
        b=gt6fIEZmMdnnpW4uBGJbo/B6YlxqeVNQpMi1bfPJig45osimVG09Y+WVK4/sVuwYsE
         HaWHBG6SP3WI7QI9ujowhxfOTvFFPzSPCQT0cQEtXhweVuYh43UYt2n5GoPohDiwV223
         HKMz6K7WtNbKXAZVIL2wP6dcbpGM4gJSoB2ygtg+RA+InFkFVngP56Jx3EO8Imy5GPuz
         zGDSiPM7ijM1Ebb2twwXEdKxhPEzRQYywULz5wtrtD3T2MUPfH0pKpbV5XYF8B/4udho
         k4Z9NKvs6HxARzAQw7qxBEDV/GPP1DZP9ZP+Ylup1OMVk5tEEU3ucrBiel/2XbW3GAD+
         OWYg==
X-Gm-Message-State: APjAAAXNlgJEmkgNQJrxrLquypiis2bLZnMPxf1MAR6LbUemWGr2Ky+A
        pWh73N8Pl0pbMUi7JcgKUBs=
X-Google-Smtp-Source: APXvYqwuUmoILY6JDjMSWG9rkBcKh8NUKy0ZDzTlqVeQ47XzFY0bkcgTnAuaXXKLfSsXsxu3u9J/nQ==
X-Received: by 2002:adf:dc83:: with SMTP id r3mr18724495wrj.179.1554737079393;
        Mon, 08 Apr 2019 08:24:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id o12sm32137298wrx.92.2019.04.08.08.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:24:38 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 6/6] arm64: dts: allwinner: h6: pine64: Add PIO regulators
Date:   Mon,  8 Apr 2019 17:27:55 +0200
Message-Id: <20190408152755.17405-7-peron.clem@gmail.com>
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

Add PIO regulators for Pine64 board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 4802902e128f..6f2d9adf4f10 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -127,6 +127,12 @@
 	status = "okay";
 };
 
+&pio {
+	vcc-pc-supply = <&reg_bldo2>;
+	vcc-pd-supply = <&reg_cldo1>;
+	vcc-pg-supply = <&reg_bldo2>;
+};
+
 &r_i2c {
 	status = "okay";
 
@@ -247,6 +253,17 @@
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
+	vcc-pm-supply = <&reg_bldo2>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.1

