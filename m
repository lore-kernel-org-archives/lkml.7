Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00CFC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA524205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfEIPEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:04:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:33485 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfEIPEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:04:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 08:04:03 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 09 May 2019 08:04:03 -0700
Received: from [10.254.89.177] (kliang2-mobl.ccr.corp.intel.com [10.254.89.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BFA80580102;
        Thu,  9 May 2019 08:04:02 -0700 (PDT)
Subject: Re: [PATCH 22/22] perf/x86/intel/rapl: rename internal variables in
 response to multi-die/pkg support
To:     Len Brown <lenb@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
 <9f57786ba08d4d5e913cd21693aadb0ccdba72b2.1557177585.git.len.brown@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <06e134aa-943a-dff9-4d33-e0bc8449f284@linux.intel.com>
Date:   Thu, 9 May 2019 11:04:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9f57786ba08d4d5e913cd21693aadb0ccdba72b2.1557177585.git.len.brown@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/2019 5:26 PM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Syntax update only -- no logical or functional change.
> 
> In response to the new multi-die/package changes, update variable names
> to use the more generic "pmuid" terminology, instead of "pkgid",
> as the pmu can refer to either packages or die.


The perf rapl "pmu" in the code is cross the pkg/die. We only register 
one rapl pmu for whole system for now.
I think it may be better use "die" to replace the "pkg" as well.
How about the patch as below?

Thanks,
Kan


 From a898867b24ed8ea3582b0c8b3218838701249065 Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Thu, 9 May 2019 07:21:35 -0700
Subject: [PATCH 2/2] perf/x86/intel/rapl: rename internal variables in 
response to multi-die/pkg support

Syntax update only -- no logical or functional change.

In response to the new multi-die/package changes, update variable names
to use "die" terminology, instead of "pkg".
For previous platforms which doesn't have multi-die, "die" is identical
as "pkg".

Originally-by: Len Brown <len.brown@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
  arch/x86/events/intel/rapl.c | 14 +++++++-------
  1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index e49f69c..f7fc94d 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -148,7 +148,7 @@ struct rapl_pmu {

  struct rapl_pmus {
  	struct pmu		pmu;
-	unsigned int		maxpkg;
+	unsigned int		maxdie;
  	struct rapl_pmu		*pmus[];
  };

@@ -161,13 +161,13 @@ static u64 rapl_timer_ms;

  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
  {
-	unsigned int pkgid = topology_logical_die_id(cpu);
+	unsigned int dieid = topology_logical_die_id(cpu);

  	/*
  	 * The unsigned check also catches the '-1' return value for non
  	 * existent mappings in the topology map.
  	 */
-	return pkgid < rapl_pmus->maxpkg ? rapl_pmus->pmus[pkgid] : NULL;
+	return dieid < rapl_pmus->maxdie ? rapl_pmus->pmus[dieid] : NULL;
  }

  static inline u64 rapl_read_counter(struct perf_event *event)
@@ -668,22 +668,22 @@ static void cleanup_rapl_pmus(void)
  {
  	int i;

-	for (i = 0; i < rapl_pmus->maxpkg; i++)
+	for (i = 0; i < rapl_pmus->maxdie; i++)
  		kfree(rapl_pmus->pmus[i]);
  	kfree(rapl_pmus);
  }

  static int __init init_rapl_pmus(void)
  {
-	int maxpkg = topology_max_packages() * topology_max_die_per_package();
+	int maxdie = topology_max_packages() * topology_max_die_per_package();
  	size_t size;

-	size = sizeof(*rapl_pmus) + maxpkg * sizeof(struct rapl_pmu *);
+	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
  	rapl_pmus = kzalloc(size, GFP_KERNEL);
  	if (!rapl_pmus)
  		return -ENOMEM;

-	rapl_pmus->maxpkg		= maxpkg;
+	rapl_pmus->maxdie		= maxdie;
  	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
  	rapl_pmus->pmu.task_ctx_nr	= perf_invalid_context;
  	rapl_pmus->pmu.event_init	= rapl_pmu_event_init;
-- 
2.7.4

