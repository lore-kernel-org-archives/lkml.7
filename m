Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D357C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9332082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/QcefCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfEPQ3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:29:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37168 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:29:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id p15so1887915pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+MUix4E2fzDWarwS4nmG/Em5BaLYXIJG0RnslLnuRA=;
        b=A/QcefCONy0p8hJbO0heZwLqxWZ8lsgdagrHghkE9zjmezGMvjfyieeXactlpqZRRa
         YLS81uVk2pJdVXGp9xaDmlgMq2U+xIeDeNkcu+gI4czxMzsnQt5Y7DBVdyYnqcLHRHSe
         /f/w5SMGU32q0oRor5O557Y/iSuZDQryFc1t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+MUix4E2fzDWarwS4nmG/Em5BaLYXIJG0RnslLnuRA=;
        b=bAAegxHAK0EMA4wUqmkxzpWaHrcmmL2hy95+rgXa2G+rVGr5TMqumjLaOFvd4zpBB9
         5xuT1pnaBysgBJx8hulhbiRcpKJeVq9QwFCh3Wl2sG78es9qXPJCJ/mrmSvdym5i9yVD
         xc+ohHxnHSvJCLvFHa1/OP4KE5Ga8qi3NYtV+Ff2iPQrmcds9Twmovc20yCiPW9D3fjQ
         RJNZ42l9K8Lsex205/bnTrpPLESXzcRPayartwRKtN7waozq8AF7pSBb6aGhyiyrDsaW
         E1cDq4XbwYutzRLby/WM/MzntZ/BgVA/+ntIaKw3m4vrCCAfJfNsmwKN1eY9Iud+y2JO
         QAfA==
X-Gm-Message-State: APjAAAXZbiKaPOhO+NTvf+2Qtk7GSJ6hHX6nptSK3aHjKFaOI0N2CFkk
        xEMWkq7rh4jkx/L1f/6Etwi7Rg==
X-Google-Smtp-Source: APXvYqxkK/qfoQgyJc5dgRsnMZtbcRgZDE5QF6K47Pw4/YozjwnhVzeOxcxp4uW/0m6HCYUODwDYOA==
X-Received: by 2002:a17:902:683:: with SMTP id 3mr9312171plh.209.1558024188932;
        Thu, 16 May 2019 09:29:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d85sm8140067pfd.94.2019.05.16.09.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:29:48 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 2/3] ARM: dts: rockchip: raise GPU trip point temperatures for veyron
Date:   Thu, 16 May 2019 09:29:41 -0700
Message-Id: <20190516162942.154823-2-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190516162942.154823-1-mka@chromium.org>
References: <20190516162942.154823-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values match thorse used by the downstream Chrome OS 3.14
kernel, the 'official' kernel for veyron devices. Keep the critical
trip point for speedy at 90°C as in the downstream configuration.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- also raise temperature of critical trip point
- add entries at position in alphabetical order
- added entry to keep critical trip point for speedy at 90°C
- updated commit message
---
 arch/arm/boot/dts/rk3288-veyron-speedy.dts | 4 ++++
 arch/arm/boot/dts/rk3288-veyron.dtsi       | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
index ab2a66aa337e..3d2769f1bef2 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -75,6 +75,10 @@
 	force-hpd;
 };
 
+&gpu_crit {
+	temperature = <90000>;
+};
+
 &panel {
 	power-supply= <&panel_regulator>;
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 58dc538b5df3..aee8350b2800 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -142,6 +142,14 @@
 	status = "okay";
 };
 
+&gpu_alert0 {
+	temperature = <72500>;
+};
+
+&gpu_crit {
+	temperature = <100000>;
+};
+
 &hdmi {
 	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
-- 
2.21.0.1020.gf2820cf01a-goog

