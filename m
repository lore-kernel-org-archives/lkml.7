Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1560C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869F820836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfLJOzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:55:02 -0500
Received: from foss.arm.com ([217.140.110.172]:47102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbfLJOyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:54:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D02F2113E;
        Tue, 10 Dec 2019 06:54:04 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B6B13F67D;
        Tue, 10 Dec 2019 06:54:04 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 00/15] firmware: arm_scmi: Add support for multiple device per protocol
Date:   Tue, 10 Dec 2019 14:53:30 +0000
Message-Id: <20191210145345.11616-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only one scmi device is created for each protocol enumerated.
However, there is requirement to make use of some procotols by multiple
kernel subsystems/frameworks. One such example is SCMI PERFORMANCE
protocol which can be used by both cpufreq and devfreq drivers.
Similarly, SENSOR protocol may be used by hwmon and iio subsystems,
and POWER protocol may be used by genpd and regulator drivers.

This series adds support for multiple device per protocol using scmi device
name if one is available. It also updates existing drivers to add
scmi device names to driver id tables.

Regards,
Sudeep

Sudeep Holla (15):
  firmware: arm_scmi: Add support for multiple device per protocol
  firmware: arm_scmi: Skip scmi mbox channel setup for addtional devices
  firmware: arm_scmi: Skip protocol initialisation for additional devices
  firmware: arm_scmi: Add names to scmi devices created
  firmware: arm_scmi: Add versions and identifier attributes using dev_groups
  firmware: arm_scmi: Update scmi_prot_init_fn_t to use device instead of handle
  firmware: arm_scmi: Stash version in protocol init functions
  firmware: arm_scmi: Add and initialise protocol version to scmi_device structure
  firmware: arm_scmi: Add scmi protocol version and id device attributes
  firmware: arm_scmi: Drop logging individual scmi protocol version
  firmware: arm_scmi: Match scmi device by both name and protocol id
  clk: scmi: Match scmi device by both name and protocol id
  cpufreq: scmi: Match scmi device by both name and protocol id
  hwmon: (scmi-hwmon) Match scmi device by both name and protocol id
  reset: reset-scmi: Match scmi device by both name and protocol id

 drivers/clk/clk-scmi.c                     |  2 +-
 drivers/cpufreq/scmi-cpufreq.c             |  2 +-
 drivers/firmware/arm_scmi/bus.c            | 53 +++++++++++--
 drivers/firmware/arm_scmi/clock.c          | 15 +++-
 drivers/firmware/arm_scmi/driver.c         | 92 +++++++++++++++++++++-
 drivers/firmware/arm_scmi/perf.c           | 15 +++-
 drivers/firmware/arm_scmi/power.c          | 15 +++-
 drivers/firmware/arm_scmi/reset.c          | 15 +++-
 drivers/firmware/arm_scmi/scmi_pm_domain.c |  2 +-
 drivers/firmware/arm_scmi/sensors.c        | 15 +++-
 drivers/hwmon/scmi-hwmon.c                 |  2 +-
 drivers/reset/reset-scmi.c                 |  2 +-
 include/linux/scmi_protocol.h              |  8 +-
 13 files changed, 202 insertions(+), 36 deletions(-)

--
2.17.1

