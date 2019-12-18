Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8B6C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C882146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Aq11DQQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfLRRYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:24:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46212 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfLRRYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:24:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so3125863wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tSV0U+WsxMuhIA7h8z+p35tUgb5H1eC3kU9lrnCcoSE=;
        b=Aq11DQQzGzUVMcpWF0JLC2YC8sZjcaX3sfuiLmMCNRh+4c7+JI34s4KpbzVuBJAHhU
         h5+qSCTuVinAqS2kS5fTfta1r86RCr1OoBFcIbsSOYGA4dTisxrZ67amFumwgvYNMu6i
         PNay5IKLqsKRt2sGA5KLjCcDNArAXPXSwVMKRQXPVctl7oH0fH08hM2qFAQUmhE4ycgT
         8gScSfV2FbRmb5BcHVFOFtO0xdqNAM46Z9Uyz4CjV38JT4PmakxTTk5RfsutAf472msv
         9d6kV3z6w/sM6/o1V7cJsXSmXmAmxw6tLaFTekzis8EWAKgU8DoTZVv+vU52P4vvqOh5
         L9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tSV0U+WsxMuhIA7h8z+p35tUgb5H1eC3kU9lrnCcoSE=;
        b=bkuFOXoTNIqN6tUCukv4LQCsPmJvGzyQx2RM7G0YPTB4eICYmCPRMpCFBugqOsuWN2
         EH+2yrxmLINL9br6JJEHaIVCAFkqt1aePvI+31Rk5gncgxUDND/wa59KyACFKI4yHV4k
         iW3d8ax6S/aoe9sHTTC/GieOOdzVced8BkTr0YWhxGF6YxB+4cCCEXKy7XaoIJrOUqew
         Z2Ax8MvVEFx0AoLhQ2nQDIn+Nfv+9fPHZ7AUWz6GidyL7q7LY9CI2M/k2LTev8kpTkGZ
         Jgg0w9yrQ7rO6tKqLl9kybnxomMhHraCgwpI00XhhdcAIsOwdB/jFxmPopY3qENp4RDk
         zaAg==
X-Gm-Message-State: APjAAAWenOB44Wg7Fhu5Hf0c6tfDWoxZ99h7h1d31WZBD1IFhD9rq68d
        BhSMsIRcCZx7LywB6P14qb8PLw==
X-Google-Smtp-Source: APXvYqzR3OHiC1qb2gmKaVTY+JWZnRqg1+/NxiFB3m8W82gVRRtbYJi73MwFBkCdV+TgNGVWs/ce9Q==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr4149822wrn.50.1576689869279;
        Wed, 18 Dec 2019 09:24:29 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id 4sm2883231wmg.22.2019.12.18.09.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:24:28 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/4] ASoC: meson: axg-fifo: add fifo depth to the bindings documentation
Date:   Wed, 18 Dec 2019 18:24:18 +0100
Message-Id: <20191218172420.1199117-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191218172420.1199117-1-jbrunet@baylibre.com>
References: <20191218172420.1199117-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new property with the depth of the fifo in bytes. This is useful
since some instance of the fifo, even on the same SoC, may have different
depth. The depth is useful is set some parameters of the fifo.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
index 3080979350a0..fa4545ed81ca 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
@@ -17,6 +17,9 @@ Required properties:
   * "arb" : memory ARB line (required)
   * "rst" : dedicated device reset line (optional)
 - #sound-dai-cells: must be 0.
+- amlogic,fifo-depth: The size of the controller's fifo in bytes. This
+  		      is useful for determining certain configuration such
+		      as the flush threshold of the fifo
 
 Example of FRDDR A on the A113 SoC:
 
@@ -27,4 +30,5 @@ frddr_a: audio-controller@1c0 {
 	interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
 	clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
 	resets = <&arb AXG_ARB_FRDDR_A>;
+	fifo-depth = <512>;
 };
-- 
2.23.0

