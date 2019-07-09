Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10044C73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BE1214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfGIMZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:25:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40871 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:25:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so3010792wmj.5;
        Tue, 09 Jul 2019 05:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ea9OBefP7pvSSVqfUjzFtJLO1qfu1J5IpuBC6szvXA8=;
        b=lIar8W4V571Uxu2sERl4IlWUHpeepEqFxd/bFLkygRHMvazE9Zr+z/Yc3aTF8JC8Ra
         B55X43nzw41xyOLFNVrJJhwdsInndY3rU7HG9jZeEqP/C+K/I/9lj959goQLVF02n5E7
         FrXMazJ4C+P6EVwBN0ZAUGFvD6E+lEsbKGzWKIMxlkM5xpTQ7WANdGIxf5dOW9YGbdKf
         xGGXv6wyAE6YXSNaAs5SSExZCicSfiCIXHir0k1m/CsFY0H4RbVapgdkcpBoK8pvPViI
         p8aBxqUTJfjtBVyMR88jy3UrFCDqdcUu1tdCo8gXBqTKqoRxgxHlXlAp0GK2d4090G8a
         TITA==
X-Gm-Message-State: APjAAAWfy/ruBe+CvDucBWLiNoHuLMrRdYdSwCJ2gdsNHx6F1oBuoz42
        MemV8yl8cj2+HgG4jLvli4E=
X-Google-Smtp-Source: APXvYqzDZc0RyEdZ7iWpR3epirfMFXKeXritactUFpnbeioCQkvkLq+btZ7C1vEOYk7kJC7xOrnXqg==
X-Received: by 2002:a1c:7a02:: with SMTP id v2mr22236575wmc.159.1562675114409;
        Tue, 09 Jul 2019 05:25:14 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id j26sm21223565wrb.88.2019.07.09.05.25.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 05:25:13 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/zcrypt: remove the exporting of ap_query_configuration
Date:   Tue,  9 Jul 2019 15:25:07 +0300
Message-Id: <20190709122507.11158-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ap_query_configuration is declared static and marked
EXPORT_SYMBOL, which is at best an odd combination. Because the
function is not used outside of the drivers/s390/crypto/ap_bus.c
file it is defined in, this commit removes the EXPORT_SYMBOL() marking.

Fixes: f1b0a4343c41 ("s390/zcrypt: Integrate ap_asm.h into include/asm/ap.h.")
Fixes: 050349b5b71d ("s390/zcrypt: externalize AP config info query")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/s390/crypto/ap_bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index b9fc502c58c2..379e43b79006 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -208,7 +208,6 @@ static inline int ap_query_configuration(struct ap_config_info *info)
 		return -EINVAL;
 	return ap_qci(info);
 }
-EXPORT_SYMBOL(ap_query_configuration);
 
 /**
  * ap_init_configuration(): Allocate and query configuration array.
-- 
2.21.0

