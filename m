Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FD3C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCC4218B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="V4Mavlc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfEMNFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:05:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37103 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfEMNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:05:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id e15so2787918wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHZ/pld/sg8uAVGHhkkrEz44b+d5Izaa0pIrN3uQMwQ=;
        b=V4Mavlc3cgLus5AEdOtVuk9qMM6lyQfOEkN0u8KEnhzsEd3hOX2fbV4GtwLj8hPyTr
         5w8RiGcpINtPoxLXnVdAm0oI1oNa3aeEUWtEYVfvrcUFI3U0+jjrXIZiCsuisDtUPMld
         9vONUn3cIyyVcXD6lY5KmmceWS+dH/4G9qYfvWMS79eBlFGzk3KO/lI7BBNO2GBHwgsy
         t0qeX/DPl9xZPqzJOm/IRLrRcmMlGBN0vi+zyUcrJPFHywFLkC4O9+dYPjMcvo30DV4V
         jwA+1nYBgDdV3KLAlU5L5mBfyEpcTgSPEPFkcn71adEJ5IWmDAtKIwIzK1mq6JKjCJ4P
         VJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHZ/pld/sg8uAVGHhkkrEz44b+d5Izaa0pIrN3uQMwQ=;
        b=aeIsSM3QLcHxWxOktqnZ8UgWKaFv/3Xtfjdhpoy6WR1IuzzjJUn1Fv1hdA2NBT7Y9L
         a4x+167jDkbDs9orCqUvkfyQ361T29ycAxX2lRt2gic5Tb1SfYahEOSEhcjZaWc4isGf
         obBzQskRmCZJ9MYn7m+OFCpchEsQbTwpfmsefRYByLmtm7raEQHNybcevq8uHrYTQxh3
         Q2kNCnBjsgeLCRtaJc+QMbf5xQe8aTrLYn0xUiQ39Yq5eguA+VdckuWXKZb1QaJUCcp3
         /3DNGrp01lWwKOEG4kz41pt+V/zzH4cBA2BmrB3MxBE7Dw2UY9U9x99k01rjQlONYBtS
         WZFQ==
X-Gm-Message-State: APjAAAVxN7kUV3p2Khh6me2Ki5QPYkj3teNKlo39fnRIkzW6cZfkd06h
        1Wa/JXPZMYqrIlx/PTuLG2K4SQ==
X-Google-Smtp-Source: APXvYqzwWbqc3KgT6JSaZYy4PBV+LnjmUu0z+YVKtdpYi8JdgyGhKJ7ChUmglf1QZ12ESiwwE8oFiw==
X-Received: by 2002:a5d:4245:: with SMTP id s5mr8742703wrr.147.1557752711799;
        Mon, 13 May 2019 06:05:11 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o6sm33701457wrh.55.2019.05.13.06.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 06:05:11 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: nanopi k2: add sd DDR50
Date:   Mon, 13 May 2019 15:05:07 +0200
Message-Id: <20190513130507.22533-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UHS ddr50 mode to the nanopi k2

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index be81f8958717..849c01650c4d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -301,6 +301,7 @@
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
 	sd-uhs-sdr50;
+	sd-uhs-ddr50;
 	max-frequency = <100000000>;
 	disable-wp;
 
-- 
2.20.1

