Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0A7FA3736
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C922067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502399AbfJQMfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:35:37 -0400
Received: from [217.140.110.172] ([217.140.110.172]:41462 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbfJQMfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:35:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0131993;
        Thu, 17 Oct 2019 05:35:14 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A84693F718;
        Thu, 17 Oct 2019 05:35:13 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: [PATCH v2 0/5] cpufreq: merge arm big.LITTLE and vexpress-spc drivers
Date:   Thu, 17 Oct 2019 13:35:03 +0100
Message-Id: <20191017123508.26130-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since vexpress-spc is the sole user of arm_big_little cpufreq driver,
there's no point in keeping it separate anymore. I wanted to post these
patches for ages but kept postponing for no reason.

Regards,
Sudeep

v1->v2:
	- generated the patch using -B that helps to keep delta short
	  for review
	- Split the last patch into 3 different patches to deal with
	  removing bL_ops, debug messages and other code formatting
	  separately

Sudeep Holla (5):
  cpufreq: scpi: remove stale/outdated comment about the driver
  cpufreq: merge arm_big_little and vexpress-spc
  cpufreq: vexpress-spc: drop unnessary cpufreq_arm_bL_ops abstraction
  cpufreq: vexpress-spc: remove lots of debug messages
  cpufreq: vexpress-spc: fix some coding style issues

 MAINTAINERS                                   |   5 +-
 drivers/cpufreq/Kconfig.arm                   |  12 +-
 drivers/cpufreq/Makefile                      |   2 -
 drivers/cpufreq/arm_big_little.h              |  43 ---
 drivers/cpufreq/scpi-cpufreq.c                |   2 -
 ...rm_big_little.c => vexpress-spc-cpufreq.c} | 254 ++++++------------
 6 files changed, 93 insertions(+), 225 deletions(-)
 delete mode 100644 drivers/cpufreq/arm_big_little.h
 rename drivers/cpufreq/{arm_big_little.c => vexpress-spc-cpufreq.c} (68%)

--
2.17.1

