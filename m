Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41521C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C51B20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IlCQxrhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfDDLRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:17:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34277 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbfDDLRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:17:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so3308923wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THvGG4Utk/yOwuQrm+R95dAZZj74janifYZa4/M9XJQ=;
        b=IlCQxrhQiFzp0pFJ/mN+j38HrpoPXfY9hI+kbZNIqGDS2UyzPLqUWKXh5o7IkWcFrH
         M/oHchaABXJb/6sak+Bes+NL1fXHsI8dDFNnkg6sjI/jU2zAPqYMY83d1/CsFeGql1V8
         lvEr9Pq8gvjhtcoJ8rtBMs5ANcsGrOfK59jmEDUPIS9QNtoqaJAMLN+bu44DVISE3qfp
         fKspSnM4K/JN9cbRlfP9S+hD3ARAgNA7aiHgcSRcy8zlA8KpOm6pxVximGe5kAdjL5NG
         ZOULw+rKsRbcJXtq2t6jdczacGpAZEHCYMhUf3kZnzCw59UeL+xZ9OWaZNDZdPzPW6e5
         dy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THvGG4Utk/yOwuQrm+R95dAZZj74janifYZa4/M9XJQ=;
        b=E7ZigIkGDtgYvsIuHJ/5bwsSbnKPTNwTvFJpXuDb4k93ncI19CMEwUlRN88PAyvhMq
         cTg+vqRiAQbN1xvvTCSSAlIu26WnOM66yak1cV+eW/wboo6Zy4CrL/BjKe7wME271N6G
         +OEemyIw/5oUt9kPscwXcK4EOw0cY6yjS6T4qFRtOKIaE/YyTqjIZpHezsXlS6RLi+ev
         rpxKLu3LLN2OmkSkr87IxxHKbA3fJ8QwUzyQinu80mqlcVhuxE0JWT3UyrIIYWIkfWir
         NsQfWyvfeupP4A+gmNZkunTXlnxbiJ+kHwPPTA9btF8zE6kj0jlez9rW/kOEUTezks6F
         MOVg==
X-Gm-Message-State: APjAAAWY/ygLdW/SWlt6H7O46ZYQC4iepYwEVXDJ12rJ9zvS0assVRwd
        U2FTuNITvwu8HcJwiqzI0qsD1g==
X-Google-Smtp-Source: APXvYqyZVrHLXXlnXSB+vYPXcp7Q9YJaa352Ul3dd0qE/uG0Kg30TmP1XfxKVrCszoObVeuWJwwOKw==
X-Received: by 2002:adf:e602:: with SMTP id p2mr3474242wrm.105.1554376666071;
        Thu, 04 Apr 2019 04:17:46 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id z23sm9024771wma.0.2019.04.04.04.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 04:17:45 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 1/6] ASoC: meson: add g12a compatibles
Date:   Thu,  4 Apr 2019 13:17:28 +0200
Message-Id: <20190404111733.28705-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404111733.28705-1-jbrunet@baylibre.com>
References: <20190404111733.28705-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible strings for the g12a devices.
Audio wise, the g12a is fairly to close to the axg, yet some differences
need to be handled.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt  | 4 +++-
 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt   | 3 ++-
 .../devicetree/bindings/sound/amlogic,axg-spdifin.txt         | 3 ++-
 .../devicetree/bindings/sound/amlogic,axg-spdifout.txt        | 3 ++-
 .../devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt  | 4 +++-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
index 3dfc2515e5c6..4330fc9dca6d 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
@@ -2,7 +2,9 @@
 
 Required properties:
 - compatible: 'amlogic,axg-toddr' or
-	      'amlogic,axg-frddr'
+	      'amlogic,axg-toddr' or
+	      'amlogic,g12a-frddr' or
+	      'amlogic,g12a-toddr'
 - reg: physical base address of the controller and length of memory
        mapped region.
 - interrupts: interrupt specifier for the fifo.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
index 5672d0bc5b16..73f473a9365f 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
@@ -1,7 +1,8 @@
 * Amlogic Audio PDM input
 
 Required properties:
-- compatible: 'amlogic,axg-pdm'
+- compatible: 'amlogic,axg-pdm' or
+	      'amlogic,g12a-pdm'
 - reg: physical base address of the controller and length of memory
        mapped region.
 - clocks: list of clock phandle, one for each entry clock-names.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
index 2e6cb7d9b202..0b82504fa419 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
@@ -1,7 +1,8 @@
 * Amlogic Audio SPDIF Input
 
 Required properties:
-- compatible: 'amlogic,axg-spdifin'
+- compatible: 'amlogic,axg-spdifin' or
+	      'amlogic,g12a-spdifin'
 - interrupts: interrupt specifier for the spdif input.
 - clocks: list of clock phandle, one for each entry clock-names.
 - clock-names: should contain the following:
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
index 521c38ad89e7..826152730508 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
@@ -1,7 +1,8 @@
 * Amlogic Audio SPDIF Output
 
 Required properties:
-- compatible: 'amlogic,axg-spdifout'
+- compatible: 'amlogic,axg-spdifout' or
+	      'amlogic,g12a-spdifout'
 - clocks: list of clock phandle, one for each entry clock-names.
 - clock-names: should contain the following:
   * "pclk" : peripheral clock.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
index 1c1b7490554e..3b94a715a0b9 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
@@ -2,7 +2,9 @@
 
 Required properties:
 - compatible: 'amlogic,axg-tdmin' or
-	      'amlogic,axg-tdmout'
+	      'amlogic,axg-tdmout' or
+	      'amlogic,g12a-tdmin' or
+	      'amlogic,g12a-tdmout'
 - reg: physical base address of the controller and length of memory
        mapped region.
 - clocks: list of clock phandle, one for each entry clock-names.
-- 
2.20.1

