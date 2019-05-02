Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E22C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5C12075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEBKub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:50:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:24027 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfEBKua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:50:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 03:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="166965982"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 02 May 2019 03:50:28 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/2] perf, intel: Add support for PEBS output to Intel PT
Date:   Thu,  2 May 2019 13:50:20 +0300
Message-Id: <20190502105022.15534-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

New PEBS feature: output to Intel PT stream instead of the DS area. It's
theoretically useful in virtualized environments, where DS area can't be
used. It's also good for those who are interested in instruction trace for
context of the PEBS events. As PEBS goes, it can provide LBR context with
all the branch-related information that PT doesn't provide at the moment.

PEBS records are packetized in the PT stream, so instead of extracting
them in the PMI, we leave it to the perf tool, because real time PT
decoding is not practical. Tooling patches are not included, but can be
found here [1].

Added is an attribute bit 'aux_source' to mean that an event is a source of
AUX data. This bit enables PEBS output to PT.

[1] http://git.infradead.org/users/ahunter/linux-perf.git

Alexander Shishkin (2):
  perf: Allow normal events to be sources of AUX data
  perf/x86/intel: Support PEBS output to PT

 arch/x86/events/intel/core.c     | 13 +++++++
 arch/x86/events/intel/ds.c       | 59 +++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h     |  9 +++++
 arch/x86/include/asm/msr-index.h |  3 ++
 include/uapi/linux/perf_event.h  |  3 +-
 kernel/events/core.c             |  9 +++++
 6 files changed, 94 insertions(+), 2 deletions(-)

-- 
2.20.1

