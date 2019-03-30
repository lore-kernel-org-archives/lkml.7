Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA81C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21456218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907093;
	bh=SxyFo79/sfYbf6EmTV9KjDzj/01/y48+gWtendvrCzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YG6KgQMlMsZ5woVTYnUJHLpf4j4IOpMJ0GTszDI8hRmhKI+URy3Qd5c+kvvttmL0U
	 7dgsP16yEaDlcud5HYMd2aSf82Xmb337PwlPpeORjawz2wB8b0fd6U50n6qQesI0hR
	 uRCyXv582l+u4j9cTyPa0LysTylrQVLB+Co2sutQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfC3Avb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730738AbfC3Av2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 760E2218D8;
        Sat, 30 Mar 2019 00:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907088;
        bh=SxyFo79/sfYbf6EmTV9KjDzj/01/y48+gWtendvrCzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3Hlc3s8JB/HyZkQg49b0Cyfg3bJWHbubifltCrK5l04SGja/RF9XC8bdm8D6eztb
         /HWBiGfcI0xsXCkdARBPaffbGnt71JS3Bo+i6C1Nxv9B8ZoLh15Gz8E3PtdNuKBghL
         ZUTkFLkKV7wr6duPWevjD/E7Hrmtamclw9Ebk/OA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 25/67] thermal/intel_powerclamp: fix truncated kthread name
Date:   Fri, 29 Mar 2019 20:50:05 -0400
Message-Id: <20190330005047.25998-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
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
 drivers/thermal/intel/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index b12ecd436e23..ac7256b5f020 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -494,7 +494,7 @@ static void start_power_clamp_worker(unsigned long cpu)
 	struct powerclamp_worker_data *w_data = per_cpu_ptr(worker_data, cpu);
 	struct kthread_worker *worker;
 
-	worker = kthread_create_worker_on_cpu(cpu, 0, "kidle_inject/%ld", cpu);
+	worker = kthread_create_worker_on_cpu(cpu, 0, "kidle_inj/%ld", cpu);
 	if (IS_ERR(worker))
 		return;
 
-- 
2.19.1

