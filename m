Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855EAC3A5A4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEEC21655
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Mbo1AIuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbfHVOZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:25:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46174 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbfHVOZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:25:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so5605675wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KG2NcaIwbNAD280NQ64Qs5ode6pikwpdVx2HlcQqOdg=;
        b=Mbo1AIuvdMXerHdaswfzRwqBNLg0dn4ksMsbHBX6Gzz7CO7Ed8uL+57KRDLMsubeLI
         i9fwlUGa8+0jRP1vOy249LbGNk6rCoLl/5SsfipVbB/xjyDOYdJJNYFajO4lqCfdpUUa
         NoZd+QfZk+EgydZA+CESI2LeUcOwP/RnN6ck8dKPbdQW5zfLgajcRvdq6vyVCh5uMI/7
         WGhpSR0IStar+a3Sq2R6J4jcSvZSVx/eb5bYo3QM44Pw30SvS51m+9eaMlT2W0/cxmOS
         nmdqOZq+uKhu/pSdFXAyCX40rJv4yyIbON40DFdjY1381M1P25kT9V/MA/gK94kpSsBr
         brYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KG2NcaIwbNAD280NQ64Qs5ode6pikwpdVx2HlcQqOdg=;
        b=Gh+14TVQ5hxVM4DBVaqwQLIA4kcdwNASiENL0KbVHd/txOfgM3j1UmKKsPOEIxKUPl
         SOmkwsRrinPIOK2tAcRHyQ/h4GcWJieJEJx95BPWRYiP9X7Ensvb7JuQslSd3LJL4A1b
         QcwHuokXNZL4hGulxN0KmJoo9YOKn9nip0p0hAR2ed7Hgx769NmjKoTd134ULh1DLvkB
         mxSAdrz0whymUzOl6IIgXwgq5MjUBG30f0r/IDK0jQI7r+KJEJ1/PFOe870qf42oROB6
         ZEKjmxXiFe9DkqYLWg57QUfnqqyYf3USBfnBTvOeEwE0R7Wu4fe5P8vkMItaIUavf10N
         1MDA==
X-Gm-Message-State: APjAAAXV3q9IJ+8gqCMk3JV5n1ddM+xRizKqIUjuU/K6FKZuepzbsvl7
        HQ7cEiDel2KJtD8keMM8FNfWUw==
X-Google-Smtp-Source: APXvYqx3Mh2RGDC4m6KW3PjxbIkLg6LPgBiTgdSz+Ekeh7xQUa6XovZaLMvsi4r6rmOAQz3j+lYyoQ==
X-Received: by 2002:adf:e708:: with SMTP id c8mr48174622wrm.25.1566483904374;
        Thu, 22 Aug 2019 07:25:04 -0700 (PDT)
Received: from bender.baylibre.local (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d17sm25806547wrm.52.2019.08.22.07.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 07:25:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] clk: meson: g12a: expose SM1 CPU 1, 2 & 3 clocks
Date:   Thu, 22 Aug 2019 16:24:54 +0200
Message-Id: <20190822142455.12506-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190822142455.12506-1-narmstrong@baylibre.com>
References: <20190822142455.12506-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the newly added CPU1, CPU2 and CPU3 clocks bindings for the Amlogic
SM1 SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.h              | 3 ---
 include/dt-bindings/clock/g12a-clkc.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index 4682a4442ae9..9c1dc6ade3d6 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -257,9 +257,6 @@
 #define CLKID_DSU_CLK_DYN			250
 #define CLKID_DSU_CLK_FINAL			251
 #define CLKID_DSU_CLK				252
-#define CLKID_CPU1_CLK				253
-#define CLKID_CPU2_CLK				254
-#define CLKID_CPU3_CLK				255
 
 #define NR_CLKS					256
 
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index 8ccc29ac7a72..3cfefaf43315 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -138,5 +138,8 @@
 #define CLKID_VDEC_HEVCF			210
 #define CLKID_TS				212
 #define CLKID_CPUB_CLK				224
+#define CLKID_CPU1_CLK				253
+#define CLKID_CPU2_CLK				254
+#define CLKID_CPU3_CLK				255
 
 #endif /* __G12A_CLKC_H */
-- 
2.22.0

