Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38160C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EBE21883
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KvoyxWVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbfIEMCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:02:04 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:34517 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388919AbfIEMBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:01:33 -0400
Received: by mail-wr1-f43.google.com with SMTP id s18so2472318wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JtJp8hwFJlC+ElDAvP+29EWq9+aj8xhCfyxpFjJGuMU=;
        b=KvoyxWVLk27MSxWet5eXVTEvqpz7OZQMYgLSKMOIRVRN8rsctD7bnPqdMwnLL3zfea
         F9a+I+VnlL2sjNeccOjyir/GffR3nHzT5+vvnS40miEitiIwqkwWFePtCCIQQe+6pGKS
         phg09gOPaLHtB62WhhzohCzkg6ZYAahehhGLmE1UqmkLWSecAcgvcHOUZ2AeMgEUfg7h
         pSxePwVlV20zeOmm+F3v5RlPjQSSF0OaJlZWhTzoptuJ27kovmuiQ9MFH+B98IzX6gWH
         Dp/KxNn2aUJZMh96iRGVoPVvSRBn1dVIRDwacVjbTBbNBKoodXk4z/k0x7sTcek7lcjl
         pgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JtJp8hwFJlC+ElDAvP+29EWq9+aj8xhCfyxpFjJGuMU=;
        b=ZwboyV0F3O8wvIeQmejwnw2Pz4LM6Vk8iFRifDiL2SPk9PHH5ydnigy8T1DJDJ6n70
         AqkMSaRB7A7SchPlpLvfcO8Mq7qJMZUUpTuFgI+UsuiZ8ynQD0+drx4Qoyn6MqSpr8D4
         ajZBalOc1h6Jj9PvIXKlz2HZ0UqEf7bUeGT6l+fuAN8907Ex3Emg0bwdsnHQ/8DOzSWG
         hBwFnBuoAgU1uoT9vAcqQ5jCSQKVE7G70hBgtsHXBOFH4OluVE4OXQ3R8C7D4NDt4Gsc
         uYDGBHPf8o0LJXBFD5SgyVb/9A7Wuw5lE3YItVKnwdiuEhBSfLZRV0nc4PsQZrgRK7Rn
         9PwQ==
X-Gm-Message-State: APjAAAURDPocXn0qOXS03GwBU1ln2XUuNuALEYuDJ//Nk7CjwRbexnZF
        GPO6cSc4c3AM1h3Z2eizNyjyrg==
X-Google-Smtp-Source: APXvYqww5BSzZzo/x/XBRxOD6dQ2QeJpWjyU0lTTUfZ8RlpNitNFN1NvIC/CeZ7zZgHLX/5AzWLHbQ==
X-Received: by 2002:adf:f543:: with SMTP id j3mr2444374wrp.243.1567684890446;
        Thu, 05 Sep 2019 05:01:30 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a18sm3436311wrh.25.2019.09.05.05.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 05:01:29 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/8] ASoC: meson: add reset binding
Date:   Thu,  5 Sep 2019 14:01:14 +0200
Message-Id: <20190905120120.31752-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905120120.31752-1-jbrunet@baylibre.com>
References: <20190905120120.31752-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The g12a audio subsystem, which is a derivative of the axg subsystem,
provides a dedicated reset line for each of the audio components.

The axg did not provide that and it is unclear if/when these reset are
required. The reset already helped solve a channel mapping issue on the
tdm formatter devices. Let's add the reset binding for the other
components, so we can describe this in DT. We'll use it later on
in the driver when/if needed.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt | 5 ++++-
 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt  | 3 +++
 .../devicetree/bindings/sound/amlogic,axg-spdifin.txt        | 3 +++
 .../devicetree/bindings/sound/amlogic,axg-spdifout.txt       | 3 +++
 .../devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt      | 2 ++
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
index 4b17073c8f8c..3080979350a0 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
@@ -12,7 +12,10 @@ Required properties:
 - interrupts: interrupt specifier for the fifo.
 - clocks: phandle to the fifo peripheral clock provided by the audio
 	  clock controller.
-- resets: phandle to memory ARB line provided by the arb reset controller.
+- resets: list of reset phandle, one for each entry reset-names.
+- reset-names: should contain the following:
+  * "arb" : memory ARB line (required)
+  * "rst" : dedicated device reset line (optional)
 - #sound-dai-cells: must be 0.
 
 Example of FRDDR A on the A113 SoC:
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
index b3f097976e6b..716878107a24 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
@@ -13,6 +13,9 @@ Required properties:
   * "sysclk" : dsp system clock
 - #sound-dai-cells: must be 0.
 
+Optional property:
+- resets: phandle to the dedicated reset line of the pdm input.
+
 Example of PDM on the A113 SoC:
 
 pdm: audio-controller@ff632000 {
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
index 62e5bca71664..df92a4ecf288 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
@@ -11,6 +11,9 @@ Required properties:
   * "refclk" : spdif input reference clock
 - #sound-dai-cells: must be 0.
 
+Optional property:
+- resets: phandle to the dedicated reset line of the spdif input.
+
 Example on the A113 SoC:
 
 spdifin: audio-controller@400 {
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
index d38aa35ec630..28381dd1f633 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
@@ -10,6 +10,9 @@ Required properties:
   * "mclk" : master clock
 - #sound-dai-cells: must be 0.
 
+Optional property:
+- resets: phandle to the dedicated reset line of the spdif output.
+
 Example on the A113 SoC:
 
 spdifout: audio-controller@480 {
diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
index 173a95045540..4e8cd7eb7cec 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
@@ -6,6 +6,7 @@ Required properties:
 - reg: physical base address of the controller and length of memory
        mapped region.
 - #sound-dai-cells: should be 1.
+- resets: phandle to the dedicated reset line of the hdmitx glue.
 
 Example on the S905X2 SoC:
 
@@ -13,6 +14,7 @@ tohdmitx: audio-controller@744 {
 	compatible = "amlogic,g12a-tohdmitx";
 	reg = <0x0 0x744 0x0 0x4>;
 	#sound-dai-cells = <1>;
+	resets = <&clkc_audio AUD_RESET_TOHDMITX>;
 };
 
 Example of an 'amlogic,axg-sound-card':
-- 
2.21.0

