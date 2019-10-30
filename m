Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E366CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46CD2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8k2Tejc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfJ3PIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:08:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45289 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfJ3PHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:07:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id q13so2686940wrs.12;
        Wed, 30 Oct 2019 08:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SPagqRzFvAqQRYLAlTZWNfeQSznNMN42BCRbkymxKk4=;
        b=T8k2TejcV/x91i7pS8E+xiODOOcD855hSGNTITM4PzlKSU4jnlmd334bkK92Uma4+T
         BVuBN3u6BpYQaAOsGStGkwGdDoCaI4tZojC9jJjYA51iS1BpekA+EFlTJtF7M93xvP+j
         IRCflmqaEqVRjkc9xcOX0UG+lBv1y93PIK360M55oanGSeGXRJUJhPQ6MG4o0u7W9Ry/
         VZ7yL9X/yadhGFcfaQpAjocSR3HJIwPlYk4w2J6IpAjAtNqmlqBx3A7iwkMFzs1GxI2v
         iV67s8mMXIw+ei2YVV1E2VCQOvLiNIyCIX0Mh6msE4rCfe+ZCbHT98MdbiiMUNPCzz4y
         grlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPagqRzFvAqQRYLAlTZWNfeQSznNMN42BCRbkymxKk4=;
        b=BwoECOEzXm2q39tmTUZWuFWm8pyvBJovFhlOTMsKsnyaRho7rEAxk9zyyMMbFxmQGm
         Es7b42d0QfH8Ei1CyEw2drFgZLFD1xVoj0Xcip6SCKZ21nhI8bVnfeBrxrJJraMh9bNz
         5XlIOfnxvWiH+8PwS0lfitw/9FHXC2kSyvXsFvzEPBmEwbrFUMd1KH8l8vpDuKLs8Ibd
         4hRMbXLnZMGzq/aw3xDo/QnatOd52fzpGcnY7nBpCdbe9BURw1Z39LQxY7SpqioSZPDy
         JexJBLp7XdUAxdHIZQ02mYngXB6k4M0/sTgN46oRLxb8RI14T6GsvE7UvndSLJ9ol+JO
         QAIQ==
X-Gm-Message-State: APjAAAUOPGDzKwWzIN1nU218H7S1KQKIGwehGE3f/9TiEiEE7GD/m4NA
        6m9ehlTnqTmgXWBrb0Wi0nA=
X-Google-Smtp-Source: APXvYqwEDJZ8SgyYMZJU+WQZfBClqringMZaO4mY28gJfyN4A5sr+jgz2ePEFpIjjQCgmQL+PridMw==
X-Received: by 2002:adf:f40c:: with SMTP id g12mr308753wro.244.1572448069098;
        Wed, 30 Oct 2019 08:07:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id 11sm278074wmg.36.2019.10.30.08.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 08:07:48 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v7 1/2] arm64: dts: allwinner: Add ARM Mali GPU node for H6
Date:   Wed, 30 Oct 2019 16:07:41 +0100
Message-Id: <20191030150742.3573-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030150742.3573-1-peron.clem@gmail.com>
References: <20191030150742.3573-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mali gpu node to the H6 device-tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 0d5ea19336a1..a029daf67345 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -149,6 +149,20 @@
 			allwinner,sram = <&ve_sram 1>;
 		};
 
+		gpu: gpu@1800000 {
+			compatible = "allwinner,sun50i-h6-mali",
+				     "arm,mali-t720";
+			reg = <0x01800000 0x4000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
+			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
+			clock-names = "core", "bus";
+			resets = <&ccu RST_BUS_GPU>;
+			status = "disabled";
+		};
+
 		syscon: syscon@3000000 {
 			compatible = "allwinner,sun50i-h6-system-control",
 				     "allwinner,sun50i-a64-system-control";
-- 
2.20.1

