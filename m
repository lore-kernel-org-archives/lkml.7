Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6743BC33C9C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B8A2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gYhCPNg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKUKOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:14:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40551 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKUKOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:14:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id y5so2983366wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FduBAwwMEHW84QfHh6b1tdX58pVww+y/7cRWB+UMkbY=;
        b=gYhCPNg9B4NLAQ6K7VLo0nzzDQaInJM7Hf864FAuXqZfI2Jc1yLh9PMQiTaLmNB+mV
         EqT7xwT8uNA1ntizSXNTpAnY/17baf4nfFyRH1jHSYu4nNpsy0nZ/rWyrX4HbdwvXqLM
         sH6VOkZNct+q1ZT2V5TDE1zLeVuuGlrzP3CCifoDSNgCrhVNyHOgs4w9VaL6jdFATevZ
         BkYePMw7gyVJ62maxFfsNFBQiRdxH5VZGKPaAqU527vISy8VTa1HYfES4DwNdbGutEe1
         /QMpVdOXWkV0U48snGckdcUmiuUye7GRqbqyM+Nq4K1NBdj2P9nb6OBH46AZ3hvYi4PR
         en9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FduBAwwMEHW84QfHh6b1tdX58pVww+y/7cRWB+UMkbY=;
        b=Tso0/mmdj6/X+px5APXxj0KgdwWVdIZ9UAMmHm5TQgsMegPhTn+IBBJL8UcM8Mrev0
         pkHSpa5yN+pI8FLftVT97U5HJG401l4096gHjjoK9+MVbrThijzq8Fd7ggxmmE/R8vx4
         L7gVFM6fec5G9jzLHZevmfIHSr/L+vtHIE5P74e6PpgVugJQDjmtDJI3ge2YEyUDutBz
         OjIw9GU2P40G/9x9or8ZKNs9GylG69J7v4cUPJGahYZ3xXTltT5iBTHeyd6iK+MMNVAs
         eKL9cxH8hR6pWP77l450BYVGkvXtu9xKs3hNk/TAziIKdvYl/qt+PEXGdjoHsY/iqWTj
         zItQ==
X-Gm-Message-State: APjAAAUbz2lMbEJUMlRMglAT6LqHTN7Rs0k1v9UhqpDZT6qBs9siBY1h
        3RYg1rH74hhLoghmhGHMnlg5aw==
X-Google-Smtp-Source: APXvYqzdsV8tU3MpgnNLOKLPCEPdCdfdteZK2zsom+LUvNxzOUhXlYOv4B+zASrT6qXl8f+2fDeuiA==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr8886475wmk.155.1574331272221;
        Thu, 21 Nov 2019 02:14:32 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o21sm1289932wmc.17.2019.11.21.02.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:14:31 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mjourdan@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: media: amlogic,gx-vdec: add bindings for SM1 family
Date:   Thu, 21 Nov 2019 11:14:27 +0100
Message-Id: <20191121101429.23831-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191121101429.23831-1-narmstrong@baylibre.com>
References: <20191121101429.23831-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to support the Amlogic Video Decoder on the Amlogic SM1 family.

SM1 has a slightly different power management handling, thus needing a
separate compatible.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml b/Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
index 8ea979bb97e6..a7ef69d02336 100644
--- a/Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
+++ b/Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
@@ -36,6 +36,7 @@ properties:
         - const: amlogic,gx-vdec
       - enum:
         - amlogic,g12a-vdec # G12A (S905X2, S905D2)
+        - amlogic,sm1-vdec # SM1 (S905X3, S905D3)
 
   interrupts:
     minItems: 2
@@ -100,6 +101,7 @@ allOf:
           contains:
             enum:
               - amlogic,g12a-vdec
+              - amlogic,sm1-vdec
 
     then:
       properties:
-- 
2.22.0

