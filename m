Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6331FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E38B20857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbfB1R6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:58:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:1658 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfB1R6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:58:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 09:58:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="125946636"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by fmsmga007.fm.intel.com with ESMTP; 28 Feb 2019 09:58:46 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        yu.chen.surf@gmail.com, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][RFC v2] Update the cpuinfo.max when power supply changes
Date:   Fri,  1 Mar 2019 02:06:54 +0800
Message-Id: <cover.1551375162.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dell Inc. XPS13 9333, the BIOS changes the value of
MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
the power source changes), the maximum frequency of the
CPU is not updated accordingly. This is due to the policy's
cpuinfo.max is not updated when _PPC notifier fires.

Firstly we should update the cpuinfo.max in this corner case,
secondly we should broadcast the _PPC notifier to all online
CPUs to keep information consistent.

Chen Yu (2):
  ACPI: add "processor.broadcast_ppc" hook to broadcast  _PPC
  ACPI: Update cpuinfo.max after bootup if necessary

 drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
 drivers/cpufreq/cpufreq.c        |  2 ++
 drivers/cpufreq/intel_pstate.c   | 15 +++++++++++++--
 3 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.17.1

