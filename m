Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DE8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7678D21871
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAuTn6c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfDKVpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:45:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42089 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfDKVpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:45:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so9225680wrx.9;
        Thu, 11 Apr 2019 14:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LVtadINjoQxMwgCqQXKn8a84EoN+51Atn4X2TR15k18=;
        b=QAuTn6c8/nyzKZvxPVTSoueg0fm2LTdsL3IpWwCKmjqim2F/9qmErOzuMBXMVzhuP3
         DTlGAzSvX3JplRLClnpp+7bs9Bx7/8c0IYGNi9O0LDEkLx85VVlSb5mJH+pkXNDJ52j3
         9YK1fYBgHQec0Nu4kwlBjOLLaz6GY2VsUwL7GHCuPGcvPws4emaXuq0uCOKi4BlwjGTK
         feJ1QJc3waAS8w8zkBiQljwWIC0IgPVcnD26ASjUT9PTrCSjMDUMYFYPEXZyDWOQN39Q
         Ujc3ERnvH1dNeOqTo0k7z6venmBdRY1J2NKmBDzcLg4Dgnc7XGOzgdQgvuje/rdQEwvq
         rffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LVtadINjoQxMwgCqQXKn8a84EoN+51Atn4X2TR15k18=;
        b=N0y5lkBUE0sLwubjpR0hF+5g/ymOxBwQjmx5UIBhtuGB2JX/m7rpzov0215WEKEkDB
         1Q8MZD1ovyJ63rQ8WKP27NIu/icRHDXvMSPGw4jvZQH6r3aNMoOsWerjCp7E1uqyGqzw
         a4pGmfXKZREwiQZwfyZ78Z+e7Cp1aMLjy8qCCjlKSNrKadIVsk85aq6nAb0v47lNjfgv
         MvhixZOZiRQoECtROx2UlXTIQaBAxV0vP+3fX4fqtdMLUo+7x09JApIDIu1GhGCOy6uc
         O7GLpZWCdepGBZGMDMMOG612jpV/VE4UJsR29GVbDzQPKQlAoBuWn0sEX11bNaHIGAyW
         EDrA==
X-Gm-Message-State: APjAAAV8Q4fp4vGyLT13lA4d+FqJNLSYQl9ot3k9W0IEmnsn39p4XeoH
        9ieZxxm1XQKa+WoTIPl21e0=
X-Google-Smtp-Source: APXvYqwf2Tm4YvVDqO+wkao4h2NJcep8SdMG+x3bb1bGOvD7ayysiVOvEQ5+N6MiG9QPlAqcVEWFTA==
X-Received: by 2002:adf:ef8e:: with SMTP id d14mr30717233wro.81.1555019101751;
        Thu, 11 Apr 2019 14:45:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id a22sm5952961wmj.44.2019.04.11.14.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 14:45:00 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 3/4] arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
Date:   Thu, 11 Apr 2019 23:44:21 +0200
Message-Id: <20190411214422.2267-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411214422.2267-1-peron.clem@gmail.com>
References: <20190411214422.2267-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink GS1 board has a SPDIF out connector, so enable it in
the device-tree of the board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 0dc33c90dd60..76a95ad33dc5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -243,6 +243,10 @@
 	vcc-pm-supply = <&reg_aldo1>;
 };
 
+&spdif {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.1

