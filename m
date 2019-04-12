Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59111C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206212171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aJds8UMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfDLMwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:52:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41737 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfDLMv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:51:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so11766281wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VWwFb/x/5djGRQFOAMKS9jR6gvNhGl6yp11Dvv7sduU=;
        b=aJds8UMcq31d/Jx5oG4bxxbazE5RXiMDjt3rTmBGHiVfuQDP6Rhy8Q9ktE1tmXMy95
         2ASHaq16IpPYzOX6eC8DQjsRKzgBv17pLfY1Jpj01DP42R2W/qH30mTwLP/Ux4jsC1Ks
         M3fNdqTfGnkcw1b+TMILwgeZBCQr3z8w5J8c1+TAbrnONrH6YtIvcWeSsy1hhwKWMPyQ
         GPh0yhZNruBRKXpceq0FHZ7xWtYkvB6muNijT7RQACKvJYrVO0zZgmyBY03JJBUBLiS7
         QUJQTAjtnmD6RWQvGGJzJc/gxjybHw5+loDfhqP9NKeexK2M2NV+Qi8rsT/DxAyMQNKc
         hAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWwFb/x/5djGRQFOAMKS9jR6gvNhGl6yp11Dvv7sduU=;
        b=jFinfOCfbFRN8jQFYcihTTllm2xlYKF4pwSzhQy3C5im+m5rBRRX/BSOD5JC6OJNeA
         NhvNIQ+MSWNHMgfB1HSjHdRQLHqU3jku6oCqG0PwAM8/ZS1RceeEXVh5HCrJYscgVoNg
         dy+rbRkf7RM2sKbgTuXSgPai/KU1b8en9D/C9opySTiwQqrSNgzNamFwocy1FAmTyzh/
         UDQrXKyIdOEjPcVNiWUqnylH63bkssjHR3Jok+Qnw00wam7geV77yp/F7T5dSSHWCMps
         20davM5dVl04TGuU592CtuQsmj4azRjMNqayOZRP7OZ2HuQIY7U2hYn8xPraYZZfRjmz
         BPig==
X-Gm-Message-State: APjAAAVmVml4kYQlNSOBzLK/I2kGwwnVttdlI1H24DSGUed33p4uJfYt
        HBKnHdpYjnoroKWTO0l6ApQIsQ==
X-Google-Smtp-Source: APXvYqzF1xmnzjs3JDjLGzZTIbfa0ZdFr/2qaQT4OKX+ROJviZKWq1zN2dh40Iw7bRCBq2Q9J94kRA==
X-Received: by 2002:adf:e510:: with SMTP id j16mr37111086wrm.259.1555073516421;
        Fri, 12 Apr 2019 05:51:56 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id b3sm42049702wrx.57.2019.04.12.05.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 05:51:55 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 6/7] arm64: dts: meson: g12a: add pdm
Date:   Fri, 12 Apr 2019 14:51:35 +0200
Message-Id: <20190412125136.28232-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412125136.28232-1-jbrunet@baylibre.com>
References: <20190412125136.28232-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PDM audio capture device of the g12a SoC.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 90b23bacd51c..ab46b2b0fb86 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -239,6 +239,19 @@
 				};
 			};
 
+			pdm: audio-controller@40000 {
+				compatible = "amlogic,g12a-pdm",
+					     "amlogic,axg-pdm";
+				reg = <0x0 0x40000 0x0 0x34>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "PDM";
+				clocks = <&clkc_audio AUD_CLKID_PDM>,
+					 <&clkc_audio AUD_CLKID_PDM_DCLK>,
+					 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
+				clock-names = "pclk", "dclk", "sysclk";
+				status = "disabled";
+			};
+
 			audio: bus@42000 {
 				compatible = "simple-bus";
 				reg = <0x0 0x42000 0x0 0x2000>;
-- 
2.20.1

