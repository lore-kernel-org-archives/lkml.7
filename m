Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A412C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EAB2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GoxXT3yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfH2PYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:24:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55791 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfH2PXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id g207so194140wmg.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6SyOjEP410Jq+yTira3a4SSlk3MOHlNB7pPOna2wDA=;
        b=GoxXT3yuQ8AHhe1/9gDuRAi4VwLJUsXE5+AOTkmy+KTLb9CUB/9weRuFQ6qunCNIw2
         xlDk5qq1V1EnMRMOlfpwHSFOdycqfu9+O9kjIjGJeCuNDXqjAhbhyAC7jP5axRHmSnur
         zHzoDaTkgS/c3SbKTLDOzFu/nbJfOWr2S5g3FOV16ltFfaDfzZCajfhhrvTh3YVMhAux
         ib1tZAgnv25aA2G3DgtN0cw/dRXHtstbq2xvFndyxR6nVVvOZZ/RHhw8dw2EbJW6xpxQ
         jZeWSyYwjIWVtvrqtOBSig78vR6/POxTh5E1lI3YxmAk9vX8G+dzX6PQ4zxMSaO/vc6X
         JzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6SyOjEP410Jq+yTira3a4SSlk3MOHlNB7pPOna2wDA=;
        b=j6TBJiHoXaFOoypovmFvF5DwzVfaIYJp4qDcNUsXfe0SXRXOVFBIm8CPagMuylgJ7N
         LZbbHlHA8VTncsD95Vj4r/ItyRcJjQk1Nrdfelmc4twP9L1qvfzJzSADvvW3gYespzw+
         nyt/J53ZKO+PaIQBV7PENo4kvpA8NDpZSuKRwHCVCfI3Y7wDGuD2F7O7ela/RMRxSH6G
         4Vu+xAU5EBdGjN5N854yfTid0N3U3v1udTRmzxHC8VmQ86XQyS72KRLd4orKMNGm18gF
         CVZIdHubwstroG+zrWB8G0Q0OyNZQCkv3NI++s30PeHecTwu0CQlVAr2De7pJdInLK5X
         FXoQ==
X-Gm-Message-State: APjAAAXhmuaTutKy3S5wJ8/V2OWW6AUxp53+LjKP+ATfJTaXQDIhOjwb
        2YVoTyXqcwKRrNZqxQ5+jhs/ug==
X-Google-Smtp-Source: APXvYqy5gGNOwYu0+fLzEsSGBC/FpGFKpBIT/9aObdyNq6KZBtGOTnxHOQBOYGJCKi/DL3GO1yijzg==
X-Received: by 2002:a1c:4c04:: with SMTP id z4mr12236406wmf.1.1567092232373;
        Thu, 29 Aug 2019 08:23:52 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 11/15] arm64: dts: meson-gxl-s905x-nexbox-a95x: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:38 +0200
Message-Id: <20190829152342.27794-12-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index c433a031841f..62dd87821ce5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -165,6 +165,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

