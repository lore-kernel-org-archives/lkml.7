Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE691C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2A4217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684698;
	bh=RjsL/Ro3n6bGlr2/VDiTzvtHYudT4NRKjI3tiYQNkgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=HReYQNueLUABejDSzn/JigRkWjkCl5fEPnYBumx0KWPpYEN7I7XgHxR0yaQeRgTAD
	 aOA94z1JkkWifa/LgsCQE0tfo3WApbxFMLK7d9dok4STE5tbmrHutiiPqEPZJ7yi7H
	 oOtajKbZ5KyKO9sJrnvCgW2rbYFYVtjWtGadBCTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfEAEY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:24:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36909 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfEAEYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:55 -0400
Received: by mail-io1-f68.google.com with SMTP id a23so14113735iot.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=/r/wJJuIve3cfROEOjQXmKOysyLZKrQ8MKJaix41P8Y=;
        b=EKVwlH7mnbauXGoQhN2zq1z6ls24aLj1FpHdlTqf7VApuvImdUsC+Zd+Zh9fOdAv8p
         9YUCK80vSY+AurVWO/jJ7B2yanj8m926eCBe7PEbe3AKs6CoIsP3FrzlRu/0pPExGYXv
         DskKJxWKsH8DaPcgANFJYUjrsyKlYpzcCW8vETi8nlVCxjbv7/RYC85mZnCDoceb1c9w
         pZ9Uxci/XWQ2Ebsri5B0p/QT+XE6RIPv+MlBki/sjrxE2Vi0CfztVHx4VnHGdbPj6zsA
         YdFzKmQskd7mDMEuBp9Vi9/tN7WeV4YcV/coV/WCIuoqjHsOE7Zl4LQFVnoIk7pou8VX
         yVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=/r/wJJuIve3cfROEOjQXmKOysyLZKrQ8MKJaix41P8Y=;
        b=q8hBXel3oMrHIhRvDl8VRAa2Iyqya2ghZim3Z/9+BjdxIVkVbhFKXhmxJnhORlYu9z
         WbY99ULMtYYsRi/EhQzIb8THznNeYgEmdjL/5VIINkMAkoXkqfgTzwUJpxYYf5sBbOd2
         wWAG+qrjBv9MjiAACTpYtqsrYOPizrjdvcmXnMUOXytHyBXa4OCwCnyaGA0h3H3tijeM
         pFgycFOhM9P/Sj50qjnT4z+qZfZNsVz+gZkjk5sfuKuLhmFry3cd/RvfKsRYuUhjbYvd
         sK0U6wki4Ca6zTxpEGG3sJQqvxlmdGAMVgvpcLtQtOmcF7/CJw1nnbTlpWPEgzuEKwrX
         kudQ==
X-Gm-Message-State: APjAAAWS5FWCrK7axGUhweXuH2DYiEF3kk54kjAfS8NDIVoogzcuIZqG
        uaa2d8m206F3Tr6pOO2fD/Q=
X-Google-Smtp-Source: APXvYqzC482Qdnx+/sMTeNrfGWswi2LyiRra6AXKBG5pISGRmvEp1lnielpVvsI8eh9AehWPAvFQPA==
X-Received: by 2002:a6b:e502:: with SMTP id y2mr12795644ioc.73.1556684694482;
        Tue, 30 Apr 2019 21:24:54 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:53 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 17/18] perf/x86/intel/rapl: Support multi-die/package
Date:   Wed,  1 May 2019 00:24:26 -0400
Message-Id: <da7518106ce152367457c014bc91281925ee9576.1556657368.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

RAPL becomes die-scope on Xeon Cascade Lake-AP. Perf RAPL driver needs
to support die-scope RAPL domain.

Use topology_logical_die_id() to replace topology_logical_package_id().
For previous platforms which doesn't have multi-die,
topology_logical_die_id() is identical as topology_logical_package_id().

Use topology_die_cpumask() to replace topology_core_cpumask().
For previous platforms which doesn't have multi-die,
topology_die_cpumask() is identical as topology_core_cpumask().

There is no functional change for previous platforms.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/events/intel/rapl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 94dc564146ca..e49f69c51b10 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -161,7 +161,7 @@ static u64 rapl_timer_ms;
 
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int pkgid = topology_logical_package_id(cpu);
+	unsigned int pkgid = topology_logical_die_id(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
@@ -571,7 +571,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -598,14 +598,14 @@ static int rapl_cpu_online(unsigned int cpu)
 		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
 		rapl_hrtimer_init(pmu);
 
-		rapl_pmus->pmus[topology_logical_package_id(cpu)] = pmu;
+		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
 	}
 
 	/*
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_cpu_mask, topology_core_cpumask(cpu));
+	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
 	if (target < nr_cpu_ids)
 		return 0;
 
@@ -675,7 +675,7 @@ static void cleanup_rapl_pmus(void)
 
 static int __init init_rapl_pmus(void)
 {
-	int maxpkg = topology_max_packages();
+	int maxpkg = topology_max_packages() * topology_max_die_per_package();
 	size_t size;
 
 	size = sizeof(*rapl_pmus) + maxpkg * sizeof(struct rapl_pmu *);
-- 
2.18.0-rc0

