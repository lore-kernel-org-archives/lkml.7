Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9822C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B26208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZAa0ZIuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfGAKre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:47:34 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:36904 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbfGAKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:47:31 -0400
Received: by mail-wr1-f41.google.com with SMTP id v14so13270145wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5UzNbuEVQn2Wy0UqdLJeMLyAIRssoP2yykdAjQ2Y/A=;
        b=ZAa0ZIuofgnRBRqOVOreiPd9jhxY4jtM+O12g3AJAvAuYi8cxkgT6R8plBF4werznY
         Aptr7tR9ZaVaL1vwwGSBg7YOLN01xOM2Wx2nZzbX1Mo95QDC0VXZU93xHKxAGgnkpfUE
         2VYZ8U9grr6SH8qKT0XJwSEHKsBEO/AfD2TLJQhCmYCYvs3Q9P6NcBN3Dc3Mj4X/9rRQ
         tp7CkTVxUoGu/idBebG06Z9hWMAcNToYIzEoKP6kRWwuvqxQBqiOB+VdCeuYW6Z9y+MH
         rGwWSh2fSkHjv4KzlSAtgcJL4T4R2b/qd82JvJ4bHjoSz1Dslldu44Wqrg4t9pEgrSqt
         +IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5UzNbuEVQn2Wy0UqdLJeMLyAIRssoP2yykdAjQ2Y/A=;
        b=Kd703vSvnyYOgZYNZJaYK8EMaHL/3hrdPME5Sm9m51IKDnp8q1O1WXVLctAkSWmgbl
         luDCx9+d4MsdeRnAWfaI7kjV9J4cvDj442aIl6y2UdsYosNrXYN4OGqiMI4ZUHtIGMii
         PFr2onoSw64j9DYoQyPPsjvf5hs3SL0WAXAxs/1YH6LyzJPnN2Fi6/1gVfWKyokf+UIn
         VNenQMXAjU3+mIigAoSBHtGziCvTxd3psbqX67NlvOctvZAKWb1B3nMufvwuCr8UPoZh
         xYKf2eLEZhH9UpRnZL5FZLWM4AVqnGoQrvFj1XgrP5G2shaMy1cTrIC0Lt/SRuOB+BoJ
         ML2Q==
X-Gm-Message-State: APjAAAXNYnLBZl6DdFvovVQ9edCanlRTWwENtqILmeziDq8qPx0Z+ENK
        /7slQec+DLSX4oiR4GvawgRxdQ==
X-Google-Smtp-Source: APXvYqy/oNXgBo9tyiXqmZZDYUmvF+ZR/X6NeS2F1pewoutaz6zgaPZSLCDGFIqrDM3XN4i0W2nn4w==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr2466415wrv.247.1561978049177;
        Mon, 01 Jul 2019 03:47:29 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d24sm11658802wra.43.2019.07.01.03.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 03:47:28 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC 05/11] dt-bindings: soc: amlogic: clk-measure: Add SM1 compatible
Date:   Mon,  1 Jul 2019 12:46:59 +0200
Message-Id: <20190701104705.18271-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701104705.18271-1-narmstrong@baylibre.com>
References: <20190701104705.18271-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Amlogic SM1 Compatible for the clk-measurer IP.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
index 6bf6b43f8dd8..3dd563cec794 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
+++ b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
@@ -11,6 +11,7 @@ Required properties:
 			"amlogic,meson8b-clk-measure" for Meson8b SoCs
 			"amlogic,meson-axg-clk-measure" for AXG SoCs
 			"amlogic,meson-g12a-clk-measure" for G12a SoCs
+			"amlogic,meson-sm1-clk-measure" for SM1 SoCs
 - reg: base address and size of the Clock Measurer register space.
 
 Example:
-- 
2.21.0

