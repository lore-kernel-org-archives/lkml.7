Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4C9C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF822341C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g/Pf7qGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfH2PYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:24:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42915 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfH2PXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so3842835wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoSuBXb+WvTUkGUKlAVpxjkPTORJSjTu3jSNV90NLlU=;
        b=g/Pf7qGIV7KZUR6RVpbTE9J9s5HaK0A+KsHIIhQGMF5QX/NvYm0sNV0Rz+sBtwB2ZA
         cGw7eiJ0+3KbxdKaXBfjBXUqq4qkfeifLbDIPrdJbrBP4oHTS7MV/S5YJnQFtiWrpdaA
         CE5yP6Wx0wq1viw3Lj9w9zUTlVdUmgGRi96ij/A+slAy2UE9m4kYDpzDhJbEpg1OieZM
         U6AJDm8SxP4wur9sYGenDR0ijU0orx6FOLYHDHgfuy3q52lvHXHyO/LUeEDcTUekypls
         bMqybSeeNw31pej3rr9Q+fGWxFidcyodAztpAOFmfA/2dvCS3EP8EOEBse/pXLI44X/8
         FbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoSuBXb+WvTUkGUKlAVpxjkPTORJSjTu3jSNV90NLlU=;
        b=QTp2L4wz84t+nnS86ynSzyOuCMXvFbLYIDVy1QURia3So6lddJmorXUd9SdGjP2T+3
         qDnrfmbxzcZxiRZjVezjG7B3cOjF6J5qDKSJsdzeca7tnunNtN1Q2iAwXtHluZoB7WFB
         AwYBWcjm9Eov09tzqR9pI+vDRadkTB/cYCcHmNqm0mDKq5eHMmbGWe2gbZ7l5AMAV9wy
         jpLwGpOxc+epXj689D/Sc6AVBSxFQoA+FQb0yWUwxfgwL74TcEWbKnzySfIf42lxuoWk
         24miDwoEJ+rZZ999/78Y+bSwma/I6ji3xKt1FLLWH6aW7DGeao3NPUoVeBWnROzGHjBE
         3wxQ==
X-Gm-Message-State: APjAAAXS9cCkqYkHu9XGzJo/1RAvHJT9URgNRfFNpH5qoqpUUppFQ8JV
        4vUqezCPFDhbZjwmc+ypjD5vI4MbSpSgaQ==
X-Google-Smtp-Source: APXvYqwNdnYUMuuMpA81ydAVpyhFFcztV8yWQ7nDKB0YZRMplk7ZmJWOz9Hobv0twRJ4rfQ1m7uAyw==
X-Received: by 2002:a5d:658d:: with SMTP id q13mr4854956wru.78.1567092231782;
        Thu, 29 Aug 2019 08:23:51 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 10/15] arm64: dts: meson-gxl-s805x-p241: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:37 +0200
Message-Id: <20190829152342.27794-11-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829152342.27794-1-narmstrong@baylibre.com>
References: <20190829152342.27794-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WiFi firmware requires that the power is kept enabled while in
suspend mode. Add the keep-power-in-suspend property in the SDIO node
to specify that the power must be kept when entering in a system wide
suspend state.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
index 3a1484e5b8e1..a1119cfb0280 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
@@ -165,6 +165,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

