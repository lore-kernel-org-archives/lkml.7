Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C181FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907A6217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909789;
	bh=yvZvvvl3jzqFAQWk0koBGI6lJnJryL41y0l+MTcLHQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sYvs7czwvPp//mauymCyGbzJRdI7BXzPpG8KLcJteNQCkl2aYqJiDwsB+pGFvQvbX
	 Iy2+08A1Ntm3yM2oFSANVprCh3pC5379rlmMOzX+WpJLxBABwogr2LZB53e5DhfwAE
	 hBzRhODjy7pEq3cqQSJ4YaWj1n6zy0w389Mk+YX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfC3BbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbfC3BbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:31:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5547721773;
        Sat, 30 Mar 2019 01:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909468;
        bh=yvZvvvl3jzqFAQWk0koBGI6lJnJryL41y0l+MTcLHQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czatT2g3SkpBFCkpOi63l7prmt0rGmef5LjbR5cBFWK3ce2TL2vNwb4ngKYKnvMGI
         LdHma6fDzgCItew6gdmaqQ9ZL0ah0qdhT7B8kOT97GqKbXjoay9Mx/iJ1++qR1JOyH
         2XHlmKG59e8L6vChPaPPLdwWqE3GUC+qYOSBJWEg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 24/37] soc/tegra: pmc: Drop locking from tegra_powergate_is_powered()
Date:   Fri, 29 Mar 2019 21:30:07 -0400
Message-Id: <20190330013020.379-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013020.379-1-sashal@kernel.org>
References: <20190330013020.379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit b6e1fd17a38bd1d97c11d69fd3207b3ef9bfa4b3 ]

This fixes splats like the one below if CONFIG_DEBUG_ATOMIC_SLEEP=y
and machine (Tegra30) booted with SMP=n or all secondary CPU's are put
offline. Locking isn't needed because it protects atomic operation.

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:254
in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G         C        4.18.0-next-20180821-00180-gc3ebb6544e44-dirty #823
Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[<c01134f4>] (unwind_backtrace) from [<c010db2c>] (show_stack+0x20/0x24)
[<c010db2c>] (show_stack) from [<c0bd0f3c>] (dump_stack+0x94/0xa8)
[<c0bd0f3c>] (dump_stack) from [<c0151df8>] (___might_sleep+0x13c/0x174)
[<c0151df8>] (___might_sleep) from [<c0151ea0>] (__might_sleep+0x70/0xa8)
[<c0151ea0>] (__might_sleep) from [<c0bec2b8>] (mutex_lock+0x2c/0x70)
[<c0bec2b8>] (mutex_lock) from [<c0589844>] (tegra_powergate_is_powered+0x44/0xa8)
[<c0589844>] (tegra_powergate_is_powered) from [<c0581a60>] (tegra30_cpu_rail_off_ready+0x30/0x74)
[<c0581a60>] (tegra30_cpu_rail_off_ready) from [<c0122244>] (tegra30_idle_lp2+0xa0/0x108)
[<c0122244>] (tegra30_idle_lp2) from [<c0853438>] (cpuidle_enter_state+0x140/0x540)
[<c0853438>] (cpuidle_enter_state) from [<c08538a4>] (cpuidle_enter+0x40/0x4c)
[<c08538a4>] (cpuidle_enter) from [<c01595e0>] (call_cpuidle+0x30/0x48)
[<c01595e0>] (call_cpuidle) from [<c01599f8>] (do_idle+0x238/0x28c)
[<c01599f8>] (do_idle) from [<c0159d28>] (cpu_startup_entry+0x28/0x2c)
[<c0159d28>] (cpu_startup_entry) from [<c0be76c8>] (rest_init+0xd8/0xdc)
[<c0be76c8>] (rest_init) from [<c1200f50>] (start_kernel+0x41c/0x430)

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/pmc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 7e9ef3431bea..2422ed56895a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -521,16 +521,10 @@ EXPORT_SYMBOL(tegra_powergate_power_off);
  */
 int tegra_powergate_is_powered(unsigned int id)
 {
-	int status;
-
 	if (!tegra_powergate_is_valid(id))
 		return -EINVAL;
 
-	mutex_lock(&pmc->powergates_lock);
-	status = tegra_powergate_state(id);
-	mutex_unlock(&pmc->powergates_lock);
-
-	return status;
+	return tegra_powergate_state(id);
 }
 
 /**
-- 
2.19.1

