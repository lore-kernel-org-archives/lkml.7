Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94BDC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989232089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfJKQlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:41:49 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:40291 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfJKQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:41:49 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iIxz5-000225-Gt; Fri, 11 Oct 2019 17:41:43 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iIxz4-0000BP-SJ; Fri, 11 Oct 2019 17:41:42 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: topology: only build cpu_corepower_mask if needed
Date:   Fri, 11 Oct 2019 17:41:42 +0100
Message-Id: <20191011164142.659-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_corepower_mask() is only needed if CONFIG_SCHED_MC is
enabled, so remove the warning about it not being used by
ifdef-ing it out.

fixes the following build warning:

arch/arm/kernel/topology.c:184:30: warning: ‘cpu_corepower_mask’ defined but not used [-Wunused-function]
  184 | static const struct cpumask *cpu_corepower_mask(int cpu)

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
KernelVersion: 5.4-rc3

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/kernel/topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 05d4223d5493..61f9a28f4bfb 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -177,6 +177,7 @@ static inline void parse_dt_topology(void) {}
 static inline void update_cpu_capacity(unsigned int cpuid) {}
 #endif
 
+#ifdef CONFIG_SCHED_MC
 /*
  * The current assumption is that we can power gate each core independently.
  * This will be superseded by DT binding once available.
@@ -185,6 +186,7 @@ static const struct cpumask *cpu_corepower_mask(int cpu)
 {
 	return &cpu_topology[cpu].thread_sibling;
 }
+#endif
 
 /*
  * store_cpu_topology is called at boot when only one cpu is running
-- 
2.23.0

