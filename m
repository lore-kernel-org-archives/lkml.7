Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3D6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D0623407
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WoMSFH+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfH1OSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:18:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52467 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfH1OSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:18:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id t17so256908wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcL3AvqHT7bRzBjlZdaYirVmcHrrTcNQrMrMxpM5Yus=;
        b=WoMSFH+jbYdpYIJW/cgs8flobaRwChKfAONQD4wALEJE4gjSTlGakMSVfTGQDWzyV1
         9rXkwTT5x8+p/jqtsNQq/CI6RgWtLm0uAPtYiaQasGq6yOm6HR+GcHa/TeY97+4J5u6J
         /p+vB2taIXzf7Uuuz10JcpYmv5J6FJ7IeI/ye2w5TOHnhLqJ/NJyhU67GOquPMYWNZPO
         BS9qD7I7a4hyiWR7DiY+U+X8DK8PRSm/gNWUNECJXfVFX0jUVTyTyiQlaxsf3a+enRkq
         D2X82syf5DJtvmSeJydBaMGuD1AbP0YRdlUQeNf0y7wofl19LBruc8DtHC7oN5vd2kGC
         ivgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcL3AvqHT7bRzBjlZdaYirVmcHrrTcNQrMrMxpM5Yus=;
        b=B5TYXcxdFVf1uZ18ni3dYDJD19EyRCYnZocXqkv4Tpa9oMmqg2gnhnoZsO4BfLNQto
         7Bu24ve/T0jT382AYEW9PceWZm6sbtO3CdC2CjOtUJ87JbnQhSQaHeROIIvav9orwjNk
         cTwpx04WWYkTlklFXnrF7qzJeYE6h3h2BhANIk8zohKpbzBa8MIDQhkfScAZYzlFAD2X
         4Iqw0DmhlYsKnUM4e6v4uhBe6eHx2GuXPioeMvU5Wvb+bIQ/UHiVqYS1Kf7/LDEMfAAl
         HJDVA1LtblY6kThreWn+CkzOt5cs1LYiayyr7knfVF/cTP20ioIb3jrojt2c+A9H6Y0K
         3wfA==
X-Gm-Message-State: APjAAAVmlpDmx9b+CaMy4k9VkyW6mTgHWQp4XfXFK5gvj98qdhawwZuW
        AvpT96TEBdL4xWvKbGk0QrEs63M4xVTa7A==
X-Google-Smtp-Source: APXvYqwn1R9gYJiKlQU8k/I2epaSnpNLgXrnH+gfIwXHbGoEEGtTexblMHvFit2KgcvAsHLnTvr1Sg==
X-Received: by 2002:a05:600c:2487:: with SMTP id 7mr5302979wms.141.1567001900084;
        Wed, 28 Aug 2019 07:18:20 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u8sm3022354wmj.3.2019.08.28.07.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 07:18:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: arm: amlogic: add Amlogic SM1 based Khadas VIM3L bindings
Date:   Wed, 28 Aug 2019 16:18:15 +0200
Message-Id: <20190828141816.16328-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190828141816.16328-1-narmstrong@baylibre.com>
References: <20190828141816.16328-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Khadas VIM3 is also available as VIM3L with the Pin-to-pin compatible
Amlogic SM1 SoC in the S905D3 variant package.

Change the description to match the S905X3/D3/Y3 variants like the G12A
description, and add the khadas,vim3l compatible.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b48ea1e4913a..99015cef8bb1 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -150,9 +150,10 @@ properties:
           - const: amlogic,s922x
           - const: amlogic,g12b
 
-      - description: Boards with the Amlogic Meson SM1 S905X3 SoC
+      - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
         items:
           - enum:
               - seirobotics,sei610
+              - khadas,vim3l
           - const: amlogic,sm1
 ...
-- 
2.22.0

