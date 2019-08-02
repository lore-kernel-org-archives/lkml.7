Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9E9C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13A821852
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFng/ii5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbfHBMVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:21:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37163 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbfHBMVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:21:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so51884764wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 05:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H5wGh69dp/2MC7doWK21wK95kqVnSSNKp+yReUaFMfw=;
        b=BFng/ii5ClHBf1j1zpaCDA5IzvC99gvtcgwdudRhLryKG6xIUyU9jDeLLixoNyvf/B
         ixf/kgetSJEvj3F0WY3AGf1a4QSlN0zXBU5B10YKflkzqLpq6TH+Y+fk0tGT0u4oe6Rx
         Nh1yBs2HgyGjOoN00wDW73WDIqtCQyDEhMI+cOqYBUqyCFAAQmwdHPv5RAaAtgG+3PZl
         3lbtMZl6nZQcY6Y9QipEhJFrv1Q9gnxHnsZAmwZ84CwgSYsRVnlobDOfxt0WotLodijs
         IkZOKAZf/4fVuX7kXJhVsArdgSO7DkbilnpByIQ9omEPIKpFIAWQ2abShToFNQbduEcq
         vs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H5wGh69dp/2MC7doWK21wK95kqVnSSNKp+yReUaFMfw=;
        b=al0yfM5WPHnG07uDErpfRr9H6Im7l4j30Vbco9RKk8q0uDchtOwMjEOLVZ3m4Bm13s
         D8yTRxvHMjS2sVXiRNYeQKM8Z5SF9CcRYIunjeuPYBiSQBO9u7DvnMAuxLMgIWDOsSO2
         uNl9x9Ze5lfdBeEcjP9qAJgCH0NKGUS5my3PiaDQHYk8eXzrUaCZiXxUbPQHe0ZxPc6y
         stw/5iGOFgPsYWKq241bbJyddcK570jTC041IEjxwLSelTRvbgngxlayqEZxWFig4sbX
         UiSlYlc0hgeZSyT/BeHQY3e5etjT6cqMxxizk6+ld2Lw9jLESsqY9UpftuitRG+TOxdJ
         p8rg==
X-Gm-Message-State: APjAAAWh8EvsHj/Jl3j3CXo8t9bMC7nsTuVsfpy5V3VhmC3/g9uiMI/1
        XA4KTAB8JjemUhQo7Eaag6TGkRaOyOPZRg==
X-Google-Smtp-Source: APXvYqy+ImRfcO++8pTE4rtugXo1crID7Pxh+mRV5Xz2OkfmY1enRlxel8RpiDgIXD3i69edDA16dw==
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr92750552wrs.160.1564748472965;
        Fri, 02 Aug 2019 05:21:12 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id n9sm120612691wrp.54.2019.08.02.05.21.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 05:21:12 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     etnaviv@lists.freedesktop.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: defconfig: CONFIG_DRM_ETNAVIV=m
Date:   Fri,  2 Aug 2019 14:20:28 +0200
Message-Id: <20190802122102.3932-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For imx8 we want to enable etnaviv, let's enable it
in defconfig, it will be useful to have it enabled for KernelCI
boot and runtime testing.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e58ef02880c..ae5bbbce8a30 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -531,6 +531,7 @@ CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_SII902X=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_VC4=m
+CONFIG_DRM_ETNAVIV=m
 CONFIG_DRM_HISI_HIBMC=m
 CONFIG_DRM_HISI_KIRIN=m
 CONFIG_DRM_MESON=m
-- 
2.21.0

