Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849E6ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2282064A
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c7nvhrGL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZEsqo6CC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfJNKXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:23:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731119AbfJNKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:23:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1878A602F7; Mon, 14 Oct 2019 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571048600;
        bh=8piCiOB8eIACAjj5PWqPvcKs+w1USlF97iqVUTDHXtc=;
        h=From:To:Cc:Subject:Date:From;
        b=c7nvhrGL3te4WTFWGoD8HqYHsk93AuR6+QlmpMPWXx/0CIEsTaGAPc7gxlpsDu8nL
         0/CXW2r6rhiex+rbSOe2LVNvzvsk83FiggJ12O6P4GlNvNzS1CidENEzCDH2jkTTJ0
         UjqsPkHff6oi+f64E5zSGFBxFU0pdiOmoyb511MI=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5359E602F7;
        Mon, 14 Oct 2019 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571048599;
        bh=8piCiOB8eIACAjj5PWqPvcKs+w1USlF97iqVUTDHXtc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZEsqo6CCBsjptzjwhPCmUPZqQ2gVzxX9Jskjr25zZRraYZf8YE17My3hoIhZqkOCS
         qHcN/Av3Aj5UxyWSmnzDnW/Jo7belI659KCVuax+IJWgfwUWqTFmmVwIBxPmeePncs
         I+gbj41e7wd11VWuLLDvQUn1kkdj3gdzZwDKF1gs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5359E602F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v4 0/5] Add Global Clock controller (GCC) driver for SC7180
Date:   Mon, 14 Oct 2019 15:53:03 +0530
Message-Id: <20191014102308.27441-1-tdas@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v4]
  * convert current documentation to YAML schemas.
  * Update license to use GPL-2.0-only.
  * define nvmem-cells/nvmem-cell-names only for the required compatible.
  * split the dt-bindings for SC7180 to a separate patch.
  * remove registering the CRITICAL clocks to clock provider and leave them
    always ON from the GCC probe.
  * Return NULL from qcom_cc_clk_hw_get where clk hw is not registered.
  * gcc_sc7180_init moved from subsys to core init.

[v3]
  * Remove old documentation and fix comments for binding.
  * Cleanup few CRITICAL clocks and add comments for the CRITICAL clocks.
  * Add reference clocks for UFS & USB.

[v2]
 * Update the DFS macro for RCG to reflect the hw init similar to clock
   name.
 * Update the Documentation binding of GCC to YAML schemas.
 * Add comments for CRITICAL clocks, remove PLL forward declarations and
   unwanted comments/prints.

[v1]
  * Add driver support for Global Clock controller for SC7180 and also
    update device tree bindings for the various clocks supported in the
    clock controller.

Taniya Das (5):
  clk: qcom: rcg: update the DFS macro for RCG
  clk: qcom: common: Return NULL from clk_hw OF provider
  dt-bindings: clock: Add YAML schemas for the QCOM GCC clock bindings
  dt-bindings: clock: Introduce QCOM GCC clock bindings
  clk: qcom: Add Global Clock controller (GCC) driver for SC7180

 .../devicetree/bindings/clock/qcom,gcc.txt    |   94 -
 .../devicetree/bindings/clock/qcom,gcc.yaml   |  188 ++
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rcg.h                    |    2 +-
 drivers/clk/qcom/common.c                     |    2 +-
 drivers/clk/qcom/gcc-sc7180.c                 | 2450 +++++++++++++++++
 drivers/clk/qcom/gcc-sdm845.c                 |   96 +-
 include/dt-bindings/clock/qcom,gcc-sc7180.h   |  155 ++
 9 files changed, 2853 insertions(+), 144 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sc7180.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sc7180.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

