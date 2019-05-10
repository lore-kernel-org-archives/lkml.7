Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5B5C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC9221479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRge4lLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfEJSqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:46:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40119 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbfEJSqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:46:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so3223319plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dPDd/YM9fuCowMTaHQd8BfNjmuB6ogsRazQppobQnOk=;
        b=NRge4lLWD34biN0HHsS/x8aInIwIg5449s38rRUe2b0/8SnW4zv+QbBxyJPusOweym
         0iYZGwSNRA/DPj4DG9+u1MQyGvY7gJoYQKcBqsOXu9jS6AiUy68k7dUm7YFe0mSST0id
         BM8p2K/JvC2igpQo4fbfyoTosL2IiCKUcRPhyqtDpx5+CxNl1ETwWePfynSz9gzd4VUB
         Sb6RuEXRE2PD0mhqC6xRjlzGgokemAOlT81WJMlmcyba1bE5AIc3hlX6N2Wwh0m6AfQH
         93yEBUME+gM4A39ay6tGELN7vvSc7Vz4DtbW7MW+iKet35dLm7AsT4Gl9D59Ho4ZQaAE
         OFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dPDd/YM9fuCowMTaHQd8BfNjmuB6ogsRazQppobQnOk=;
        b=iItJAjZNJepGmaaFkWNwxqYBmDZn1RidwZc6TrwHSWe+Dhfc2KhPLUggGRZEnHzsk0
         r+uvADAXoBJRGxax34VbV2xQaDppwnvAiT2KXKyLL0NSuVq4qRPLi/bsZFeoyH67zJQ6
         TTFNXqC8vZE8/+f1VtJphVol3US0utbD5/nk8CoHvxGeLzPgzkBLRVRt3hhzQQrnMQTe
         Tb+ag4Y6GWFGkvT9HokaoIRaBzgcypHVfOogMkIwjaZ0UQHWqwaSuAsv7SUPNUlrXfMD
         34NRKoanY0l2PKjXF0qrWLyymtt6cD9gRemJY+VaOWW8K8O5TpPb5JuJD74mJV109RWC
         Ba4g==
X-Gm-Message-State: APjAAAW6zxPaGp9ZKwjpu1rxcpk84Kr94imUZ9l24sw8MfDSq4P3EqZ/
        wcmAn2ZDfjehDJbcP7gWQ3L1
X-Google-Smtp-Source: APXvYqyPMEoC0n8EFpYKyCnf2TvInUdFcI+6TRfWMqJ4w7ChCXirM8cIzI85YzSAFPzflzzq5xI/mA==
X-Received: by 2002:a17:902:ab98:: with SMTP id f24mr14847531plr.223.1557513966313;
        Fri, 10 May 2019 11:46:06 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c1:9991:95b6:5055:2390:bf9b])
        by smtp.gmail.com with ESMTPSA id g188sm8652049pfc.151.2019.05.10.11.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:46:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v3 4/4] reset: Switch to SPDX license identifier for reset-simple
Date:   Sat, 11 May 2019 00:15:25 +0530
Message-Id: <20190510184525.13568-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
References: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to SPDX license identifier for reset-simple driver.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/reset/reset-simple.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 5e8c86470e6b..8043ba48a30a 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Simple Reset Controller Driver
  *
@@ -8,11 +9,6 @@
  * Copyright 2013 Maxime Ripard
  *
  * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include <linux/device.h>
-- 
2.17.1

