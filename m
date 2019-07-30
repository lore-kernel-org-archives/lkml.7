Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D4FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F255D21726
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2D7mmbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfG3Q6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:58:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36891 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbfG3Q6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so57295055wme.2;
        Tue, 30 Jul 2019 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvMj+TSXx0caGJICPDntAoDwA9dWuEv6I6M6qTAotek=;
        b=L2D7mmbA2ZJtJuCUjp4zDhGi9X/q4CZLrC7ymto0p/Zcg6bSf8c36Jb4KODJhvgT4r
         1gMRZQ+pDxloiKp2CMnaUdgNNsZYKe1yk/eG38XXRyVZB/l8Ammk3fJvP7iRMVWZpSVI
         /cPzowgHV9OHXRU2cxzQW7clMhWJ5KEVhcwhCUkR9V4uxPAuLtMHpR9Xj9BpirO4zTju
         IRP0BTSwAqIOu1fiio7CawpaKLon8E8m4A93MSsUQBve8+q/1Hc/6r68y4h3swBs51io
         gICEgl4OYKF0MiDaYanHfR5HSoiUcl15AxfikqaK4LqTT5X7Ic3KOY7JsDlh9hk3P39p
         4jUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvMj+TSXx0caGJICPDntAoDwA9dWuEv6I6M6qTAotek=;
        b=i3AfwXKcnrVLcUQ2Ko7pk4bU7+B8U+lxCeuW2jH616OJba/BYc8eeByp1AGDoENDWb
         qPKbQKb7GsHO9JMBUK8nfczvxXoaJa3uneKV8ZmGV8c3NSA/vsrMTd6yWTfBWtFSA+49
         tA946fBNW58PwX4n3KBrWFw44Pn4/GPDyJMSr6C6GFhz1k2HaMK8MrZT/QijReEQPVPT
         OvLcSb8UZ0fK8/NbnwHqYR3SxheIN2mkUlyKwAIhkH0wsMRHaitxHAfZAajjAbdK3kN8
         FSdpxZgRP2u2NwmlgmvYfE4haTqNX92W8cMCAV9zsl5N+x+wcpytH/lBhMQxLvVuIBep
         uEeQ==
X-Gm-Message-State: APjAAAUx6vRLievZnU2MCdDRmFPvYpiFby0nffbXs8x3n0swRXkfF2z7
        mxjeeVK57VJL7IuT6AYfXnw=
X-Google-Smtp-Source: APXvYqyyJqnzoBo6cjHisXEQOuR7FS1EUUvRVeP0J/djP1VetsZPY0z2OtTv4jv87G34URLs+nrOBw==
X-Received: by 2002:a1c:4041:: with SMTP id n62mr46227135wma.100.1564505893690;
        Tue, 30 Jul 2019 09:58:13 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id r5sm70845040wmh.35.2019.07.30.09.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:58:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 04/15] memory: tegra20-emc: Include io.h instead of iopoll.h
Date:   Tue, 30 Jul 2019 19:56:07 +0300
Message-Id: <20190730165618.10122-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730165618.10122-1-digetx@gmail.com>
References: <20190730165618.10122-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register polling code was gone, but the included header change was
missed. Fix it up for consistency.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index b519f02b0ee9..1ce351dd5461 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -10,7 +10,7 @@
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/iopoll.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-- 
2.22.0

