Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BBBC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90AF2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lsSTVAhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbfDRM1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:27:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40551 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388430AbfDRM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:27:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so2737884wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9GXR/XbcC+MuPwrv6yn5gN1sB6ocW5hyXF8NUjGi26E=;
        b=lsSTVAhb+qlYZx6/VJZVKeluppYr+EBnKnGJ3q+BLnQRCCtudLXHVoKFhBfbV4ya+M
         JcZNjtXkyeA5QgzkwlBoBr6NXwqnHIu2BFFvoA0mQfJv1y/9asKzk4bZXUizQJcB5xTb
         0l6rDJpgrrGbzTge5SddZq+W0/7hstXWk9qVGWK87oa0Bf0YqkVJF2DUArmGLRM7kWty
         G/yg8Tu9gVGhXRrFHEo8+g5HAW/ruFyn99oC4D0QCS2I952CREt9ZeyI26GuGs63yPpG
         XyCeTTApAcxGJpkiXOuWOPijDlZo18ZrqL5fIkZ7O7cdPkxZQxWoiSbIPm03apaXDLe7
         BYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GXR/XbcC+MuPwrv6yn5gN1sB6ocW5hyXF8NUjGi26E=;
        b=NryuO9cGnuXUfv9zznlY6WAttY1uNFlKEQkBsqMlXxlPCP+bGTdfNQakMRbv+hRrfK
         1NnSlyZ5d57Qt5HNZ2TZscfFDXsL38Yp0PvNBt+zYgnQljo1eF/g7bZTH0UpKuv97fYN
         K/1c6xkyKJZKD0+PeoywxerZDnnOSv2vSLObUdcM18HVG6+FRL3VJj8Z3CXH5Rtm/xtt
         4DW5/IyTdnAywtFMBYRelQpOxQwcP4DXAVKGHPV/Q9Tdz3HSC82SUGY0U1t9gYp3xCl0
         KE+dFWuGT78tTS2+CBubxoBQ2Lv+3IsE7TdP++alj05gcnwviDXoSfla2o9YCGq/hgBD
         iC6w==
X-Gm-Message-State: APjAAAU1YBBBxwOOzCiMNNV1nKkeflNMUJfGGbMKvqJHkGV55+MZADxn
        LeNjZs0Nv6dzjbFwZkLmBDgZ+A==
X-Google-Smtp-Source: APXvYqw3FHqzmykIz55fADriP7f/Vj9TMin3ermX/n1eHPrq40L7JksYv3X7ZwQu+Szw3rc2cNlXJg==
X-Received: by 2002:a5d:6687:: with SMTP id l7mr484340wru.307.1555590445504;
        Thu, 18 Apr 2019 05:27:25 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z14sm1510110wro.81.2019.04.18.05.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 05:27:24 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 1/6] arm64: dts: meson: libretech-cc: set eMMC as removable
Date:   Thu, 18 Apr 2019 14:27:09 +0200
Message-Id: <20190418122714.30805-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418122714.30805-1-jbrunet@baylibre.com>
References: <20190418122714.30805-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eMMC on this board is add-on module which is not mandatory. Removing
'non-removable' property should prevent some errors when booting a board
w/o an eMMC module present.

Fixes: 72fb2c852188 ("ARM64: dts: meson-gxl-s905x-libretech-cc: fixup board definition")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 255cede7b447..d4d5e3e5439d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -255,7 +255,6 @@
 	cap-mmc-highspeed;
 	mmc-ddr-3_3v;
 	max-frequency = <50000000>;
-	non-removable;
 	disable-wp;
 
 	mmc-pwrseq = <&emmc_pwrseq>;
-- 
2.20.1

