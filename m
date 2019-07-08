Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF407C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B4A20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391267AbfGHPrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:47:43 -0400
Received: from foss.arm.com ([217.140.110.172]:52312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733310AbfGHPrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:47:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5864F360;
        Mon,  8 Jul 2019 08:47:41 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5442B3F59C;
        Mon,  8 Jul 2019 08:47:40 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: [PATCH 00/11] firmware: arm_scmi: Add support for Rx, async commands and delayed response
Date:   Mon,  8 Jul 2019 16:47:19 +0100
Message-Id: <20190708154730.16643-1-sudeep.holla@arm.com>
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

[1] https://lore.kernel.org/lkml/20190708154358.16227-1-sudeep.holla@arm.com
[2] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git scmi_updates

Sudeep Holla (11):
  firmware: arm_scmi: Reorder some functions to avoid forward declarations
  firmware: arm_scmi: Segregate tx channel handling and prepare to add rx
  firmware: arm_scmi: Add receive channel support for notifications
  firmware: arm_scmi: Separate out tx buffer handling and prepare to add rx
  firmware: arm_scmi: Add receive buffer support for notifications
  firmware: arm_scmi: Add mechanism to unpack message headers
  firmware: arm_scmi: Add support for asynchronous commands and delayed response
  firmware: arm_scmi: Drop async flag in sensor_ops->reading_get
  firmware: arm_scmi: Add asynchronous sensor read if it supports
  firmware: arm_scmi: Drop config flag in clk_ops->rate_set
  firmware: arm_scmi: Use asynchronous CLOCK_RATE_SET when possible

 drivers/clk/clk-scmi.c              |   2 +-
 drivers/firmware/arm_scmi/clock.c   |  23 +-
 drivers/firmware/arm_scmi/common.h  |   6 +-
 drivers/firmware/arm_scmi/driver.c  | 346 ++++++++++++++++++----------
 drivers/firmware/arm_scmi/sensors.c |  32 ++-
 drivers/hwmon/scmi-hwmon.c          |   2 +-
 include/linux/scmi_protocol.h       |   6 +-
 7 files changed, 280 insertions(+), 137 deletions(-)

-- 
2.17.1

