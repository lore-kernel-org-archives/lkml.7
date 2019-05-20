Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A33BC46470
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38F121479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="a9+TNBgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbfETNOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:14:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53983 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfETNOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:14:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so13256802wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m47c/l62ndl1BZoIquVCAdRz64Yquba0Nph44qgFKpU=;
        b=a9+TNBgqnV2CrEHXljT0uw9ovdO7ia1lACaaNVfaHCiyWMp9hbktkPEO4xtWN1wlZN
         /OBe+lIsQLHY/0oZNXeEgz7oYLTwoFmTtfqvfznfqiPjmj41i2mcgXCmFoBBwI4Btee5
         Yc5+MbcTTrqcHSdI2/CUu9w4m+/+ikRZoCEZWuRv8I/cqhW3DcRvommSzq8FCT5dGrc6
         GwT053sPmg6D496MIDo1xNreR+nnWNVKCVDwzRp23MROzcQNcgMc5WnB/MK4ZjUrVQvX
         8vF8a6r0j8rUGlCKW+pLIqfIY0IAryRP1rUldHXTX42E9n3Gai9fok4OSqOL0CA62yFi
         22cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m47c/l62ndl1BZoIquVCAdRz64Yquba0Nph44qgFKpU=;
        b=b5Rr/pS5y1x6xS3GzLyA9xOoliAAeYHoubVL94IRxEcG+Iq94we3l7DT/WLh6x7f9x
         5ZyfGUmdW+xmCQsarXFVUbT8yk63VuQbc2+momeyoGB+6TfhXdhrRW8QuP4sX1DGe9D0
         BJtg4jH1C5grZTBMUv1tpzr/x5TC6ccgYaECwZA+T5uGemNJkhh0JXCNF5bIZTga6oNa
         YbmPCXjrFSxTl1dUGbKHq9Ke/t31L2wNsMRW7UAgrXB4M4JfMt2Hw21aZUc9lfZqnz3T
         I/W/EBzV9/7zppGJBQnsaCbHpzREeraMtXlJIpXC4zF9XWLvewzpl3BsCILIG0SlauNx
         NFTA==
X-Gm-Message-State: APjAAAVeg2xwxrz4bwoT4doRMllDqyxCoTBTArL9HJvd0NkBniHj6jD2
        12FFSjaiLaxtH7hc/F4r61CZyw==
X-Google-Smtp-Source: APXvYqxLfvHVZc8cuXZUlVVEnCemwaArTi91A2WfQOsaaIfxLFsAdBOHU81+/ps8QxtzRG1xz26+Ng==
X-Received: by 2002:a1c:cb82:: with SMTP id b124mr12189669wmg.107.1558358053429;
        Mon, 20 May 2019 06:14:13 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z8sm18054284wrh.48.2019.05.20.06.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 06:14:12 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] arm64: dts: meson: sei510: add network support
Date:   Mon, 20 May 2019 15:14:01 +0200
Message-Id: <20190520131401.11804-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520131401.11804-1-jbrunet@baylibre.com>
References: <20190520131401.11804-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the network interface of the SEI510 which use the internal PHY.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 484b93ef11d8..be1d9ed6d521 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -29,6 +29,7 @@
 
 	aliases {
 		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
 	};
 
 	chosen {
@@ -149,6 +150,12 @@
 	};
 };
 
+&ethmac {
+	status = "okay";
+	phy-handle = <&internal_ephy>;
+	phy-mode = "rmii";
+};
+
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
-- 
2.20.1

