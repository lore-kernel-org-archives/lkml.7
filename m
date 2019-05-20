Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6D2C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F8D213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="w4TOcDtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732852AbfETOe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:34:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40934 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731620AbfETOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:34:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id 15so9253669wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bKRlBkskczdPPqv9G18ixpX6ovvQaVIENR175SCnaOw=;
        b=w4TOcDtrhR68jFkglzFkuS/h0l6AA7RAFMFTc1ZKS2SiFvUY5b5VaQTv8FiFD4pL6o
         xt1kKjn8KBaqQjp116lcsnPrEWIe7GjJLqo1tyGpZm6ENdDJ5uZVg9KbI3fqBHLuIReF
         dcBjR/OXXgHxFPBfGo7cx7D5iZY3WIcxzSxzmGfIbYwDJLT4wPAbkYwGnNzcJ7iEe00L
         tvB2S8ulKpTgKYHf6t8VTYikHcaKg2PMtZq8stskss9rc5cBWAeqknOpQ7CAab7TzMmb
         LO5SbbDoyb++CX868C4YmbfL3MhoR+Uy+Kr5d62dDx9k3DwpoWW52l5zxf191TFDBEH5
         +DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bKRlBkskczdPPqv9G18ixpX6ovvQaVIENR175SCnaOw=;
        b=CldRjWWm99bYj/tQlZ2S5Fo2NiTCGKcuCfcX6+lpKSFbWJpqBVuX2BqgCF127F7yDA
         lW6fvU0vOmoArMiP8Y1/EOKOjkRverUbl2Gt1r9CMi2mLVPyx0l5WD/vmACfLi2lRJhQ
         Q8kQelcF/RgdOSymNKDfqO5muQ4PdXvlcyTqjsykaeEdoAa33vj/ajZTLghSug8rU+s7
         7RZTkZViwatNG6wbM00FoHPNMQFYqJGWfkteaaeH1rv+anG3FI44qcx/vDpu/92q/K68
         pGW+3ylq8KtzSoMZsppmuGpnfi2h4j5+dmr0GJdqhVEUCuVxWlM5DY3ce+guL2/iAMVR
         fAhg==
X-Gm-Message-State: APjAAAVauNDHzWaw5M8HrcgmBC2XC76Y8KW+7PUugXuxQDkJRueAxBoW
        6OckeeEI50Y291LCLlGxovpVhA==
X-Google-Smtp-Source: APXvYqx+UgKQ5uSpmtMVwgvlCWIXdlNSISmktEc+Chtb/r17fmqYen2EMJgEmkH9LBS7MXaGKdgbdA==
X-Received: by 2002:a1c:c5cf:: with SMTP id v198mr12197070wmf.84.1558362897089;
        Mon, 20 May 2019 07:34:57 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c2sm12756186wrr.13.2019.05.20.07.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:34:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH net-next 1/2] net: stmmac: dwmac-meson: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:34:49 +0200
Message-Id: <20190520143450.2143-2-narmstrong@baylibre.com>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
index 7fdd1760a74c..5ae474ebaaed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson6 and Meson8 DWMAC glue layer
  *
  * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/device.h>
-- 
2.21.0

