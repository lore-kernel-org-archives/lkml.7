Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD8FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C294221721
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tpfLSV4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391789AbfETOif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:38:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44159 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391733AbfETOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:38:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id w13so4149880wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ultmkYjgWhJ/xZHGxkX6N7CA7j/pBGMWJYUycDlyOs=;
        b=tpfLSV4cgjiX4q7HAr6FjjL+4hAE1a2rIdc3QDNDMtisfhHt2noyz4xFmhQW9wMIcT
         l50KHhcRb71FeUBVlXyVxQCYFdvkDPl/kfkuYrA5b0+vUmIK/O68PldpZ8qWqoW+X4UQ
         SdZ2M0ZHnUFpzfRNvbA8r+zDRhj12eEucC+T1lJBnNBt0iava/+NyjaXOUYYHxvF4Ftk
         XDxTzXNGW3SIWGIbST69maQJDj8SAXLLlxZH1BMgizsyEJmFIKZ21i4Icxms+dy9GkWd
         M9d/JAfVc181/AzipqUiOqoI4qD8RlHPIRMhzAWtpg29FDAHRr3wkk93Px41z/CPXAoV
         L68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ultmkYjgWhJ/xZHGxkX6N7CA7j/pBGMWJYUycDlyOs=;
        b=e+uK2cDsGx7Q2+kgJCepH1Jo5wZADcsCpHiHzOARf0495gW5oyIcTEIjOTFG8cyTUg
         ACCb1BeeZOhdvGUuBVa9K/uNO6x9onru044ZnS+HrrbBYanWccqMiweHGJLx80IHE+D2
         IL4IGADfcHe3z+3sUXva2cveQjum+BxzPuMqAA1CBVko9ObixBi9i0dIfdB4lJzctIDq
         Qubj9WrgGraFf9g13aqV1zxW0PAEOIZzBXmDUx3dLAYw0Nzyj+KE6l8z7yHEnDIcYyOM
         7kkqMs/LvOokMPwnIb7OZpJdTh5thyFIOGZnkkv+rORDxqvLiZ/G3Flzm/FUnYBGl5j8
         7n/A==
X-Gm-Message-State: APjAAAUvEmENYhcUNH3u+5xjiXLmoAD6s+eVSX50/mmy+Bdsk/y1mdbJ
        bR4IPRZUvvyxV4m5S4lkkZWkSw==
X-Google-Smtp-Source: APXvYqzWgIrW0/dCRvdB6eUhF/nw2Ad+krPVAseHdSHHJyhHJ7FSI12d8sKvnebQHv1xTL/p6YvoeQ==
X-Received: by 2002:adf:8b83:: with SMTP id o3mr38659791wra.278.1558363101749;
        Mon, 20 May 2019 07:38:21 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y4sm12505976wmj.20.2019.05.20.07.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:38:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 09/10] ARM: debug: meson.S: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:38:11 +0200
Message-Id: <20190520143812.2801-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520143812.2801-1-narmstrong@baylibre.com>
References: <20190520143812.2801-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/include/debug/meson.S | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/include/debug/meson.S b/arch/arm/include/debug/meson.S
index 1bae99bf6f11..df158693a327 100644
--- a/arch/arm/include/debug/meson.S
+++ b/arch/arm/include/debug/meson.S
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2014 Carlo Caione
  * Carlo Caione <carlo@caione.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #define MESON_AO_UART_WFIFO		0x0
-- 
2.21.0

