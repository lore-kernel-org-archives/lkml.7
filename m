Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0531EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C963D22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="skd+6wLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfHTJqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:46:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34454 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbfHTJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:46:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so11698323wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wu+Hc1WycBhYeKR1pHbRQ6nVmuPzQ42/00GPF9ACS0U=;
        b=skd+6wLZFaGGAnwwAVlawhB0YB3fgyzkrfNxyIbQmuSYzcxK1m5LRcV3YMhTHl6xnT
         WQqyOczqznGQEwtngKkgVihlcWs6C+BPd2XjqYCCBde1YcFH7Ju+HioxY4GbB/T3TldC
         4/mI7j1o3rv8VLZFhgDYPIHlj5zH/Wt0FcRcXvzoMYw0br9N/d/GrnjfUsUgFsJHpw4s
         1zOFffK4RCWzi2hPVSHMbacYWjw2IHnt56AP0qZnWpzopOBzLMlna1tkorQWvv817zOw
         g+PzR3AE/PwtO4klH7y1MkabhZFOhE5XHJsk02tpaym8JiNbkZx8t6dZxllpdtgfTp2/
         wI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wu+Hc1WycBhYeKR1pHbRQ6nVmuPzQ42/00GPF9ACS0U=;
        b=BlvRF1uMKtl9wucVzp6bqPnjUO5/8iENYMlufXBLYOHqJdq8uBraW3goq2dNvNWv/e
         mpaiwzj/5jD/22K6TTahrccgQwpJHUHX+XLFWAOP2wJe4JhHOqHyc5fIJ7KRiaAnKW55
         h6XA8GDbv/LLV+TysmjD+TRfzXJQpzR4lsTnOLypVIo99iXxD28M6xnLmMeoiEkn+bi/
         r1b7zwyaIqJnbY/LQMm83IGHh6fAQ0xfPWlQSM18gz/xwqmSJVwxNXZMLq4dO1sFwIV9
         QZzAaAsH67iA/pcWe/DWl1EXzvwtpN51kGa/B/DTb1hiRx1/g+XizRXSll0yS5jfmfDC
         30mg==
X-Gm-Message-State: APjAAAXVGTQ6Csm7+eltvGSKaP7/Ius1ftexhUoa5kQKpXsp125OccUk
        15VRN4Mr3m1OVbCldzSa+IEEiw==
X-Google-Smtp-Source: APXvYqys9kYkJyg6KnuwR/NfvkRSehLjMhdFPI1tUm2CTUkxzTfLEICnt5NyKEOMcUoSGn2YjsoEjw==
X-Received: by 2002:adf:f386:: with SMTP id m6mr32999738wro.313.1566294390507;
        Tue, 20 Aug 2019 02:46:30 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o17sm15958305wrx.60.2019.08.20.02.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:46:30 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] reset: dt-bindings: meson: update arb bindings for sm1
Date:   Tue, 20 Aug 2019 11:46:24 +0200
Message-Id: <20190820094625.13455-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820094625.13455-1-jbrunet@baylibre.com>
References: <20190820094625.13455-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM1 SoC family adds two new audio FIFOs with the related arb reset lines

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt  | 3 ++-
 include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h        | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
index 26e542eb96df..43e580ef64ba 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
@@ -4,7 +4,8 @@ The Amlogic Audio ARB is a simple device which enables or
 disables the access of Audio FIFOs to DDR on AXG based SoC.
 
 Required properties:
-- compatible: 'amlogic,meson-axg-audio-arb'
+- compatible: 'amlogic,meson-axg-audio-arb' or
+	      'amlogic,meson-sm1-audio-arb'
 - reg: physical base address of the controller and length of memory
        mapped region.
 - clocks: phandle to the fifo peripheral clock provided by the audio
diff --git a/include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h b/include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
index 05c36367875c..1ef807856cb8 100644
--- a/include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
+++ b/include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
@@ -13,5 +13,7 @@
 #define AXG_ARB_FRDDR_A	3
 #define AXG_ARB_FRDDR_B	4
 #define AXG_ARB_FRDDR_C	5
+#define AXG_ARB_TODDR_D	6
+#define AXG_ARB_FRDDR_D	7
 
 #endif /* _DT_BINDINGS_AMLOGIC_MESON_AXG_AUDIO_ARB_H */
-- 
2.21.0

