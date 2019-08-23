Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9883AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676C722CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LRxuLnOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405110AbfHWHDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:03:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36521 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405060AbfHWHDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:03:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so7616143wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uI8qQhPoSb2o78mSYJur6fMHkdVTqendruK+vUMA+EI=;
        b=LRxuLnOgnkev29O5lb2dlPiBfPa1sUXeWz/jSvH/c6uTLmk9wmTZ+lv1qzIcNpT8x9
         jGq7Zs6Iv3r3izu/Eaq0Ej/39vRhNMYaO8vqse6XVCA4nLV4tGfzmDhu1Q/3yXJ73uvf
         LDFzEC5eadqmsQpAUKSMwUzmM20p9FQEDc0zFoXdOD/c8ufVi5RExUfpJ6l/PmaTQwgX
         mX7OFYVSszT4/R7dzAy2fTBcM3kemZTVLhBpg5th3IblC77zRJnLEOC4tZnsDJ0mt4b6
         ySZJW5y8+2KqFkEe3mLTqQX2YdgHIaS1fKrbrzNFpi5/33EZ/ufy3pfi2a5WMFzMr852
         8UXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uI8qQhPoSb2o78mSYJur6fMHkdVTqendruK+vUMA+EI=;
        b=iyd4QyFOCDY52SYpomZ6JtoHCa/PWDgCdPec5mMJSXQE1bFtDP3lkQWdZDiSVqf/OZ
         b0XB66QCZwp02qiayZ8afNFVLiyC7ODLaNmvDbM44prKa03a8TaRw31MiAEg/yL1+e2G
         /K/fv+bfRsBxk0t4J47RAP9WTVm+mJUq74oS/9rUiqUDVlCNa6UQ7KD8Y8KO6QWzxULY
         APdJ+1Kn5vGSyjHU6+8wgKIyS40VJsLGyh3xvs1ppwYZoKaDJ0+kC4jlxYdAMdLVgiSO
         PDeBrj4RJz4H3ScjY2iwJZUd5EQ7hvIs8e9Ff7eAlmoZjuojLwWvupy/Wb9pHzas7rpZ
         Tzig==
X-Gm-Message-State: APjAAAWenHReL+6un6vsFoMaDsq7q+lnc2Yfc5XQaKYWhulo9NH/04yb
        ZP3OzQF1BdtRUN+PHobNbW7XbA==
X-Google-Smtp-Source: APXvYqx5BXWNMME8DGfmLerCyIhSAAFxC3+YjVaDJOMVLxMm/VisM7XkyefM1tsKyH3BQ6Dfmiwqyw==
X-Received: by 2002:a5d:51c7:: with SMTP id n7mr3013137wrv.73.1566543785617;
        Fri, 23 Aug 2019 00:03:05 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm1741833wmg.45.2019.08.23.00.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 00:03:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RESEND PATCH v2 12/14] arm64: dts: meson-gxbb-nanopi-k2: add missing model
Date:   Fri, 23 Aug 2019 09:02:46 +0200
Message-Id: <20190823070248.25832-13-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823070248.25832-1-narmstrong@baylibre.com>
References: <20190823070248.25832-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxbb-nanopi-k2.dt.yaml: /: 'model' is a required property

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index c34c1c90ccb6..233eb1cd7967 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -10,6 +10,7 @@
 
 / {
 	compatible = "friendlyarm,nanopi-k2", "amlogic,meson-gxbb";
+	model = "FriendlyARM NanoPi K2";
 
 	aliases {
 		serial0 = &uart_AO;
-- 
2.22.0

