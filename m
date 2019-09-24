Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47F8C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE1E20665
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IwL+hTlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390000AbfIXPeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:34:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34904 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389843AbfIXPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:34:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so575640wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 08:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwFyXGBqFYuC/YIQ48LJbHRdAjX7P5PZkteQ+2xVhOw=;
        b=IwL+hTlRWqUjdAXdcuQwYePG18rcM/tDvvnrZiseWHuBOGL1ziNS5lPODy1pd0AIKd
         Re1CE5+HhGzrPRRCDiXbGKnvZNz7d2F2COSpFwxTp2rW/AS59ZKtxtj++NWpS/kv5P20
         gF30NCWIrE5aM9IipkS26V0RuWHriDXgF+wXeumjxADKxYPa8lv9kUfM3aJezJxEXaNG
         /CWf5UW5CNC/DoxriBzwI2YnxJWnJu8NC10mzqYUiDKi2RuofyIECfHx0/Tsh1f7s3Yt
         hsK4484mZfZz39MsAaPLf5YYr0wGNVlLDworXDOnLTqYYwWfifmVZQJdytpn2RPnunhk
         ZDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwFyXGBqFYuC/YIQ48LJbHRdAjX7P5PZkteQ+2xVhOw=;
        b=R86qaNE9HAPSG3ufTk2Y6k/kSkmuiSgJWmhw6b8ld5Qxu/ZP9EvoN/KIf0qwc2CsFl
         3zyOL2zAP5/bov/C6qErCN3JqKtseMuQ0+pvFRDJSFQ8CIsAQ/DDYaC09I8o5bv4stMM
         xeUBTOOYCovR0HFxyYdFUfC5cGAT5s7988YI3TIxXs0xHkyY332vOlh3StbzpM93NCZf
         2UYfnZArhfjwwXp2DJGQ5wbH9DnutNxXAyFEQhIipcIwcv5IOf589TfNZVQRY/QPTzmf
         tIj8EJODydBOXKZY0o+oGw6ZBEHmaG6LYrmbRltkUoizLnmQD+1Ou9v8nfHq+twY4Hn9
         1O8A==
X-Gm-Message-State: APjAAAVPhXDt6NU/16dRZUp9g3hZvO3puO3fLEwqKmpjrmrmUYGQEleD
        t3omekwzwea96Kwt6ZZe9CX+iw==
X-Google-Smtp-Source: APXvYqwKFyuwn8czPB//lYXxUKAhousEX+yuI/rd1uOvk1eQoXayPQmUcJGYjHQv1woPvN4u/0mjsA==
X-Received: by 2002:a7b:c451:: with SMTP id l17mr655496wmi.61.1569339241629;
        Tue, 24 Sep 2019 08:34:01 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d10sm144240wma.42.2019.09.24.08.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 08:34:00 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: clk: axg-audio: add sm1 bindings
Date:   Tue, 24 Sep 2019 17:33:50 +0200
Message-Id: <20190924153356.24103-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924153356.24103-1-jbrunet@baylibre.com>
References: <20190924153356.24103-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible and clock ids of the sm1 audio clock controller

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

