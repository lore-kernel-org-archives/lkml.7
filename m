Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8CCC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F8D20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYdousLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfDKWah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:30:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45016 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfDKWaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:30:06 -0400
Received: by mail-lf1-f66.google.com with SMTP id h18so5899446lfj.11;
        Thu, 11 Apr 2019 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsYzqS+sD+odCER6OAB87SufxlLcgz5HRZWnhoapdvQ=;
        b=mYdousLlYMPA/MCAK2QG0cpWfZQRahCWSjT19JGibS0vWSRa3eGeol92VenMQXqjQl
         MFbP8LX39TcwnqRFPlLt2ijXSMzeGJuK4awCHjrdg8E4gZAxlrOYc/TLifxnmG8mkf56
         uwUr3ECOqfKcEEXBSmFzsBUqGn4sqt+wtMbkHVb382qEQWvD+lhfWmr5hpSmyEVU0S3P
         JaJ6WF5j/dJcUkFKVv49qxoVFwI+PyPPk5+K4dfGr6FErH/xnHsPDpJ0HpZZraeqNL+j
         yTKTSIjxVAEGAzA08K4CGQUCUp5K3B6x875DnCfclVc2/qCFR/pjjvbrwNm5o8U4LnXT
         NPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsYzqS+sD+odCER6OAB87SufxlLcgz5HRZWnhoapdvQ=;
        b=hlA6u6aFQ1ccu8/reiHK/iV8yjzEvuXxpzqZA3WQI7vK3d46DuRLRNiP2n3nCfJNbx
         F+LjIlAIQaNpusoID8rLlPiNi+XWbxtSb8khN0rNmZJFNo1F0MJ1xZaw46sq35kD5Yxm
         WDZjFtdA6DAv+bBEytr+XbgSnFy4VZUtz4PA7XTSvbBAErmb+oDKBaE4ryxBFdjlC4Dm
         ruD7qhoi3NXpj6sFbZwT/eUYn7QkNsAcl2Utt92ikrBc/x3iAxsy0+jl036PsHoIiGe3
         gFq9QIUQxlXKEay62pDbat7rqVbRBeBotFhHe8yrahPYFgu95heSXZpdh4tBF6FvSLRU
         vIxA==
X-Gm-Message-State: APjAAAWrYuyNMKDx6znlBrD6L4Aqdq7jgjAzKzcmjOweh9RnYkKFYZH7
        ucLiJagDYhBinEnODU2QeGByEk2Z
X-Google-Smtp-Source: APXvYqyTpO6KQagoSs+3BF66j2zdj+yIL760WLZcKVe0a10F0eRNQltBqmvh5cxf69XzKnvzvhJqMQ==
X-Received: by 2002:ac2:4291:: with SMTP id m17mr16986694lfh.29.1555021803915;
        Thu, 11 Apr 2019 15:30:03 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d13sm1646000lfa.40.2019.04.11.15.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:30:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 5/8] PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
Date:   Fri, 12 Apr 2019 01:29:11 +0300
Message-Id: <20190411222914.25539-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411222914.25539-1-digetx@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no real benefit from doing so, hence let's drop that rate setting
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index ed67d7a48176..aefd4874b5a2 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -648,8 +648,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	clk_set_rate(tegra->emc_clock, ULONG_MAX);
-
 	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
 	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
 	if (err) {
-- 
2.21.0

