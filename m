Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02235C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BEB20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCYqXx36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfDWC0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:26:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43494 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbfDWC0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 22:26:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so6629452pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 19:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gASq3fDuMs0vNSJwTjZaOrSujM7fxO1Yz4CvMFkoEJ8=;
        b=iCYqXx36jkAyFd9ij8v0sRLq374JRNRE8B4Vhjp5QBX0wvx6ZfyP0Cs0x8Re0rviaN
         GqYIWv5GBdszkjTBYN8oVHxCsvtoqbu5+iEIQLiqJrLIDaexKlzL6mRsJ/ftRrTrn+Ew
         SFeOEWevFR2VzkHx1TgabdQPxfD+XiZXfYS5tn8PcbOaRz2Gy6yQuikLhF4WTt5k/Ivc
         DOSjyDZ7BZTK1JyqHozphZ/kUJwfBb3eX0F42TGlKp61njikMV89Tlw4l3uu/wOwz1bh
         4hTvwN6XWKZW6cyILYDwDC0af4XyxVI7a+5S2kV5CIUi1LM+2eW+F58RJYNWk3+tI8Rf
         AcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gASq3fDuMs0vNSJwTjZaOrSujM7fxO1Yz4CvMFkoEJ8=;
        b=Byx3thppkObG28BPbhzEyLke/lXLDRRMTTl8J0rkA7UzUTnIiCqLvkxvgkcCQS6Y7f
         28t+vUbxOVG7Ix9HwAtfffrH+xyoG/aiq+07m3nL4k85G2yxLHCQ7GZDhj2V681TQABi
         3mxKPeAaGBg256kbWVlAiIe0OuhDc6QpeCCOAz+1b6isCsj52DDSgRmrC+J6iT+OK+ID
         etlT8/ygDyu1GLe1vYDC9/bgMZb2nCosj7ZTTqKfZU75hyQxFgy885Ga6Jwrqu2Ffe6h
         A1O5a8kd2ckmTrpTRBO4OojD/+qxuQEQXYvXfOeOlmdwZ+P3dnyK5symXbERJUWib1Ht
         5ySg==
X-Gm-Message-State: APjAAAXGHTf77OtRkYLC645fVHWzoLFy7DGA8proSZP88JAYxKF2KHf9
        lEjCibi3UtkI4id/6cDzq96xag==
X-Google-Smtp-Source: APXvYqzd+6Rz44lnMs0lPc5HWEvvP2fnwZEERIXT1ZcpDnFtC1zT8zJUoi6k6uJC4et996PGZafC2A==
X-Received: by 2002:a63:4c26:: with SMTP id z38mr22609786pga.425.1555986394820;
        Mon, 22 Apr 2019 19:26:34 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d25sm18874024pfn.154.2019.04.22.19.26.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Apr 2019 19:26:34 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        robh+dt@kernel.org, mark.rutland@arm.com, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        baolin.wang@linaro.org, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: ASoC: Add Spreadtrum multi-channel data transfer support
Date:   Tue, 23 Apr 2019 10:26:21 +0800
Message-Id: <fd223d1dcf5be1f83863e881fa3db931b5c84601.1555917711.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Spreadtrum platform, the audio subsystem will use the multi-channel
data transfer controller to transfer sound stream between audio subsystem
and other AP/CP subsystem.

It can support 10 DAC channel and 10 ADC channel, and each channel has
512 bytes depth data fifo. Moreover each channel can be used DMA mode
or interrupt mode to transfer data.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Move the documentation into sound/.
---
 .../devicetree/bindings/sound/sprd-mcdt.txt        |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sprd-mcdt.txt

diff --git a/Documentation/devicetree/bindings/sound/sprd-mcdt.txt b/Documentation/devicetree/bindings/sound/sprd-mcdt.txt
new file mode 100644
index 0000000..274ba0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sprd-mcdt.txt
@@ -0,0 +1,19 @@
+Spreadtrum Multi-Channel Data Transfer Binding
+
+The Multi-channel data transfer controller is used for sound stream
+transmission between audio subsystem and other AP/CP subsystem. It
+supports 10 DAC channel and 10 ADC channel, and each channel can be
+configured with DMA mode or interrupt mode.
+
+Required properties:
+- compatible: Should be "sprd,sc9860-mcdt".
+- reg: Should contain registers address and length.
+- interrupts: Should contain one interrupt shared by all channel.
+
+Example:
+
+mcdt@41490000 {
+	compatible = "sprd,sc9860-mcdt";
+	reg = <0 0x41490000 0 0x170>;
+	interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
1.7.9.5

