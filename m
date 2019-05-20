Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F10BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CED217D8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E1AMWXuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391853AbfETOlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:41:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41812 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387800AbfETOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:41:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so14633683wro.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1us822oM0AhXAzcfAqzMQ3a5bieM7q3ASmOGadOuJBc=;
        b=E1AMWXuy38k5enWVyxUIT/ZFjHFZOcLT7CtTfUN1RC08MO3lMPdlB9MZH6gbDpwXD5
         sIKnvw6Pt9WOWPtKKFY5ZZBINljbEiv3mIAs3Zhvs18xzREQM10TX32ptwEB12C4QqgY
         wQ4lwYft+xHb2ElPch/aLITUutJEdMrtuT37fdrqAKdcI2c5c79ymYkeg45++A6eV93b
         JHs+yVdektui4T0pIf5OS1mtK+6pKlECHlMbVhcw/HI8lRo17pkA79XTzmrAuaPNECpq
         O4TXt98WUPh9rzKjCQ5u6chtmr6HTFHcyANC1+0he2BUvbUwG18Rs6RReBGUMJ+J+z7o
         LJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1us822oM0AhXAzcfAqzMQ3a5bieM7q3ASmOGadOuJBc=;
        b=EJd6ltGtGcphYe7l2rrq28ymehxtaTfvK0cUkz3wdGcPX3uSA/2f46GxkFj+abV/AA
         UMjIkSAHgZRcptdfn6MAgxbZb5440tY2hkJpL4luI4xm5DzW1pvZm/mE96ZEAxFWOxcY
         QGNzmA81IL6SrOMeXuFhy+1XgyQ3dBSZ3htANbrK5+vV4UNLe2UUIXq/qXBH6qSmta7a
         dQGMOHDrIYXQ1d+2B2hqxNwp2YFFxzc2j8fWNfO8GpFI0+0Qo6yT5gvzsnIingxTGSdy
         cdHFUpd6hqhQPYeX0JtckJxLOmqBy3somS/Ry+xGSUq6pB0pgNrqkfc6sJ4uWWA2Z6Np
         gEAA==
X-Gm-Message-State: APjAAAVZow3YVgtPdYokI+wkgpf5cn1AnkeUXLF0jFYSdgZUnpO1dkP1
        8mKHEqwH7VEe2uWI3Aeoj+iAog==
X-Google-Smtp-Source: APXvYqzBMSwJalhz2Y3RNdF8Ya61WL0sUiZ27ozMXzLdu3QUKt9tpH6yOyRHK1BjUf1IUkGmcdgesw==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr7135680wrv.268.1558363282687;
        Mon, 20 May 2019 07:41:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w3sm6743679wrv.25.2019.05.20.07.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:41:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/5] dt-bindings: gpio: meson-gxl-gpio: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:41:06 +0200
Message-Id: <20190520144108.3787-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520144108.3787-1-narmstrong@baylibre.com>
References: <20190520144108.3787-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/gpio/meson-gxl-gpio.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/dt-bindings/gpio/meson-gxl-gpio.h b/include/dt-bindings/gpio/meson-gxl-gpio.h
index 01f2a2abd35e..62417358f55b 100644
--- a/include/dt-bindings/gpio/meson-gxl-gpio.h
+++ b/include/dt-bindings/gpio/meson-gxl-gpio.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * GPIO definitions for Amlogic Meson GXL SoCs
  *
  * Copyright (C) 2016 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _DT_BINDINGS_MESON_GXL_GPIO_H
-- 
2.21.0

