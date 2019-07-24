Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6938C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6DA214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000200;
	bh=57XWPzSCC7hNlIdYjU1JBY9CMGs/M4vKwYPpt2R/sag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kP7+9JCaCOfrAGmlPJr4I6bVvsHQHbzCbqHc7ACt0d7Mvc8ZF9JML3EvYPMmoQLFq
	 V7Xx/vg2zqB4k3302fSnkk4pDlND1gVCWHG6BaM4mUw+Fu3+VkCUAOyauNX3HMguML
	 gw+RWqW/ckCNRrFhj/x2xnpUu5Q7L2pSva+AVEro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbfGXTcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388017AbfGXTce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:32:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A80C92238C;
        Wed, 24 Jul 2019 19:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996753;
        bh=57XWPzSCC7hNlIdYjU1JBY9CMGs/M4vKwYPpt2R/sag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZfIFPGlJdMbMvi98e9Az2DjzbnrVtfrh1VkeEOxr4W9WV6s7GHJFp+LYskdpJM39
         M0bg+OuqPTxH/lu6QmZ5Gsj9d7m1Gu4bUGViuh0HPpp4qiYl7DKv2x+7PVtsN/42tV
         QcdLlfUJukTHAyIszV043jLb9v1nr4gpo1DGU3w0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 167/413] clocksource/drivers/tegra: Release all IRQs on request_irq() error
Date:   Wed, 24 Jul 2019 21:17:38 +0200
Message-Id: <20190724191746.959945008@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7a3916706e858ad0bc3b5629c68168e1449de26a ]

Release all requested IRQ's on the request error to properly clean up
allocated resources.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-tegra20.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 1e7ece279730..fe5cc0963ac9 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -288,7 +288,7 @@ static int __init tegra_init_timer(struct device_node *np)
 			pr_err("%s: can't map IRQ for CPU%d\n",
 			       __func__, cpu);
 			ret = -EINVAL;
-			goto out;
+			goto out_irq;
 		}
 
 		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
@@ -298,7 +298,8 @@ static int __init tegra_init_timer(struct device_node *np)
 		if (ret) {
 			pr_err("%s: cannot setup irq %d for CPU%d\n",
 				__func__, cpu_to->clkevt.irq, cpu);
-			ret = -EINVAL;
+			irq_dispose_mapping(cpu_to->clkevt.irq);
+			cpu_to->clkevt.irq = 0;
 			goto out_irq;
 		}
 	}
-- 
2.20.1



