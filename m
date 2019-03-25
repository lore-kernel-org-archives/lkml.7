Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1695CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F6620830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfCYQEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:04:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:30362 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729010AbfCYQEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:04:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 09:04:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="145078748"
Received: from spandruv-mobl.jf.intel.com ([10.24.11.149])
  by orsmga002.jf.intel.com with ESMTP; 25 Mar 2019 09:04:40 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pprakash@codeaurora.org,
        wangxiongfeng2@huawei.com, srinivas.pandruvada@linux.intel.com
Subject: [PATCH v2 0/2] Correct the processing for base_frequency
Date:   Mon, 25 Mar 2019 09:04:38 -0700
Message-Id: <20190325160440.7575-1-srinivas.pandruvada@linux.intel.com>
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

v2:
Changes done as suggested by Rafael.


Srinivas Pandruvada (2):
  ACPI / CPPC: Fix processing for guaranteed performance
  cpufreq: intel_pstate: Also use cppc nominal_perf for base_frequency

 drivers/acpi/cppc_acpi.c       | 9 +++++++--
 drivers/cpufreq/intel_pstate.c | 5 ++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.17.2

