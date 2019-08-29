Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE35FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8099E2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iz3w00oM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfH2PYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:24:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39620 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfH2PXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so3863378wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SiL45R060WCezmhZNNgvA5GD6ew6UdT9naA5+iprxJs=;
        b=iz3w00oMmhwELo5mlz7WH3W3SCHzbt/CfLJWsAoY91Ld9m+Ysai9qYSacAS3GizB4m
         kMqlbOhOXjDfHq3XiJ7j2dIERqKE5plX/KZAqA4D8uhnrPgKCxQZAgBB34yhvh2HkRk7
         s85NcR6XFFCR8/xbuJmgHX0afclGzVCVvvOaKrjxUDjOta6Vasf7+nVMTDtdeFeV3Exd
         cNWIYk8yN8i8yO5NnE1RKT7IDu9D9DglTndbLtMGjppQioO0LjofVRQBIHBIHrwJP0bX
         n4LQyboRqzBjgrOFllI97n6xmZJZX9WPG8Hc41rAyQ4LDx5ExOfvsmAg+uD3+0BSgnG8
         +0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SiL45R060WCezmhZNNgvA5GD6ew6UdT9naA5+iprxJs=;
        b=ZcwisXZYfHIPFS6zfNpTdQgsxDa1Qafp3zO/Is16NdXEUc7L5jeWLjEgf4iUaMBYj6
         +xWLW3Fy+JYC8WA34NBJxLa5rFvtGcj3SuV9gcosGmfXGiiYeVUgegBFrSfM3H+THkX0
         YsPykURqxauaqkh8Fh2DXWwZlgOHc7I/X6SXcPYizdwuVf/pJ3P+jy02hoyQYpnrkK5V
         vn2fwoIRwsOywdUKyB8vsLEwuWiemPeJ0sPqr6WfF3mAUYCyJKL7DBfa3GGXEkd7eyiU
         393Ri6Vb4IYSuHkV9eePQbJRKCU54BXwGJZv/W4Hk4QeB5zX3lpjBApE/6HSozTYrUm/
         ZoEw==
X-Gm-Message-State: APjAAAVS8+dM1BnQusLfJCODV9hIBT5dPaEY6uB3BK6aNGHGlFOVQA2p
        HG9VGUGT6b8epNJdjuRLvSh78g==
X-Google-Smtp-Source: APXvYqw4kFKc52LDFXq9PBL0wPfc+IrjPgZFhUUCyDOFG0eZ0v47NcbuorEHE2HuyIfF3ef4eLIGkg==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr12837183wrs.117.1567092233542;
        Thu, 29 Aug 2019 08:23:53 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 13/15] arm64: dts: meson-gxm-khadas-vim2: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:40 +0200
Message-Id: <20190829152342.27794-14-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index f25ddd18a607..5fc38788610f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -332,6 +332,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

