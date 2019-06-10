Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57288C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3061B20859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbfFJH3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:29:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:14541 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387920AbfFJH3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:29:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 00:29:19 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2019 00:29:17 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] perf intel-pt: Prepare for PEBS via PT
Date:   Mon, 10 Jun 2019 10:27:52 +0300
Message-Id: <20190610072803.10456-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

PEBS via PT is a new feature that encodes PEBS events into the Intel PT trace.
This patch series is preparation.  Alex has posted his kernel support:

    https://lkml.org/lkml/2019/5/2/323

This patch set adds the packet definitions and a new packet decoder test,
followed by patches that enable synthesizing PEBS samples.

 
Adrian Hunter (11):
      perf intel-pt: Add new packets for PEBS via PT
      perf intel-pt: Add Intel PT packet decoder test
      perf intel-pt: Add decoder support for PEBS via PT
      perf intel-pt: Prepare to synthesize PEBS samples
      perf intel-pt: Factor out common sample preparation for re-use
      perf intel-pt: Synthesize PEBS sample basic information
      perf intel-pt: Add gp registers to synthesized PEBS sample
      perf intel-pt: Add xmm registers to synthesized PEBS sample
      perf intel-pt: Add lbr information to synthesized PEBS sample
      perf intel-pt: Add memory information to synthesized PEBS sample
      perf intel-pt: Add callchain to synthesized PEBS sample

 tools/perf/arch/x86/include/arch-tests.h           |   1 +
 tools/perf/arch/x86/tests/Build                    |   2 +-
 tools/perf/arch/x86/tests/arch-tests.c             |   4 +
 .../arch/x86/tests/intel-pt-pkt-decoder-test.c     | 304 +++++++++++++++++++++
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 114 +++++++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  | 137 ++++++++++
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   | 140 +++++++++-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |  21 +-
 tools/perf/util/intel-pt.c                         | 296 +++++++++++++++++++-
 9 files changed, 1002 insertions(+), 17 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c


Regards
Adrian

