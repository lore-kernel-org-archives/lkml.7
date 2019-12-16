Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9FFC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E3321835
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576529268;
	bh=AHIxHCZn5O33ir7Tz+Pc4yZfThRcdwfTHwkAQkkxnh8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=V6DpO4Wh5009vv1C925FNFT+8kitcHGmMU4UzDtT6f19gLHT/Cf53lYJYGxyfj0WU
	 dnCdm6drjM4B74eD2SfxK+v5rVKZ1/7lfsMnQy/e/TVjcbRVYHKh1TbJs9kEILf4HL
	 2Y+juo7/ZdCzscn42b4Afs5BYhz1I3DccxhxrfaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLPUrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLPUrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:47:47 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C94321775;
        Mon, 16 Dec 2019 20:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576529266;
        bh=AHIxHCZn5O33ir7Tz+Pc4yZfThRcdwfTHwkAQkkxnh8=;
        h=From:To:Cc:Subject:Date:From;
        b=s754W1cd5pFR9BAxO/SEuXMqoJoqmOxamehyGOhQOsIjg1udllusSfzYDbzgSGMKX
         I1vtb3hz7fXi3mJQMcLTZ72/T51khCtmpDIZPouMvy5ZjE5WPuKCqwLI+0MyqU/XnR
         BJ6n8Guw8A/BJsRbepRSICa7O2HSkDNojiZglmJ0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ed Maste <emaste@freebsd.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sudipm Mukherjee <sudipm.mukherjee@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 0/9] perf/urgent fixes
Date:   Mon, 16 Dec 2019 17:47:29 -0300
Message-Id: <20191216204738.12107-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo/Thomas,

	Please consider pulling,

Best regards,

- Arnaldo


The following changes since commit 761bfc33dd7504de951aa7b9db27a3cc5df1fde6:

  Merge remote-tracking branch 'torvalds/master' into perf/urgent (2019-12-11 09:58:16 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.5-20191216

for you to fetch changes up to 58b3bafff8257c6946df5d6aeb215b8ac839ed2a:

  perf vendor events s390: Remove name from L1D_RO_EXCL_WRITES description (2019-12-16 13:40:26 -0300)

----------------------------------------------------------------
perf/urgent fixes:

perf top:

 Arnaldo Carvalho de Melo:

 - Do not bail out when perf_env__read_cpuid() returns ENOSYS, which
   has been reported happening on aarch64.

perf metricgroup:

  Kajol Jain:

  - Fix printing event names of metric group with multiple events

vendor events:

x86:

  Ravi Bangoria:

  - Fix Kernel_Utilization metric.

s390:

  Ed Maste:

  - Fix counter long description for DTLB1_GPAGE_WRITES and L1D_RO_EXCL_WRITES.

perf header:

  Michael Petlan:

  - Fix false warning when there are no duplicate cache entries

libtraceevent:

  Sudip Mukherjee:

  - Allow custom libdir path

API headers:

  Arnaldo Carvalho de Melo:

  - Sync linux/kvm.h with the kernel sources.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (3):
      tools headers kvm: Sync linux/kvm.h with the kernel sources
      perf arch: Make the default get_cpuid() return compatible error
      perf top: Do not bail out when perf_env__read_cpuid() returns ENOSYS

Ed Maste (2):
      perf vendor events s390: Fix counter long description for DTLB1_GPAGE_WRITES
      perf vendor events s390: Remove name from L1D_RO_EXCL_WRITES description

Kajol Jain (1):
      perf metricgroup: Fix printing event names of metric group with multiple events

Michael Petlan (1):
      perf header: Fix false warning when there are no duplicate cache entries

Ravi Bangoria (1):
      perf/x86/pmu-events: Fix Kernel_Utilization metric

Sudip Mukherjee (1):
      libtraceevent: Allow custom libdir path

 tools/include/uapi/linux/kvm.h                     |  1 +
 tools/lib/traceevent/Makefile                      |  5 +++--
 tools/lib/traceevent/plugins/Makefile              |  5 +++--
 tools/perf/builtin-top.c                           | 10 +++++++---
 .../perf/pmu-events/arch/s390/cf_z13/extended.json |  2 +-
 .../perf/pmu-events/arch/s390/cf_z14/extended.json |  2 +-
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  2 +-
 .../arch/x86/broadwellde/bdwde-metrics.json        |  2 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |  2 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |  2 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  2 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  2 +-
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |  2 +-
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |  2 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |  2 +-
 .../arch/x86/sandybridge/snb-metrics.json          |  2 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  2 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  2 +-
 tools/perf/util/header.c                           | 23 +++++++---------------
 tools/perf/util/metricgroup.c                      |  7 +++++--
 20 files changed, 40 insertions(+), 39 deletions(-)
