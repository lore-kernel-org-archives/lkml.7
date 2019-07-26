Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA62C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FA122CE5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfGZNvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:51:50 -0400
Received: from foss.arm.com ([217.140.110.172]:44412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbfGZNvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:51:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F353A337;
        Fri, 26 Jul 2019 06:51:46 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B9A383F694;
        Fri, 26 Jul 2019 06:51:45 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2 00/10] firmware: arm_scmi: Add support for Rx channels, async commands and delayed response
Date:   Fri, 26 Jul 2019 14:51:28 +0100
Message-Id: <20190726135138.9858-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds SCMI infrastructure/core support for recieve(Rx)
channels, asynchronous commands and delayed response. It adds async
command support for clock rate setting and sensor reading based on the
attributes read from the firmware.

The code is rebased on the cleanup series[1] and is available @[2]

--
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/20190726134531.8928-1-sudeep.holla@arm.com
[2] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git scmi_updates

v1->v2:
	- Fixed error messages to indicate Tx/Rx correctly
	- Dropped receive buffer support as notifications are not yet added
	- Simplied atomic_inc/dec for async request count and fixed the
	  commit message
	- Fixed fetching sensor value i.e. *pval + 1 to *(pval + 1) in
	  scmi_sensor_reading_get

Sudeep Holla (10):
  firmware: arm_scmi: Reorder some functions to avoid forward declarations
  firmware: arm_scmi: Segregate tx channel handling and prepare to add rx
  firmware: arm_scmi: Add receive channel support for notifications
  firmware: arm_scmi: Separate out tx buffer handling and prepare to add rx
  firmware: arm_scmi: Add mechanism to unpack message headers
  firmware: arm_scmi: Add support for asynchronous commands and delayed response
  firmware: arm_scmi: Drop async flag in sensor_ops->reading_get
  firmware: arm_scmi: Add asynchronous sensor read if it supports
  firmware: arm_scmi: Drop config flag in clk_ops->rate_set
  firmware: arm_scmi: Use asynchronous CLOCK_RATE_SET when possible

 drivers/clk/clk-scmi.c              |   2 +-
 drivers/firmware/arm_scmi/clock.c   |  21 +-
 drivers/firmware/arm_scmi/common.h  |   6 +-
 drivers/firmware/arm_scmi/driver.c  | 342 ++++++++++++++++++----------
 drivers/firmware/arm_scmi/sensors.c |  32 ++-
 drivers/hwmon/scmi-hwmon.c          |   2 +-
 include/linux/scmi_protocol.h       |   6 +-
 7 files changed, 271 insertions(+), 140 deletions(-)

--
2.17.1

