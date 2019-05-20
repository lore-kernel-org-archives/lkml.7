Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D75DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EFA216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="COuaP2MB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbfETODT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:03:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37082 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbfETODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:03:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id e15so14769777wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4GPEWsqSGIyKcLWUOXlYrzt0kxAdz+VJbHUnZMff5l4=;
        b=COuaP2MBnNWmngBntTsQoeRBks/Mc7dW9Rx6RL9bbz9atupXmZyHVyM5CGPycOM/n6
         8xVcnEnPA/L9itDuEmkLpaKMoLR83F33ROmW0vYMgSmFL5werfREgUWBvnn9NH3XsKUP
         T7p8ES/4c276ThMeDFvFkRDy7+3D5GhEy5mhGGBsBofNwqgl+8Y8/wujjk9yGB0h3Gq3
         fBMZRKVvffi4KNCHTppYERrvhI8vDj5br3gY40RHGQD8B1Ia6/68CjrRj4/eoIqBdQum
         0h5X7UECzZQTBNgYqk2dmCC647QtPHtX51c0Vh09eXOX2+wx3KJ4iM9k06dtQvEXoEca
         lcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4GPEWsqSGIyKcLWUOXlYrzt0kxAdz+VJbHUnZMff5l4=;
        b=BpHu9YBQwFOpMxpHhbaz2saVqEcwLChpvw8aUZt+f6QUeQX223RWZg/stz6k/E6urE
         ypllSOdwYIrf8/NThtfvninA5Ax3H6euxByICItHlV0lLx2g5eIHjuLiK6Q89/EhuaUe
         NbPJww704qu0FUEXdthVW2+04Tu5qeHhgzUoynP3ds5YuFmDW/uW1aU+nFtb/e+w4F4c
         sU+mbcBCmZ/KXw0aQ3j0e5JOnxQ71dOI9aemh9ws/YFs7o13BKpUtMveT1wbgvDW8glq
         F9H47fNeCGRjkIKDlTUt2/yzsIrg04z2lbVckr5uhzk0lE2wsz6CN7wgzSDsdcVQtyXZ
         fEGg==
X-Gm-Message-State: APjAAAWdGtEfpXetJeft0SkF0r8qPKH2GWL/NCApUPDujDYR58IJjo/x
        hepw4kX4uMswIuSYa1tzVZK1Vw==
X-Google-Smtp-Source: APXvYqxW2HOtstliXfUJp5IEyuxHFFP18XQUBF3m6AqmQies8+8zwfm7C97xqkPjFQbVAoamlJqbjw==
X-Received: by 2002:adf:e691:: with SMTP id r17mr27306891wrm.50.1558360992409;
        Mon, 20 May 2019 07:03:12 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y8sm14051419wmi.8.2019.05.20.07.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:03:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] irqchip: irq-meson-gpio: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:03:10 +0200
Message-Id: <20190520140310.29635-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/irqchip/irq-meson-gpio.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 7b531fd075b8..d83244ea0959 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2015 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
  * Copyright (c) 2016 BayLibre, SAS.
  * Author: Jerome Brunet <jbrunet@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- * The full GNU General Public License is included in this distribution
- * in the file called COPYING.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.21.0

