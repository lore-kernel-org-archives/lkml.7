Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7EEC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367BA2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770386;
	bh=sHjWaloOLI+KdSjEfxy0JZYKC4zGVk01LY1fWe3b0SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=qQZGRpU32blDQtAtYP4QMIRhhoIDYzKxCMVrCPiebSwgdyE10ROQirkOB63vA+VwT
	 Enjogu7QK42tY8rtxkzjeQXkPcPSiOs0VJJnvYleBH9w62fsVg+NVsjuBAM4VGAjm8
	 6XDRNtPOE1DmFamrsGo9gmBVooPyv4ddtmm/tGb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfEMR7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:59:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40129 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbfEMR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so7593407pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=W+LbcGoinyl8so0ByhwqIosqlA08N7Jf5zgSchH9jvU=;
        b=UFovtUA47yV18tT3Xfzaz+0Q8fdK9J3/1/D/+yFORsUFCZhrdxYXRReUa7bWqq8+rh
         xCpY4JRWYFTULcQFBw5vRwWg7xaDa+mxGlAIGr1RGZRGlg82TZZerQY0CJulunONZ+Dn
         /66+Y9rNmLwJ3pmgyjJiacEE6M3wgVe1aRVxKEIXKG/od9EVBGZBLikupWuAY+IjhHNT
         hnp0/B/PsbrPyE4WFZEe68CUd+4W/lYhMEUoJmVUKA/sJMcmwfOegHuhsh/I55sDnA12
         VMiwo4UxoTO+rwiITy+03XdQTNkO1747gawc+rPO/NO9qn/8UNcwUyDyAzI8uxuGCHRE
         y/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=W+LbcGoinyl8so0ByhwqIosqlA08N7Jf5zgSchH9jvU=;
        b=Qlb/Fhsw8hf/TJkCN6rhlqBwXvNReIYfoESg0yEof8XVdBI7hAIjIrbL9szSUrtVnl
         KWtzd3s1DWkdIX7WjH1ldJQYR6pRA0p49qWuZRazc790YmXKDu5CMLcXaJe/IQ5OxYe8
         fnIkfGTYlAgkJs/1YjRAKdPmw87nuvPt9phKIfIQY5O4IRVfjxlyrVV/S4+sQ6UAfHb1
         mp9pGoVOQsK8jtpWNC3FWH12P7tdOIHHWabRVLR+7YGjTMo/wEUDoguy82KL8Ujg5DZ3
         iMc5YW66qA9G041N4XRslbIZhrkQZqk+DRIQ0rk56FOPJf+z5VV4sPOVtmmixk5IcOe5
         6WYQ==
X-Gm-Message-State: APjAAAUjIR2nuMyb7nW7fyI136MmYlk5LxidqhP71sv6rlqz+AY5BK5y
        uTEIR+UP8FUhHLkIEu7IJwc=
X-Google-Smtp-Source: APXvYqyg5cP9W/RXQFiRDP4Ic8oCt4AtDcojopoyEnSB8r+J4PbdnNYqUBG2vOun/oOR57xYMrNdSg==
X-Received: by 2002:a62:1d0d:: with SMTP id d13mr35204316pfd.96.1557770377587;
        Mon, 13 May 2019 10:59:37 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:36 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 15/19] perf/x86/intel/cstate: Support multi-die/package
Date:   Mon, 13 May 2019 13:58:59 -0400
Message-Id: <acb5e483287280eeb2b6daabe04a600b85e72a78.1557769318.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some cstate counters becomes die-scope on Xeon Cascade Lake-AP. Perf
cstate driver needs to support die-scope cstate counters.

Use topology_die_cpumask() to replace topology_core_cpumask().
For previous platforms which doesn't have multi-die,
topology_die_cpumask() is identical as topology_core_cpumask().
There is no functional change for previous platforms.

Name the die-scope PMU "cstate_die".

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/events/intel/cstate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 6072f92cb8ea..267d7f8e12ab 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -302,7 +302,7 @@ static int cstate_pmu_event_init(struct perf_event *event)
 			return -EINVAL;
 		event->hw.event_base = pkg_msr[cfg].msr;
 		cpu = cpumask_any_and(&cstate_pkg_cpu_mask,
-				      topology_core_cpumask(event->cpu));
+				      topology_die_cpumask(event->cpu));
 	} else {
 		return -ENOENT;
 	}
@@ -385,7 +385,7 @@ static int cstate_cpu_exit(unsigned int cpu)
 	if (has_cstate_pkg &&
 	    cpumask_test_and_clear_cpu(cpu, &cstate_pkg_cpu_mask)) {
 
-		target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+		target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
 		/* Migrate events if there is a valid target */
 		if (target < nr_cpu_ids) {
 			cpumask_set_cpu(target, &cstate_pkg_cpu_mask);
@@ -414,7 +414,7 @@ static int cstate_cpu_init(unsigned int cpu)
 	 * in the package cpu mask as the designated reader.
 	 */
 	target = cpumask_any_and(&cstate_pkg_cpu_mask,
-				 topology_core_cpumask(cpu));
+				 topology_die_cpumask(cpu));
 	if (has_cstate_pkg && target >= nr_cpu_ids)
 		cpumask_set_cpu(cpu, &cstate_pkg_cpu_mask);
 
@@ -663,7 +663,13 @@ static int __init cstate_init(void)
 	}
 
 	if (has_cstate_pkg) {
-		err = perf_pmu_register(&cstate_pkg_pmu, cstate_pkg_pmu.name, -1);
+		if (topology_max_die_per_package() > 1) {
+			err = perf_pmu_register(&cstate_pkg_pmu,
+						"cstate_die", -1);
+		} else {
+			err = perf_pmu_register(&cstate_pkg_pmu,
+						cstate_pkg_pmu.name, -1);
+		}
 		if (err) {
 			has_cstate_pkg = false;
 			pr_info("Failed to register cstate pkg pmu\n");
-- 
2.18.0-rc0

