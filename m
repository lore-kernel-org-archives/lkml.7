Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B6DC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1872F208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576015459;
	bh=W1rixHlRglZalpJ3fSvD2qz0lSsb15o4abLzRwMrYYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E4l4e/P9xDUmnaE1jKq0wvVU+u3rktuwOo4fRKb8FmYwe5iz/5U5M0Z4wbirzR3JS
	 xK93sIgfuxIxaHAd+eecLSQPwkfbmkXETASYRv/JEa1+uFxMWeZWdL6/oaI3nP4txa
	 RfcwzsEddCaPyP7Y3L6EnTmspgpO38lt4ccZ/vHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfLJWER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:04:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfLJWEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:04:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C212465E;
        Tue, 10 Dec 2019 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015451;
        bh=W1rixHlRglZalpJ3fSvD2qz0lSsb15o4abLzRwMrYYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Km/cCl626oqYcOS2RGhSNtWspd0BGhZspE7efBonyRMwKSz3PH6QjM+cnIawbyB5
         c00Ju4YbS0T1eu6RBdTtSqmPjEF5HgopasFKvCZD0Q7Pfq8QadtVUfzevXcTQQMIQ9
         kdRrmIIqjpHnKoW39hvtCRmNKrfSPQnYgancTYDw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 058/130] arm64: psci: Reduce the waiting time for cpu_psci_cpu_kill()
Date:   Tue, 10 Dec 2019 17:01:49 -0500
Message-Id: <20191210220301.13262-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
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
index e8edbf13302aa..3856d51c645b5 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -84,7 +84,8 @@ static void cpu_psci_cpu_die(unsigned int cpu)
 
 static int cpu_psci_cpu_kill(unsigned int cpu)
 {
-	int err, i;
+	int err;
+	unsigned long start, end;
 
 	if (!psci_ops.affinity_info)
 		return 0;
@@ -94,16 +95,18 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
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

