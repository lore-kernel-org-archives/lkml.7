Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2686C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A083E26FC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSm8CyIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfEaXI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 19:08:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42580 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfEaXI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 19:08:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id o12so363482wrj.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 16:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lXGJJGRdK+7Mhn6kDAcXqEfPisaHBcAFrLZGIKetik=;
        b=sSm8CyIe9SzlBDr40vLrDOr/j2fAY3SoT3HxBs2KgOPVSQaIRtrm1tjVcnUS1INJO4
         Jxnd53mjq3cJwPFyHEoRUqfCxQIYTnUjlb2qQiwcK4bnteiUr7P9hzDd6vdQC3/VZec1
         PxngvqnHQb8RMnbC6izwqS93e+Hi9oZVMRglRAnhZ6KlfktcSNeNFocbZGPZqCLwurCg
         /SuVVOiNC8zAx1ED15C05xjSxrSMye/h8JcCep2udPISNRX+t0gSHhUv43WmhtM1wSIo
         Syt7rtefvZjc4abI/3hvAwYzB1yLRqm3HJqnQa++/L4EKoJKPGqGfSQUzY5EFZa3KkgG
         SbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lXGJJGRdK+7Mhn6kDAcXqEfPisaHBcAFrLZGIKetik=;
        b=oEHphfw0krAb1yWGvnlZxzB7qfvqfqCDwBRnuEoi/f1RHxhdct3LSOFliEBPPQWRWs
         3rF4ex/2Y4sfBHmYSKVVwpk0AMzT0iw+Y1H4JSC5VvESKFTHNXhQJTKnsF996fZwcvwr
         cvmNdmQ+gYQuqfwCrEsPYpD2QzpIEVgq5WQA5wkLszgXGG/INvpXM5uNp0brSzD0ZvVQ
         gBHGsAe7V4p7hLQE4//C/t2KyKyqYFnYs5wKFrIkG/trjdLoQx4LYtSkKlALk72V69te
         ojF5O3nK2Zw2cAzFI4Ign6jvbnAkG8gof4NjUPQBIET9mJ6mspe3xNS0yJJUDmuOQtZF
         wSXA==
X-Gm-Message-State: APjAAAW6XYFpI7U17CE8+f0xQ1TkgjNOE3Ga7fYc5iaIyfIzkHZzgqy5
        GdYDNQBmRDzJVD6ft6kHlxjCkw==
X-Google-Smtp-Source: APXvYqyjpprq46/pLxoJ5SaZr7OViHzmH5sWIGr/pTT1jcAsaFQdXn0NQv1ZGfkrB29IH9WL0edq4w==
X-Received: by 2002:adf:e286:: with SMTP id v6mr1108236wri.340.1559344134957;
        Fri, 31 May 2019 16:08:54 -0700 (PDT)
Received: from localhost.localdomain (catv-89-135-96-219.catv.broadband.hu. [89.135.96.219])
        by smtp.gmail.com with ESMTPSA id k184sm15271171wmk.0.2019.05.31.16.08.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 16:08:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH] regulator: bd718x7: Drop unused include
Date:   Sat,  1 Jun 2019 01:08:51 +0200
Message-Id: <20190531230851.8084-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not use any symbols from <linux/gpio.h>
so just drop the include.

Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/bd718x7-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index fde4264da6ff..8c22cfb76173 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -4,7 +4,6 @@
 
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd718x7.h>
-- 
2.20.1

