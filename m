Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7774C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984EA208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557676532;
	bh=Tn/Xh9BC2361aMIb7WmsJUAhVveRtEPdktsYhKL8B7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KDujU+CoLnI5P+5uBnxM6cqSEI4DugjTKOsHcXIrO9dxYwZqf4R+f0ROoqJjAb+zH
	 O5kDEgCj+I3LF278hm2xPsNoc//6fphdoXgy406d3BofSHe6UQqsxjFdEYLBlT9jqi
	 9Y4CW2SytJGHteIFWT/1Ak/NeCOETeGd4kReRrts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfELPzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:55:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbfELPz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:55:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 033DB308FBA9;
        Sun, 12 May 2019 15:55:29 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A8294B6;
        Sun, 12 May 2019 15:55:26 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/9] perf/x86: Get rid of x86_pmu::event_attrs
Date:   Sun, 12 May 2019 17:55:12 +0200
Message-Id: <20190512155518.21468-4-jolsa@kernel.org>
In-Reply-To: <20190512155518.21468-1-jolsa@kernel.org>
References: <20190512155518.21468-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 12 May 2019 15:55:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody is using that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/core.c       | 3 ---
 arch/x86/events/perf_event.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index de1a924a4914..f2be5d2a62fe 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1850,9 +1850,6 @@ static int __init init_hw_perf_events(void)
 			x86_pmu_caps_group.attrs = tmp;
 	}
 
-	if (x86_pmu.event_attrs)
-		x86_pmu_events_group.attrs = x86_pmu.event_attrs;
-
 	if (!x86_pmu.events_sysfs_show)
 		x86_pmu_events_group.attrs = &empty_attrs;
 	else
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 07fc84bb85c1..3f87cb4d7585 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -631,7 +631,6 @@ struct x86_pmu {
 	int		attr_rdpmc_broken;
 	int		attr_rdpmc;
 	struct attribute **format_attrs;
-	struct attribute **event_attrs;
 	struct attribute **caps_attrs;
 
 	ssize_t		(*events_sysfs_show)(char *page, u64 config);
-- 
2.20.1

