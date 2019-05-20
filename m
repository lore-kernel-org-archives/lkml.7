Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F07CC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E68213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GApKEWEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391632AbfETOgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:36:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55740 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbfETOf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:35:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so13548096wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/IQIiBxQQceOQ1Fth2H/n6wt8SG358oGzAhtkipV64=;
        b=GApKEWEdPnbMaWzQa05Iq9QP1y91iTXaYPumr/5P89B1mfgAlLJ6NOI6iWJ0OIuhEM
         59M8j4XvcU5auApgPlcPlIrpAeUHzg4AzZQIFXBFOdRv1sShBhO2kDo+XyUKp2DWCb+i
         THsAfzL30A0LNUfSXUroeZS/KC5t99UMoCGNQHrFbg5IgGxUGe/bDXY6ORw/1EEBtujG
         zAlOnsdJnM0htJTkzGD+pDHrIwOEBmVsp4p18Bq7NMsDwnXUFMdJOFerr0feU0Wc6SYE
         6poc+5Vx7UyhZhqUWYxSga/buwo13xOpQpZqC8z1x1vInhq0awN4eyIMOYXdz2/Vklcm
         WG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/IQIiBxQQceOQ1Fth2H/n6wt8SG358oGzAhtkipV64=;
        b=NImHP5T7pJ12Ge3i8bA0OSGWFtj0mjh3Qbjfikf0eKvBnTDAv7a9/UWWI0zXKYUSjr
         SAgZVi1KwQ1BzOG+N5VZ94+GCS1iIOS+b0WO4ugmx4xU5TyWgbwCDI/JY0eeEYI5b7o9
         xFYUDjKoApDPy8mpKfgIcuO7+//9mnKOAP5nYGCLp5dlgQtvXEGZf7XYcod6l3Aek2J7
         B0xVcofppv+IcUPvj9Uh6D6HW2xpYnFg/7Ebq2rxY9XmIjvAzOhI5n4SMAG/af/L5fMh
         /x5n4Ns+sWhNZxbACMkPdbU8UGhIxyALF4LqLiLTH71K6Yo/toHkouUTWygoDxPh1e3r
         Ri5w==
X-Gm-Message-State: APjAAAW7DGlTlRGDWURKXuEB/uDnDB1UXm5x2t2RnPm2MgRowguVkQHf
        Wb/gOR3Pabutx0bI+tQXvyb+Yg==
X-Google-Smtp-Source: APXvYqwetj4Xy0Szkpqs0+6b88v6/86NBnhvTXRKC28fd1PYFkfi9fdcPWhg4U8BxtlCsQaiSSlFQQ==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr11888332wmj.41.1558362957248;
        Mon, 20 May 2019 07:35:57 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j13sm14042591wru.78.2019.05.20.07.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:35:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] phy: amlogic: phy-meson8b-usb2: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:35:51 +0200
Message-Id: <20190520143551.2330-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520143551.2330-1-narmstrong@baylibre.com>
References: <20190520143551.2330-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 9c01b7e19b06..5f17f10f4df9 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Meson8, Meson8b and GXBB USB2 PHY driver
  *
  * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
-- 
2.21.0

