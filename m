Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC796C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F782077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S/3okXCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfH2PXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:23:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33951 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfH2PXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so3901919wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BV274s7zt3wwvGwt3NgSkJi54bLOGbQjevUMF5GAsdI=;
        b=S/3okXCKjNTOL8vkN0yxlvYrGXaYiBD9C8IO+pFcUgOVRGOs1ELkYjmVFFgrLcQH6C
         8wdPNFLBqkpjKEWiA0t85ERq3bsV/eCcM2Be3aFFG8gmMFcBtCQL4DdFlQR5FoIfElEu
         0JQPFWrgNm/mYo/oReoHFqvoApe5aUgUDO6wmfGBtjn899XOxD6MmNTKby0KkTXm/IbC
         gTn6bLXwnGor/R5dHIfafVm941o3Wt3bYvjrK4GtOC1t2hMn4mnBwR9Urm72w3OuOJ9t
         XDs5wzOpGLn+QxmS00VnDLGKNFdOjBixrZaSJpITNNTaXAn/283ToOPyImavpgwV4BQ2
         rjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BV274s7zt3wwvGwt3NgSkJi54bLOGbQjevUMF5GAsdI=;
        b=G7unl52ScSgh+JnOPmAqYoOGXAIQFq+LuLBnEQwcu6Dh55fwztYRNkXT4R0n4H8R2s
         MqGi/kHC8ZLnsuCt1d94gTewTMu5exrvZD9k62Afyil1KpsMtZ4qbrK5XHprP0jiwqDG
         IwSha1N4t5p2FdZOX5GCFBhLO+WmDycEwwO+J0sk4SAEMAoPQplOZ8kYlgUw+EsesnSo
         ZBmQsq8ojTYlx+g2kqYL4vON+S9PCDrVst93zBz8daakHz7pE9FGHBn3lyhMltfsAURc
         14uVwdjTpjXV4UI6sfXu71+G2pSgAp7DV+TP4J63dgX+4KNznOOeXKnKwndcP82Im9P9
         X0xw==
X-Gm-Message-State: APjAAAXboBRs+QxmpK7GOL9xDrk+064aKWtXHZlCw+1hT8VWgCPynPbB
        ga9Rh3ERZXD367YrpB0meyCOdw==
X-Google-Smtp-Source: APXvYqydgX/gtdvTwrPnfTWn9Om1yJ56I2EGB7GGkB7eYu7itvRAS9hY7BegpIShnflsBTBc75fqvg==
X-Received: by 2002:a5d:434f:: with SMTP id u15mr7173257wrr.16.1567092227993;
        Thu, 29 Aug 2019 08:23:47 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 04/15] arm64: dts: meson-gx-p23x-q20x: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:31 +0200
Message-Id: <20190829152342.27794-5-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index a9b778571cf5..12d5e333e5f2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -169,6 +169,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

