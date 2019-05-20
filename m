Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A59C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479E1213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JPqUrDoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391624AbfETOf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:35:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35040 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389902AbfETOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:35:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id q15so13308298wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Tp4igOWpLjFstT7mLomxyhxOJ4hU08I+JLwXX6vyLs=;
        b=JPqUrDoakqnlNXwLx1lJ/9ptBcMPzrsThemzcki3b6ofuygt+rMIhSe5H1Z9bNH8EH
         spSKD5ih854XSYq1hu23Yym7GTbY12olxkhbKtDv1xtJA+OZwcBSh3/1dMJ2WF5Wt7bz
         J7PqqbgIdPa11jK1gePhuUu7dLjcuP6/NMnaPTIBcazTKwf5GC67mptW5xRkZBDrpKth
         QP68/z8WoSfVUSHZ2kWt+Wqos7mjOjg8I1tYR1vSkPGQFLVUhWLGwK+sMqYonZQltBYc
         mlmX3p6qmt9C5eg5Bgqiud7GO5YFflDf8ARKF5FCHdHe+BbunJz6cIMdsSTHyXVlqRDX
         N4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Tp4igOWpLjFstT7mLomxyhxOJ4hU08I+JLwXX6vyLs=;
        b=J1pqx1xiSAsiEx1hhZBe5dYiNi1sMr7Y9+3kpZUN2JJ41vP5QvhXDYSbpwCH/5txS0
         1miyV1StfEvD+qqE54i534M+YmKYwzCStxNEk4b+aP7AK4hywzmVwJasFhbiq+uUZRSj
         gg/h9tqpYpEfdEnS4p962uCYe0C5AtECyTdNHhbtsKPwIIuvrdIUFYtRbeGn1nnCmfj1
         WlK0tTcbiaWY57O8OPndjoKgfbAB7b7J2zNTkekTxZhCUJPgGUoau6qrly6MCjqiqJGR
         QJ6/7qZbt9xRxgdTPeTBzE6iIPvJP4kh4uIfr0GU5FZCtbcyvfK5fDk8Ft9pH15l0OvK
         lkZw==
X-Gm-Message-State: APjAAAWe/luPs0P2D3ubGqfvQEhVzVmHF7QYH35qS6zAkt7cldMddGhs
        nls/ZUE3n/uqskY6BU5ge9baAs+922w8MA==
X-Google-Smtp-Source: APXvYqx5u+oQO4+Xw6KSmmZolOHTKAmznD3CVkpwkb3h7EAzR6mYiwKcj9TbtCtuNa7vGpKGbovjFA==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr11793629wmj.32.1558362956333;
        Mon, 20 May 2019 07:35:56 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j13sm14042591wru.78.2019.05.20.07.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:35:55 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] phy: amlogic: phy-meson-gxl-usb2: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:35:50 +0200
Message-Id: <20190520143551.2330-2-narmstrong@baylibre.com>
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
 drivers/phy/amlogic/phy-meson-gxl-usb2.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb2.c b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
index 4cbee412f2b0..c86255f28f1d 100644
--- a/drivers/phy/amlogic/phy-meson-gxl-usb2.c
+++ b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Meson GXL and GXM USB2 PHY driver
  *
  * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

