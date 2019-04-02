Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E9CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891EC2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfYkhCBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbfDBPpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:45:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47037 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbfDBPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:45:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so6463477pll.13;
        Tue, 02 Apr 2019 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RuAdNiK4G8Qqo5TwmjxGhbMJlztb3V/aCnDWI43Lc58=;
        b=FfYkhCBpQGCeVxjzVByhi5fptKvA9UQBYui7XVjgEji4EZZ2pMkpMF5mK+8LTMD6p3
         xYZ0I1VdoG2cnkQOfYNm5vYZye7eJuPtRDkKfv/Z3Hk5aKa0zhC7gjruAOjuDukaMWJR
         pwcAlqiI+pgjwIGZYs9ZXOYkQOw4VCRVRgywzrBAoxFug8BLZTx8DjuGB83be5ZzLre2
         DlTcFa8/IkCB62YnLeKuZxO8UbdUFe8PGkYrNzmTS2DIVj5mrE6y05b5rI97oZB8bxd8
         8dQHk2Tq2k0HcADTml/cR4hv4zvO7zOPjB8AfqHb9LwOzIY7GltuYYRhTItTO62z0BjQ
         J8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RuAdNiK4G8Qqo5TwmjxGhbMJlztb3V/aCnDWI43Lc58=;
        b=PGcrpJ1Jisr91Je/8JnBRqAKKtvS/Q8f9XVmXmAmd9Zb6RNMLYx2CkpULrWB+wj3ci
         45A+a+ZkIEbiADYsOoOkFaL7JSgDqiqeMqzZSeNm2kDWN+gpn1RvVNRVM0FFsuBC9/jp
         c571RIUWBqYV3P+z0S6Tt68U6jzlwGDc1ODgwPAo9s4G9jnYhkJZCpexzCsg2lux9BpS
         2c4UeO+a7LO5rxuUSZmN633Mblmyp+slCyxX0NLHIxEJTxB+6KWRNSDzyekcfXBJ4kfD
         BIOAh14IsoInJ0MTf9U1bg1VcHQaREKMeCQHwY4Sf7VlzE/gv7RksPZIHTIRKKIg4VGB
         hTLQ==
X-Gm-Message-State: APjAAAVr4JQXSemVkfN8Gjn2CRVvhVco/X1E/blLz7Gkm/t1tm1tkUQf
        M7ZF+dVCrZOUh1g/ZB2fzNk=
X-Google-Smtp-Source: APXvYqxL2WQoiuUb2u0kWYvuuHaiaeLwgdlNbbtuyuLRR1bAUifCiuQRsBKTRhJVlap733oG/OmyZg==
X-Received: by 2002:a17:902:2927:: with SMTP id g36mr43162839plb.57.1554219927729;
        Tue, 02 Apr 2019 08:45:27 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o76sm39421316pfa.156.2019.04.02.08.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:45:27 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 3/5] nvmem: sunxi-sid: convert to SPDX license tags
Date:   Tue,  2 Apr 2019 11:45:12 -0400
Message-Id: <20190402154514.11284-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190402154514.11284-1-tiny.windzz@gmail.com>
References: <20190402154514.11284-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates license to use SPDX-License-Identifier.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/sunxi_sid.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 570a2e354f30..54620d72ddb9 100644
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
2.17.0

