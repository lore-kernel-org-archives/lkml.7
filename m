Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAC5C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069642173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419207;
	bh=YGRQedWumi+kbbwbElqXz/8IZIYlT6VDf/f5s6Qm8sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l8n8peobz+j04YuTRpp8KYoIxTGUp55v9O2+l1cv4Xuzv1+fFqihpJH36is1wQePz
	 yOI4QrjzdMOaUqmMFVksxOcTGcIfVytDytLOhOzg4iNBmUBIywRd/PCl3DHxQvXZS+
	 AHLrU052qfg4on/MZX+PqafpAT2PFDge11eemGA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390279AbfGRDGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390257AbfGRDGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:06:41 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7660D2053B;
        Thu, 18 Jul 2019 03:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419200;
        bh=YGRQedWumi+kbbwbElqXz/8IZIYlT6VDf/f5s6Qm8sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ykzAOsfERkL1N25Zt08ceONItf8omR1sn11cmy2AZCp9NScB0T7B9EUNfDGo5PdD
         uhj/YUN1jg88QHvor8T4Vu4E8ViNdzFnY6/EsCx2g1TLNMRcYNDuwlRxI2xEIR8cT7
         58e/flENNprOUbzbNxTfvH4igrkq5TzLKk+zauG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 4.19 05/47] drivers: base: cacheinfo: Ensure cpu hotplug work is done before Intel RDT
Date:   Thu, 18 Jul 2019 12:01:19 +0900
Message-Id: <20190718030048.575117359@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
References: <20190718030045.780672747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

commit 83b44fe343b5abfcb1b2261289bd0cfcfcfd60a8 upstream.

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
Link: https://lore.kernel.org/r/20190624173656.202407-1-james.morse@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/cacheinfo.c   |    3 ++-
 include/linux/cpuhotplug.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -653,7 +653,8 @@ static int cacheinfo_cpu_pre_down(unsign
 
 static int __init cacheinfo_sysfs_init(void)
 {
-	return cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "base/cacheinfo:online",
+	return cpuhp_setup_state(CPUHP_AP_BASE_CACHEINFO_ONLINE,
+				 "base/cacheinfo:online",
 				 cacheinfo_cpu_online, cacheinfo_cpu_pre_down);
 }
 device_initcall(cacheinfo_sysfs_init);
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -170,6 +170,7 @@ enum cpuhp_state {
 	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
+	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
 	CPUHP_AP_X86_HPET_ONLINE,


