Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773FBC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E523222BF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343782;
	bh=iOj8CJhHNalPdK22Tr/ETE/feQREA8Pz9UcoTQaOLwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WhdgyFJVkU2wLMFnNVNsK9REiBbMikXYaXmBWBNm10yJIibvULF6u7Pq275Ys9mLL
	 SL0z+Smayxxse8fjavoCf0zsPNYWgfuJmSS7VU1CpeR5P1VUUmqtqUJC/6xNFzkE1U
	 CLMvcZCwmdRPWTWQIcL+P4YiFln3lvcKWB+YzGPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410608AbfIXQtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410580AbfIXQtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:49:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAAC121971;
        Tue, 24 Sep 2019 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343774;
        bh=iOj8CJhHNalPdK22Tr/ETE/feQREA8Pz9UcoTQaOLwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcYly+ctse3R2edBykifNlkHTxngEuHvfy1qwVC0dTrs/b3zRJt9ms3OrBGg3iIHq
         ghgG+GdN/j7P15EbRz2FSpg1MoEufRUxUPFJAxs54crMhIpX7SnGobjKdJ9fJg9ScX
         us8JV+BNCf8ITRnSA3iRWLemKsVslq1imcv7Pdf0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Lynch <nathanl@linux.ibm.com>,
        "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 24/50] powerpc/rtas: use device model APIs and serialization during LPM
Date:   Tue, 24 Sep 2019 12:48:21 -0400
Message-Id: <20190924164847.27780-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164847.27780-1-sashal@kernel.org>
References: <20190924164847.27780-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Lynch <nathanl@linux.ibm.com>

[ Upstream commit a6717c01ddc259f6f73364779df058e2c67309f8 ]

The LPAR migration implementation and userspace-initiated cpu hotplug
can interleave their executions like so:

1. Set cpu 7 offline via sysfs.

2. Begin a partition migration, whose implementation requires the OS
   to ensure all present cpus are online; cpu 7 is onlined:

     rtas_ibm_suspend_me -> rtas_online_cpus_mask -> cpu_up

   This sets cpu 7 online in all respects except for the cpu's
   corresponding struct device; dev->offline remains true.

3. Set cpu 7 online via sysfs. _cpu_up() determines that cpu 7 is
   already online and returns success. The driver core (device_online)
   sets dev->offline = false.

4. The migration completes and restores cpu 7 to offline state:

     rtas_ibm_suspend_me -> rtas_offline_cpus_mask -> cpu_down

This leaves cpu7 in a state where the driver core considers the cpu
device online, but in all other respects it is offline and
unused. Attempts to online the cpu via sysfs appear to succeed but the
driver core actually does not pass the request to the lower-level
cpuhp support code. This makes the cpu unusable until the cpu device
is manually set offline and then online again via sysfs.

Instead of directly calling cpu_up/cpu_down, the migration code should
use the higher-level device core APIs to maintain consistent state and
serialize operations.

Fixes: 120496ac2d2d ("powerpc: Bring all threads online prior to migration/hibernation")
Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190802192926.19277-2-nathanl@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/rtas.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8afd146bc9c70..9e41a9de43235 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -875,15 +875,17 @@ static int rtas_cpu_state_change_mask(enum rtas_cpu_state state,
 		return 0;
 
 	for_each_cpu(cpu, cpus) {
+		struct device *dev = get_cpu_device(cpu);
+
 		switch (state) {
 		case DOWN:
-			cpuret = cpu_down(cpu);
+			cpuret = device_offline(dev);
 			break;
 		case UP:
-			cpuret = cpu_up(cpu);
+			cpuret = device_online(dev);
 			break;
 		}
-		if (cpuret) {
+		if (cpuret < 0) {
 			pr_debug("%s: cpu_%s for cpu#%d returned %d.\n",
 					__func__,
 					((state == UP) ? "up" : "down"),
@@ -972,6 +974,8 @@ int rtas_ibm_suspend_me(u64 handle)
 	data.token = rtas_token("ibm,suspend-me");
 	data.complete = &done;
 
+	lock_device_hotplug();
+
 	/* All present CPUs must be online */
 	cpumask_andnot(offline_mask, cpu_present_mask, cpu_online_mask);
 	cpuret = rtas_online_cpus_mask(offline_mask);
@@ -1003,6 +1007,7 @@ int rtas_ibm_suspend_me(u64 handle)
 				__func__);
 
 out:
+	unlock_device_hotplug();
 	free_cpumask_var(offline_mask);
 	return atomic_read(&data.error);
 }
-- 
2.20.1

