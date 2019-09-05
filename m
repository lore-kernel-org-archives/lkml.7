Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4C5C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89C92082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fH4pEpea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbfIENut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:50:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46810 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732027AbfIENur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:50:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so2863207wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOkiOZt6tUh2pBf+83UJHLS8/NEBh0SpKX8xW2sR6I8=;
        b=fH4pEpeaPpTrxdIDkiSAP9OKTD2gnJKXmbAKpvvII9xS2Nznc3fU+YM20p41PUEYe+
         lnHBqLCAEhGhMATXsFlBg68FRwmErAG45oEy23pNXPGEWUx+mgi7Ou1S9W6umUQXRsVP
         giArIRM9aRIjcnaYMi/ySdVB7dqtiCv4ynxgef4mMlDOhXK7bzHjaX/FxSo7Jw/ys1Ri
         QopSpJoTrn1RJa56eHCOBNb+cYWC+h1vo/ld+kUUXS+rDz4n+79vK2suGos3OR76s850
         xLi7W+kGTLNeqkEYDuoxqwBCeyLNrgvckStdj8N4dXiayVeg8uDYpCBByUME7dca5tAz
         /Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOkiOZt6tUh2pBf+83UJHLS8/NEBh0SpKX8xW2sR6I8=;
        b=O4fpg7A6j4ovSImI+aztenCwSg7Sn295G5qPivzY0A7ZWGLf0jZpnhrXC93pEZ1Mok
         /nH2EXVe8ZnJ37LLEjRsoMDh4Xfqs2o76xIcoVgIBkpj6OtWeS/75QqdQ/PmwGrm53F9
         a0jBgKI9o/O8Nzodm7IBn7/5yWzsWy0RVuz8n10P5l2XY7pi4koPcvKu/2jI5/w8Jg8o
         S6/8/YUxoJNCQgiguNcmMBeNCSOYBnISoB99/4DrseBEJm09ZOqan8MhIB44UyrWpIVt
         xBnnk1gyDiS31t1xd3p6lBQ/wuBAn8MLsA0WO2JXY/pyNjHTDvr629MQeqf4XaPmKJoS
         ZwOQ==
X-Gm-Message-State: APjAAAW1PvMJY1QSUUsrkcY+axD4/u0rDd7NcRPq/xG3gom3iGA8yRn6
        7R36uhUDhqqTZvjw/Dd5NHWIYJFus/4eHw==
X-Google-Smtp-Source: APXvYqxrzLFfHy7t4aRY1w5WOQmGxxUE0GDjUhQx/bqFaMS+KA7w/b2UxEzoERkiezkzLsGar0DCNg==
X-Received: by 2002:a5d:504d:: with SMTP id h13mr2746749wrt.342.1567691445811;
        Thu, 05 Sep 2019 06:50:45 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y3sm3324893wra.88.2019.09.05.06.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:50:44 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] reset: dt-bindings: meson: update arb bindings for sm1
Date:   Thu,  5 Sep 2019 15:50:39 +0200
Message-Id: <20190905135040.6635-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905135040.6635-1-jbrunet@baylibre.com>
References: <20190905135040.6635-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM1 SoC family adds two new audio FIFOs with the related arb reset lines

Reviewed-by: Rob Herring <robh@kernel.org>
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

