Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A31C19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 20:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D18206C1
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 20:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myd3tsfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfHDUci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 16:32:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43224 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfHDUci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 16:32:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so7768430wru.10;
        Sun, 04 Aug 2019 13:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJcTX6yAM/28X+y7Mpoop6XMEsRl/RWmoeElcLy1hsQ=;
        b=myd3tsfjagcJQVGtr1pZjOA14+sS5tTfp/5T34+bxh0e4x9zDOcAelWWZNmLK2S6KW
         TaJ6p4ihbxxEfmD7Ze/uyWk6EeowRlyTc+IlPeAbGdoJHPmI7By14+axKg261p/swOsF
         f+B7roH+5Fkith597jXgSQ6sXQvSpAIUUAlDPCg+puU3fl5JoswIDY3fX6k4n5mQtVZt
         OuC7sfW4Yy85rgFkFbL6KmD+lUd0/78qO0JsJmJOjjH7OBJZCWF7vmWG0S4ow8vzH3vD
         OoVkyE0kHFnzKqZm97jKuQgPCLt+RjrWnp0JW/n9svkHXELwN/7qeFAfruvtAIoTWUmZ
         YM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJcTX6yAM/28X+y7Mpoop6XMEsRl/RWmoeElcLy1hsQ=;
        b=tT0BDnzuL1TLs5FQLz4xigYs3JSbAsLxhvLZ5u1+ADmuZmSoazBZpFNbzl5nMA6VJK
         /3C/8lYyBUZcI4blfYzKhnW6dCB/l1cNsGA3DVcJtDeOrRoyoqKYR8SzjbJFz1hTNsV9
         2B9z7TJDestMlTxMxX8xS+c2qw6YY2RQYNqJXEVYX2Xf4MUHdt0qYudre3+NhgFBWVeF
         QRB5Xu7ht6Hhg38tRatbhG5zkpTonGRXhOmpQIWXZ7ijcv+ZvrdR3DD1/2EV5UoWDIO+
         Fi1jcjT7d83qVGUlIfOIdJJc2WI1l2FwuQbEsZbS1o5TV+s/rUZI9kqUpTXu0TFBfrGw
         yJ0g==
X-Gm-Message-State: APjAAAWp5Ib8cgOGmsZnLZVtJSGyOyfj/+mBDPMvlopsAz7Bk2sAs4/E
        sL4DpZhZafj1Qk7vmAks2UY=
X-Google-Smtp-Source: APXvYqz6zXXgesNxrw1GRqNtRHfvZKscXL1dPOOLJLrkKRVPznyq+CZfPQrkgHZO0MXDwRZqCZgaFA==
X-Received: by 2002:adf:e4c6:: with SMTP id v6mr150550068wrm.315.1564950756492;
        Sun, 04 Aug 2019 13:32:36 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id b2sm112066619wrp.72.2019.08.04.13.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 13:32:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] soc/tegra: pmc: Remove unnecessary memory barrier
Date:   Sun,  4 Aug 2019 23:29:27 +0300
Message-Id: <20190804202927.15014-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190804202927.15014-1-digetx@gmail.com>
References: <20190804202927.15014-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removed barrier isn't needed because the writes/reads are strictly
ordered and even if PMC had separate ports for the writes, it wouldn't
matter since the hardware logic takes into effect after triggering CPU's
power-gating and at that point all CPU accesses are guaranteed to be
completed. Hence remove the barrier to eliminate the confusion.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v4: No changes.

v3: No changes.

v2: New patch that was added after Jon's Hunter pointing that it's better
    not to change the barrier's placement in the code. In fact the barrier
    is not needed at all.

 drivers/soc/tegra/pmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 4e44943d0b26..8f8fb2db064d 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1460,8 +1460,6 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 	do_div(ticks, USEC_PER_SEC);
 	tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
 
-	wmb();
-
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
 	value |= PMC_CNTRL_CPU_PWRREQ_OE;
-- 
2.22.0

