Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDCFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF042075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfCVWpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:45:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:15693 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbfCVWp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:45:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 15:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="309622827"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.53.177])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2019 15:45:25 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pprakash@codeaurora.org,
        wangxiongfeng2@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] Correct the processing for base_frequency
Date:   Fri, 22 Mar 2019 15:45:18 -0700
Message-Id: <20190322224520.6740-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The base_frequency display in cpufreq sysfs for intel_pstate gets the
guaranteed ratio by reading CPPC guaranteed performance register as a
first preference before falling back to x86 MSR for Hardware P-state
Capabilities. The current code in cppc_acpi.c assumed that "guaranteed
performance register" can be an integer field, which is invalid as per
ACPI spec. So this change explicitly check for INTEGER values for
invalid BIOS/firmware and ignore. 
Also guaranteed performance register field is optional and when not
present, nominal performance can be used as the guaranteed performance.
But spec calls that this is true only in non-autonomous mode. So
no change is made in cppc_acpi.c to make nominal as guaranteed in this
case to avoid dependency on autonomous and non-autonomous mode. Instead
a change is added to intel_pstate driver, which is specific to x86 to
make nominal as guaranteed when guaranteed performance field is absent
or has invalid value.
Also we are working to clarify this non-autonomous mode requirement
through ACPI standard body. 

Srinivas Pandruvada (2):
  ACPI / CPPC: Fix processing for guaranteed performance
  cpufreq: intel_pstate: Also use cppc nominal_perf for base_frequency

 drivers/acpi/cppc_acpi.c       | 10 ++++++++--
 drivers/cpufreq/intel_pstate.c |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.17.2

