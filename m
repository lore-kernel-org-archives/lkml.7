Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2930FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D1A217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkpt6hq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390412AbfEXPfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:35:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32851 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390163AbfEXPff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:35:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so9078956ljw.0;
        Fri, 24 May 2019 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdWdZJtFLzv4jBGeRTNjR+jpddUaN+iIYYeuiIm2P7U=;
        b=tkpt6hq/2DH8WDXDwdpqUUJBG8pgyCin+cZBq7daZESOfqZShEIaUO0zh2Wt55r1Yj
         3LkwPshSBk9e66iQfLz8YOcq8pMi2Ex0tD79aHiGaySnWKh7xvtLBYI0rxH831ZWX7xG
         sMe0dMakoAPU8snm3jgs2HOtvY8H7I5xh8sfbNlSWigJE8zlAClywzx6+fY0QyCmIXvY
         VgXDV4uqIg8hNf1Yifi8VaFGlE1uQ9DRX/c5yKyAvoEbZHP1n/V3eiZVr+ZTPPNpVnVC
         +hbwSx6Q6JNZ+0ornpozFrVAuKymZTG0XWJ+lG8G/NCw1uLc6Ou+C3ToX/kxtbifDBUX
         bcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdWdZJtFLzv4jBGeRTNjR+jpddUaN+iIYYeuiIm2P7U=;
        b=uFCmyUO4fAyNHrXRlA2stsq8lVqAUl34pNYYo8g7KZH+amvPI6FKXD10dLIt2txizl
         6WNY5ZFwqO7k3NSZYKmgREWfJcW5BNLtBasaU78Ql5aBhJ/hxbbeRzqPoh1vIkUxmSe2
         4pQmYXSYzKRbvFC8xonmjsNI0cSQKcQ+nNVd/RayU/8APsuR+RYNcppoI/7BApZitT1A
         QTICyfg+AYZ3sxjp2ivm1sSIUKsb0S/ClktRairrzzK+8Te3zOzO7ctuLL661eU67REv
         IuhkumjZYserLOPSOVUgiPnMxmI2hQe2SprsInYhguiAQjtabhVE3B79ftaA6oFPa8ME
         vaBw==
X-Gm-Message-State: APjAAAW9X5HRO8PlXGxWqcR08oV0HYjStchclvqCGArEW+2QVaTWCVAN
        9NTK2awkI5nKBEjiKj0AZOA=
X-Google-Smtp-Source: APXvYqwd49qp6YKW0neMcGz6SFiiEsLpisFnpfouM3YjeYiB3AEAviwn8Wa/I6GqMw59WTlcFNZDAQ==
X-Received: by 2002:a2e:9acb:: with SMTP id p11mr23733949ljj.129.1558712133364;
        Fri, 24 May 2019 08:35:33 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id y14sm572316ljh.60.2019.05.24.08.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:35:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH v3 7/8] clocksource/drivers/tegra: Use SPDX identifier
Date:   Fri, 24 May 2019 18:32:52 +0300
Message-Id: <20190524153253.28564-8-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524153253.28564-1-digetx@gmail.com>
References: <20190524153253.28564-1-digetx@gmail.com>
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
index 12784a82fd57..1a3ee928e9a5 100644
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

