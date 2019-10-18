Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847FECA9EA4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1CE222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OhEGjNNA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QZ/4Si57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633259AbfJRKJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:09:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407945AbfJRKJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:09:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7856160DCF; Fri, 18 Oct 2019 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571393377;
        bh=GnyW+zZ5E9Qp6Unvs/fu9z+p34r4HvU9EpUGbP/UdtY=;
        h=From:To:Cc:Subject:Date:From;
        b=OhEGjNNA8KUNTP77pBgZROYPIHrD+HrzE1DdLr4J/aFRzB3TDaOKjPMGwAtugY3Xd
         +oUuNK1lhuj1cdb/7rxhFGyx0VpsLi75EVhfaQnsElHroGQ0r3bpOEi/XHE6is56Py
         PW0oSJJqpmjUKIdNuV/uqHnE5VaFBWlT52xRZ8Ro=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9679860AD1;
        Fri, 18 Oct 2019 10:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571393376;
        bh=GnyW+zZ5E9Qp6Unvs/fu9z+p34r4HvU9EpUGbP/UdtY=;
        h=From:To:Cc:Subject:Date:From;
        b=QZ/4Si57vvVV2Y9EKddzQeHoS3sFeoYUMM5rsYfi2GV0QXyZ20V3BKG7pb+2cpKYu
         5jZJbfF4H7gB5nIDx8aZfa5G1rjr8AIaQmSQIqJ+Jo1aZvITV+8vuwfMm69dYUZlwY
         BcjIBs+8MYANUfZW9oqyl1l4di99zgHCQ14ssQC8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9679860AD1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1 0/3] Add support for RPMHCC for SC7180
Date:   Fri, 18 Oct 2019 15:39:21 +0530
Message-Id: <1571393364-32697-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Documentation binding of RPMHCC to YAML schemas.
Add RPMH clocks required to be supported on SC7180.

Taniya Das (3):
  dt-bindings: clock: Add YAML schemas for the QCOM RPMHCC clock
    bindings
  dt-bindings: clock: Introduce RPMHCC bindings for SC7180
  clk: qcom: clk-rpmh: Add support for RPMHCC for SC7180

 .../devicetree/bindings/clock/qcom,rpmh-clk.txt    | 27 ------------
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     | 50 ++++++++++++++++++++
 drivers/clk/qcom/clk-rpmh.c                        | 19 ++++++++
 3 files changed, 69 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

