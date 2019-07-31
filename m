Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2209C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79588206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mQ/GItiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfGaIka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:40:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45237 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfGaIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:40:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so68667528wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75XNmhFNb9+dcVa4YPmR0y+UGapfOVB2uryDAdPU4o4=;
        b=mQ/GItiV/jIekXUfQF4MaKyeF2xxU5ZvV65tC6WZtOplsowpKXAcaU2ed76arFJ2HF
         FRrWiFna/EnHvHxzgRZqv/+XpaJ27aSEQLNVHv0fTRsStQlfzxlUE31f7kYDoDoGEM2+
         LR1I6fEfN+WigiRr1yzP2X2YunGiuAh4/Ya265Ada7lN82hSuP0n9z8pIs/wPGx3F5AV
         AcivDHZutEmkStVMWqMtfAEqbMTZG0dN9LyQ7aoN3T4h3BlZSMLDbguHvRT3ydv2nQSU
         Uaf4bN0q+oQm12t0bypww0qe//veBeJZ9glvWslrbP1JBZQIW7BrI4CZULyhUkGiY0xF
         EiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75XNmhFNb9+dcVa4YPmR0y+UGapfOVB2uryDAdPU4o4=;
        b=OD7ETIvsh79OMxUWZVwPcpwSmi8w8giw6VHRDLACMFWDaX+ifJWVWM7fyZ4n2HLWs9
         5J55CCrFF8Sw/+I0XF6w1Qr/3zkwKu8TgpF57fkC57GRUxLbrWhVbA37haLcTxLPO2rn
         OrJ27Kfsdxf9HrWwrihmHtlpEnajdz+0HTVHW4mLH/qCmiN9ktvw3ow6KaeHa/N03tyh
         oatnxVb/9C12J/lEgHXDE2PjaDZUUJ4PK0cfkJTtKq4JQK9MmFCmooy12g/cBRhdIJ9p
         rYB6bNduxqUvr9Uz5Qo8sCgC2kqEyz+oJh+ZEAG5bwb0yDajJUcplE9VniodigkOjITY
         6Ptw==
X-Gm-Message-State: APjAAAU1wbqyLPxxoDM7ZWDoc2NpD1n1QM8YoLguQdY/mu1nVAj5WxoL
        H4bvYoVIw6HQBUkIQHMIBFOqnw==
X-Google-Smtp-Source: APXvYqyi4k1XS4obufEQe9GPrtTQh4Ldosu/Cj3LUEjIEn/ydGYaGOvK4niO7KpZnRyZkkeRGMiirg==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr17572698wro.133.1564562426143;
        Wed, 31 Jul 2019 01:40:26 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 18sm56049308wmg.43.2019.07.31.01.40.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 01:40:25 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/4] clk: meson: g12a: expose CPUB clock ID for G12B
Date:   Wed, 31 Jul 2019 10:40:19 +0200
Message-Id: <20190731084019.8451-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731084019.8451-1-narmstrong@baylibre.com>
References: <20190731084019.8451-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the CPUB clock id to add DVFS to the second CPU cluster of
the Amlogic G12B SoC.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.h              | 1 -
 include/dt-bindings/clock/g12a-clkc.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index c8aed31fbe17..559a34cfdfeb 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -216,7 +216,6 @@
 #define CLKID_CPUB_CLK_DYN1_DIV			221
 #define CLKID_CPUB_CLK_DYN1			222
 #define CLKID_CPUB_CLK_DYN			223
-#define CLKID_CPUB_CLK				224
 #define CLKID_CPUB_CLK_DIV16_EN			225
 #define CLKID_CPUB_CLK_DIV16			226
 #define CLKID_CPUB_CLK_DIV2			227
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index b6b127e45634..8ccc29ac7a72 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -137,5 +137,6 @@
 #define CLKID_VDEC_HEVC				207
 #define CLKID_VDEC_HEVCF			210
 #define CLKID_TS				212
+#define CLKID_CPUB_CLK				224
 
 #endif /* __G12A_CLKC_H */
-- 
2.22.0

