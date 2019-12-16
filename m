Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EDAC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFAB24682
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfLPWQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:16:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:54719 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfLPWP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:15:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 14:15:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="212362075"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 16 Dec 2019 14:15:22 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v9 00/13] selftests/resctrl: Add resctrl selftest
Date:   Mon, 16 Dec 2019 14:26:34 -0800
Message-Id: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With more and more resctrl features are being added by Intel, AMD
and ARM, a test tool is becoming more and more useful to validate
that both hardware and software functionalities work as expected.

We introduce resctrl selftest to cover resctrl features on X86, AMD
and ARM architectures. It first implements MBM (Memory Bandwidth
Monitoring), MBA (Memory Bandwidth Allocation), L3 CAT (Cache Allocation
Technology), and CQM (Cache QoS Monitoring)  tests. We will enhance
the selftest tool to include more functionality tests in the future.

The tool has been tested on Intel RDT, AMD QoS and ARM MPAM and is
in tools/testing/selftests/resctrl in order to have generic test code
base for all architectures.

The selftest tool we are introducing here provides a convenient
tool which does automatic resctrl testing, is easily available in kernel
tree, and covers Intel RDT, AMD QoS and ARM MPAM.

There is an existing resctrl test suite 'intel_cmt_cat'. But its major
purpose is to test Intel RDT hardware via writing and reading MSR
registers. It does access resctrl file system; but the functionalities
are very limited. And it doesn't support automatic test and a lot of
manual verifications are involved.

Changelog:
v9:
- Per Boris suggestion, add Co-developed-by in each patch to make it
  clear who contributed to the patch set.

v8:
Update code per comments from Andre Przywara from ARM:
- Change Makefile and remove inline assembly code to build and test the
  tool on ARM
- Change the output to TAP format because the format is both readable by
  human and other test tools.
- Detect resctrl feature from /proc/cpuinfo instead of dmesg to support
  generic detection on all architectures.
- Fix a few coding issues.

v7:
- Fix a few warnings when compiling patches separately, pointed by Babu 

v6:
- Fix a benchmark reading optimized out issue in newer GCC.
- Fix a few coding style issues.
- Re-arrange code among patches to make cleaner code. No change in patches
structure.

v5:
- Based the v4 patches submitted by Fenghua Yu and added changes to support
  AMD.
- Changed the function name get_sock_num to get_resource_id. Intel uses
  socket number for schemata and AMD uses l3 index id. To generalize,
  changed the function name to get_resource_id.
- Added the code to detect vendor.
- Disabled the few tests for AMD where the test results are not clear.
  Also AMD does not have IMC.
- Fixed few compile issues.
- Some cleanup to make each patch independent.
- Tested the patches on AMD system. Fenghua, Need your help to test on
  Intel box. Please feel free to change and resubmit if something
   broken.

v4:
- address comments from Balu and Randy
- Add CAT and CQM tests

v3:
- Change code based on comments from Babu Moger
- Remove some unnessary code and use pipe to communicate b/w processes

v2:
- Change code based on comments from Babu Moger
- Clean up other places.

Babu Moger (3):
  selftests/resctrl: Add vendor detection mechanism
  selftests/resctrl: Use cache index3 id for AMD schemata masks
  selftests/resctrl: Disable MBA and MBM tests for AMD

Fenghua Yu (6):
  selftests/resctrl: Add README for resctrl tests
  selftests/resctrl: Add MBM test
  selftests/resctrl: Add MBA test
  selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest
  selftests/resctrl: Add Cache Allocation Technology (CAT) selftest
  selftests/resctrl: Add the test in MAINTAINERS

Sai Praneeth Prakhya (4):
  selftests/resctrl: Add basic resctrl file system operations and data
  selftests/resctrl: Read memory bandwidth from perf IMC counter and
    from resctrl file system
  selftests/resctrl: Add callback to start a benchmark
  selftests/resctrl: Add built in benchmark

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/resctrl/Makefile      |  17 +
 tools/testing/selftests/resctrl/README        |  53 ++
 tools/testing/selftests/resctrl/cache.c       | 272 +++++++
 tools/testing/selftests/resctrl/cat_test.c    | 250 ++++++
 tools/testing/selftests/resctrl/cqm_test.c    | 176 +++++
 tools/testing/selftests/resctrl/fill_buf.c    | 213 +++++
 tools/testing/selftests/resctrl/mba_test.c    | 171 ++++
 tools/testing/selftests/resctrl/mbm_test.c    | 145 ++++
 tools/testing/selftests/resctrl/resctrl.h     | 107 +++
 .../testing/selftests/resctrl/resctrl_tests.c | 202 +++++
 tools/testing/selftests/resctrl/resctrl_val.c | 744 ++++++++++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 722 +++++++++++++++++
 13 files changed, 3073 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/Makefile
 create mode 100644 tools/testing/selftests/resctrl/README
 create mode 100644 tools/testing/selftests/resctrl/cache.c
 create mode 100644 tools/testing/selftests/resctrl/cat_test.c
 create mode 100644 tools/testing/selftests/resctrl/cqm_test.c
 create mode 100644 tools/testing/selftests/resctrl/fill_buf.c
 create mode 100644 tools/testing/selftests/resctrl/mba_test.c
 create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl.h
 create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl_val.c
 create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c

-- 
2.19.1

