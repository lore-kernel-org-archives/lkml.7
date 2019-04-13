Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18659C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D279020869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKRCYL/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfDMKdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37499 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfDMKd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so13880810wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jA6D7OJ9pvsmQ14gC9C8Sc1eaZLUKPQp7K1Sjy19+I=;
        b=UKRCYL/WK9NYcWZFqvmyXZROjuqZTIURzvo6WlvyRqCAkSFWRGFSuBvTdfRHY6SfOn
         7NOky5zWzvKZlJXte5MimROoFpRLXXeSDgP8izp5erl7u58Wc2Vd+dEzh7GspgicrrpM
         z/16YVLJ7QP/TmqeyKl6n6zxX0xFIu/7LdnZeZnf4z8Cl+Wjtw0N4/EHJgg+CXuBb2ax
         hHxc6TtHEyyB9kp34y5Eth3NTJ5B+Tnnyl8Q7Kx5D9eUIEwmxle0Rvg3O9CSnfvJvz93
         3pFjfzv4pXDO30fH2ChKZR8FHsw89we5DnSb9dy2JvW9lAR/Qsf/DdHq82hdNQKRAQ6B
         VZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jA6D7OJ9pvsmQ14gC9C8Sc1eaZLUKPQp7K1Sjy19+I=;
        b=aeMwg2dxb1hf6L8eK7ngXC/W9P3+KYlhM42lV1LSqLAoVPj+IcfLpsWZok4YkCUv9o
         vr5hqiVvrB6KG1nTiKxpGZmhjtBB8wckBxwcSaGmDVfc6Gcli+ZdLRInxu5HM0hxmq/1
         bUg9M1v/w+ZzfN1qdf/Zs4us+Uovrflgdh4zgW5OG2MrJpcCQ4DW3epR+USWNoImlPaP
         CfIb/YtpAb7quxA7pqwpJXTEwKF92XOjXBLfYy7Ht1/IFLB3gJ4iDOgr41aKVHN0jm2K
         +lq8o/QzWIx12y68xPB9JoM2nDDyp7BF2B+vBhDau1R/bLCYvA83HZ1olbkGnfM41YLA
         osRg==
X-Gm-Message-State: APjAAAXvNgIGs5J4kdzM1qhf5jlp1428cezzjOy3Qde7kwOw20DAxMYT
        3yW7hHIpPTKQ98N5TNQuXSeUng==
X-Google-Smtp-Source: APXvYqx5xN0FecUqjKn7zV4ZtW7LGbx/4lQh+2nDBgtZwK4DhRcpu5a5RJegc4Pm4RoVl7bBHZjcMQ==
X-Received: by 2002:a7b:c309:: with SMTP id k9mr14437930wmj.45.1555151606681;
        Sat, 13 Apr 2019 03:33:26 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 19/20] nvmem: sunxi-sid: convert to SPDX license tags
Date:   Sat, 13 Apr 2019 11:33:04 +0100
Message-Id: <20190413103305.9576-20-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Updates license to use SPDX-License-Identifier.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index e7936380ce89..7013f9cc43c7 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Allwinner sunXi SoCs Security ID support.
  *
  * Copyright (c) 2013 Oliver Schinagl <oliver@schinagl.nl>
  * Copyright (C) 2014 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/device.h>
-- 
2.21.0

