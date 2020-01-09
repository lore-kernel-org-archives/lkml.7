Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B46EC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD45221569
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="DWOUhR5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbgAINw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:52:29 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45517 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbgAINw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:52:27 -0500
Received: by mail-wr1-f41.google.com with SMTP id j42so7412794wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZrLGBX0GAZWIN09k6Jkrkg5nYulCVLrz9ygY+tV/Kr0=;
        b=DWOUhR5Pw1UT7nKDs96VcPAvctYVQZndKPpUAYQQaemJuOKNPPi0djqIMoTKZmGNdU
         m3gYqAb2ZVDxU/ZmL47bE6H4/45c0kE9GHr77nVQmGhaqxX9qBzA9K0zkGCvferdeN3h
         J1DrePcxW4f1i1JjeVvek39aSe3n1PTymc+5Lx1s6ZtJwDtXi55BhGpYWr9i0eEcmce6
         2SBlT27TJFZJymacRlX9+h9SesUOiLwWCZMyW9bsfLSzvrjNHj4TEEiRpWGHHO7BVaSC
         OKY8TIY484UNoZXe/Xrdxwn1WuxtuR7eWETApOEoiAYq28mwHqlCmjaNheN8dW5yrSOx
         ch2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZrLGBX0GAZWIN09k6Jkrkg5nYulCVLrz9ygY+tV/Kr0=;
        b=m8hxP+Csfypwrt4u7hdhCSlkkApD5m6nj7Dm4VSyaBMzuCsfVcgwMgfyrhPff7Vkcl
         lGO2sedt3OBZz3i3TBDDuo4I6GBjzsXPBS6UbB09i18uHPqA7xqL0RsFCZCag5YwuWr0
         GjtlwQ76j1zb8Iptv3LeiLNeFLJfazh0mYkfEyaUdexA6GqaHYfRDyS0BIV9RCpvR1YB
         IF7EsXjBAhF+sPalgTqU3jvRNOP8LDO4XAdnV2yvWnwi1Bur0VX3azNi9E/wz59gjqBN
         Kr3D7SMaWcpQMOQz063lyjQpdmdSznUSlhcsRDyRk6ESgV7XFkOCB+eMYkeQ2UMXeeiF
         S4uQ==
X-Gm-Message-State: APjAAAXCWpWDUwHceRc4u0VBy0B+zVWsGTTrvUg70ZuRNZ09mVvprHAb
        ZQ8r2gXamjavaHqlW0PtBPK2UQ==
X-Google-Smtp-Source: APXvYqw3xbHMsE3r5E/4sf+7dAbuVceFIbAf9AcL+fsqMok5sD7ZmoMagUK3wKeOBKhMKTlaTmrfug==
X-Received: by 2002:adf:de84:: with SMTP id w4mr10669349wrl.97.1578577945671;
        Thu, 09 Jan 2020 05:52:25 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g21sm2877547wmh.17.2020.01.09.05.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 05:52:25 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] arm64: zynqmp: Use ethernet-phy as node name for ethernet phys
Date:   Thu,  9 Jan 2020 14:52:15 +0100
Message-Id: <fabbd8e1417f326376d12b5bd0935405ce26eac6.1578577931.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578577931.git.michal.simek@xilinx.com>
References: <cover.1578577931.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ethernet phys based on devicetree specification should be using
ethernet-phy@ node name instead of pure phy@.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Add missing patch

 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts      | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index 3542d92735cb..69f6e4610739 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -73,7 +73,7 @@ &gem3 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	phy0: phy@0 {
+	phy0: ethernet-phy@0 {
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index e5d83a4aca07..b75235ae7d30 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -84,7 +84,7 @@ &gem2 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	phy0: phy@5 {
+	phy0: ethernet-phy@5 {
 		reg = <5>;
 		ti,rx-internal-delay = <0x8>;
 		ti,tx-internal-delay = <0xa>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
index 3750690925ad..4ea6ef5a7f2b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
@@ -73,7 +73,7 @@ &gem0 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	phy0: phy@0 { /* VSC8211 */
+	phy0: ethernet-phy@0 { /* VSC8211 */
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
index 9a894e6db6ba..41934e3525c6 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
@@ -74,7 +74,7 @@ &gem1 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	phy0: phy@0 {
+	phy0: ethernet-phy@0 {
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index d92f617f0b9d..7c6b538490f8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -105,7 +105,7 @@ &gem3 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	phy0: phy@21 {
+	phy0: ethernet-phy@21 {
 		reg = <21>;
 		ti,rx-internal-delay = <0x8>;
 		ti,tx-internal-delay = <0xa>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
index 1780ed237daf..d9ad8a4b20d3 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
@@ -16,7 +16,7 @@ / {
 
 &gem3 {
 	phy-handle = <&phyc>;
-	phyc: phy@c {
+	phyc: ethernet-phy@c {
 		reg = <0xc>;
 		ti,rx-internal-delay = <0x8>;
 		ti,tx-internal-delay = <0xa>;
@@ -24,7 +24,7 @@ phyc: phy@c {
 		ti,dp83867-rxctrl-strap-quirk;
 	};
 	/* Cleanup from RevA */
-	/delete-node/ phy@21;
+	/delete-node/ ethernet-phy@21;
 };
 
 /* Fix collision with u61 */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index cfb054e46723..2d71b4431cce 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -50,7 +50,7 @@ &gem3 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	phy0: phy@c {
+	phy0: ethernet-phy@c {
 		reg = <0xc>;
 		ti,rx-internal-delay = <0x8>;
 		ti,tx-internal-delay = <0xa>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index ea2dcbe9effd..ae62fe4287c2 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -106,7 +106,7 @@ &gem3 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	phy0: phy@c {
+	phy0: ethernet-phy@c {
 		reg = <0xc>;
 		ti,rx-internal-delay = <0x8>;
 		ti,tx-internal-delay = <0xa>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index d656eb8b3040..b3c29947d6b3 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -101,7 +101,7 @@ &gem3 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	phy0: phy@c {
+	phy0: ethernet-phy@c {
 		reg = <0xc>;
 		ti,rx-internal-delay = <0x8>;
 		ti,tx-internal-delay = <0xa>;
-- 
2.24.0

