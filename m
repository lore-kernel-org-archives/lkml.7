Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE9CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EFF20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sownw1wD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfDAPDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:03:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58120 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfDAPDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:03:51 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F4091EC0354;
        Mon,  1 Apr 2019 17:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554131029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ID4grBT9wHWRYXPPSwvRThRgD8ziDtniErq38bMC/B4=;
        b=Sownw1wDqHwxMCtpDZ/JpBApBrufD5+r2Xoo47aMyHExqGyDE207xkBQbL9C6wNBTbbqh9
        xCLeAWnzyQApZXOWOUu9Ei6d3Ifw0vIpWcVmNlrW6R7bE8tN9BXofhqYu3iE/0nMmir3t0
        n7dM2Qd6vAvqb+RqdAu0yvWgtxzq/nc=
Date:   Mon, 1 Apr 2019 17:03:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Erwan Velu <e.velu@criteo.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq/intel_pstate: Load only on Intel hardware
Message-ID: <20190401150345.GJ28264@zn.tnic>
References: <20190330100225.14744-1-bp@alien8.de>
 <fa14666a-269c-249a-f603-b00f6301c1a6@criteo.com>
 <20190401083902.GC28264@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190401083902.GC28264@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

This driver is Intel-only so loading on anything which is not Intel is
pointless. Prevent it from doing so.

While at it, correct the "not supported" print statement to say CPU
"model" which is what that test does.

Suggested-by: Erwan Velu <e.velu@criteo.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b599c7318aab..2986119dd31f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2596,6 +2596,9 @@ static int __init intel_pstate_init(void)
 	const struct x86_cpu_id *id;
 	int rc;
 
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return -ENODEV;
+
 	if (no_load)
 		return -ENODEV;
 
@@ -2611,7 +2614,7 @@ static int __init intel_pstate_init(void)
 	} else {
 		id = x86_match_cpu(intel_pstate_cpu_ids);
 		if (!id) {
-			pr_info("CPU ID not supported\n");
+			pr_info("CPU model not supported\n");
 			return -ENODEV;
 		}
 
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
