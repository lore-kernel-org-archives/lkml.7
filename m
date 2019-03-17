Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE0DC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EB720896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4IJO0se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfCQT7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:59:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42748 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfCQT7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so10665050wrr.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bK9Ov11oNFfu1+tMHy0IsI+Waj7sbWUkp7bNzmSIAkk=;
        b=Q4IJO0seHoF+g+wSVDbm6aSGgk6HLJmLgbt/1/UTL5f2lFvs06OwBxjheC9Tn1n2ny
         TF2jNNlSOXCDBCbaudmwV9E7YttfWEulEyfaYlnvA/3eOf6wkZKYEQ5splMsuWgR1s8b
         PWzb6E6y1pGDthhcfaVpakzang7LhWtD4S3C5MeQkXl7IC6saOu2yG29uhM0NBtVLmpr
         IEHLGsSeG1aHe5u+gUtcdN3qJ94hszqwQ7wq6vHnSvwV3u/88vQd9LSeGVO1a+GyJWZk
         TfaUtgMJH9lywVMmnJuZJJVy7QOxp7NY0fmLqbl18e0AxbHzZO5nhSqJ3gWoZcRPGdof
         4QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bK9Ov11oNFfu1+tMHy0IsI+Waj7sbWUkp7bNzmSIAkk=;
        b=GX8AXtoxhyQ/9ZKFcsl73eccaFlV5jhXrCZxuCQsAXrlsk1ljxulcGLuA7dkD29MLF
         r2vf1hIeseH//T4U0OF1Wr+Yy2C9ai5NPbknm+SZCp58AdVHNrNGvqgsPvSMptnFakIV
         MH1pf6KoSD5POIWiQ9w7o/CsuzoP9/sCKcC02VWo/bL+GnGfy42D2mWuVQK89HDLHF0y
         La7diwReXvOFvXUwBoJssAnX/Z94LJ0b9xQ03c/SoD9LVZdybI43my7i5Gsjf3h0aYXx
         2wUuScn8HUmWQVaGP9QoQJsOwqcdNgZwGISratM2Grn8T/GTu+mvUV+3hSQoKoubz6pB
         zZkg==
X-Gm-Message-State: APjAAAWHdm67JMkM97eHfxq1oxUtayAPoToH02/uaw9CgTjz8OMmCp+n
        2zqB/ncJadgCrrrY4t7Efqj2yCPD
X-Google-Smtp-Source: APXvYqy5P8M1mmeGCjHcnRoWkeiSjwyT32iL2wGFXeV6VJsfSLPnIybyEbzGZx8/iJtOWs11BKDVLw==
X-Received: by 2002:adf:cd87:: with SMTP id q7mr10225133wrj.92.1552852780958;
        Sun, 17 Mar 2019 12:59:40 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:40 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Dotan Barak <dbarak@habana.ai>
Subject: [PATCH 03/15] habanalabs: remove implicit include from header files
Date:   Sun, 17 Mar 2019 21:59:15 +0200
Message-Id: <20190317195927.26238-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dotan Barak <dbarak@habana.ai>

This will prevent unneeded include of header files, which may increase
compilation time.

Signed-off-by: Dotan Barak <dbarak@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya_security.c | 1 +
 drivers/misc/habanalabs/include/goya/goya.h  | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya_security.c b/drivers/misc/habanalabs/goya/goya_security.c
index 575003238401..9d2dee67e46f 100644
--- a/drivers/misc/habanalabs/goya/goya_security.c
+++ b/drivers/misc/habanalabs/goya/goya_security.c
@@ -6,6 +6,7 @@
  */
 
 #include "goyaP.h"
+#include "include/goya/asic_reg/goya_regs.h"
 
 /*
  * goya_set_block_as_protected - set the given block as protected
diff --git a/drivers/misc/habanalabs/include/goya/goya.h b/drivers/misc/habanalabs/include/goya/goya.h
index 614149efa412..3f02a52ba4ce 100644
--- a/drivers/misc/habanalabs/include/goya/goya.h
+++ b/drivers/misc/habanalabs/include/goya/goya.h
@@ -8,10 +8,6 @@
 #ifndef GOYA_H
 #define GOYA_H
 
-#include "asic_reg/goya_regs.h"
-
-#include <linux/types.h>
-
 #define SRAM_CFG_BAR_ID		0
 #define MSIX_BAR_ID		2
 #define DDR_BAR_ID		4
-- 
2.17.1

