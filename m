Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF0DC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D64320854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pjZEBxgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfCRKFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52716 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfCRKFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id f65so12314821wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Lj23NNiwvSBJgMpzQcSPJzZg545AVVfKByrCGsDrxU=;
        b=pjZEBxgS8pDyJKPJyYPMJsl4jtmuTMtXSTrFKCbjfK6b8j0zavYifZkaCuPsnbcfZc
         bs1HomnxbXllocZBvjHF5KeF9XtBvXbsTz1HajSARlCJQk6Mwl/TnOeMML2285CKG8wS
         2EhpMeGuV8O8KQBm/el6YXUdmx+aBcGGtV6UvsyedYDLGztNJe+9rvKcHtx8EA9YVVMT
         cwFTcWtu/WFS2SXk1uqz1Bfw/KaL4NfIjWr8BSBDhj07PuJtNm1s+WBbcNE2aapXklUf
         /tk4YNhoL0OPzbeHa3WfQ6sn7ehilJONJrI6NUdM3R8ivyM8WViM5Qf6wVtsX56a8OO5
         eBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Lj23NNiwvSBJgMpzQcSPJzZg545AVVfKByrCGsDrxU=;
        b=S0LUqIoymAx8YfXk++KDQaNOaudXqccu+lAUHDxUCYVGmMYrtwfncQrJPZRCS68HPL
         fMqLH0GO99LGPf0/N7qOEkHCyfctuTOCZo6hTQKsbAb1WXktCMtGO0IEHVkT3MroGBEz
         UAwuq61VmWwJLC5kMJGNw8A9ht5bNfba4woRDRW8LDrX8s10jqeQ5no+R4VlT26u4o7P
         tBHjPIb+W63ZZZjJSqr3pyC3RNfKXPxwN38O8pR7Jo7YRSiisqk7GBAqTbj5r3wjbw+h
         fFSwgyEZEh8NYanl5kJD8+gxmqpQtJQ3fjD4Vx9lA1V9A2NX7f2Mu1qHPTfFSxeaeoIQ
         U0ag==
X-Gm-Message-State: APjAAAVUm9ZlAKYnt3mH/yy5sCA45FVJKu/G0raj7fIMm4D9ENSmTmd/
        qtdzRhwgDdnk+OKjs0J0nHgNjg==
X-Google-Smtp-Source: APXvYqzodbCpdIVd3EV70tiQabqEr/bJqrYH1Q7vuNdrLgFe2wa22kGAg6tQ+gzQ+Fj10dA0Wcf5KA==
X-Received: by 2002:a7b:cc10:: with SMTP id f16mr10132433wmh.49.1552903507142;
        Mon, 18 Mar 2019 03:05:07 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i11sm5216800wrp.40.2019.03.18.03.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:05:06 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 07/11] arm64: dts: meson-g12a-x96-max: Enable BT Module
Date:   Mon, 18 Mar 2019 11:04:54 +0100
Message-Id: <20190318100458.5619-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318100458.5619-1-narmstrong@baylibre.com>
References: <20190318100458.5619-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Bluetooth Module on the X96 Max Set-Top-Box.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 5c37930b09e2..bc152b1863c3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -90,6 +90,18 @@
 	};
 };
 
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.20.1

