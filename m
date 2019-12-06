Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0C2C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4AC2245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e0nUuEUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLFKCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:02:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51828 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFKC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:02:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id g206so7169601wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExlHwuEsZrdq/cS/A52nW9Gjb1C6JL+YnuwC+fr1mv0=;
        b=e0nUuEUVSAHl/nuJIWjAi2qj9Iy9fpYx6JkeTKSH44mUHOg3h9CGMKB8SLTpUVKCMI
         QzyJH0YMOcNuQKSKYH34f6Lmn38wgnkgU5HTOjVfU6Kx+g2mTlQJu8foNauRSp2T0KT5
         1pBx0yutMtm/6C/KAQf2F8hnOY4hn32+dTRYO7eJ2jQ5VwEzbLLcAIsDRoSzaE4J0SLc
         qafN18YO5G/367ruhvA++Cxo8RV9hgqaPOo3ZkkVUeMA4BMvPsaFY23F6+k/kvYtuQmj
         fF46Czp8w0CiyyvANr6Jsis1LKrPNI+uf6LvFDiNTgnxt251vVAPdczKAgK4CG9wBxah
         n0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExlHwuEsZrdq/cS/A52nW9Gjb1C6JL+YnuwC+fr1mv0=;
        b=j1FuukoAJ8se7fO2sH+wI7W9DRAFt1Z46/Yxe895TdYMdtMW5Rv8hSLuVE7EWz8Fmr
         1oSF+eFEvR2eOILplYCQiQrjIgw7kLRZ+fnJhP+F+iUDvPzurKy1GAW+KandlNXzxoUC
         ZyFbSaHMnf98Lb+gvpxSJTLqieJVieBBjZM6AtdOwuMX4uMXOCK87JYRU/jBog+nUts9
         p1kYCn15UTIRBMjcVSeUJKkw3fn2j6fpdGqD2dZDBIeZ1D+UXqfb8nsg/SSNJkCMrI1M
         vzthwuzXaoAYAhit2Lux8wBhqYguUbCJ8iXv0sx/MgoXskCE70umrEYiLUG07ksIzb6W
         o6IQ==
X-Gm-Message-State: APjAAAWR4BXgawgaK1VorkC7j5txc0i5efz05qvTXcoskWqKQSTZrzyT
        TmQbAaYB5Q/xMSIFwQ5hQZMYKQ==
X-Google-Smtp-Source: APXvYqyBH5d3S2z4hcDaLNT4wsiniwDOfg/jr25pzg6CsQNOb4csh/su5yLUQBS3d4LbUvq58k6JuQ==
X-Received: by 2002:a1c:8153:: with SMTP id c80mr9521659wmd.58.1575626546610;
        Fri, 06 Dec 2019 02:02:26 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d14sm16372314wru.9.2019.12.06.02.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 02:02:25 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: defconfig: enable FUSB302 as module
Date:   Fri,  6 Dec 2019 11:02:16 +0100
Message-Id: <20191206100218.480348-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206100218.480348-1-jbrunet@baylibre.com>
References: <20191206100218.480348-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the type C fusb302 driver as module

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 47d1b8fb1969..5ccb2100db92 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -618,6 +618,8 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
 CONFIG_USB_RENESAS_USB3=m
 CONFIG_TYPEC=m
+CONFIG_TYPEC_TCPM=m
+CONFIG_TYPEC_FUSB302=m
 CONFIG_TYPEC_HD3SS3220=m
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
-- 
2.23.0

