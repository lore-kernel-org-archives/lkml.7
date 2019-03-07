Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA1FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFE3214AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bpGg0R5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCGPOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:14:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42799 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:13:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so17851534wrg.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bf1+mf6QfF0AsCLbNkZ8mPUtWVYO9Du/N5n2zl8nGt8=;
        b=bpGg0R5lH1fa5WfXHk0KkF12jcH5G5qkJgiPhF857EkVXitlkhzOPKOsAa7cshICu7
         wS7rO0HpWnBXmKYUOxvl6+9qgi94yAvvO4LXSH9IIlS+9EWghEtrszyfs2B4JIDcvD+6
         x72M1dQBfERvWxk6pmdry/RnK8SIMBuYxQ1XSR+RyZtiyJCpyRXC7eSy3DmMYdQPcyWU
         sklEgjyP5x7+FnkpqWgPa/Z+jqOtLnYegVH8jLvDtv1MJ3NvSNfEiC/S3nZpF450QPor
         uCkZzQk3szbY8a9USEDH0JJKai2zT0Dx0XTyPYWg5ErW2+e4QaDNLNFvWebCwaL42SmL
         8NnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bf1+mf6QfF0AsCLbNkZ8mPUtWVYO9Du/N5n2zl8nGt8=;
        b=cCF5AHZrsWCt1+K+Xsg667pJXPklTPWikq1XNiuTpelKAK4fQ8aKh+l7jzTw1R60sU
         FDgsvs8IIh947Ra2FJr3Ln1JIE5aSGXfoRGuKx3wNIuuw7GDfrWDHOaXB78tO4+67BB8
         0gYvDEK1bRIK9sAeN2YypYrO2P4dDec2IdBD0/FSV21Br1M6esUJvkdDCBAQlJxeRcn7
         qtcrlNVt493ZTwHhjGzK7NccKk9yMZ4yrcDaTupPcIxWR/dhN1U3sH6e/Ei3nmBN0msC
         3J5qrpzDzu7qQmEcUHp9TftOyYDOZYmysB5lU+3OQeIc2X+X6ZGSSY6ZPHBC3Btt3FXH
         Nl6A==
X-Gm-Message-State: APjAAAXA04TRERVhUXUEB1jmkYQM8/wmrHuwVSiTTVydkQUlcb4Eu3ml
        74k+NBkr/2k7mBYsAsWbcw8qLw==
X-Google-Smtp-Source: APXvYqwmQzpfl9/1mNwGo7zgz2jQGPTPZYva7ziWJYqeIKewiGh2ykoHTRFEoLay4q7YqEW/kL6QOQ==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr7018237wrm.291.1551971627761;
        Thu, 07 Mar 2019 07:13:47 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r15sm5756563wrt.37.2019.03.07.07.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 07:13:47 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 5/9] arm64: dts: meson: g12a: add reset controller
Date:   Thu,  7 Mar 2019 16:13:37 +0100
Message-Id: <20190307151342.7381-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307151342.7381-1-narmstrong@baylibre.com>
References: <20190307151342.7381-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

Add the reset controller device of g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index f8f055c49f9a..2a700bb45d04 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -245,6 +245,13 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
 
+			reset: reset-controller@1004 {
+				compatible = "amlogic,meson-g12a-reset",
+					     "amlogic,meson-axg-reset";
+				reg = <0x0 0x1004 0x0 0x9c>;
+				#reset-cells = <1>;
+			};
+
 			clk_msr: clock-measure@18000 {
 				compatible = "amlogic,meson-g12a-clk-measure";
 				reg = <0x0 0x18000 0x0 0x10>;
-- 
2.20.1

