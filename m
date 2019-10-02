Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28857C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28B1218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b9E91j2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfJBJPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:15:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41126 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBJPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:15:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so18746500wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jr85PqBhcGLPuS9IfqPXvfyfH/vk/S6Kq+krrnohXK8=;
        b=b9E91j2tOGQa80OiDbPQZnp1ooHtiOfWBRpCp09EX6LbNb5gHKXXM3bJcvLmmGHzJm
         2hjBzxfvYCJzv5du2SdsDj3BkDJpw3SSmBx0xxtkT0uSibO7MfeQv4tKi5ZFVf/arAS/
         lSRMBDgX+BlxnsxXU8Be+xJ17IraB4IWK+1hNcZrj8/2tbQ02PuGU1ahPeR4SceY0i+1
         BxpBTdZPUeK2XhKWn9hcfayYDkjyv0BpvTW2lT23CYLjNwnek3vVnrAcbCFKtNAzLkkb
         XhvtWXr+ZjdjZMhd/YYi2jf46ptvH8vW6EjqYzlDQ+PKMY8ndnNyvcftmj4/do/E0GA/
         Yh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jr85PqBhcGLPuS9IfqPXvfyfH/vk/S6Kq+krrnohXK8=;
        b=NyLG6Yt1Tfy1E73uGDrw96TiP0oUwbDs+Hc8nYjN3yrlSWjNuhjuWjqhGiPWtsqeAk
         KoyxC8fCV+TESJP3M2poPozxJVDzItsgiXLv10a1kVnR4ArfRLr4YwRBzFsC22R9T/UH
         G9VIHhyUWxvOj46MqiUAetoij0rnDcYmOaU5NW/6nDCGSevZHoymjCmvu67HTAEQNfkF
         HAlbnJxzgXxtI2BFHpMMVPZAOCt32wVUT9+e6UuigDKwKSnUBxBgk0GIhm4J5XEoWaSJ
         QoEh1PfKjxHgwmtUCimq6461v8IWm9G3qsy+OjwLMgeBR+jBoBz+BIlmfbMi7TrEsmnj
         NeGQ==
X-Gm-Message-State: APjAAAUrMpPURtuz/ROB6VGw83x2nuCt7/7jVcEzNsrn62k7os+nQGMr
        qVmJzy8tvWyZVQ2XvELuzSVmhQ==
X-Google-Smtp-Source: APXvYqwKRhrOpTNo/XjxTlReO7lIbiWJmOmqE5Fky5rIUFB1VKrTGBOJpqMWNd1dHNrGCWAWnmvVJQ==
X-Received: by 2002:a05:6000:1046:: with SMTP id c6mr1996636wrx.189.1570007733410;
        Wed, 02 Oct 2019 02:15:33 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r13sm32913737wrn.0.2019.10.02.02.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:15:32 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] dt-bindings: clk: axg-audio: add sm1 bindings
Date:   Wed,  2 Oct 2019 11:15:23 +0200
Message-Id: <20191002091529.17112-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002091529.17112-1-jbrunet@baylibre.com>
References: <20191002091529.17112-1-jbrunet@baylibre.com>
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

