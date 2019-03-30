Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D647CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 10:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97166218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 10:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TD6HiWvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfC3KC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 06:02:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46596 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730532AbfC3KC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 06:02:27 -0400
Received: from zn.tnic (p200300EC2F148A00C43C95AA310C833A.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:c43c:95aa:310c:833a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3648C1EC066F;
        Sat, 30 Mar 2019 11:02:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553940145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=fPgktxmAoVc55FNFVGCEpY8L5UOzA8MrHbl6ThgEQBY=;
        b=TD6HiWvlY6sw5rz+KHKtZq/YNs0nhajn5roI4hESZnU60puluYUfkimnZDRE0cZhzX53Kx
        jjuFzrLYxvDMj5x+Yfw217ZDDF8fAmHmZ9Kmg7OaFKM3f5dhv5jXSITcVtUVvgwj0fIiD0
        NCtcW+hVHRlwDXYCsx7jknKRgPqMQCo=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Erwan Velu <e.velu@criteo.com>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq/intel_pstate: Do not issue the not supported message on !Intel
Date:   Sat, 30 Mar 2019 11:02:25 +0100
Message-Id: <20190330100225.14744-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Issue the CPU-not-supported message only on Intel machines as this
driver is Intel-only. Which means, the print statement can remain
KERN_INFO for ease of debugging (no need to enable it first in dynamic
debug).

While at it, correct it to say CPU "model" which is what that test does.

Fixes: 076b862c7e44 ("cpufreq: intel_pstate: Add reasons for failure and debug messages")
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Erwan Velu <e.velu@criteo.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ea62e3f02d56..19854f01e2fa 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2608,7 +2608,9 @@ static int __init intel_pstate_init(void)
 	} else {
 		id = x86_match_cpu(intel_pstate_cpu_ids);
 		if (!id) {
-			pr_info("CPU ID not supported\n");
+			if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+				pr_info("CPU model not supported\n");
+
 			return -ENODEV;
 		}
 
-- 
2.21.0

