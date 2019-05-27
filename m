Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B073C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31249208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NKW1FoDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfE0NWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:22:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39636 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfE0NWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:22:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so11770981wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69AN6m6mgKCwdcDa48hHuHSqPDwANWv3gTQBvJBCe4E=;
        b=NKW1FoDM7+uCcjHpoXzZvu2le9mOkCrRwH38dVKrBJtVrYLf3/DDOj+jugAfySkByC
         9iwhNkqIDF7xpdcN6v13sSTt6HExdbrRXITzEjQ7UTLiR2YgAnqbv6OmZhuBZAy+Vf9e
         9+AzZiodLJvl4KpKAMZrP22JzCezBQm0FdG0propgvsvc1j8JlEHAysmFkr+p1BMeDuq
         47bZdGND8oUKUDewb1I83L7ef5Sdx2iyrctvyxuPx0Wiizwb+EFmcw351bbDX1sIcGfT
         Z2eTetqLRZUrUt3BEj6yvx7Z4TDl1qd0fBxaF0tRnLfkbEisnMvxbLOiJ8e6N07mRb6B
         3t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69AN6m6mgKCwdcDa48hHuHSqPDwANWv3gTQBvJBCe4E=;
        b=j2aZhklpHo+c/bQ7SNrAyNl/iIQhQ8xfrhJraeE5ca2UTb9XeyGh0qdMFEiwrc8Fsd
         VA4LGXFarQ6S1rcVggCTClET+95I/YvvU7JvRDZloDwYoD4sLNhNYl53+d3s6GOkQN50
         zXtCzpmumX/C1eDPzvG+Rlfl7Y1SQrQp0BzBILk8xw0PAFN552N9O5eIjV0cST6SH+i6
         aSoU5MrYyBtmJ2hxxQ6kagSR/H+kn/iHxwM8+Q91LyUAkp1j+ay4xHjQMG8ikgzNCo+z
         4Qm71m5NxUqxAc8kntRTXmCuetffD4f2EdcETM1FMly5dJeYu2MVcU7A9V6AoFi8FlT9
         4+wQ==
X-Gm-Message-State: APjAAAUDCtN8N3w54pbhNDpoJ+qr92mmtULvMt+Vs4KAlPccIw2SlQit
        ysxW+MNuCW6VePyR1aWUehe26Q==
X-Google-Smtp-Source: APXvYqzElmRUyLlTyruLYLsM/Nb7x3XAYbg7BArgQ0z8D76DZjUsgRdoF4S5RmrF1hmHCLqlPITFfQ==
X-Received: by 2002:a1c:8017:: with SMTP id b23mr1635231wmd.117.1558963325400;
        Mon, 27 May 2019 06:22:05 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l12sm7019836wmj.22.2019.05.27.06.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:22:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 03/10] arm64: dts: meson-gxbb-wetek: enable SARADC
Date:   Mon, 27 May 2019 15:21:53 +0200
Message-Id: <20190527132200.17377-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527132200.17377-1-narmstrong@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

Enable SARADC on Wetek Boards.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index b0d74ab619b0..45e306da2154 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -59,6 +59,13 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	vcc_3v3: regulator-vcc_3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_3V3";
@@ -172,6 +179,11 @@
 	clock-names = "clkin0";
 };
 
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao18>;
+};
+
 /* Wireless SDIO Module */
 &sd_emmc_a {
 	status = "okay";
-- 
2.21.0

