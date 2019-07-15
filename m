Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C8AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAC92081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199977;
	bh=ucldNSU9aF/6swDbofRjao5OCEXesRq3j4nOSnVhMs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r6Rhr794rHKgj5zRWRDdZoQkK48fQPMVGz1oxlFFk98PNGQZvjvtWxxCpy94dAXX4
	 00eN9AqTFMLSO8iPluw8TxCDqMrgHlM/rRDdJEqnRWsF6O97lCyem14g+uMWm6QQb/
	 EMA9xvYPvItieU73xAocp7+nW5qMgA0CnYyAXtjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389145AbfGOOM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388839AbfGOOMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:12:53 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 655252081C;
        Mon, 15 Jul 2019 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199973;
        bh=ucldNSU9aF/6swDbofRjao5OCEXesRq3j4nOSnVhMs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCtdxjd/Ors2uYrpLZkrNKUGEqosuWKYtWv6gfEcjqnXYMIBO7KXYcrcZvp/IpzQD
         fP2qxnjBM0h5pxFUrPBEn169hUeCUwvCd/CCmyrjfi+3/QWRAwl+JkmmapK1AjFR19
         g6pYm3uZNHTt8LuZyA3tJ/cbot2MK/VqySjFzGcE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 151/219] clocksource/drivers/tegra: Restore base address before cleanup
Date:   Mon, 15 Jul 2019 10:02:32 -0400
Message-Id: <20190715140341.6443-151-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit fc9babc2574691d3bbf0428f007b22261fed55c6 ]

We're adjusting the timer's base for each per-CPU timer to point to the
actual start of the timer since device-tree defines a compound registers
range that includes all of the timers. In this case the original base
need to be restore before calling iounmap to unmap the proper address.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-tegra20.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index cc18bb135a17..84adfff59fb0 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -341,6 +341,8 @@ static int __init tegra_init_timer(struct device_node *np)
 			irq_dispose_mapping(cpu_to->clkevt.irq);
 		}
 	}
+
+	to->of_base.base = timer_reg_base;
 out:
 	timer_of_cleanup(to);
 	return ret;
-- 
2.20.1

