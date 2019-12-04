Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA4C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D70720675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew2kG1pA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfLDNdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:33:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43170 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfLDNde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:33:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id b1so3385551pgq.10;
        Wed, 04 Dec 2019 05:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=A25GspOP/H1evlaxQOyjWW6KvcwnSro5rGpRXcQFYV4=;
        b=ew2kG1pASB0XkGMKDqb+FvwhANd2mlGEDByyjkzl5YIZQLVMXs8kACbWHjVSOM7pPe
         FGvKbFziox2Kz86DbfzEzEcmDZAHsZXiQnIiRz+5XJhFjdS4PmZfPyDseaOm6Kbnw9Op
         qpB88ECx1oRy20ZL/qmyznwusGqXvjdQANOIbUxZZ5U36/w9NxB52dVDCGbDAgRX4IRy
         cqvetN2NCLjdZBIn422CCXNkN4W08d8QeNjymZe6KHz4AILS9pXR5h5eQQO9PlP1Uast
         wV1dCL3rI++ql7jErS1Fm853+LJb/T1Yq1vUIVB28DwXcOATQEujbYjE+o1g9/7bQ5HS
         jcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=A25GspOP/H1evlaxQOyjWW6KvcwnSro5rGpRXcQFYV4=;
        b=NJNIMrmIZgzIy0nCEqivcY1N5KP8dTXdSuhFFahDVl3Ve88rZK5pIKj99Yci7Ul74h
         nFrRYzkkayiTadRBiY1piTcr947eX1L+sfmYmRRQR4FVkNNq+/Sa/sshPP+dxyZrXxef
         /NxIjA/qOZRWHDTcKRoh0hSwb9XixWLX441HCmCI7hga0fBkfamk3oychG+Uf+dYh421
         DtUwZdQGcNSp58bwXRP9hPAzOu6v0wjfiXnP4FxZ7cnY8dOpvLBULxTjEcMIKaN74m3a
         pUC1QY3naYMVLRPvbDH53+YVoKQv4jnCQbLB0Nl/+HoRtRxwpt97EKtJCXEW4KWUa6hg
         /ShA==
X-Gm-Message-State: APjAAAXi9Kqjq9a3NJNU6t1UgQfmy9WHzLaOdQa6uextNZAzkcIjXxX/
        Kd2B6TzWpuIsgBJ21+PEsFY=
X-Google-Smtp-Source: APXvYqx0FcJBl26PQ3mn0KT4C343r/E5Kb4JMSiASKhxNqnoLxnweeSB9zz3gsjhtnOVH9tKhuHy0g==
X-Received: by 2002:a63:d017:: with SMTP id z23mr3578890pgf.110.1575466413972;
        Wed, 04 Dec 2019 05:33:33 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e27sm8553536pfm.26.2019.12.04.05.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 05:33:31 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brian Cain <bcain@codeaurora.org>
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Tuowen Zhao <ztuowen@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] hexagon: io: Define ioremap_uc to fix build error
Date:   Wed,  4 Dec 2019 05:33:28 -0800
Message-Id: <20191204133328.18668-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap_uc is now mandatory.

lib/devres.c:44:3: error: implicit declaration of function 'ioremap_uc'

Fixes: e537654b7039 ("lib: devres: add a helper function for ioremap_uc")
Cc: Tuowen Zhao <ztuowen@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/hexagon/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 539e3efcf39c..39e5605c5d42 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -173,7 +173,7 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 
 void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
 #define ioremap_nocache ioremap
-
+#define ioremap_uc ioremap
 
 #define __raw_writel writel
 
-- 
2.17.1

