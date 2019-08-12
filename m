Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F38C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67212216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XpYjyWdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfHLMdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:33:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40924 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfHLMdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:33:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so5311474wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plGjGyOid1jI+Xxis9Als2EenBhEyLHhPcpZxpUYN30=;
        b=XpYjyWdYBPsfSVDPqs6fexsdgC4vL2x6VRpB6oaxOfECc6Mn2cmm6J/8mSgqpaawLe
         W3P/RY77ybPvnTPMIxOq36v5XwRau6gkHfMlvDqV72+eqoIJVPF6kHoIDGvFiIOBCqDA
         zw0YxxmmDvx0T4x+sVAPSCxL2aVRncYaifq4S63oRnyjBD7JRlN9bVz0hjexlWe+qx92
         8PRyRwf6GVeu2i9C7D9nnDbyh+jNo1l8Ea6i7jHkuXCWjk/pATBN+CqJjI+JIesAcHS7
         zdCym0I/xWqggw9bfpyyXbyqvbiSNRMSASOmfrZgwWBHHxfzbvOBKjjiZ60JUQgXmSQJ
         GKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plGjGyOid1jI+Xxis9Als2EenBhEyLHhPcpZxpUYN30=;
        b=MWviTWcpGO+7sy0tVwRMcEcvEkeLc+4GITuU//oQsoZeTb9lqOwjyy48U3k+gH3Vlc
         pFKtpPEdVcmnC887rnD1jzRkOdGE5dVdxR4pzKfR4sVtS45uwE9IAm92L9APhCcH0ZdQ
         i55BMMxHntghbZx8tYufmkWCm0NRdoVcB8nXTDRwL3jKgQH1jv4Er9J8QXEM97bs7Mio
         jrOhlaENL4ek81mreXUY4JnxI0Marmu79kdZ6qapabYAHV+5nBxlfRqhLhrr2HhSZMN0
         xaj1Eis9tQ44J+pjfpZBe7qnTopV2JubNUzhc7ZE6Zhmo02Od8Tsxd64frPQB9JEDMcZ
         IwpQ==
X-Gm-Message-State: APjAAAW/g3KxdmnE1LKjtAXrdQiwZUS/s++/9rr0XWsnKmfpVKMJ6X4X
        uWnSlOJWwk1GyZY111Y2nSykVg==
X-Google-Smtp-Source: APXvYqzHIX4tNNjkOMLzgNZUMPelibgCS0O7pJpM5ShGJto2BBvnGspYwSkJjUPqNI0ReZ/bAsYCEw==
X-Received: by 2002:adf:9484:: with SMTP id 4mr13629346wrr.14.1565613178522;
        Mon, 12 Aug 2019 05:32:58 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z6sm15886432wre.76.2019.08.12.05.32.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:32:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: clock: meson: add resets to the audio clock controller
Date:   Mon, 12 Aug 2019 14:32:52 +0200
Message-Id: <20190812123253.4734-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812123253.4734-1-jbrunet@baylibre.com>
References: <20190812123253.4734-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the documentation and bindings for the resets provided by the g12a
audio clock controller

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/clock/amlogic,axg-audio-clkc.txt |  1 +
 .../reset/amlogic,meson-g12a-audio-reset.h    | 38 +++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
index 0f777749f4f1..b3957d10d241 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
@@ -22,6 +22,7 @@ Required Properties:
 				       components.
 - resets	: phandle of the internal reset line
 - #clock-cells	: should be 1.
+- #reset-cells  : should be 1 on the g12a (and following) soc family
 
 Each clock is assigned an identifier and client nodes can use this identifier
 to specify the clock which they consume. All available clocks are defined as
diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
new file mode 100644
index 000000000000..14b78dabed0e
--- /dev/null
+++ b/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_MESON_G12A_AUDIO_RESET_H
+#define _DT_BINDINGS_AMLOGIC_MESON_G12A_AUDIO_RESET_H
+
+#define AUD_RESET_PDM		0
+#define AUD_RESET_TDMIN_A	1
+#define AUD_RESET_TDMIN_B	2
+#define AUD_RESET_TDMIN_C	3
+#define AUD_RESET_TDMIN_LB	4
+#define AUD_RESET_LOOPBACK	5
+#define AUD_RESET_TODDR_A	6
+#define AUD_RESET_TODDR_B	7
+#define AUD_RESET_TODDR_C	8
+#define AUD_RESET_FRDDR_A	9
+#define AUD_RESET_FRDDR_B	10
+#define AUD_RESET_FRDDR_C	11
+#define AUD_RESET_TDMOUT_A	12
+#define AUD_RESET_TDMOUT_B	13
+#define AUD_RESET_TDMOUT_C	14
+#define AUD_RESET_SPDIFOUT	15
+#define AUD_RESET_SPDIFOUT_B	16
+#define AUD_RESET_SPDIFIN	17
+#define AUD_RESET_EQDRC		18
+#define AUD_RESET_RESAMPLE	19
+#define AUD_RESET_DDRARB	20
+#define AUD_RESET_POWDET	21
+#define AUD_RESET_TORAM		22
+#define AUD_RESET_TOACODEC	23
+#define AUD_RESET_TOHDMITX	24
+#define AUD_RESET_CLKTREE	25
+
+#endif
-- 
2.21.0

