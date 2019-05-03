Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1158FC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5062087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Jl8ktPAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfECKuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:50:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46253 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfECKuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:50:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x43Ao34h2712333
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 3 May 2019 03:50:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x43Ao34h2712333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556880604;
        bh=WTqzzJ4cP3ZKaoaSJYipFlFfrIhPOe9QXWH9JQ9dRr0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Jl8ktPAxGpYfshJ4FvZDECTq3w/T2B7xD016/8VBp5DecN747YBJNDm767JvikUl2
         BFqcYwC22e99Ruh1b2RlBL4paie6eCBucuhjH82vns/WdbmtSRk0x9MdN9T+2eIadQ
         xh8C5hSNxyaeZN2APQwNWa0GU29SSXxuJ+hErUNlOGUWQnJ4Gsmka0mZNaf1Szvjtx
         dLQw22/enzNszFZrd8R3TeTXA8DeGEex9gKS+4ZvQm3ZP1XH9M8sWb1Fw2FWCiBx61
         fP0SVTDWWI4Eog9Bpp4LRV7ovQNUP12N3h1cFGYusaIPjNnWBP7e8KmFs7MEYYb6dm
         2qT7UUs6EE7BA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x43Ao2kh2712329;
        Fri, 3 May 2019 03:50:02 -0700
Date:   Fri, 3 May 2019 03:50:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexander Shishkin <tipbot@zytor.com>
Message-ID: <tip-72e830f68428ab9ea9eca65d160795f4e02cecfc@git.kernel.org>
Cc:     a.p.zijlstra@chello.nl, hpa@zytor.com, vincent.weaver@maine.edu,
        acme@redhat.com, torvalds@linux-foundation.org, eranian@google.com,
        jolsa@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, eranian@google.com, mingo@kernel.org,
          jolsa@redhat.com, torvalds@linux-foundation.org, acme@redhat.com,
          vincent.weaver@maine.edu, hpa@zytor.com, a.p.zijlstra@chello.nl
In-Reply-To: <20190503085536.24119-3-alexander.shishkin@linux.intel.com>
References: <20190503085536.24119-3-alexander.shishkin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel/pt: Remove software double
 buffering PMU capability
Git-Commit-ID: 72e830f68428ab9ea9eca65d160795f4e02cecfc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  72e830f68428ab9ea9eca65d160795f4e02cecfc
Gitweb:     https://git.kernel.org/tip/72e830f68428ab9ea9eca65d160795f4e02cecfc
Author:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate: Fri, 3 May 2019 11:55:36 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 3 May 2019 12:46:20 +0200

perf/x86/intel/pt: Remove software double buffering PMU capability

Now that all AUX allocations are high-order by default, the software
double buffering PMU capability doesn't make sense any more, get rid
of it. In case some PMUs choose to opt out, we can re-introduce it.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: adrian.hunter@intel.com
Link: http://lkml.kernel.org/r/20190503085536.24119-3-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/pt.c | 3 +--
 include/linux/perf_event.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fb3a2f13fc70..339d7628080c 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1525,8 +1525,7 @@ static __init int pt_init(void)
 	}
 
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
-		pt_pmu.pmu.capabilities =
-			PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_SW_DOUBLEBUF;
+		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_NO_SG;
 
 	pt_pmu.pmu.capabilities	|= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE;
 	pt_pmu.pmu.attr_groups		 = pt_attr_groups;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e47ef764f613..1f678f023850 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -240,7 +240,6 @@ struct perf_event;
 #define PERF_PMU_CAP_NO_INTERRUPT		0x01
 #define PERF_PMU_CAP_NO_NMI			0x02
 #define PERF_PMU_CAP_AUX_NO_SG			0x04
-#define PERF_PMU_CAP_AUX_SW_DOUBLEBUF		0x08
 #define PERF_PMU_CAP_EXCLUSIVE			0x10
 #define PERF_PMU_CAP_ITRACE			0x20
 #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
