Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD38C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCE92075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfDBTrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:47:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:54553 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfDBTrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:47:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 12:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,301,1549958400"; 
   d="scan'208";a="130892957"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga008.jf.intel.com with ESMTP; 02 Apr 2019 12:47:39 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 00/12] perf: Add Icelake support (kernel only, except Topdown)
Date:   Tue,  2 Apr 2019 12:44:57 -0700
Message-Id: <20190402194509.2832-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To make the patch series easier to be reviewed and integrated, it is
condensed into a smaller set of patches, which only include essential
features of Icelake for kernel except new hardware Metrics counters for
Topdown events. The user space patch and Topdown support will be
submitted separately once the patch series is integrated.
(Please let me know if the Topdown/user space patches are still
expected to be included in this series)

The patch series intends to add Icelake support (except Topdown) for
Linux perf.

PATCH 1: Patch to fix wrong PEBS_REGS for large PEBS
PATCH 2-12: Kernel patches to support Icelake.
 - 2-6: Support adaptive PEBS feature
 - 7-8: Enable core support with some new features, e.g. 8 generic
   counters, new event constraints, a new fixed counter.
 - 9-12: Enable cstate, rapl, msr and uncore support on Icelake

Changes since V4:
- Separate the changes. Topdown support and user space patches will be
  submitted separately.
- A patch to fix wrong PEBS_REGS for large PEBS
- Rename has_xmm_regs to pebs_no_xmm_regs
- Rename PEBS_REGS to PEBS_GPRS_REGS
  Add PEBS_XMM_REGS for XMM registers
  Refine the extra check in x86_pmu_hw_config()

Changes since V3:
- Keep the old names for GPRs. Rename PERF_REG_X86_MAX to
  PERF_REG_X86_XMM_MAX
- Remove unnecessary REG_RESERVED
- Add REG_NOSUPPORT for 32bit

Changes since V2:
- Make the setup_pebs_sample_data() a function pointer argument
- Use cpuc->pebs_record_size unconditionally
- Add comments for EVENT_CONSTRAINT_RANGE
- Correct the Author of "perf/x86: Support constraint ranges"

Changes since V1:
- Avoid the interface changes for perf_reg_value() and
  perf_output_sample_regs().
- Remove the extra_regs in struct perf_sample_data.
- Add struct x86_perf_regs
- Add has_xmm_regs to indicate the specific platform which support XMM
  registers collection.
- Add check in x86_pmu_hw_config() to reject invalid config of regs_user
  and regs_intr.
- Rename intel_hsw_weight and intel_hsw_transaction
- Add missed inline for intel_get_tsx_transaction()
- Add new patch to extract code of event update in short period
- Code rebase on top of c634dc6bdede
- Rename @d to pebs_data_cfg
- Make pebs_update_adaptive_cfg readable
- Clear pebs_data_cfg and pebs_record_size for first PEBS in add
- Don't clear ICL_EVENTSEL_ADAPTIVE. Rely on MSR_PEBS_CFG settings
- Change PEBS record parsing order (bug fix)
- Support struct x86_perf_regs
- make get_pebs_status generic
- specific intel_pmu_drain_pebs_icl()
- Use cpuc->pebs_record_size to replace format_size
- Use 'size' to replace 'range_end' for constraint ranges
- Add x86_pmu.has_xmm_regs = true;
- Add more explanation in change log of REMOVE transaction
- Make perf_regs.h consistent between kernel and user space

Andi Kleen (2):
  perf/x86/intel: Extract memory code PEBS parser for reuse
  perf/x86/lbr: Avoid reading the LBRs when adaptive PEBS handles them

Kan Liang (9):
  perf/x86: Fix wrong PEBS_REGS
  perf/x86: Support outputting XMM registers
  perf/x86/intel/ds: Extract code of event update in short period
  perf/x86/intel: Support adaptive PEBSv4
  perf/x86/intel: Add Icelake support
  perf/x86/intel/cstate: Add Icelake support
  perf/x86/intel/rapl: Add Icelake support
  perf/x86/msr: Add Icelake support
  perf/x86/intel/uncore: Add Intel Icelake uncore support

Peter Zijlstra (1):
  perf/x86: Support constraint ranges

 arch/x86/events/core.c                |  15 +
 arch/x86/events/intel/core.c          | 117 +++++-
 arch/x86/events/intel/cstate.c        |   2 +
 arch/x86/events/intel/ds.c            | 501 ++++++++++++++++++++++----
 arch/x86/events/intel/lbr.c           |  35 +-
 arch/x86/events/intel/rapl.c          |   2 +
 arch/x86/events/intel/uncore.c        |   6 +
 arch/x86/events/intel/uncore.h        |   1 +
 arch/x86/events/intel/uncore_snb.c    |  91 +++++
 arch/x86/events/msr.c                 |   1 +
 arch/x86/events/perf_event.h          | 113 ++++--
 arch/x86/include/asm/intel_ds.h       |   2 +-
 arch/x86/include/asm/msr-index.h      |   1 +
 arch/x86/include/asm/perf_event.h     |  49 ++-
 arch/x86/include/uapi/asm/perf_regs.h |  23 +-
 arch/x86/kernel/perf_regs.c           |  27 +-
 16 files changed, 882 insertions(+), 104 deletions(-)

-- 
2.17.1

