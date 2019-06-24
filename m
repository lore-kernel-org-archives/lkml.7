Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F54BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C944620645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbfFXRhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:37:21 -0400
Received: from foss.arm.com ([217.140.110.172]:55672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbfFXRhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:37:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50144C0A;
        Mon, 24 Jun 2019 10:37:20 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFCBB3F718;
        Mon, 24 Jun 2019 10:37:18 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v2] drivers: base: cacheinfo: Ensure cpu hotplug work is done before Intel RDT
Date:   Mon, 24 Jun 2019 18:36:56 +0100
Message-Id: <20190624173656.202407-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cacheinfo structures are alloced/freed by cpu online/offline
callbacks. Originally these were only used by sysfs to expose the
cache topology to user space. Without any in-kernel dependencies
CPUHP_AP_ONLINE_DYN was an appropriate choice.

resctrl has started using these structures to identify CPUs that
share a cache. It updates its 'domain' structures from cpu
online/offline callbacks. These depend on the cacheinfo structures
(resctrl_online_cpu()->domain_add_cpu()->get_cache_id()->
 get_cpu_cacheinfo()).
These also run as CPUHP_AP_ONLINE_DYN.

Now that there is an in-kernel dependency, move the cacheinfo
work earlier so we know its done before resctrl's CPUHP_AP_ONLINE_DYN
work runs.

Fixes: 2264d9c74dda1 ("x86/intel_rdt: Build structures for each resource based on cache topology")
Cc: <stable@vger.kernel.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
I haven't seen any problems because of this.

Changes since v1: lore.kernel.org/r/20190530161024.85637-1-james.morse@arm.com
 * CC-list, added fixes/stable tags.

 drivers/base/cacheinfo.c   | 3 ++-
 include/linux/cpuhotplug.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index a7359535caf5..b444f89a2041 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -655,7 +655,8 @@ static int cacheinfo_cpu_pre_down(unsigned int cpu)
 
 static int __init cacheinfo_sysfs_init(void)
 {
-	return cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "base/cacheinfo:online",
+	return cpuhp_setup_state(CPUHP_AP_BASE_CACHEINFO_ONLINE,
+				 "base/cacheinfo:online",
 				 cacheinfo_cpu_online, cacheinfo_cpu_pre_down);
 }
 device_initcall(cacheinfo_sysfs_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 6a381594608c..50c893f03c21 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -175,6 +175,7 @@ enum cpuhp_state {
 	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
+	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
 	CPUHP_AP_X86_HPET_ONLINE,
-- 
2.20.1

