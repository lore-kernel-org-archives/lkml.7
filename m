Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222DFC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE782073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GTWXCCOn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cWprBifP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfKOKEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:04:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33840 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfKOKEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:04:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3635B61187; Fri, 15 Nov 2019 10:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573812259;
        bh=VaQ+M/cW4KikmTdqZ7Lp5Io5EF9nqMDanu2nvq5JxhM=;
        h=From:To:Cc:Subject:Date:From;
        b=GTWXCCOnq5XtWiQ4ZxV8/n7it/OX0dwNRMOAruCpQMTeg7kBmOwQa+n3ZiVsxJUpJ
         WT5D9/tbk2qk+zi7j+Sv3pXrsQm52NfNTB+cA9vwgPZ5rGETJnKMstV3I/OGIn+A/B
         2nnIuw/CPTwpCVrWq8JHQKml9W7CDAe/1QUghQvs=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54E82610DC;
        Fri, 15 Nov 2019 10:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573812256;
        bh=VaQ+M/cW4KikmTdqZ7Lp5Io5EF9nqMDanu2nvq5JxhM=;
        h=From:To:Cc:Subject:Date:From;
        b=cWprBifPUUATJDsFJkKauI4x/6I7C8D7Qt4zTLmcTAQafcqAJUT2NHKemjD/WHTFL
         JIjERMPvZTfXtabobfS4Bg1vQ0460zcF6vQBBh9KH0WFTmjUsKt442VVvHPyrhgbKE
         6a2DoZ5moYVN//CbLTs9YU3VoLho6zHACVPeNJ1A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54E82610DC
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
Subject: [PATCH v1 0/3] Add display clock controller driver for SC7180
Date:   Fri, 15 Nov 2019 15:34:02 +0530
Message-Id: <1573812245-23827-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the display clock controller found on SC7180
based devices. This would allow display drivers to probe and
control their clocks.

This driver depends on the display port clock ops support
https://patchwork.kernel.org/patch/11069087/

Taniya Das (3):
  dt-bindings: clock: Add YAML schemas for the QCOM DISPCC clock
    bindings
  dt-bindings: clock: Introduce QCOM Display clock bindings
  clk: qcom: Add display clock controller driver for SC7180

 .../devicetree/bindings/clock/qcom,dispcc.txt      |  19 -
 .../devicetree/bindings/clock/qcom,dispcc.yaml     |  67 ++
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/dispcc-sc7180.c                   | 776 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,dispcc-sc7180.h     |  46 ++
 6 files changed, 899 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
 create mode 100644 drivers/clk/qcom/dispcc-sc7180.c
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sc7180.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

