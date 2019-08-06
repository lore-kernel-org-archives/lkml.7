Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2BFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7647120717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbfHFRCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:02:19 -0400
Received: from foss.arm.com ([217.140.110.172]:36984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbfHFRCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:02:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EB75344;
        Tue,  6 Aug 2019 10:02:16 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 571DB3F575;
        Tue,  6 Aug 2019 10:02:14 -0700 (PDT)
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
Subject: [PATCH v2 0/5] firmware: arm_scmi: add SCMI v2.0 fastchannels and reset protocol support
Date:   Tue,  6 Aug 2019 18:02:03 +0100
Message-Id: <20190806170208.6787-1-sudeep.holla@arm.com>
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

v1[5]->v2:
	- Changed the macro SCMI_PERF_FC_RING_DB to use do {} while(0)
	- Renamed RESET_ARM_SCMI to RESET_SCMI and reworded Kconfig text
	- Dropped unused struct device pointer from scmi_reset_data
	- Added to_scmi_handle which helped to remove some repetitive code
	- Fixed some doxygen comments
	- Initialised rcdev.nr_resets
	- Fixed MODULE_DESCRIPTION

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0056b/DEN0056B_System_Control_and_Management_Interface_v2_0.pdf
[2] https://lore.kernel.org/lkml/20190726134531.8928-1-sudeep.holla@arm.com
[3] https://lore.kernel.org/lkml/20190726135138.9858-1-sudeep.holla@arm.com/
[4] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git scmi_updates
[5] https://lore.kernel.org/lkml/20190726135954.11078-1-sudeep.holla@arm.com/

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
 drivers/reset/Kconfig                         |  11 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-scmi.c                    | 126 +++++++++
 include/linux/scmi_protocol.h                 |  26 ++
 9 files changed, 663 insertions(+), 9 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/reset.c
 create mode 100644 drivers/reset/reset-scmi.c

--
2.17.1

