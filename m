Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB149C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75167206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqmU0ruU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfHNHYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:24:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46359 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfHNHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:24:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id f9so5328494ljc.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txvhkLq1oQkrQZlNX4f8rqJxytvmF9p8mW3QiWDWHfg=;
        b=WqmU0ruUSunATOxLdt0++LUfIPMrL0m0FDwXtlMlFp4n/xusT3qg3bUXL2UPJp6Gci
         Ay5uQeT6PmVDtraExkqcHnex7kEIwtn5F8juiw8ADafz2baFc7ekSnDtXR441gMzsQpx
         uqJdvLW+aT6UEsWRaudXMTsn/AHDDrkPChMFCVMtFIVqhaJeM2qeJqbM9V33DJtbiI81
         9gMkVScQcL7lhuL/7ssk2vZpuYZhM7pud+E787VO6TronDYn8mC/mfehHe9pThAenDKC
         4fWzH291fd85xpBQxOSh1VeQx/IpvjMiAAXSgOJNdVDheEFt205+iPLSeBcT1J4NnqEz
         +HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txvhkLq1oQkrQZlNX4f8rqJxytvmF9p8mW3QiWDWHfg=;
        b=Fesa0NX3/S+9Moh0+4Av2DU6ttltp+A3SyrtUDAhxfOJ2uqMCkpWAr+loSAbQFCnJa
         r2s5mmpeqNkpIRfuFtzNG3HyzF9PHLjvIJeqh6l7eQAZqdfF4FBIy8T147FqisTmavJx
         qrIE+mZrICNNYtuYEKyzM3EMi2V1IpBIMihEVYGwY07BnM+HIQVnaj0e1kwS3eu4saIM
         EUHuHMJbq8rMiGsl1sdJFbJFXdS7nWVSqV3cSSZjrwIBnhB2db7zbIc017K6a/KmkZWW
         OkGs5XJzzozeR6cB8wdu5ZtHMYY6bkYj26n7pRWkUCGNnpfK+5O11emLJXq3hV0Qxq2F
         d1QQ==
X-Gm-Message-State: APjAAAUaaxkBT9oSqRKCOUjothIL/z81qvFauo79ubtsPCDInvRO3KVT
        Tv+HbkSPu/sOJdNvs5/1hGBDwA==
X-Google-Smtp-Source: APXvYqyGrsxkXTzxQ19BKMuHGWbHsZf86tnrRUDEAjqHv6SAP7M+Z3zcMsDWQ7AOr1zrj0MxxHyO4Q==
X-Received: by 2002:a2e:a312:: with SMTP id l18mr12572868lje.182.1565767446457;
        Wed, 14 Aug 2019 00:24:06 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j14sm21937508ljc.67.2019.08.14.00.24.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 00:24:05 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Paul Parsons <lost.distance@yahoo.com>
Subject: [PATCH] mfd: asic3: Include the right header
Date:   Wed, 14 Aug 2019 09:24:03 +0200
Message-Id: <20190814072403.6294-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a GPIO driver, use the appropriate header
<linux/gpio/driver.h> rather than the legacy <linux/gpio.h>
header.

Cc: Paul Parsons <lost.distance@yahoo.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/asic3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 83b18c998d6f..a6bd2134cea2 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -15,7 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-- 
2.21.0

