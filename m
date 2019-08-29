Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A7FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A833323426
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xdD1rGlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfH2PYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:24:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52021 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfH2PX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id k1so4167929wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNct68VLdvOJio/5Gf7jYfAx8Jm9CSApcCCK+DehTpM=;
        b=xdD1rGlCDppR2G3tq2+Afor02L9Lnru3XcK4gyu03zLYhux3tnOdWcFA9uaXQG1WnU
         6Q4JYSRjbgvCJBFE0gGwUjt7zre9uwnqq6x6fhFiPZmRYjPVZM6iKe1zQR1VN1nFM4Z6
         K/Re2HoM/+UDeEl7dWjG/IBG7hBzvQSIl4pHaNAVkoSThZyrK4OOMpL3Lq/Ovu/DqUUx
         U+juR23BbNDF4W3Wtib+cjCxGvo1/0iBqroAuCbSnklMvi5vUfAZful9aqjUHt3Pb+Sz
         hYj9u0IRN4AURaJohbzU3iKogFKWMHH8GTjPDe/Yem4auNrMmWnPSELLHfn/IC6oIYcj
         DB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNct68VLdvOJio/5Gf7jYfAx8Jm9CSApcCCK+DehTpM=;
        b=duDC4TILqYVGk7zkOOWXVAw4WaZ6LzAJIaLFiwO00fsTcElr2mgF9dwl1xedt/NkS/
         zNLJrMDYAKbOto/Gac8w401GqVJwqV95jwlGGf6aUooUUHyil90FqCVm9oeaa6QBPHpE
         BnrgJh7SzxRxGU+0ouMOym8iC5V1vmouFc9VV5m9HkAUCcTYod1HIIly111QaZNKXjcz
         S/Op7+riCOcvoSh8p0YuLkko0Wru4AObWuPfI05llbQ6cXoBLMav9XE59hDnSiq+h5S9
         H8TUbcge01vn+mxs4EgMQrDVL2v8qZPiO8LXWOM6AN4RmuIAnjVbNRnYx/9i0THr/8xj
         H9cg==
X-Gm-Message-State: APjAAAVLNlaYCa8BIEbI3wH0GRQ0kk6QoCFqBdnTsLrV0UXkSTzYO2NT
        /sFyMhliNKCuLeLFTqIPUMf9DQ==
X-Google-Smtp-Source: APXvYqyxkniha6um+qP2owGsl3mhEShJhy9rrrm7n8jV9cz/FPjsOQkUroI676R6AzEmgachU49oDQ==
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr12604588wmj.86.1567092234111;
        Thu, 29 Aug 2019 08:23:54 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 14/15] arm64: dts: meson-gxm-rbox-pro: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:41 +0200
Message-Id: <20190829152342.27794-15-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index 5cd4d35006d0..420a88e9a195 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -148,6 +148,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

