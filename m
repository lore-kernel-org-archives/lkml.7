Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7064C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0BF214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IVmIf78I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfG2NC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:02:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36513 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbfG2NC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:02:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so61842090wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zpr851HMr2C/6wpW/fjgX4pS+dl7PCTuVx/DMDxcThc=;
        b=IVmIf78IJU5aRgsX2G1HqgHG4gUMk87UdaGXrM/qg9kxvtuyVkZmYR9x8WLK1ULFTX
         FokG4NTFEjm0kKUPe3tSO9hQutVLy/ZedxMBjSE4rtgVEvXBXl61eOmb6eFoDItT+xRz
         Boi14E4dWXIKuLzjdYF8XILxCFAWcMVrBUSKAJ61JB0cMegkLGHCzkuQY5619R1waaB9
         04efrurE2Vc6FsrXDIfsXbXNy7nKclZr8tlRdDuspWUFOuo7stK6JVgofieof7f2yOky
         febOvPdFwy+EU+Bkfyi7P/ae3GplqN+L0+tLOfv8gn29/UfcmzLh+UTQN4JdFsKiN+kd
         +oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zpr851HMr2C/6wpW/fjgX4pS+dl7PCTuVx/DMDxcThc=;
        b=B6MX8srcF1iF9DMRfwjADN9wm51SkIl2dOxjMW/nRBxPO2TqiBlkheTX0oEWYja+Be
         2MHFMV9EFuVensHUHCloAvjydhifY+uwiFX4GUP8UaJOFJaRMsR5nKlA7M2qJM+gquuv
         1+jj3AApWRCGrZqytSdV+bMHa2/kORyrRmIkytb7SlA/7dryKImHpVXOUfxs/VfY10uw
         VcbQHXKWML1e+Ph8Ifs7woP75rrSOO2KnozkdOEmVPaq7Jc9HRaaAHJob7qc5fd7ZjT4
         FbvNkKVQjPpqaFm30gw4jMMErA7J/PJ+VWH/bZ6M6T7A8s7d0C5ZtEw3nIM2eLkqJDDh
         RPGw==
X-Gm-Message-State: APjAAAXqLMDJrgcwBc/2nP7+9kdP9FsWmntYWOQJ8eE7XD2moAgi4zt8
        10rU+3J0Fkmka366nMmOXeu0mg==
X-Google-Smtp-Source: APXvYqxoSLVFIeYxYdV5hYNuyqLN4MINVeUl04PX1hyBeSvXWR3XeJJNee8SGZulXnrDLKFW4GD1Uw==
X-Received: by 2002:adf:df8b:: with SMTP id z11mr64212411wrl.62.1564405344004;
        Mon, 29 Jul 2019 06:02:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x185sm52990545wmg.46.2019.07.29.06.02.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:02:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] soc: amlogic: meson-clk-measure: add G12B second cluster cpu clk
Date:   Mon, 29 Jul 2019 15:02:18 +0200
Message-Id: <20190729130218.6635-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729130218.6635-1-narmstrong@baylibre.com>
References: <20190729130218.6635-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the G12B second CPU cluster CPU and SYS_PLL measure IDs.

These IDs returns 0Hz on G12A.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-clk-measure.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index c470e24f1dfa..f09b404b39d3 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -324,6 +324,8 @@ static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
 	CLK_MSR_ID(84, "co_tx"),
 	CLK_MSR_ID(89, "hdmi_todig"),
 	CLK_MSR_ID(90, "hdmitx_sys"),
+	CLK_MSR_ID(91, "sys_cpub_div16"),
+	CLK_MSR_ID(92, "sys_pll_cpub_div16"),
 	CLK_MSR_ID(94, "eth_phy_rx"),
 	CLK_MSR_ID(95, "eth_phy_pll"),
 	CLK_MSR_ID(96, "vpu_b"),
-- 
2.22.0

