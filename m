Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566B5C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFC620863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kyYql0N/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfETToN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:44:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53314 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfETToL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:44:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id 198so539776wme.3;
        Mon, 20 May 2019 12:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cerp4BVz6jg3tc4rdBJfzN6XOYaVzz+u0Df3uTDWRZE=;
        b=kyYql0N/INbJltmfL4wFEOR+NsMXKiaRLatSdnJCMyxaA4MIIcyUUCEHtSsgERHE7/
         S/hoOwAe1IXGGrqMuJ4LFzQ//JAB8NAAT9hcwrAMLJk5ca+nMQiCNDdjJ/eg0h4wPqmk
         ad84lRW4KWxKwTNWjd6i9rn+LXgH70sP+aO9K4aZfogHpeE13o6TdQQPqLQ2H2FN/FVt
         0vnpHxxu5ly+oVB03lXLmvCBoNjgr7HlM0hDVBc/OTRYdxBUjHly+K/W5Spbb08tGYo1
         LWvKe8pPuKhXH9+/krespj+/cG2GWWN4nDzWRdFqVrpDddLVhtYUJvvxBOIBt8Nx2RmD
         n89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cerp4BVz6jg3tc4rdBJfzN6XOYaVzz+u0Df3uTDWRZE=;
        b=JYFSCbL3kbMikdTsMXG76U1yq428ZYsuVxl819hFKoyaPtyzpxGNfUPGTOzf6+MU7L
         QgnUcTLyQGE+EfIkT2CEU/zbMYtiNkTzITijlzEvYlTMsj9BD3yW8odulISsqgmS72nH
         6JJDqXE8gLl1zdkvq9wSVndgjlsfXwnn/CXQt/OsJikEtjUzl2Am/NfcCWWwM5zUFIF2
         lzmyRW+GjhtJhnFL/rDYQFvWTBax7akgr5MISyGc9iGgjpnDqDO22puZgimm59+C9XZB
         tkUJRSAqjHg1sZUEmsEUevQ/yUnXmR4z/q3fuaO0xHNWVnr6Q/iF41SWMU47IXIfPcUS
         r49A==
X-Gm-Message-State: APjAAAVSNr6mVPejhPjUYka2IqMSod9Z3Cl7FhyVpX01Q0crbvBF1/go
        U6HVYLBsWGST7xBtUpKtBb4=
X-Google-Smtp-Source: APXvYqz6TjOgiMXyvvY45YMYM5QAQd+aEkZPv3dGBlfGkdv3uVfPB9l0UQz9qje2U4+bNqxrMirqJg==
X-Received: by 2002:a7b:c939:: with SMTP id h25mr612524wml.7.1558381449221;
        Mon, 20 May 2019 12:44:09 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id p8sm9135352wro.0.2019.05.20.12.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 12:44:08 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        mjourdan@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 5/5] ARM: dts: meson8b: add the canvas module
Date:   Mon, 20 May 2019 21:43:53 +0200
Message-Id: <20190520194353.24445-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
References: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the canvas module to Meson8b because it's required for the VPU
(video output) and video decoders.

The canvas module is located inside the "DMC bus" (where also some of
the memory controller registers are located). The "DMC bus" itself is
part of the so-called "MMC bus".

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index ec67f49116d9..e4134c63a48c 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -205,6 +205,28 @@
 		};
 	};
 
+	mmcbus: bus@c8000000 {
+		compatible = "simple-bus";
+		reg = <0xc8000000 0x8000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xc8000000 0x8000>;
+
+		dmcbus: bus@6000 {
+			compatible = "simple-bus";
+			reg = <0x6000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x6000 0x400>;
+
+			canvas: video-lut@48 {
+				compatible = "amlogic,meson8b-canvas",
+					     "amlogic,canvas";
+				reg = <0x48 0x14>;
+			};
+		};
+	};
+
 	apb: bus@d0000000 {
 		compatible = "simple-bus";
 		reg = <0xd0000000 0x200000>;
-- 
2.21.0

