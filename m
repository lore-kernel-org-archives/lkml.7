Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78608C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491E520C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbfB1OA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:00:28 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:54366 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731450AbfB1OA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:00:27 -0500
X-IronPort-AV: E=Sophos;i="5.58,423,1544454000"; 
   d="scan'208";a="8917271"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Feb 2019 23:00:25 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3C321446E12B;
        Thu, 28 Feb 2019 23:00:22 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] i2c: designware: Add support for a bus clock
Date:   Thu, 28 Feb 2019 13:52:08 +0000
Message-Id: <1551361930-24434-1-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Synopsys I2C Controller has an interface clock that some SoCs 
require to access the registers. This series also details the new clock
property in the bindings documentation.

v5:
 - Code comments and commit messages updated to reference "interface clock"
   instead of "peripheral clock".

v4:
 - Code comments and commit messages updated to reference "peripheral 
   clock"
   instead of "bus clock".

v3:
 - busclk renamed to pclk.
 - Added comment with dw_i2c_dev struct definition describing pclk.
 - Added enable rollback of first clock if second fails to enable.
 - Changed clocks and clock-names sections to use term "peripheral clock"
   (pclk) instead of "bus clock" (busclk) in dt-bindings documentation.

v2:
 - Use new devm_clk_get_optional() function as it simplifies handling when
   the optional clock is not present.

Phil Edworthy (2):
  dt: snps,designware-i2c: Add clock bindings documentation
  i2c: designware: Add support for an interface clock

 .../devicetree/bindings/i2c/i2c-designware.txt         |  9 +++++++++
 drivers/i2c/busses/i2c-designware-common.c             | 18 ++++++++++++++++--
 drivers/i2c/busses/i2c-designware-core.h               |  2 ++
 drivers/i2c/busses/i2c-designware-platdrv.c            |  5 +++++
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.7.4

