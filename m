Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33260C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07884233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dLorAy/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfH2PX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:23:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46073 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfH2PXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so3821929wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDNcnLq+b6mBPqMQqj1uI4ke3syAlfKCQSY799vo0LM=;
        b=dLorAy/DgPWHgQKpS9UzHskRBhT6WrHSkOcR0GwM8nusl4Jg4sN2daFt6AE5GcvhMO
         2RtioBnQxvK5m1Nt4mmURPkw0nsjew196jBud9NnF9Or+MzKApgoqbZtongSNtejaPCg
         13e4P/O0DFPCAAOvUqo4DJApwVJB2UiAQFzU7oR3ZjMhGoJBUCfhuwA5POL7vA/G/8it
         3c+qXohLp81m2Ku1T+PKJ7ngGADw09iRR5nVqp8tz1dFtKr2+az9yHm8QhAwe5HA3yL/
         bSr+SKNFvvj75dZge/2ZqhhidNdFhgcUMkHBlSBqPmcIc0swIE47G2B5cdv0VV/rUI9j
         fnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HDNcnLq+b6mBPqMQqj1uI4ke3syAlfKCQSY799vo0LM=;
        b=TFzY/YDt5aCQym+PcqgNZ/qk0GPJv1AzBbkBd7Zz9XWkiL0CaemPMgf3Mz8Z1WLznJ
         jx5jusSfUXHz5xS8PHY63p8++hzFynUDyo9KHJzBEu8odnwVGlyihFyMBZB1NVs2pojZ
         1RLEXJY2x3WvkGUyAgd3Xg9tXonva5pevVjQJ4JE8S8+LEmE3uBCGJ85YqnXhj8Cil/7
         zKdHeiQ8Jxk4XyR9sFQlAfEiwDiujSYEqjjPNvGHlSdDu4nY3TU/knzNqyBavNhPMPCs
         TOCGtI9hoyCcSmEQtZ8aFDB1mfWh0MMghUEuvJZIMsbFUh6dUQmH2rmC46TQ6cg009Ex
         tejQ==
X-Gm-Message-State: APjAAAX6Qy4si+QiPc/qvzo846E0QwAVfs5nnsyYy02AEoC1AtmxlAJT
        fQV5Fj03qTOsNAZT1/I3Xg5m1SPx8nJPtw==
X-Google-Smtp-Source: APXvYqyTy4p5gj4PxVF79IC7zf/oN42FSf8AQ/YXD/PbaxsDqieMtxf5MdKlVyNt9EAxAJmJzZ9Mdg==
X-Received: by 2002:adf:8541:: with SMTP id 59mr12256907wrh.298.1567092230520;
        Thu, 29 Aug 2019 08:23:50 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 08/15] arm64: dts: meson-gxbb-vega-s95: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:35 +0200
Message-Id: <20190829152342.27794-9-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 43b11e3dfe11..d2ee2577d479 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -183,6 +183,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

