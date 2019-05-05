Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD86C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 16:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B49208C2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 16:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW1NgwzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfEEQZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 12:25:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34292 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfEEQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 12:25:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id s7so3662940ljh.1;
        Sun, 05 May 2019 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJiWha3xmfpfGUauVHHLrdkEBWwTxWF5yNbhjCCJouw=;
        b=SW1NgwzW5FOZVKR0o8KAMgxh1OA8ifum4GOaTCPIYc04SlQjVJ8TUJr+I362vdpHWF
         PB7m9hrcxc3LVy7ediTiCN5s1CsKhp4yO7akJ81WjkXMA3H4mA3J6PRdTmpFxVuTNNcZ
         pvGn/jasU+dQgGqIWSoIkdnSINtHaKeILbFzBqecW4Za/aRBGgLUJmXhfEAjzrey+cV3
         SP93dUisShgXDP1rF6QPexphpMHBuc/OCi6wxmV4oVly0pfT8wWR7NQXSN6RbVZ9r/s7
         m2cFPhrJ3r5eQ1U+Egw9LuJ2TtX1lW09vs1et5PXuk03EpeXlILvW9HK12lmJHiy1csv
         z7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJiWha3xmfpfGUauVHHLrdkEBWwTxWF5yNbhjCCJouw=;
        b=VZ9tQxTLzR11rEKWV2cGsFJab7yfBKRQDyRIZUobjqQZWiGwNk8Potv4szD0qo093E
         C0W3/xJ9oNqUt7d8C/RMRJTCtW0rzzV73Y/xeMdzVdQr0YAKSpEUL+22m14nZP/GKuwC
         dM66YjPjOLN2gNV451KA6IZHUpDjV5YHiC4SJ6bSNs761vATnCy37fD1qo8qGkTRo0LE
         CidqEawX0ib4gxJML5SQY1drKNPL6SkckkpfeWde+s7dTD64wUYcHfXUCI+RuD6QTrs9
         Hf2Z8/cC1pkftes0zD9Ve84ICDmT/hHA0+Yh34zytEey3JBw6+Qb5KpmXpZHl8YMmYS+
         ok5g==
X-Gm-Message-State: APjAAAWIo+6GJpcRi/x7625QDmpGzO2MGLq+kJiC10TT77mVnwstElSN
        9Y2o6AFiAfrsX1/mCKtBxuwc9jJZ
X-Google-Smtp-Source: APXvYqz8k3mqo3ITBLY8yzWm3ryHGLOMDMrdFYexck9IbRLuYrusEo8C8YSL6TsrbOgqyUkFuITVbQ==
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr11047779ljj.192.1557073521658;
        Sun, 05 May 2019 09:25:21 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id g13sm1581649lfh.49.2019.05.05.09.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 09:25:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] clocksource/drivers/tegra: Use SPDX identifier
Date:   Sun,  5 May 2019 19:24:36 +0300
Message-Id: <20190505162436.23125-8-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505162436.23125-1-digetx@gmail.com>
References: <20190505162436.23125-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPDX tag for the license identification instead of a free form text
to aid license-checking automation and for brevity.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 47ef8c9aa0ba..40d9b27d30a3 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2010 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@google.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
+ * Author: Colin Cross <ccross@google.com>
  */
 
 #define pr_fmt(fmt)	"tegra-timer: " fmt
-- 
2.21.0

