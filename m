Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40AFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C334F2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="V8mPxxId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388848AbfDRLpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:45:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37808 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRLpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:45:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so1095120pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 04:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FDI7jlmtUbC4uyTJe0fcB/FBs1V9HgH7WoUFZRcYrek=;
        b=V8mPxxIdSeZpmynHNxQxNzqhmEi51wCY8sNdvUc+lcEOGi4cKd8O/0tK6xLiD071r4
         4LGXvmyB06ORbT6ea+HE297cEewDjct0KKKcQr29686axxnd1/Y4mSV2+h+Bq/1zSZDc
         sa7ehXvDeGtBW4mYN+xniSJH/jRor0I9yvVrLfCcqYrIl2w9T+pNmD9S/6pQUCS9vGJN
         tbm8LUgV6TbGwa8XVFxZg29wSPLTGtgHQPpaQK8pto2G1wqcaNLIHAdovOzxZFh6DF29
         95UoZqWOqa0ctD/kwcjaSlWI2DQJbjzY8VQ5U0EHLw5edHea51EU0ltOjlERbO1aT+lE
         hlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FDI7jlmtUbC4uyTJe0fcB/FBs1V9HgH7WoUFZRcYrek=;
        b=Kv6efOLSUWiaHinnyqmH/eLy6FMHnx4xaOuSMa8cN7CymbWYfa4P688KX+YG97T3kz
         5jyyhz1PhzcUW93nnmAe5Lf+erUCD/AaAhlCPurEm9ITWpwOoBckhvwk6/VNwuO76BKs
         korfd3fhl7dFk1Z+0Bodk8JBNHiEC6Nh3C2gGovUi0P88tD/pvd4hcum1f71/wvwKlfd
         Ms0YnrlGRkAwzaQ005COF0k9bB3JKnrxlUnESDmysG2EJhm1gTWpeTYYp10TwIbdPgKe
         TIsx8nUm5ZzWzcg9lUggDutfJA2Ci6QFTOE7j/q0BPY14PQBs6vjNxS37w9Fr92Kydyr
         Xp5Q==
X-Gm-Message-State: APjAAAXg4ZuVLdT7wSeIZK+y39x3dJ5LH1FDNwSr0hfMxEYqBtvxwvaT
        1sJO6hqEyyMprpZn5YMiRhedUA==
X-Google-Smtp-Source: APXvYqxOjKi32lYPZOe6U/AWqeO8L6rGCRSn5IATExvKDgLtnm+YjwNJ+oljBRjCRr/kSCAnYNy96w==
X-Received: by 2002:a65:625a:: with SMTP id q26mr89437665pgv.68.1555587920018;
        Thu, 18 Apr 2019 04:45:20 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id l19sm2550579pff.1.2019.04.18.04.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 04:45:19 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] regulator: ltc3589: Switch to SPDX identifier
Date:   Thu, 18 Apr 2019 19:45:00 +0800
Message-Id: <20190418114500.1098-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190418114500.1098-1-axel.lin@ingics.com>
References: <20190418114500.1098-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ltc3589.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 077e73715514..9a037fdc5fc5 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -1,21 +1,9 @@
-/*
- * Linear Technology LTC3589,LTC3589-1 regulator support
- *
- * Copyright (c) 2014 Philipp Zabel <p.zabel@pengutronix.de>, Pengutronix
- *
- * See file CREDITS for list of people who contributed to this
- * project.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Linear Technology LTC3589,LTC3589-1 regulator support
+//
+// Copyright (c) 2014 Philipp Zabel <p.zabel@pengutronix.de>, Pengutronix
+
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-- 
2.17.1

