Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB83BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7F420850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLym+nFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfDKVpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:45:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40612 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfDKVpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:45:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so8505736wmi.5;
        Thu, 11 Apr 2019 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JVJVK0fp29mg3uKqbJ1q8hSd1H1wIjJMNf88P2gVgQM=;
        b=eLym+nFzMPEMBTGFUxknYwNUspxDzZykV9hXzVkOvQhnfIqALZMOLkWucFAWqSgiri
         fPU7+rUFijm7zUgVVYmidMrygjzh+PkhTBvYmyv70nWSBzXHZ77+WxHgh9+gipKnKXBJ
         ARBNXZr7eCwqcCAcSFUqyDGlcYWdRp2/CXVTr1RTiIpNxuDnif4EdnX3GGEqNR+uI1fi
         Tljc1h7aI48BnCa14/TMeNXr4XXzmEO4VeeV0wEfiPFdhxwsmFcAJfYnMDJTuxVRgMfL
         C5vZFQXNAxJV5CsLCH54GqGGSoU/cVgPpL2eU4p/toforWEJaFPoTBs3/iYU3m/kpOCY
         zZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVJVK0fp29mg3uKqbJ1q8hSd1H1wIjJMNf88P2gVgQM=;
        b=gAFEYBWOnH2nibaxBPp+VoUSl30p/qaZwrRZzTNY5ghkALFYjgQlZojReneiT/AvHA
         cq9xYpfb9CIhQi2mJXjh+6GnDHUv5DOJlrcOtMY+HiPTMsYY3tla4zS2/dPg9SaiMjA6
         jgjz38xHnX2/6AoXOPeRY7cNPmsANDIuwnCoxXnOS5JxnyrOvcM6iiUB/ak1ef5i41em
         VtKE8uCoyaNFxlWMwrdTRu9kGARQR+kxRyoiIbTk0XmfBV1Os9RnlOs2EHcq0WPsaXAw
         4q3fXUKrR4gnaMtruF3sqNOyZQ0yD+VXxrWUzO3Aste+ddljQridBz62n/P6XTY62CFt
         GY/A==
X-Gm-Message-State: APjAAAWnMojnbBsrHC8KFT8ghCFPi3GUCQqWr5gudJge8AmQnYhKIH41
        WspAEhEDnkjbdaR2IVwKnA/tSeyzzJNLyg==
X-Google-Smtp-Source: APXvYqw1FfnLiu9yGxJABPKTeB77CeJRhU/gQkKVmtDIgPljWAD+qUTsp2BPgy/PT1sKmVHRyn+rBQ==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr8649183wma.120.1555019102854;
        Thu, 11 Apr 2019 14:45:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id a22sm5952961wmj.44.2019.04.11.14.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 14:45:02 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 4/4] arm64: defconfig: Enable Sun4i SPDIF module
Date:   Thu, 11 Apr 2019 23:44:22 +0200
Message-Id: <20190411214422.2267-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411214422.2267-1-peron.clem@gmail.com>
References: <20190411214422.2267-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 and H6 use the Sun4i SPDIF driver.

Enable this to allow a proper support for these SoCs.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..423413768d79 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -531,6 +531,7 @@ CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SUN4I_SPDIF=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
 CONFIG_SND_SIMPLE_CARD=m
-- 
2.17.1

