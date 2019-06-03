Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937F4C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6961F26F77
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDtH4dKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfFCTEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:04:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38638 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfFCTEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:04:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id o13so17290735lji.5;
        Mon, 03 Jun 2019 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdWdZJtFLzv4jBGeRTNjR+jpddUaN+iIYYeuiIm2P7U=;
        b=fDtH4dKSmtMQ6MN6v2gwGTwC3anRHfBwnA+RH5dIEtGTPcO4LWcn1gdY3VPkAMd9Ey
         9hB/xH7LOL2+/Rx3o3GBLI4s9rvZlkqcFx0mKAkLBzbhlqWv5vTqE5eS3bYSyK8QilCX
         bzBg9mR5UWRgn9gI352lxR8X5lnh5mUNtZBxfGulzKnUxsP0gmIob9mxlu4KSwC+Asam
         JpGOamIJxWx2cmJKe/N72WUBjo6ZvgJykBz1gOb9C6IpP+G1LFSSy9Qtqg9Gzw5lKsCJ
         beA44JAgRwfkb965gwHVLNogeqARzYKPORyFogW516NWMUo1QxR/VvUyPy5d7Ec0UeOg
         WtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdWdZJtFLzv4jBGeRTNjR+jpddUaN+iIYYeuiIm2P7U=;
        b=I5XhMTsWC29fNlhT5mjYtZMlt6vZK3+u+QscKp8qaCL5Ay1Ay2n6FWqqTXWXhfQf7v
         M7bVdYOG8mygDQWO/Ni+S4ZyfSgWPWIl9Dt3Nn+jUd/HiBscNGzV3MbkFcPb5HRKwuf0
         d6rtvoLeT6/Wa2bmHqk0U2lQvHcyu7KJzhWj+MozSnJcyEkXGbyilsTmg5VgLVMzSpwt
         w5c22dx8f1JEnKAoDagpvGaLslsjw3Mc8SPRrcLfUj98q/iFdHMb2hrUrNB4D0brTVzb
         1IA/ga2eRh1Pkx/QwyBDBLj4s9M0cJYNMOBWhIHBot2ilxJiNRXN316noYIQUbDRc9mY
         ZTiQ==
X-Gm-Message-State: APjAAAXh760plAi/fPiooGwQo3z/6YZcqGPEWEdx0zk5Q0w7X304vGxy
        dxJn2wdZnWOwvoHpCNMhIkY=
X-Google-Smtp-Source: APXvYqzVdZqbt/3xufEe8kXoCpvJZ/T65wAOGOU9isSXFxHE+gLwafoPPLI1WZ6Z2ywjO4A6vAPkNg==
X-Received: by 2002:a2e:91d7:: with SMTP id u23mr14631935ljg.150.1559588660339;
        Mon, 03 Jun 2019 12:04:20 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id l22sm2768805ljb.39.2019.06.03.12.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:04:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/10] clocksource/drivers/tegra: Use SPDX identifier
Date:   Mon,  3 Jun 2019 21:59:45 +0300
Message-Id: <20190603185948.30438-8-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603185948.30438-1-digetx@gmail.com>
References: <20190603185948.30438-1-digetx@gmail.com>
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

