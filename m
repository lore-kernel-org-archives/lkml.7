Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A140EC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3B1217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="VgXqaaH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfDSA6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:58:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43001 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfDSA6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:58:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so1937973pgh.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 17:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Li6iXJl7rVcmj7e3akMpjNXlMCHCNUtylQ6KQWUz8IM=;
        b=VgXqaaH6efEtd+h8J8tuUThn/d+lKpu7glQ5KRX1/CbgaZseQs5BWBUJ3MjoA8bFig
         prz+Tn1YlKLbkUOEKNWCypjfjt7crwHbpwTp75dLeWi7m8iUxgwe7tN4gnqpyZsAZo6G
         Tm2Ss2rwxgqMtkC0PVHQ3Bpvi4ovzKDW7a7YLEe+rlHbyVaG52wGRumrEYayV2Ewyq5t
         B7wR9DUUM/EUhX/CszJ1a8hYBf55QD+S2n3RujyJHLhMoCiZBtUoTZaPvuYDf34Z0/XN
         5rqaZvv67zx4Eo1xumHJyzT7tjFAYohGLNR7gFhl0JyjgfaEOsavas6BLI0q/vFOfcgR
         96Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Li6iXJl7rVcmj7e3akMpjNXlMCHCNUtylQ6KQWUz8IM=;
        b=R5PMelq7lLD5R+BByv022dqu6O4Edqyxht6HkM035R4zatV/74L6JaB+Yef7xZu54Q
         FKDZZnIv5DOMgOazomwJIvQ2vgiDAYlF8Dnc5lk2NzBCkHijlYmzoChYB8znAL5bXbS8
         wPfiIuOZWvenukpWBfqVk3ng2IR53V6oJBfcewH1YZX47YbsxAeNylkuAPU05SQimx/d
         20bqhuW3egCyuMrI3+GAPuFRLDUyDxgLwfv7kPBWB6P2Op28kB1/ovSlyPnMX6LH+8NL
         ECe0vbqj+qgpyaywJj4OtGx5LKDGrLUJYuaa0p9KcvvqauYEqQjcXNAE6TKwMdWAuV9d
         fI/w==
X-Gm-Message-State: APjAAAVhky2U778AylLwyGLZouLQcFHzfRrGxDaz2Z3Jn2po3P4dPwAn
        ZCdTkIpDWK0UpE7znkQKeusLHA==
X-Google-Smtp-Source: APXvYqyj+6FFwsgeLC1OYbIswz865mb9gRtXcEidi6m1LaZboUZ7QM9OYsngdpOKMEiOOLXvHaSljw==
X-Received: by 2002:a65:62cc:: with SMTP id m12mr1070936pgv.118.1555635521278;
        Thu, 18 Apr 2019 17:58:41 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id 6sm4209106pfj.95.2019.04.18.17.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 17:58:40 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wadim Egorov <w.egorov@phytec.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Yunfan Zhang <yfzhang@marvell.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: fan53555: Switch to SPDX identifier
Date:   Fri, 19 Apr 2019 08:58:24 +0800
Message-Id: <20190419005824.21533-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190419005824.21533-1-axel.lin@ingics.com>
References: <20190419005824.21533-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fan53555.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index e2caf4173ab5..dbe477da4e55 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -1,17 +1,13 @@
-/*
- * FAN53555 Fairchild Digitally Programmable TinyBuck Regulator Driver.
- *
- * Supported Part Numbers:
- * FAN53555UC00X/01X/03X/04X/05X
- *
- * Copyright (c) 2012 Marvell Technology Ltd.
- * Yunfan Zhang <yfzhang@marvell.com>
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// FAN53555 Fairchild Digitally Programmable TinyBuck Regulator Driver.
+//
+// Supported Part Numbers:
+// FAN53555UC00X/01X/03X/04X/05X
+//
+// Copyright (c) 2012 Marvell Technology Ltd.
+// Yunfan Zhang <yfzhang@marvell.com>
+
 #include <linux/module.h>
 #include <linux/param.h>
 #include <linux/err.h>
-- 
2.17.1

