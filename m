Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BB8C072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9588216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WOQGo5E3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391615AbfETOfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:35:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37770 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbfETOe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:34:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so13317231wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jL8EOSTC/B97Q4hYmRDMBEhteRV4Llk3yLW6XJX3YpI=;
        b=WOQGo5E3cBke6q8UgR21NkLOtOUFmM9cJSAy8j0HGje6MfYqcjKkfQ6zQhG+HrG6yP
         tVTmu021qWNJ0EP6J/uvHe/UnTsSzLi58ScfYOr8hRnQr1aEligQKbtbWPPuK0zd66MP
         OgqWP2IGRpvc7D6/qBR6k95C6yNMuUtOYM9cBWSH6Lrj4MFrDPneMgbYJIvK6/rXx1S/
         ZB6nb4s0sRBxmATJZi2b+oG+T3TB9sJTG0jbi0xUo12BwK8Lz/Ze/0t4jJLf1yn5CICi
         ClQSm0KVnlq8x/QxBtZ6K4ZNrpSOiB7b3gvmL0sd4Xg7uOjpyms8cGcVg+5y/SmlEesx
         R40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jL8EOSTC/B97Q4hYmRDMBEhteRV4Llk3yLW6XJX3YpI=;
        b=A5zbFM7BNmFdJqVJwMgTJVgbH2UqSM9zrwbsHWVUDLY0YHFkYhhQBECqP1vpxZdUKB
         rCzzlm2mFRRgtF60vBVW+IcLhrxF0E4xWiefRHK7EE7iXgfb4WAaOCKutSfwmh+HR2Ul
         SkAXKbC1v4Cx6FUuc2dDV1/1kA8VL8vUoD79Ac559rGwtKO1227PpIHtBMHtcuYXP6hY
         5hJd1vGLe0dznV8taRgiHfZRCdvAyNE5apuhZX7rUaHipLo7gfyHM3UbCE7qYqF0JGG+
         0ABN7dSN+IDXbvz0eJoWD6Jue4ktnUrJ2QQ3h80D8SlQr2hyK6wb5PIVFoG5I+SOt/K+
         cM6g==
X-Gm-Message-State: APjAAAXLMtH0HzOKVQnVk22G5Oz43yx5JvnauARcZBQ5A3hCSP4Jrvvy
        C8SpDv5XCTflKIXWntp3ubr4PrF8jSfn3A==
X-Google-Smtp-Source: APXvYqxZ3+v/oE9giWxGxEusI5X93pq9x7W3ufJ2uNkz5Lh5e9NxuHzhkG+fIq3auPMxo0dZb4l8gw==
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr28896695wmj.127.1558362897942;
        Mon, 20 May 2019 07:34:57 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c2sm12756186wrr.13.2019.05.20.07.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:34:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH net-next 2/2] net: stmmac: dwmac-meson8b: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:34:50 +0200
Message-Id: <20190520143450.2143-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520143450.2143-1-narmstrong@baylibre.com>
References: <20190520143450.2143-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index c5979569fd60..c06295ec1ef0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson8b, Meson8m2 and GXBB DWMAC glue layer
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

