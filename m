Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEE1C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E5E2803D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jZRdLLd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfFCJsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:48:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35233 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfFCJrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:47:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so7385873wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T9Ny5N7xcGaPs9PTlrreMwQ78swu8eI1bqcwr5eO4vE=;
        b=jZRdLLd/0Cwb2WksjvzB5nfmewOs6XQTiqgY3942FTJZbY3otyh522qliwYQUxB80r
         tldzgHNhJJDUtVqZqbbUaurGWFIWMjB07Tbpi2Nr2fXQbwTBScqSPtUEzGg/REKu8y74
         96r+RTtykcM+FmDC49Bf97j7ggNKk0RTHUuwghW1TiaWe9aw9eVSzVAoxtuj+vxVomPN
         tE8aXdcslm6uL7cb4sB09Tn+q496+67zaoL3zQAiyh29M07k1Qg3Rxo9T99jVmXQrivZ
         e5NouXydbCRiZ+Waa4lXIO2rqDLnEoyHPxG/FtOnB3HRl6PwFtyvfszgfY8tbh8F0jq/
         nGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T9Ny5N7xcGaPs9PTlrreMwQ78swu8eI1bqcwr5eO4vE=;
        b=lzSgY9DWaGC9QJYpR5/M4mgG3WYgTmbiyQLxZ3B8nK8C5d91I/oFshEPhTACLwoeNA
         YcVa11cUVrnSQcJLs96k6K1oIeIU64xBbLHWebxRfsR/rj+GZNSP+1bp5bKcAMs40Bh0
         q17Vf7Ra4Fi0RIx6QyWivJ5//juR/0t33knYnN3NXg16pp8U9LuENocY9ebaADATc9sz
         viPHxGzYXCLWXPvN56xUy/jLbBiYPaA+DDu3orHoGS0c6H5wqpqKvKHEGkoXRpyYD0W/
         14GiZGMicU/B6WtB61aXGefCCCHUJcbSB8+rd2oRkprx7YOS0wjpaZSAFEIfj//teMMa
         r2AQ==
X-Gm-Message-State: APjAAAXb1LAioBO99xUC8AlvuufHRl3LHEs6wlw8iG7uKiAneCax01qq
        yO+qMLQx5mIZ+LniiCyJczAlo2IgzEQLpA==
X-Google-Smtp-Source: APXvYqxYgQQ6aKW2VVH6+UX/ZVBFLY7/jEsZhudyesWCvOJtNp0VN66G3eM04FyN/tjpGKCky56o9g==
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr13747212wmj.155.1559555270333;
        Mon, 03 Jun 2019 02:47:50 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14sm11235375wrh.86.2019.06.03.02.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 02:47:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/4] arm64: dts: meson-g12a-sei510: bump bluetooth bus speed to 2Mbaud/s
Date:   Mon,  3 Jun 2019 11:47:39 +0200
Message-Id: <20190603094740.12255-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603094740.12255-1-narmstrong@baylibre.com>
References: <20190603094740.12255-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting to 2Mbaud/s is the nominal bus speed for common usages.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 3e0e119c13ce..4fc30131e5e7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -530,6 +530,7 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
 		clocks = <&wifi32k>;
 		clock-names = "lpo";
 		vbat-supply = <&vddao_3v3>;
-- 
2.21.0

