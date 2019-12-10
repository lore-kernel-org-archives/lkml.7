Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272ABC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF96F2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017471;
	bh=KTnAKvILCardkPueMWJQLeWMrlCrn0p7kS17N3X9WQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1aAH8bcKK/N+78fYYx9hBgcyqzNF5YxVGUp+hxssZqbA3mNaApIGeZK8slJGUjSdE
	 JeEIiwTG7bAv8q0fnzFgSjXLv5FsiXOZ2fmLHRnOuj4+iKq4RgU1zijWW1N1B/LLPe
	 6qOYgL0C8+e+CN3xWoEPL4aqsaVk9OvxvOZD9OI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfLJWht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbfLJWdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:33:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E6B207FF;
        Tue, 10 Dec 2019 22:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017234;
        bh=KTnAKvILCardkPueMWJQLeWMrlCrn0p7kS17N3X9WQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnRWiJPE9uU53+Ni+28LEzIS0ppT1245V1o9MAtkRpZQ5cYM+T7xoUfY6F6wBwFWz
         WsIjnGC3jgfGu8BmZJBYQeDnVUH/RZo017eRWjjXXvTwSGcWXed02GXdVp1ideRRgj
         xurHHvdCmuZCDEfBLh4jD/vWlyrm94c9NnU1Eq/U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 32/71] arm64: psci: Reduce the waiting time for cpu_psci_cpu_kill()
Date:   Tue, 10 Dec 2019 17:32:37 -0500
Message-Id: <20191210223316.14988-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223316.14988-1-sashal@kernel.org>
References: <20191210223316.14988-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

[ Upstream commit bfcef4ab1d7ee8921bc322109b1692036cc6cbe0 ]

In cases like suspend-to-disk and suspend-to-ram, a large number of CPU
cores need to be shut down. At present, the CPU hotplug operation is
serialised, and the CPU cores can only be shut down one by one. In this
process, if PSCI affinity_info() does not return LEVEL_OFF quickly,
cpu_psci_cpu_kill() needs to wait for 10ms. If hundreds of CPU cores
need to be shut down, it will take a long time.

Normally, there is no need to wait 10ms in cpu_psci_cpu_kill(). So
change the wait interval from 10 ms to max 1 ms and use usleep_range()
instead of msleep() for more accurate timer.

In addition, reducing the time interval will increase the messages
output, so remove the "Retry ..." message, instead, track time and
output to the the sucessful message.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/psci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index f67f35b6edb12..e6ad81556575c 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -151,7 +151,8 @@ static void cpu_psci_cpu_die(unsigned int cpu)
 
 static int cpu_psci_cpu_kill(unsigned int cpu)
 {
-	int err, i;
+	int err;
+	unsigned long start, end;
 
 	if (!psci_ops.affinity_info)
 		return 0;
@@ -161,16 +162,18 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 	 * while it is dying. So, try again a few times.
 	 */
 
-	for (i = 0; i < 10; i++) {
+	start = jiffies;
+	end = start + msecs_to_jiffies(100);
+	do {
 		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
 		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
-			pr_info("CPU%d killed.\n", cpu);
+			pr_info("CPU%d killed (polled %d ms)\n", cpu,
+				jiffies_to_msecs(jiffies - start));
 			return 0;
 		}
 
-		msleep(10);
-		pr_info("Retrying again to check for CPU kill\n");
-	}
+		usleep_range(100, 1000);
+	} while (time_before(jiffies, end));
 
 	pr_warn("CPU%d may not have shut down cleanly (AFFINITY_INFO reports %d)\n",
 			cpu, err);
-- 
2.20.1

