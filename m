Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05AFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAD5215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfJDIcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:32:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:57519 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730501AbfJDIcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:32:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 01:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,255,1566889200"; 
   d="scan'208";a="204236420"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.66])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2019 01:32:41 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] perf record: Put a copy of kcore into the perf.data directory
Date:   Fri,  4 Oct 2019 11:31:16 +0300
Message-Id: <20191004083121.12182-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are patches to add a new 'perf record' option '--kcore' which will put
a copy of /proc/kcore, kallsyms and modules into a perf.data directory.
Note, that without the --kcore option, output goes to a file as previously.
The tools' -o and -i options work with either a file name or directory
name.

Example:

 $ sudo perf record --kcore uname

 $ sudo tree perf.data
 perf.data
 ├── kcore_dir
 │   ├── kallsyms
 │   ├── kcore
 │   └── modules
 └── data

 $ sudo perf script -v
 build id event received for vmlinux: 1eaa285996affce2d74d8e66dcea09a80c9941de
 build id event received for [vdso]: 8bbaf5dc62a9b644b4d4e4539737e104e4a84541
 Samples for 'cycles' event do not have CPU attribute set. Skipping 'cpu' field.
 Using CPUID GenuineIntel-6-8E-A
 Using perf.data/kcore_dir/kcore for kernel data
 Using perf.data/kcore_dir/kallsyms for symbols
             perf 19058 506778.423729:          1 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
             perf 19058 506778.423733:          1 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
             perf 19058 506778.423734:          7 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
             perf 19058 506778.423736:        117 cycles:  ffffffffa2caa54a native_write_msr+0xa (vmlinux)
             perf 19058 506778.423738:       2092 cycles:  ffffffffa2c9b7b0 native_apic_msr_write+0x0 (vmlinux)
             perf 19058 506778.423740:      37380 cycles:  ffffffffa2f121d0 perf_event_addr_filters_exec+0x0 (vmlinux)
            uname 19058 506778.423751:     582673 cycles:  ffffffffa303a407 propagate_protected_usage+0x147 (vmlinux)
            uname 19058 506778.423892:    2241841 cycles:  ffffffffa2cae0c9 unwind_next_frame.part.5+0x79 (vmlinux)
            uname 19058 506778.424430:    2457397 cycles:  ffffffffa3019232 check_memory_region+0x52 (vmlinux)


Adrian Hunter (5):
      perf data: Correctly identify directory data files
      perf data: Move perf_dir_version into data.h
      perf data: Rename directory "header" file to "data"
      perf tools: Support single perf.data file directory
      perf record: Put a copy of kcore into the perf.data directory

 tools/perf/Documentation/perf-record.txt           |  3 ++
 .../Documentation/perf.data-directory-format.txt   | 63 ++++++++++++++++++++++
 tools/perf/builtin-record.c                        | 54 ++++++++++++++++++-
 tools/perf/util/data.c                             | 46 ++++++++++++++--
 tools/perf/util/data.h                             | 12 +++++
 tools/perf/util/header.h                           |  4 --
 tools/perf/util/record.h                           |  1 +
 tools/perf/util/session.c                          |  4 ++
 tools/perf/util/util.c                             | 19 ++++++-
 9 files changed, 197 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/Documentation/perf.data-directory-format.txt


Regards
Adrian
