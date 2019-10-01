Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40D5C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CA821920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wq/CTtai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbfJALzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:55:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35807 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732589AbfJALzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:55:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so15168930wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jr85PqBhcGLPuS9IfqPXvfyfH/vk/S6Kq+krrnohXK8=;
        b=wq/CTtai+tj+0EA5/5tGDINFALVYjqHd5o9YDSqfsH+rL8wN0D5iHkYAuD2Awt2m+3
         sTSuStDx+HVDFbYqUE14wm28g33855ugCeNpCVEAfkWXLuqyxADHhI3CFmH+A2tV+hPc
         1NZJBHMEqWvPEqIRP7xWiPeLv7PwO/pq/X/z2epIq+edinej+x4sAqN0LYs16EIrUaB4
         xMDjJm42h08EKg2OT4pffOhaSbLa5x2sknySblsMLPd+/6Ut1r1jglilCpjQ8BxjX/D5
         i+eAmXiRRuwdRD9S9uaesuX4ZxIBDsK05jiTMeEaf2ghAfufnTMh2+EeAZ5mhOgih+3D
         Bebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jr85PqBhcGLPuS9IfqPXvfyfH/vk/S6Kq+krrnohXK8=;
        b=PtYYkdUduK2PMNNUrmcUpkmHQ/9S4kddqoQnMD73+ArJjkqB/8SxHWpsol1JdwsOuz
         zhn+m59G4a4Xur1sc3h3kUfTlApAHMq2lfrw3gZ5TGSg6JsWi3uSy4ofiCddqIijWFXI
         ro+unS3FBfA7KvAZTaXAt6jYUki7RZpKiTpLbcB4/zYaHphsKIFbaelwyBxX7JIHv7cc
         WhxDd6fNceRYe6h/0JA2lDRB6Z8YtaKhFOW7khskW9x9CycNsbN//aYAGJys84y6hlro
         ZtQPfgVXSkX3e4mHDNjeVY5ySR71MeMC0DSZnwsEHqKZ+nbvR9JOFEXUSecEJHFHOaKa
         /4ZA==
X-Gm-Message-State: APjAAAWzKsXwD6lk3zZBH+gY7q3I4IEwoMnsNIPgQ/n1XVqcUmF+wQs5
        7HpudV0k4T5P3xMl2kwXQn/7Hg==
X-Google-Smtp-Source: APXvYqyBmzH9tgnVO3ZeOVIRoAdUpntLskVDsijM/gPi3reuvy7Fv3R63Frl2E3e5wblRMK2F086iQ==
X-Received: by 2002:adf:f502:: with SMTP id q2mr17229425wro.186.1569930915902;
        Tue, 01 Oct 2019 04:55:15 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p85sm4052171wme.23.2019.10.01.04.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 04:55:15 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] dt-bindings: clk: axg-audio: add sm1 bindings
Date:   Tue,  1 Oct 2019 13:55:04 +0200
Message-Id: <20191001115511.17357-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001115511.17357-1-jbrunet@baylibre.com>
References: <20191001115511.17357-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible and clock ids of the sm1 audio clock controller

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/clock/amlogic,axg-audio-clkc.txt          |  3 ++-
 include/dt-bindings/clock/axg-audio-clkc.h             | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
index b3957d10d241..3a8948c04bc9 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
@@ -7,7 +7,8 @@ devices.
 Required Properties:
 
 - compatible	: should be "amlogic,axg-audio-clkc" for the A113X and A113D,
-		  "amlogic,g12a-audio-clkc" for G12A.
+		  "amlogic,g12a-audio-clkc" for G12A,
+		  "amlogic,sm1-audio-clkc" for S905X3.
 - reg		: physical base address of the clock controller and length of
 		  memory mapped region.
 - clocks	: a list of phandle + clock-specifier pairs for the clocks listed
diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindings/clock/axg-audio-clkc.h
index 75901c636893..f561f5c5ef8f 100644
--- a/include/dt-bindings/clock/axg-audio-clkc.h
+++ b/include/dt-bindings/clock/axg-audio-clkc.h
@@ -80,5 +80,15 @@
 #define AUD_CLKID_TDM_SCLK_PAD0		160
 #define AUD_CLKID_TDM_SCLK_PAD1		161
 #define AUD_CLKID_TDM_SCLK_PAD2		162
+#define AUD_CLKID_TOP			163
+#define AUD_CLKID_TORAM			164
+#define AUD_CLKID_EQDRC			165
+#define AUD_CLKID_RESAMPLE_B		166
+#define AUD_CLKID_TOVAD			167
+#define AUD_CLKID_LOCKER		168
+#define AUD_CLKID_SPDIFIN_LB		169
+#define AUD_CLKID_FRDDR_D		170
+#define AUD_CLKID_TODDR_D		171
+#define AUD_CLKID_LOOPBACK_B		172
 
 #endif /* __AXG_AUDIO_CLKC_BINDINGS_H */
-- 
2.21.0

