Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7D4C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7A8218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QTcUTuCG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I5e+FVfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfIRJuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:50:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfIRJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:50:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7EDBB61156; Wed, 18 Sep 2019 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568800233;
        bh=xyYzZvDrPlefM2pyPZyZ7gp8uCNw/jVtNKs9TVfQ16k=;
        h=From:To:Cc:Subject:Date:From;
        b=QTcUTuCGNoMNcJyKgtvbKJCvSGcrEyGh30gN0jF3TlLqaYsBNuVqFWxeJH0R3emVe
         eSSYFXbY+EEhIaiQ6pTkti7wfiUayEzWj/I1m8V0OF/zesl6LmhUGwVdOUkbgAVu27
         vhP//cJA5YTM3wApcRd3xjFFI1r72OnG3UeZIk0I=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FA8A61197;
        Wed, 18 Sep 2019 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568800229;
        bh=xyYzZvDrPlefM2pyPZyZ7gp8uCNw/jVtNKs9TVfQ16k=;
        h=From:To:Cc:Subject:Date:From;
        b=I5e+FVfu479ONK5966qeH2Wxs1MVaes4PYmuihMASvMZQFyqIz1RfMkKDiRGWCKCz
         Qr9VLrKGo+5yHPPhG6hcWwmN3qvziBqgPeoapyxax7m0XTWyQUtpLT2atooWKYVoMF
         KBvO7AzMJDygV9axMkAcyb+kmAAngsHqK6E5lf5M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FA8A61197
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>,
        robh+dt@kernel.org
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v3 0/3] Add Global Clock controller (GCC) driver for SC7180
Date:   Wed, 18 Sep 2019 15:20:15 +0530
Message-Id: <20190918095018.17979-1-tdas@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Taniya Das (3):
  clk: qcom: rcg: update the DFS macro for RCG
  dt-bindings: clk: qcom: Add YAML schemas for the GCC clock bindings
  clk: qcom: Add Global Clock controller (GCC) driver for SC7180

 .../devicetree/bindings/clock/qcom,gcc.txt    |   94 -
 .../devicetree/bindings/clock/qcom,gcc.yaml   |  157 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rcg.h                    |    2 +-
 drivers/clk/qcom/gcc-sc7180.c                 | 2515 +++++++++++++++++
 drivers/clk/qcom/gcc-sdm845.c                 |   96 +-
 include/dt-bindings/clock/qcom,gcc-sc7180.h   |  155 +
 8 files changed, 2886 insertions(+), 143 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sc7180.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sc7180.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

