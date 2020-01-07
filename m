Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58D3C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC8E20715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acgjS9YU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgAGTKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:10:25 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33036 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgAGTKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:10:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so70316plb.0;
        Tue, 07 Jan 2020 11:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=udxb2nz6/O0HfR1mRrdKFyNfS9Q09XXu4H95tu0JCZs=;
        b=acgjS9YUAcyPamemAb1Nj3Ec3zSSVYS9z7m2SeFGysjQJcpak11/bjEbqTf6TsZ5/Z
         nmZMY8WoZI3nH5qzbrPt/udBt8ITZwOFx1ogVStEHvnKQ6IgBS62CPOpoku7bpS5OcDw
         AqoDnrqlfHeWBxKiXghnmOEZkWYNGx+rwe2NdGja40iLS1Hac0lyATVyYqEePrC7+jQX
         u8l0N/qIn+fvT25hJGnUjeDuEwxQRiLC+ydXDaz2N1lAqJkR5NGp8N/WeEkO7BbndWzs
         xZlFQw4Y1Zx3kKGJWSkaI01JzGj/MAyxn5wrURDHPv5tnz/xrKBT7SoYsGbsCgJzZGzu
         KgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=udxb2nz6/O0HfR1mRrdKFyNfS9Q09XXu4H95tu0JCZs=;
        b=lIXEXpgcidQzm8gX9WCBS3reou2uYx5WaMZr7PkDt3RFRql1tnfX1yzeXLghGBLLst
         yZNUjvEFzRY/xp+pwzrCuXa4NRxo+sFEXhwUD0YKRhP9yFko3kfyDVghLAfBQsS57K8S
         GPtln1VTsaT4/vAAdUDF4SlJ+q0bokoWNUDwmKVpoSwT6GDcEXV4CmwRJi+IqMHuygx4
         gEAV0gUa0PnO9ceQXllz0BHdv84LWiZeU16UDWxD++bxUuAWh+OU2ncbTeFyKfgWcgqA
         WAMEuSZJcM37m0o4dAU8NsJxopyEe2F8VKapZd/jqAYSgSYudRhLv8mUcFy5mEKwJihk
         tQ6g==
X-Gm-Message-State: APjAAAV2sccX5SGQpJG9CNAdko/GDQXlvgmogw3+yKuuZ/779qZjRc1h
        dPjc9cjE6xnxVdVODfbeUK+FeaLKdIE=
X-Google-Smtp-Source: APXvYqwDRiU7nES6NK298Wl7FIXAxcCBKJmxGZr5Hcbhc7ypDJiUD4Wl4SjDYqFbTiKPrv8b7Kk8wA==
X-Received: by 2002:a17:902:7c85:: with SMTP id y5mr1141774pll.227.1578424222460;
        Tue, 07 Jan 2020 11:10:22 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id s7sm324776pjk.22.2020.01.07.11.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 11:10:21 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] ARM: dts: exynos: tiny4412: enable fimd node and add proper panel node
Date:   Tue,  7 Jan 2020 19:10:20 +0000
Message-Id: <20200107191020.27475-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable fimd device node which is a display controller, and add panel
node required by it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
v2:
-update commit msg and merge to one patch
---
 arch/arm/boot/dts/exynos4412-tiny4412.dts | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index 01f37b5ac9c4..3a91de8a8082 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -66,6 +66,31 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
+	panel {
+		compatible = "innolux,at070tn92";
+
+		port {
+			panel_input: endpoint {
+				remote-endpoint = <&lcdc_output>;
+			};
+		};
+	};
+};
+
+&fimd {
+	pinctrl-0 = <&lcd_clk>, <&lcd_data24>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	port@3 {
+		reg = <3>;
+		lcdc_output: endpoint {
+			remote-endpoint = <&panel_input>;
+		};
+	};
 };
 
 &rtc {
-- 
2.17.1

