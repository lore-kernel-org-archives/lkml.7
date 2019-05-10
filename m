Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259FAC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85FE21479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HWrLNOSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfEJQtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:49:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35108 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfEJQtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:49:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so4185908wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QD9hBkezx95+dQeemkScJZveM5ylPZcSzzLZ+VBuxxE=;
        b=HWrLNOSW7RlVAi8RnLDx9KvIJJknkMjmnYmZy9vW+1r2Ma2dQZiiDk7bY9t/f18XlA
         ruQW4Pgi+nn4UplAbSckCQl+rTWnKc/XFo3SAExVvYIUksfeRGB9IXrglJt27LbXWzDx
         UfYVUOBbUBaPkIMh/fXiKGzHRlaGldrihSDv5LwkaeLgbDZtfimsklmxo6juBNUUGQsb
         rLEXRDRLc6qvjpYDGaFJPEOOKRW9wZKGuGJaYhFFKNywyeiZsTT4ui4rH63GDiNoe1lI
         ADhN+LhC0aOhapH30Ta4zLY13kfu50mhOI5VagYLrUorRUs3lGZQYRcDuA6WPmn6G6vt
         M9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QD9hBkezx95+dQeemkScJZveM5ylPZcSzzLZ+VBuxxE=;
        b=nIWPadzR8kq1QoDbIB6bNwdLxP4EPdeL+VJ45/XUoCNBuT4eobobQ8DXFL9iAmPRPv
         x6LlFoSGLrXSTuBCIjSyKSQDgLBGM9RvEnb5nx9fgjFAbbHDvzUh1UNSCFBT3DcCFXuq
         /klrc2t4O8NiC4Vr8R8omDl1QRPPHFp5gJN81/FXgkIpvG7uAvMeznUC+NgGoH9CX4Gw
         3MkyJUr9cD/N5NVMvGaWmj7NHoZFDbpjd+CTf6OWnKDdnIfXzy4Tc1BLBnty+WE+QUEo
         07rUlAtXseP3TbzfH4u1Mq2SKBps9g8gnGYIOo9gjiYXIFvbUhCDHnlSHdteldGCrHJO
         AM1A==
X-Gm-Message-State: APjAAAVD7Rlya3GRn8iT4wQk3oCeHlwt1x8tmgoB41Xk6L19Na48CS0i
        L2jCCHLscSe9JzC5S/G1z1J7DA==
X-Google-Smtp-Source: APXvYqwUEF4XTc72WlhD1gJI2eKGwCeixpKjDSaEsM4YUTrNZXm/BcVU7KxsNOWWwpGU80rHKeaNLg==
X-Received: by 2002:a1c:730c:: with SMTP id d12mr7423745wmb.47.1557506985321;
        Fri, 10 May 2019 09:49:45 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q26sm5114308wmq.25.2019.05.10.09.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 09:49:44 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/5] arm64: dts: meson: g12a: add network support
Date:   Fri, 10 May 2019 18:49:35 +0200
Message-Id: <20190510164940.13496-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add network support for the g12a

Jerome Brunet (5):
  arm64: dts: meson: g12a: add ethernet mac controller
  arm64: dts: meson: g12a: add ethernet pinctrl definitions
  arm64: dts: meson: g12a: add mdio multiplexer
  arm64: dts: meson: u200: add internal network
  arm64: dts: meson: sei510: add network support

 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  7 ++
 .../boot/dts/amlogic/meson-g12a-u200.dts      |  7 ++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 90 +++++++++++++++++++
 3 files changed, 104 insertions(+)

-- 
2.20.1

