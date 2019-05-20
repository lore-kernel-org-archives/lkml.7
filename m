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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18686C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E832E217D8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bqnP7lv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfETToK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:44:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37923 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfETToJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:44:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id t5so521221wmh.3;
        Mon, 20 May 2019 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbtcwLTT91//XKmC+nVPtkzszNKe+pk1U7NYT699Lrc=;
        b=bqnP7lv6jn4i1Q/jGxux0ThtCKwf8NtdpmWcAE95aDI+W14w8Kip28zRIk0UnNd8H9
         uLwKOByCpDXwwQznTYVX3bssmINT2gpSwsbYZ1rL2R1gmwUAPDUmWBsGQbVQzPcinQxB
         xNYMJxEfvY2sSqcqHpH7Vx/DfEpp8pH6kVd09RmaSHI7rfv11xyghvZOXzuUbOElDYC3
         PgPwRXIStRlsP7T2dy8TNs86gkFVpGW/dj2my/NPhPbqACLEN3aD6uFczsJj5+rKvnlZ
         J/DrwtS/iLZyhyS4arHTi3Zzq4tSQbZQxGNFynJz7SAhXAel9FsB2Id3VoiSsq0lQ39Q
         4q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbtcwLTT91//XKmC+nVPtkzszNKe+pk1U7NYT699Lrc=;
        b=lWpEtNOUJVrVzCVDCs20EfdstIdIwCXMAEilOBlm/y3Ha9sMh86ppNOh+B+Imo1MkB
         7HsmxNca1qSarA9BBcaEfwNUDBtxwnNamhebvcGq5i55eKGZngCupy9LoflIgc047YV5
         R23aCymXZjGTvv26ZSppXN9Rs8TjAOB3fOuKALj1lrGJoD41eHiTqopNKDHpnnj9nmh/
         xng3K8xN/XpijiTFVXQPeAsYrBXn3KdUmkev05EjHyV7WTZQUJ+0lpfcqPgYc2m2/mM9
         F6InulKe2h1wroeB4qOFfl6T+4cs2kIB9pNsS86C/mJ13/qJdPSa/WPr321We+fmO8k1
         AZ7g==
X-Gm-Message-State: APjAAAXzGRryIQozHnlnLa0cli6BR7bNcl6Y7pARDcvVLbV5fEW15N5d
        lY+hNlLdNdQ/nNMAUMDVtMU=
X-Google-Smtp-Source: APXvYqxIvBEBsiGaewtDr53S3vSH0QaYQdhtkgZBbh05g6PE/3rwce7wCD+fDv/oMZdNDf13BNdexQ==
X-Received: by 2002:a1c:9d56:: with SMTP id g83mr614737wme.8.1558381446984;
        Mon, 20 May 2019 12:44:06 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id p8sm9135352wro.0.2019.05.20.12.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 12:44:06 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        mjourdan@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/5] ARM: dts: meson8: add the canvas module
Date:   Mon, 20 May 2019 21:43:51 +0200
Message-Id: <20190520194353.24445-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
References: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the canvas module to Meson8 because it's required for the VPU
(video output) and video decoders.

The canvas module is located inside thie "DMC bus" (where also some of
the memory controller registers are located). The "DMC bus" itself is
part of the so-called "MMC bus".

Amlogic's vendor kernel has an explicit #define for the "DMC" register
range on Meson8m2 while there's no such #define for Meson8. However, the
canvas and memory controller registers on Meson8 are all expressed as
"0x6000 + actual offset", while Meson8m2 uses "DMC + actual offset".
Thus it's safe to assume that the DMC bus exists on both SoCs even
though the registers inside are slightly different.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 40c11b6b217a..6a235275b01f 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -228,6 +228,28 @@
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
+			canvas: video-lut@20 {
+				compatible = "amlogic,meson8-canvas",
+					     "amlogic,canvas";
+				reg = <0x20 0x14>;
+			};
+		};
+	};
+
 	apb: bus@d0000000 {
 		compatible = "simple-bus";
 		reg = <0xd0000000 0x200000>;
-- 
2.21.0

