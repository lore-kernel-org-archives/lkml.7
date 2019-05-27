Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C708C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B6C21707
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfE0CH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 22:07:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17579 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725923AbfE0CHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 22:07:55 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5FB2233BD9F184B792E4;
        Mon, 27 May 2019 10:07:53 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 27 May 2019 10:07:45 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 1/2] drivers: base: cacheinfo: Add variable to record max cache line size
Date:   Mon, 27 May 2019 10:06:07 +0800
Message-ID: <1558922768-29155-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add coherency_max_size variable to record the maximum cache line size
for different cache levels. We will synchronize it with CTR_EL0.CWG
reporting in cache_line_size() for arm64.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
ChangeLog since v2:
  -- Rebase to 5.2-rc2
  -- Export cache_line_size for I/O driver
ChangeLog since v1:
  -- Move coherency_max_size to drivers/base/cacheinfo.c
  -- Address Catalin's comments
  Link: https://www.spinics.net/lists/arm-kernel/msg723615.html

 drivers/base/cacheinfo.c  | 5 +++++
 include/linux/cacheinfo.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index a7359535caf5..8827c60f51e2 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -213,6 +213,8 @@ int __weak cache_setup_acpi(unsigned int cpu)
 	return -ENOTSUPP;
 }
 
+unsigned int coherency_max_size;
+
 static int cache_shared_cpu_map_setup(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -251,6 +253,9 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 				cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
 			}
 		}
+		/* record the maximum cache line size */
+		if (this_leaf->coherency_line_size > coherency_max_size)
+			coherency_max_size = this_leaf->coherency_line_size;
 	}
 
 	return 0;
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 70e19bc6cc9f..46b92cd61d0c 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -17,6 +17,8 @@ enum cache_type {
 	CACHE_TYPE_UNIFIED = BIT(2),
 };
 
+extern unsigned int coherency_max_size;
+
 /**
  * struct cacheinfo - represent a cache leaf node
  * @id: This cache's id. It is unique among caches with the same (type, level).
-- 
2.7.4

