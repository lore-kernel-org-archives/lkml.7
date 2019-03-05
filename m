Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C5BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C25208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551799542;
	bh=2HsIXxNShLglA73yL5KjOzyocvzJmP+5gFr7WZh22mE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wVfKQ8T0n8ZbdGiMWJigIekMfhGTMkdJ2GEnpzf2xQ50FQQ0H7aQlO/qrCisTmNm5
	 Md20z/l/+YNa0YjGR2Pszbr/FSDZa62leptHovfAJmFQQ1BekkNEg9f5w8aEdfgL4q
	 GpBSR6BXUy02XQZahpPAKfZI8NVxKWWFN2VNDpgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfCEPZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:25:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfCEPZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:25:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0AEA87634;
        Tue,  5 Mar 2019 15:25:39 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AC291001DF0;
        Tue,  5 Mar 2019 15:25:37 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 0/8] perf tools: Assorted fixes
Date:   Tue,  5 Mar 2019 16:25:28 +0100
Message-Id: <20190305152536.21035-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 05 Mar 2019 15:25:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending assorted general fixes that queued
up in my other branches.

It contains all my previous posted single patches,
(except for the dir data patchset).

Also available in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


---
Jiri Olsa (8):
      perf c2c: Fix c2c report for empty numa node
      perf tools: Add error path into hist_entry__init
      perf hist: Fix memory leak of srcline
      perf tools: Read and store caps/max_precise in perf_pmu
      perf tools: Get precise_ip from the pmu config
      perf tools: Probe for precise_ip with simple attr
      perf tools: Fix double free in perf_data__close
      perf tools: Force perf_data__open|close zero data->file.path

 tools/perf/builtin-c2c.c  |  8 ++++++--
 tools/perf/util/data.c    |  4 ++--
 tools/perf/util/evlist.c  | 25 ++++++++++++++++++++-----
 tools/perf/util/evsel.c   | 36 +++++++++++++++++++++++++++---------
 tools/perf/util/hist.c    | 51 ++++++++++++++++++++++++++++++---------------------
 tools/perf/util/pmu.c     | 14 ++++++++++++++
 tools/perf/util/pmu.h     |  1 +
 tools/perf/util/session.c |  4 +---
 tools/perf/util/setup.py  |  2 +-
 9 files changed, 102 insertions(+), 43 deletions(-)
