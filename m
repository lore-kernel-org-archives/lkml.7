Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9B3C32759
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B293B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TDu0To1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfHNOa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:30:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33401 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfHNO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id p77so3462054wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DsqMA3qFAXn24pl05ljozym+J7gax0j6GjVntAiYOQ=;
        b=TDu0To1gCBZ+0AOKz7IpaNPzK0Nklzt+Do4HG6UBKz8GHnEaskp1xeIHtdmHB5EGwu
         HQ+THz3WwnyD7hPhYAFN+GWMKRL3iUd8f6j/31JnYDhinQr4mk8ffnerVi4mfd1iiW7b
         96z9WAMcmvYshPheRCk5Ri0HObVUdnQdgAYiantB/y4xjGpUSm803U1c6ifMGhar3U6l
         1ppMmmVTnxYkC433993KQzu5XxnSIJbVTQ7bLVphp22U5smc2iZkmmfwqoNZZC+eApgf
         3XCecNk8mgl6nFbPeeo1dshRnLdmhAT1PpkP32hKuxHyvrmDnRIEB9ONN6nnWnoX92W3
         JFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DsqMA3qFAXn24pl05ljozym+J7gax0j6GjVntAiYOQ=;
        b=BSTS91IDXHG8S2H0evPfwpeOBe8tw7MXBnEJ36nYa9En7/gAsdkxYXio8xsmJ5o1M0
         E9dJ0k3Zavts122qqLkvet6b1euXWG+qzRFBw9wD53jaBG4/sXY692i4dmAEiIsOhQ5x
         47Pg8j14J4+n2bl5xYce0yfc7M34q3yRpvsLm1ZyvX2kaKKN9Nn1Ws0X4nmgpDN/hnjZ
         E0ix65EMvOtR/CKbbthVzxcV2gaXy1lm0XfKsgfAMipC4JvdZSP7NPMWTFdI2ntIjwO4
         omxhB8xU3E3vhWN7y5TB7fwV9ONkEIbWh89y7wnISLNKZIT2KSfT61N/kt1o/TpdP09H
         geHQ==
X-Gm-Message-State: APjAAAWIFrZRfuWdW+WpLrVXF+mUliTbPKUchByPVuAkHvmJ5hOalNug
        zTYZLLVDJ7U2yv6q2A8frS7oUA==
X-Google-Smtp-Source: APXvYqxaYmczp3cYsY3AQw5hAaTzvtpY7hpeQlM/ZpQaPs9n0FItyfE0GfptHr27uq56N5g8qEPzQQ==
X-Received: by 2002:a1c:6c01:: with SMTP id h1mr8773247wmc.30.1565792966998;
        Wed, 14 Aug 2019 07:29:26 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o7sm4202908wmc.36.2019.08.14.07.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:29:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 04/14] arm64: dts: meson-gx: fix spifc compatible
Date:   Wed, 14 Aug 2019 16:29:08 +0200
Message-Id: <20190814142918.11636-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814142918.11636-1-narmstrong@baylibre.com>
References: <20190814142918.11636-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxl-s805x-libretech-ac.dt.yaml: spi@8c80: compatible:0: 'amlogic,meson-gx-spifc' is not one of ['amlogic,meson6-spifc', 'amlogic,meson-gxbb-spifc']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 5b3dfd03c3d3..e2cdc9fce21c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -317,7 +317,7 @@
 			};
 
 			spifc: spi@8c80 {
-				compatible = "amlogic,meson-gx-spifc", "amlogic,meson-gxbb-spifc";
+				compatible = "amlogic,meson-gxbb-spifc";
 				reg = <0x0 0x08c80 0x0 0x80>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.22.0

