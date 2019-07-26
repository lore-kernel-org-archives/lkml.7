Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FAFC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AC320449
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfGZOAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:00:08 -0400
Received: from foss.arm.com ([217.140.110.172]:44942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfGZOAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:00:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42007337;
        Fri, 26 Jul 2019 07:00:06 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5AC803F694;
        Fri, 26 Jul 2019 07:00:04 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        aidapala@qti.qualcomm.com, pajay@qti.qualcomm.com,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        wesleys@xilinx.com, Felix Burton <fburton@xilinx.com>,
        Saeed Nowshadi <saeed.nowshadi@xilinx.com>
Subject: [PATCH 0/5] firmware: arm_scmi: add SCMI v2.0 fastchannels and reset protocol support
Date:   Fri, 26 Jul 2019 14:59:49 +0100
Message-Id: <20190726135954.11078-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI v2.0[1] released recently adds support for:

1. Performance protocol fast channels
2. Reset Management Protocol
among several other features.

This series adds support for the above 2.

The code is based on the cleanup[2] and Rx/async/delayed response series[3]
and is available @[4]

--
Regards,
Sudeep

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0056b/DEN0056B_System_Control_and_Management_Interface_v2_0.pdf
[2] https://lore.kernel.org/lkml/20190726134531.8928-1-sudeep.holla@arm.com
[3] https://lore.kernel.org/lkml/20190726135138.9858-1-sudeep.holla@arm.com/
[4] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git scmi_updates

Sudeep Holla (5):
  firmware: arm_scmi: Add discovery of SCMI v2.0 performance fastchannels
  firmware: arm_scmi: Make use SCMI v2.0 fastchannel for performance protocol
  dt-bindings: arm: Extend SCMI to support new reset protocol
  firmware: arm_scmi: Add RESET protocol in SCMI v2.0
  reset: Add support for resets provided by SCMI

 .../devicetree/bindings/arm/arm,scmi.txt      |  17 ++
 MAINTAINERS                                   |   1 +
 drivers/firmware/arm_scmi/Makefile            |   2 +-
 drivers/firmware/arm_scmi/perf.c              | 257 +++++++++++++++++-
 drivers/firmware/arm_scmi/reset.c             | 231 ++++++++++++++++
 drivers/reset/Kconfig                         |  10 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-scmi.c                    | 133 +++++++++
 include/linux/scmi_protocol.h                 |  26 ++
 9 files changed, 669 insertions(+), 9 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/reset.c
 create mode 100644 drivers/reset/reset-scmi.c

--
2.17.1

