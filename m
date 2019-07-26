Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12416C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB70D2238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d8QZIZxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfGZMq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:46:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45165 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfGZMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:46:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so54276036wre.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20qFoI2zAcPj/2YkU+y26itShjeGgYjqahabkwiHIZo=;
        b=d8QZIZxg3qalk8cFoc3e6Svi1f1hjZPya7iD801QTZ6MeKg8ghkNFcSYyjgKo1/fyF
         2iUDoTmf7nkIXIeYwpgXuV6aWSBACiYoJKgOM7zwAuX5NJEJD7eh2RFTWcOLZSJY8db2
         /nun0C+jShXsTAOfFCkBO4v8xgSwa9c+Hc5i/kDmTZiOnjqm0U3qL1T44a1ZPqQORRDg
         lNXiiAjurl9dM+VmxMFWAZ7sKRBcocVAiNHj3U1yWCh5yMfP52f+zH1HUtfaZpDnw+Fq
         jEISIgjgDgCYC0YBVIehl/Q4KuzWnytfTwtRfQnfZYYH3Qg8odBhB+WqizrLnxpKRLT2
         EBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20qFoI2zAcPj/2YkU+y26itShjeGgYjqahabkwiHIZo=;
        b=NrYj2p5xwySOg3aokDZjzIdPP+y46uHJRC/cWv51NrSv4DDvywSFQHHh6F5mfr1SjW
         m+Ubj/5pdr8TJjWgkW4E9a9YrYRt4adADAi6iA0CZark7bfkBMo/BRKeXZfRty77fjBx
         /RB3hAh0GWQol9ILCOjABURkr/3uFuc9BNk7KZF8EwP1hOGiiBxjP/iGSMpjB2T4m9uY
         WPIE64k2bUj2XbQQyDNiBc7/xDzBuLq9Fx/759EMmSbVreKcrpzs9MrBzb8oHublGqsp
         t8ftMwgauaiNAYT0pst1bkIoiB6XDbXI2LPHG00M3EdAVwV2zi8KxfH9Ffeav2JQVjIL
         OBbQ==
X-Gm-Message-State: APjAAAWBhBctoKxUS2XFrw/dSoSKOFHE06SELsRZQwo/45obVoBelzPr
        zGBDBfBB6zpavR5daxPqeH6vrA==
X-Google-Smtp-Source: APXvYqzLBzFzlo7nLvJmt4fKbevNt+r1fN1E5ZFnZOsl8lhgIl0SZeLHq4xpPKRJt37hUlte8hZ+zA==
X-Received: by 2002:a5d:4ecc:: with SMTP id s12mr21563wrv.157.1564145211051;
        Fri, 26 Jul 2019 05:46:51 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id x16sm39090124wmj.4.2019.07.26.05.46.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 05:46:50 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: meson: add video decoder entries
Date:   Fri, 26 Jul 2019 14:46:39 +0200
Message-Id: <20190726124639.7713-4-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726124639.7713-1-mjourdan@baylibre.com>
References: <20190726124639.7713-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the video decoder for GXBB, GXL and GXM chips

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 11 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 11 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi  |  4 ++++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index f734faaf7b78..0cb40326b0d3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -845,3 +845,14 @@
 	compatible = "amlogic,meson-gxbb-vpu", "amlogic,meson-gx-vpu";
 	power-domains = <&pwrc_vpu>;
 };
+
+&vdec {
+	compatible = "amlogic,gxbb-vdec", "amlogic,gx-vdec";
+	clocks = <&clkc CLKID_DOS_PARSER>,
+		 <&clkc CLKID_DOS>,
+		 <&clkc CLKID_VDEC_1>,
+		 <&clkc CLKID_VDEC_HEVC>;
+	clock-names = "dos_parser", "dos", "vdec_1", "vdec_hevc";
+	resets = <&reset RESET_PARSER>;
+	reset-names = "esparser";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index c959456bacc6..a09c53aaa0e8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -848,3 +848,14 @@
 	compatible = "amlogic,meson-gxl-vpu", "amlogic,meson-gx-vpu";
 	power-domains = <&pwrc_vpu>;
 };
+
+&vdec {
+	compatible = "amlogic,gxl-vdec", "amlogic,gx-vdec";
+	clocks = <&clkc CLKID_DOS_PARSER>,
+		 <&clkc CLKID_DOS>,
+		 <&clkc CLKID_VDEC_1>,
+		 <&clkc CLKID_VDEC_HEVC>;
+	clock-names = "dos_parser", "dos", "vdec_1", "vdec_hevc";
+	resets = <&reset RESET_PARSER>;
+	reset-names = "esparser";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index 7a85a82bf65d..a0e677d5a8f7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -144,3 +144,7 @@
 &dwc3 {
 	phys = <&usb3_phy>, <&usb2_phy0>, <&usb2_phy1>, <&usb2_phy2>;
 };
+
+&vdec {
+	compatible = "amlogic,gxm-vdec", "amlogic,gx-vdec";
+};
-- 
2.22.0

