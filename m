Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9ABECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFF821A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfIKIul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:50:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbfIKIul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:50:41 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1641D4EFB943E5F659AA;
        Wed, 11 Sep 2019 16:50:39 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 16:50:29 +0800
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
        <ard.biesheuvel@linaro.org>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wuyun.wu@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] arm64: psci: Use udelay() instead of msleep() to reduce
 waiting time
Message-ID: <e4d42bda-72f2-4002-f319-1cbe2bff74d2@huawei.com>
Date:   Wed, 11 Sep 2019 16:50:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to reduce the time of cpu_down() for saving power, found that
cpu_psci_cpu_kill() cost 10ms after psci_ops.affinity_info() fail.

Normally the time cpu dead is very short, it is no need to wait 10ms.
so use udelay 10us to instead msleep 10ms in every waiting loop, and add
cond_resched() to give a chance to run a higher-priority process.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 arch/arm64/kernel/psci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 85ee7d0..9e9d8a6 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -86,15 +86,15 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 	 * while it is dying. So, try again a few times.
 	 */

-	for (i = 0; i < 10; i++) {
+	for (i = 0; i < 10000; i++) {
 		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
 		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
 			pr_info("CPU%d killed.\n", cpu);
 			return 0;
 		}

-		msleep(10);
-		pr_info("Retrying again to check for CPU kill\n");
+		cond_resched();
+		udelay(10);
 	}

 	pr_warn("CPU%d may not have shut down cleanly (AFFINITY_INFO reports %d)\n",
-- 
1.8.3.1

