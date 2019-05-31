Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EAAC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4287226FD4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFTrUeYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfEaXGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 19:06:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54413 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfEaXGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 19:06:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so3762060wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 16:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHs7Q+7eiRr6o5cvQUXVsgOMCj96Y7GEyw0Jj7X/LGs=;
        b=fFTrUeYZRUfZjCLTHVcQcD/0XAbpRg0e7v94LUS+1qu059vhysSucEYr5PiZov2YrH
         etBOitUjh+MlI0e4gl7v2CDuS4lKadnh5FF34dfVzYQMdWqQ2t+/s+QFK6Qngi9lVRSQ
         bQMu5+rgGUv8mVZyWQ0yVQmZ8gpHk4SGAZB1Z6Frm5JjfYuJFNfLMwxqYR5FtSLnhcoD
         e/POn/rM2g+PbedUEJnps7Et9V09E4KQGQKKbdJsXhQE0bb3n9KkReRi7dMX8aNLGDud
         wuGLBoI7wG5njz92P03FB6ySqdFQhHNjgUvCZk7bn4s8uVZVArVlfyPsBVuVvFz2S4gR
         HjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHs7Q+7eiRr6o5cvQUXVsgOMCj96Y7GEyw0Jj7X/LGs=;
        b=SyIT1YEjjqb3bePOoxlrardkPN0gJNmln9tnAoJNmCz1icz5C1wc51eTf5IYqQexGD
         p5tDg9HKpd/aoEx8X/5xfPR2Fuq2WBwQBLmQUYOjT74XiNSK2IOY0FwSfSJIS4N09rbT
         goA4jOZMOTDYFnnuk/wDiFXperp5Sk6mPjrFgob/45eZK+7PMEzKlTvQYBKyxqsxeIwN
         JDQfDlR2xbrWWqRgGHAcUPiGprs+CQzJa/q9yujjEo565Rh5sAo1lEyelc6FTmTQo7FF
         nXOmO6SwF3RrBMJN4Iq1pjZ5ObA4g5iqPLvGWpJtBr6qE2gmkzVD5TyrTz09YPGTwaqC
         QZdA==
X-Gm-Message-State: APjAAAUbI5gbhE2CDosUQotaTeSwIuXjuInJ+hThHtd0DxrkxvwlTHqd
        ktbFGM8WNexYAbMzeKR4Mq8ctTgqegc=
X-Google-Smtp-Source: APXvYqzbpBMMLWIpzfEucehHl2OxSZQZUHvdkP/nYc0r47mDZwALeHhtbNQXa+eEpldpt3CLOKec8A==
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr7287814wmj.41.1559343973033;
        Fri, 31 May 2019 16:06:13 -0700 (PDT)
Received: from localhost.localdomain (catv-89-135-96-219.catv.broadband.hu. [89.135.96.219])
        by smtp.gmail.com with ESMTPSA id f8sm413384wrx.11.2019.05.31.16.06.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 16:06:11 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH] regulator: bd70528: Drop unused include
Date:   Sat,  1 Jun 2019 01:06:08 +0200
Message-Id: <20190531230608.7361-1-linus.walleij@linaro.org>
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
 drivers/regulator/bd70528-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 30e3ed430a8a..0248a61f1006 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -4,7 +4,6 @@
 
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd70528.h>
-- 
2.20.1

