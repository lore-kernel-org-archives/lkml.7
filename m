Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ED3C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD8320866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGLNI7tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfFNOc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:32:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42000 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfFNOc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:32:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so2763480wrl.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUVAO9iLGJNRNJEPd7H1CfX7s+UdeP4IbOhhoga28vY=;
        b=BGLNI7tU6zps67gzg5Opx9rF/JLyRRffawoMDt8HYwlF0w02JdFZnXrrothPaqdAzX
         qci/LAKxC7Dr/9dE8ItskLqFe2QPGzVuwr7CYRM+9H7d+jnlKbSg32rRwjs6GyvgQuap
         9T6+ZXbcOIyScxbpRxDJg9qcK8PXvYvKcouH3hhu73SCeN80UeBYWAk50V+RVIA7YYmz
         szKAG2dPIKq7SzmRrfXyD0SJUOv31Ky6H4aA6VZMu1+n/iJUprllFdDwI2aw9ujnu/i8
         VM3kTGUMBCYSIaJhFcSbFIeU629Kcz3ZKlzeCFNGbogkKzAEXdtK3bbP62F2KIWKp87Z
         XoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUVAO9iLGJNRNJEPd7H1CfX7s+UdeP4IbOhhoga28vY=;
        b=C8KaUU8o3vPpKPpvZ6MvFrmEe3M8g3dB6UobpbS0bsTrZvTW0dCu0g647wUAk2JXER
         bUgk9zxFAeNQmpxU668taYdQkwzpU+uaVZKQAVMpQbaP2rTlo8OtGk8q8+n1osshMag8
         2YlyKeFkK0QYh07Tht2zy6FByO7Cyw/t70BK8T/0mTFq+BN8kp2s9qweOSB86ur1hsb4
         jXbk9HLX0IrVGw6v/YvCQ/+Cj2kpUUKE6xrr9ujeh4A+DYC7uk7gSEuUEx7z1DAAxze1
         4438b6xL54Tv6WLLMphAqPAXnl9lkTVF1TG/nwvg/ePGGNNssvwF1vqUrGmk4WccMNVg
         MlDA==
X-Gm-Message-State: APjAAAUYvrnKdYhP6aQ9rWgqqeBTegnlBTeN4bGU7A3nO/WlH0HvamFi
        1N+1mCRSQgFYeqT89N0iAtU4bEbC53rldg==
X-Google-Smtp-Source: APXvYqxByHhhpN4LBQH+Lym3eidzYUkKun3Cy4qGfJP9ZhKTCVWqeqYsR3cLBzrMopEHQ/fyTyVMkw==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr63912708wrp.133.1560522744176;
        Fri, 14 Jun 2019 07:32:24 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t6sm4738007wmb.29.2019.06.14.07.32.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 07:32:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] nvmem: meson-efuse: update with SPDX Licence identifier
Date:   Fri, 14 Jun 2019 15:32:16 +0100
Message-Id: <20190614143221.32035-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
References: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-efuse.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 99372768446b..9f928fa9964f 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson GX eFuse Driver
  *
  * Copyright (c) 2016 Endless Computers, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
  */
 
 #include <linux/clk.h>
-- 
2.21.0

