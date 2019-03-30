Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F7FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56622064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907814;
	bh=C9WHlEfBZ6OjV8DWCyrQ4P5au21j9+KB9aU8OgVHXzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SGOGtRnOqfiHs4Cq6lfrlVV/lw5q+mXw16QnF/qC13TSH1jFP7MdoQLrOZnGydCR5
	 FTUQKpkoiIaD8I0LD/t71b42QSXtQKuIQ4qWEkhBpK6M2SyIz/eUIiXM+Wmq0gU94T
	 TZgXclkoIF5AfEkqilOnhz53wOp28AtOduXQ7NWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbfC3BDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731224AbfC3AzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:55:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD03218AC;
        Sat, 30 Mar 2019 00:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907309;
        bh=C9WHlEfBZ6OjV8DWCyrQ4P5au21j9+KB9aU8OgVHXzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DiYs6NvZw/iRQkJ/p1rQayzKaxE3QFvIOcdREtSEnxw5ZtdlRqQYoxBso09BZV9wh
         Sy7NYZOWL5DzpBN1p2+wV4iOnTKvOFdaIKHv+CTySJ9W+Hg+6B7OmMhKh0JtvRDstS
         QzlP2wZB7N3BnMXg5h4iqne9/HgXewE7U4gRMcNs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 16/37] thermal/intel_powerclamp: fix truncated kthread name
Date:   Fri, 29 Mar 2019 20:54:17 -0400
Message-Id: <20190330005441.27540-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005441.27540-1-sashal@kernel.org>
References: <20190330005441.27540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit e925b5be5751f6a7286bbd9a4cbbc4ac90cc5fa6 ]

kthread name only allows 15 characters (TASK_COMMON_LEN is 16).
Thus rename the kthreads created by intel_powerclamp driver from
"kidle_inject/ + decimal cpuid" to "kidle_inj/ + decimal cpuid"
to avoid truncated kthead name for cpu 100 and later.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 45d9840491bd..c3293fa2bb1b 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -494,7 +494,7 @@ static void start_power_clamp_worker(unsigned long cpu)
 	struct powerclamp_worker_data *w_data = per_cpu_ptr(worker_data, cpu);
 	struct kthread_worker *worker;
 
-	worker = kthread_create_worker_on_cpu(cpu, 0, "kidle_inject/%ld", cpu);
+	worker = kthread_create_worker_on_cpu(cpu, 0, "kidle_inj/%ld", cpu);
 	if (IS_ERR(worker))
 		return;
 
-- 
2.19.1

