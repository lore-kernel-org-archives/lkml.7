Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1DDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC57E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPzZgaLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfDXXPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:15:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39078 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfDXXPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:15:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id d12so16009372lfk.6;
        Wed, 24 Apr 2019 16:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h24MMyPZcUy0YS2LlpZQn6bubvBfDnhKztlsVunvvkc=;
        b=qPzZgaLh8xqS5IsUPtCA8V4MBaOMfMh16YoK3iGZBGsEjFn5ZQvAYY782FyrN+Rv+H
         t+w4NPjKY8ORTV3xkQSgy1ysmtABwS9qkw4C6BDyc64jVrPlgPEZWqCvTUzMDiPkYitn
         9wVw1d2DQwPY2Ucjr7QzkM1714tS+qn3ptNSRVTaS62rjhtoKTiN4aqptK3uzKsTfnUS
         jV6ixuB8NJGmWIFbn6IcL19qWMJsyB4abZgEpihM3XGJIp7g6bbYfH/yxSS35XM5+Eic
         Da1a1ET8aZ+Uj99VroRZxNME5IsTngXyTOcRWwOkPjYyroQ2lVwQPF4wFc+p4mJ7fqrv
         0QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h24MMyPZcUy0YS2LlpZQn6bubvBfDnhKztlsVunvvkc=;
        b=iQokPeqmKmS7XTdyNSRzRujdutSOCdiKJMBAZQHKH+hlmwPECbIxrj4ZRiziRCeijz
         ct6bD0wlIpBmtZ6kkojHn6WAwyHQS+sn3hZAnD0ZORS64bb0aYUJ6PLrxxAkW7BVY7c8
         9pLVckPupc+oDSanTqFK2Z6uARMdb0cOl4j6m04oa6ooXbvZk9UyejBqrcgzP44mQ29B
         XoklcLsxdETNc/kSwvnC12+h9y3D7V5RoPIEV3JwOxDoHiSCtkP54Ql7+TaI5ts8Tc0T
         Uh93Sn634ePLJbc8opxaxC0CIef6UxVoE2BDUhpTVXUMoAVAuVUuyCzY0nd47Db6aFRW
         uohA==
X-Gm-Message-State: APjAAAWeCYrJxsAi5AmhvBP7GTfCTvRFCoIMRuWEklzwf0SqPNGSGO4i
        svNao9ww1EKvQNvuAZZ5lRA=
X-Google-Smtp-Source: APXvYqyUv8KzRGtBxV+BJz1XhdF9FepN2DU+zHz76+nHXu/b5qbKfiVebP01RlZwjDsVHI8nzso8TQ==
X-Received: by 2002:ac2:5143:: with SMTP id q3mr5986366lfd.169.1556147714710;
        Wed, 24 Apr 2019 16:15:14 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j13sm830192lfb.34.2019.04.24.16.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:15:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/7] clocksource/drivers/tegra: Use SPDX identifier
Date:   Thu, 25 Apr 2019 02:14:44 +0300
Message-Id: <20190424231444.20876-8-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424231444.20876-1-digetx@gmail.com>
References: <20190424231444.20876-1-digetx@gmail.com>
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
index e87fa5719d4b..610d351a1818 100644
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

