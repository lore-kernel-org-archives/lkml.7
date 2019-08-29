Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20086C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66512077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="voUAvq+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfH2PYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:24:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40266 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfH2PXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id c3so3864136wrd.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0JxMEcHFS4bD0DZNCQjjDFLTS/cdSPkBWCvGgTlb44=;
        b=voUAvq+bWRwwNVo2zmuIwa7IrCEcc0R46b3t6lVI6BYtf1zAf4ncx8f7efTli46KxO
         L48IIzurEgsdYVyyOV+CnSU/JmPlOyVq4NIcO0Fyd4CIq2vR8DI/nHPx1pn40JPLkhf7
         XMHHQeZa3ZR7xk+kjD9MDvRsH589FYMv3Tx4Wx9fi4NRRg9Sr3p1UJ7CgXUHWR4SldWb
         dhkXjqRwJMZ5wo5+BtigmO3Jmeg21muktkzl9wlZKWaG45z0OcUYjD5n93IcU2bAtRrC
         zaNES8vzeK4x7L3dCzvRYrJJY55Mblxaw7sgkry4ttZ4f0fvX5bNA38vtWLary0P6ZNn
         PL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0JxMEcHFS4bD0DZNCQjjDFLTS/cdSPkBWCvGgTlb44=;
        b=m0wh5BosMigjvq8If8NIasFB9cHdgb7I3sdhZAERR02vdjFJvdtKpQgbIwTiCsw+e2
         yodq9z56RSydT8NZByF5h5dl7xWX6wmcRUqDBOqeuW+0lHfQS6NnBB6Pl2xSPrIa6Bt7
         T/A9WHybJSh7ZO13k++t+IPn+YtJCP2d1bKeHz1rzX8X8h11FVt0NOsxTGrL3pj720x2
         tNjp28V3DQ5n3FRIRTefaGGBhrkagQmnxAMhtaoDm/1G8sLB6I06OiF8v2pnEmRu2ZgA
         RjEJjaUgzXgBWvVYn2zDNPjjk5nn4pJpKyVxBvHaOCQ7Iq0q38egvRrZ1FBUWn9DJH0L
         c51g==
X-Gm-Message-State: APjAAAXkvoDPM+roBRGJfpvRJYzEW9CdxcnNpeCR9j4fo8Olz/9Dr9JO
        nvCCuG3VrNoemg3kTIoxPC7VY8sZ/GS2/g==
X-Google-Smtp-Source: APXvYqwrHBq50xm/y/QTlunBrzrR+U+SgWq6jx3rfG7lMEfW9JRChVyC8aRFObf7j+g60i7WJ5zjiA==
X-Received: by 2002:adf:d852:: with SMTP id k18mr3251493wrl.88.1567092232975;
        Thu, 29 Aug 2019 08:23:52 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:52 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 12/15] arm64: dts: meson-gxl-s905x-p212: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:39 +0200
Message-Id: <20190829152342.27794-13-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index e3c16f50814b..43eb7d149e36 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -119,6 +119,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

