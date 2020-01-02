Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A80C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D0B2072C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ik+PwvY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgABQ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:58:55 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:36281 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgABQ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 11:58:55 -0500
Received: by mail-qv1-f73.google.com with SMTP id di5so11893265qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 08:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=88PK3Hq3Ohz3nw0QAxzD7HSNlTKeJP6chz1iwMhFdQU=;
        b=Ik+PwvY/Kh/G05WYwTp3Qp2kOTNAFUBEA/M8oeiYW9eBsndWyAibRr5plHr+YJLsNW
         yBBFFgaVpg/rGpxd2rycU19OqesVHqr9K20x24ooG7DAwjveJ0XR4Bo+LDsyBrX8DdS/
         FQsmgT63+Nx2xKaSHr7YuuG9ToJ42Q5fTuDhEKPIRpy7js8AiStDb2wpmKu1e/Oeqly9
         +rxoqiAem9ahoPCwqne4eZljQGihcXKnRyndQLG0SiKgOQx5Juc3NvopFnFMdm7h+MNP
         xoFdqdaEHEX7WbR13ebxMVyIV9TSW31JnqalHT4kAnmrrR5uUC88qd4qAwHmlKAvIeIT
         rtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=88PK3Hq3Ohz3nw0QAxzD7HSNlTKeJP6chz1iwMhFdQU=;
        b=Tz6ZgP2rKpdM9ptEV5Vgee7v1LHqU3qBdACx2iQXAf+lgLozzkYbvd3q5ulUQd9Emh
         T63pEwo6oJazMXZHl0qumifLOWCKovfvrtrDHvG+2x4elUgTT6jscVbl3PrTevXBvYmm
         Jq36PoGE06pccFQjvrhtMquh0TEN1CqgZf78IcqW7xAjOHS35ZsW5K9n8JamiiKOXlbY
         rOToRL3ToeTbGKtaKuHCiEP2HTdS9RUwTkIhdCnQYtb299mpk8d7BvLEa2Oeta/uND+5
         tEhfevb4OnUW6YMt4sFlU8xuwNMi8LShBoY/JQ+rM1y6wjWOQcxHxDpIOS0nxADvMMiU
         h6tQ==
X-Gm-Message-State: APjAAAWH7ajhTL9haqugq6/0G6Wk82QhIiCQmr/R91XlMj4GtKtXXiCN
        kSSLpgJrdD5/umeV6K+CJ7Y2F7l/A85Ukw==
X-Google-Smtp-Source: APXvYqx8Kknv0lj6mRvldzRhV5Evf9y6FQXXZ6oAc6/yV0EeJswhe4KYZvD0NONPMaagEsa5WIcxQdeUq3XJsw==
X-Received: by 2002:a37:4905:: with SMTP id w5mr66983189qka.267.1577984332807;
 Thu, 02 Jan 2020 08:58:52 -0800 (PST)
Date:   Thu,  2 Jan 2020 08:58:44 -0800
Message-Id: <20200102165844.133133-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3] x86/resctrl: Fix potential memory leak
From:   Shakeel Butt <shakeelb@google.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The set_cache_qos_cfg() is leaking memory when the given level is not
RDT_RESOURCE_L3 or RDT_RESOURCE_L2. However at the moment, this function
is called with only valid levels but to make it more robust and future
proof, we should be handling the error path gracefully. So, moving the
allocation after the valid level checks.

Fixes: 99adde9b370de ("x86/intel_rdt: Enable L2 CDP in MSR IA32_L2_QOS_CFG")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v2:
- Move the allocation after validity checks

Changes since v1:
- Updated the commit message

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2e3b06d6bbc6..dac7209a0708 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1741,9 +1741,6 @@ static int set_cache_qos_cfg(int level, bool enable)
 	struct rdt_domain *d;
 	int cpu;
 
-	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	if (level == RDT_RESOURCE_L3)
 		update = l3_qos_cfg_update;
 	else if (level == RDT_RESOURCE_L2)
@@ -1751,6 +1748,9 @@ static int set_cache_qos_cfg(int level, bool enable)
 	else
 		return -EINVAL;
 
+	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	r_l = &rdt_resources_all[level];
 	list_for_each_entry(d, &r_l->domains, list) {
 		/* Pick one CPU from each domain instance to update MSR */
-- 
2.24.1.735.g03f4e72817-goog

