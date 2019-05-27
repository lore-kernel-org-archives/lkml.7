Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605C2C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3623D20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CzfTYlgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfE0NpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:45:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42373 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfE0NpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:45:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so17001304wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yKlrJZSJfkJAMunRaPk1pX4C2NAtlEVVJ1amc5U2ytE=;
        b=CzfTYlgihs929oAZAwxnDUHHBZJEJOFJH212FuRaJP+I1NGIwXrnHFYdraVegEotLd
         OfrrYV1/8IamzBsQby5uirbaJ4GdY5uw/p8tiYhnNFhxbQ1fwrVDDLA5Mhb2y7j6KvHR
         /9/5y6Qocl/t6/TH5I2QqSMcvwFPu3uqBKk1F9gaaVK+mdH7T67VXSXekDNxyj+CXNQr
         MTJPy+dOMLAJ5PqWnHsN6g0nRoXYFHqOAn8nDWpD8Rd5PZUQJ78XOWiorNGe+YW32tHL
         4/VyoKlu+IlArUKiUBqFKAZLwNaHLAznVi7AwdQZhYrzx8+zqoFDoSavknJNiycIObGd
         LGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yKlrJZSJfkJAMunRaPk1pX4C2NAtlEVVJ1amc5U2ytE=;
        b=uC3xm+mye/0vPg3Lion5AnfECBAFb5pIE33FqA0qS04T5sM/pFlbVJLkOI9S29IhNl
         vP4xs9aqjej18Z3t2sK3ufNBXnffXQujImXiI49QP/6hNEU9lYzDKXIVV7x4qAy2MSo3
         NQ6oot9p5LZZJwY7j5Si6Ho/f6ls6ohqjOov9R7Q9nuQoTq7N2tfPVpAjxtqvrAFQoVW
         kuf0X9WxgsU1+4y5AKaEIeMwbMpzy8NgIKRZcBNRP8cc7VMeUmi1F9x5wdJAd33RZHQH
         iqDtOCqMZkvjbmL76RzbDRQHHGt/IlFDafVGD0udj8JpLrz2lW6Q+CVh/gv2WP7x/G8U
         mU8Q==
X-Gm-Message-State: APjAAAXQdSxZhLQp2zRrMojShZRiVQPoUZapd8c13JTwrJYOJzQVPP1r
        Q/ISL4630jaFIo75QQS2lJY+T7IIto4vXw==
X-Google-Smtp-Source: APXvYqwiN6ifcwXnGcZ6gnfqyUyC6M9fEaB3L7zOO03zuwpP1KIXSNdkJEF5+lVA+07qYStg98XLgw==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr12646301wrs.191.1558964705068;
        Mon, 27 May 2019 06:45:05 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f65sm19615654wmg.45.2019.05.27.06.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:45:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tglx@linutronix.de
Cc:     jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2] irqchip: irq-meson-gpio: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:44:56 +0200
Message-Id: <20190527134456.5112-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Changes since v1:
- Use correct GPL-2.0 license

 drivers/irqchip/irq-meson-gpio.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 7b531fd075b8..1a6bef48bd22 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
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

