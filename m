Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0275BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 04:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B872133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 04:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfJIEpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 00:45:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729040AbfJIEpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 00:45:54 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 536C27FB91AF7942FE52;
        Wed,  9 Oct 2019 12:45:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 12:45:44 +0800
Subject: [PATCH V2] arm64: psci: Reduce waiting time of cpu_psci_cpu_kill()
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wuyun.wu@huawei.com" <wuyun.wu@huawei.com>
References: <18068756-0f39-6388-3290-cf03746e767d@huawei.com>
Message-ID: <9df267db-e647-a81d-16bb-b8bfb06c2624@huawei.com>
Date:   Wed, 9 Oct 2019 12:45:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <18068756-0f39-6388-3290-cf03746e767d@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If psci_ops.affinity_info() fails, it will sleep 10ms, which will not
take so long in the right case. Use usleep_range() instead of msleep(),
reduce the waiting time, and give a chance to busy wait before sleep.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
V1->V2:
- use usleep_range() instead of udelay() after waiting for a while

 arch/arm64/kernel/psci.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index c9f72b2..99b3122 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -82,6 +82,7 @@ static void cpu_psci_cpu_die(unsigned int cpu)
 static int cpu_psci_cpu_kill(unsigned int cpu)
 {
 	int err, i;
+	unsigned long timeout;

 	if (!psci_ops.affinity_info)
 		return 0;
@@ -91,16 +92,24 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 	 * while it is dying. So, try again a few times.
 	 */

-	for (i = 0; i < 10; i++) {
+	i = 0;
+	timeout = jiffies + msecs_to_jiffies(100);
+	do {
 		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
 		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
 			pr_info("CPU%d killed.\n", cpu);
 			return 0;
 		}

-		msleep(10);
-		pr_info("Retrying again to check for CPU kill\n");
-	}
+		/* busy-wait max 1ms */
+		if (i++ < 100) {
+			cond_resched();
+			udelay(10);
+			continue;
+		}
+
+		usleep_range(100, 1000);
+	} while (time_before(jiffies, timeout));

 	pr_warn("CPU%d may not have shut down cleanly (AFFINITY_INFO reports %d)\n",
 			cpu, err);
-- 
2.7.4.3

