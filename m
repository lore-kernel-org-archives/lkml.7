Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B58EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C66022CF5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i4HxGKUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbfIEMBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:01:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56190 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387775AbfIEMBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:01:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id g207so2467710wmg.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frXECa7oB40w9WZ9n2ecYzcH89/QDSFs1zSP6u+7Qvk=;
        b=i4HxGKUMtgFYoZ5e+oi5v+JhlTAUa42yN4QdLJHfvLUZyZvd+x6GDzYM8VAmo50xRn
         NRMPhKfVV9dJhhrhUxM7Hvq7YhR7+HCGoqV4SpkB/isItxpnJHFjtG0ttT1tIS8JU9MJ
         I9/XLbDxxTLI2rNtvYwbXmiYZUqfHX6W0Jef+ZURbKfOnjNzZ3Hyhz84kw7aOrlv5Fiu
         Q0EseEc5xuJHTwMboJ5tDsZhWWE7ASGCU83RjCI5yHIGLO6CUFH9ofQTFDij2KaSdHUl
         sVwcbhWVPWSyyZWejd9g2GuqseEp2/FRfl17WRUgI3ZwWeQtFupyorp5d1hIoBQaRfVv
         hm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frXECa7oB40w9WZ9n2ecYzcH89/QDSFs1zSP6u+7Qvk=;
        b=jsCW2zZmB+3FlEkEzdVNu8U0NTj2Lpq7DXrIDX/ir7EtID0LZ0UxNpZ4awz5HgolHY
         yWH32i6J9nsk4Rc+rR7ufJRNPcOYMT40l0kPeA9PKzv9nISQtaVYAlkreBx/SvLQMnff
         PAQGBLKtcur0Rom4c2ZxzGui5hxu0/NsVKajje3Wcieu+JTMocHubA8g49qHwHsFR0CB
         DVtNdk8xERZAmlqlaQW5nk34S00iOrGB/7XmUF4Q2ChLnB4o14ov0N4GssiuKl9E42yw
         3HMqb8xpi9GQj/Zng9WYKTte7xfZcKVbJQ6ZW2DpYC4Q4a1KJev3FiTyHELrGmfPlKH/
         jFHQ==
X-Gm-Message-State: APjAAAWGLXNCk+zF/HLnpZDAVLJo6JsuzyWsiY5WKvhJC9SqFBfADS6M
        eUwMrguqaePawlHEumS7uo60eg==
X-Google-Smtp-Source: APXvYqxA/Q9whlszOMfcSkbW9Mrtlo0RubDAdo+i8gx27YCkWw9SpbgHeHqvHsmJM0vvSdovJDDBnA==
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr2422292wmj.74.1567684889405;
        Thu, 05 Sep 2019 05:01:29 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a18sm3436311wrh.25.2019.09.05.05.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 05:01:28 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 1/8] ASoC: meson: add sm1 compatibles
Date:   Thu,  5 Sep 2019 14:01:13 +0200
Message-Id: <20190905120120.31752-2-jbrunet@baylibre.com>
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

Document the compatible strings of the audio devices of the sm1 SoC
family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt  | 4 +++-
 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt   | 3 ++-
 .../devicetree/bindings/sound/amlogic,axg-spdifin.txt         | 3 ++-
 .../devicetree/bindings/sound/amlogic,axg-spdifout.txt        | 3 ++-
 .../devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt  | 4 +++-
 .../devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt       | 3 ++-
 6 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
index 4330fc9dca6d..4b17073c8f8c 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
@@ -4,7 +4,9 @@ Required properties:
 - compatible: 'amlogic,axg-toddr' or
 	      'amlogic,axg-toddr' or
 	      'amlogic,g12a-frddr' or
-	      'amlogic,g12a-toddr'
+	      'amlogic,g12a-toddr' or
+	      'amlogic,sm1-frddr' or
+	      'amlogic,sm1-toddr'
 - reg: physical base address of the controller and length of memory
        mapped region.
 - interrupts: interrupt specifier for the fifo.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
index 73f473a9365f..b3f097976e6b 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
@@ -2,7 +2,8 @@
 
 Required properties:
 - compatible: 'amlogic,axg-pdm' or
-	      'amlogic,g12a-pdm'
+	      'amlogic,g12a-pdm' or
+	      'amlogic,sm1-pdm'
 - reg: physical base address of the controller and length of memory
        mapped region.
 - clocks: list of clock phandle, one for each entry clock-names.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
index 0b82504fa419..62e5bca71664 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
@@ -2,7 +2,8 @@
 
 Required properties:
 - compatible: 'amlogic,axg-spdifin' or
-	      'amlogic,g12a-spdifin'
+	      'amlogic,g12a-spdifin' or
+	      'amlogic,sm1-spdifin'
 - interrupts: interrupt specifier for the spdif input.
 - clocks: list of clock phandle, one for each entry clock-names.
 - clock-names: should contain the following:
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
index 826152730508..d38aa35ec630 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
@@ -2,7 +2,8 @@
 
 Required properties:
 - compatible: 'amlogic,axg-spdifout' or
-	      'amlogic,g12a-spdifout'
+	      'amlogic,g12a-spdifout' or
+	      'amlogic,sm1-spdifout'
 - clocks: list of clock phandle, one for each entry clock-names.
 - clock-names: should contain the following:
   * "pclk" : peripheral clock.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
index 8835a43edfbb..5996c0cd89c2 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
@@ -4,7 +4,9 @@ Required properties:
 - compatible: 'amlogic,axg-tdmin' or
 	      'amlogic,axg-tdmout' or
 	      'amlogic,g12a-tdmin' or
-	      'amlogic,g12a-tdmout'
+	      'amlogic,g12a-tdmout' or
+	      'amlogic,sm1-tdmin' or
+	      'amlogic,sm1-tdmout
 - reg: physical base address of the controller and length of memory
        mapped region.
 - clocks: list of clock phandle, one for each entry clock-names.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
index aa6c35570d31..173a95045540 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
@@ -1,7 +1,8 @@
 * Amlogic HDMI Tx control glue
 
 Required properties:
-- compatible: "amlogic,g12a-tohdmitx"
+- compatible: "amlogic,g12a-tohdmitx" or
+	      "amlogic,sm1-tohdmitx"
 - reg: physical base address of the controller and length of memory
        mapped region.
 - #sound-dai-cells: should be 1.
-- 
2.21.0

