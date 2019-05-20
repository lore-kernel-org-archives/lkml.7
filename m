Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872BDC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D14C216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0uHHRnJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391833AbfETOl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:41:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45882 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389030AbfETOlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:41:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so14865844wrq.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/eIOsCuxZwktl3xw8ay3mSx96v8QQ77Uvy6NZl0E648=;
        b=0uHHRnJUYdVoRrTFCqfzIRBv9Av29o4nV8C1TIS9S2aUgCicSRTzNLNnFQnKRyYvAT
         QRSxLM2pahL9yUiWDWZD1soaAnw50vTNmx2iuYfW4OAOFqhaltwHQQwu+hmwD88/tTWm
         7ISI3n+CapSqNCCeRzTtEl7EGbIVfJDcGGvJbWqciTEUQBaw7iYPj3NEKaGILqutpwaJ
         6+oeEkQw5Tc8FBI1CwD2UGZWEOeyLWNFsPiQMFF6EWyYGnXYBCebV4hTKriArm1d6icc
         U8ZC5B9HOFWd6ryyKpSXF9qN6SjUmtErJpkzHz2A3sVH92U3w7OmJKDiCWCKCLJuTVCE
         Ikug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/eIOsCuxZwktl3xw8ay3mSx96v8QQ77Uvy6NZl0E648=;
        b=a/uAEq4zTIoOnpDH4RQy4c5si+GWAw+pR29Q8HosIARJmpzIqIFGgQDqMKNWSMff/C
         UmzqTuouon43fgx4cIz8VMt51bMOYhUoAoewsIjiMqOerwA9Yp2UBinxsi0FjWpZFqGK
         JciICEfA6C2HV+T0BdJWdVnBBr+Y1mGgfVQn/xy6Toky8IvKMQo8pVPph2c7pp3De8K9
         AV+2qFwBY1LmR6/XGjZ4O3iD7jfBGrc1URXHfc4oEnW3JEeissFSCU0Yyyoqrj4aQ7rR
         VRJ+sVWpSVa9os8ymgQ4PpsmXw92OZdsepSr5b87WQ5g6yAoiCqPDII2zt5M9azreqzA
         2fWA==
X-Gm-Message-State: APjAAAWzhSnztvqa6muB4R7MkVtRrvntdFBLcFSp3kUpX0R7moRoRnkw
        S6hfpvRwokMFwodT9RZC3UcMGg==
X-Google-Smtp-Source: APXvYqwgtePZNKu08GKGClVL1s98oqOvHASlh3T+I+k6sUKnVg2QOZSHDtEWj4Cg2DLN7JSb8cfegQ==
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr33715538wrn.289.1558363283611;
        Mon, 20 May 2019 07:41:23 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w3sm6743679wrv.25.2019.05.20.07.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:41:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/5] dt-bindings: gpio: meson8-gpio: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:41:07 +0200
Message-Id: <20190520144108.3787-5-narmstrong@baylibre.com>
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
 include/dt-bindings/gpio/meson8-gpio.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/dt-bindings/gpio/meson8-gpio.h b/include/dt-bindings/gpio/meson8-gpio.h
index fdaeb5cbf5e1..e1387a8520e5 100644
--- a/include/dt-bindings/gpio/meson8-gpio.h
+++ b/include/dt-bindings/gpio/meson8-gpio.h
@@ -1,14 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * GPIO definitions for Amlogic Meson8 SoCs
  *
  * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _DT_BINDINGS_MESON8_GPIO_H
-- 
2.21.0

