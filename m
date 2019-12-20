Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A588C2D0D1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A9E24685
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfLTDbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:31:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:65387 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfLTDbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:31:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 19:31:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,334,1571727600"; 
   d="scan'208";a="222412899"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 19 Dec 2019 19:31:10 -0800
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        yixin.zhu@linux.intel.com, qi-ming.wu@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 0/2] clk: intel: Add a new driver for a new clock controller IP
Date:   Fri, 20 Dec 2019 11:31:06 +0800
Message-Id: <cover.1576811332.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds clock driver for Clock Generation Unit(CGU) of
Lightning Mountain(LGM) SoC.

Patch 1 adds common clock framework based clock driver for CGU.
Patch 2 adds bindings document & include file for CGU.

These patches are baselined upon Linux 5.5-rc1 at below Git link:
git git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git

v2:
- Move the driver to x86 folder.
- Remove syscon usage.
- Remove regmap based access. Use direct readl()/write() instead. Add spinlocks.
- Change all enum values to capitals.
- Rename all data structures & functions from intel_* to lgm_*.
- Remove multiple header files. Keep only one header file.
- Make probe fail when any of the clk/pll registration fails.
- Fix few bugs with clk_init_data assignement.
- Address review concerns for code quality/style/convention.

v1:
- Initial version.

Rahul Tanwar (1):
  dt-bindings: clk: intel: Add bindings document & header file for CGU

rtanwar (1):
  clk: intel: Add CGU clock driver for a new SoC

 .../devicetree/bindings/clock/intel,cgu-lgm.yaml   |  43 ++
 drivers/clk/Kconfig                                |   8 +
 drivers/clk/x86/Makefile                           |   1 +
 drivers/clk/x86/clk-cgu-pll.c                      | 194 +++++++
 drivers/clk/x86/clk-cgu.c                          | 559 +++++++++++++++++++++
 drivers/clk/x86/clk-cgu.h                          | 296 +++++++++++
 drivers/clk/x86/clk-lgm.c                          | 351 +++++++++++++
 include/dt-bindings/clock/intel,lgm-clk.h          | 150 ++++++
 8 files changed, 1602 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
 create mode 100644 drivers/clk/x86/clk-cgu-pll.c
 create mode 100644 drivers/clk/x86/clk-cgu.c
 create mode 100644 drivers/clk/x86/clk-cgu.h
 create mode 100644 drivers/clk/x86/clk-lgm.c
 create mode 100644 include/dt-bindings/clock/intel,lgm-clk.h

-- 
2.11.0

