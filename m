Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B286BC2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 04:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FCA20828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 04:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hcihvkhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfL0EnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 23:43:07 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:52217 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727040AbfL0EnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 23:43:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577421786; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jjnGo5m0k2+Y839lX1GftsdU7nefXOeX3wW6IIf2kys=; b=hcihvkhdKHXtJMP11HJTNnyfvPuq3IZBTrscXAZsCsnv6joS9Awu5G33ZSdyPsgQdD/AEZUJ
 ro9xmoY/KBCrS+Ac0JOXf0a6iaOkQAFoQqG9H1uUgHDWBgLufBQ+nHovWSgwKlHIDckfW4+b
 r6dcV8Y5xAPJIa+CBExC2KA2UFQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e058bd1.7f4126e0a4c8-smtp-out-n01;
 Fri, 27 Dec 2019 04:42:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BDAF2C4479F; Fri, 27 Dec 2019 04:42:57 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E73E6C433CB;
        Fri, 27 Dec 2019 04:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E73E6C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 0/3] Add modem Clock controller (MSS CC) driver for SC7180
Date:   Fri, 27 Dec 2019 10:12:37 +0530
Message-Id: <1577421760-1174-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v2]
  * Update the license for the documentation and fix minor comments in the
    YAML bindings.

[v1]
  * Add driver support for Modem clock controller for SC7180 and also
    update device tree bindings for the various clocks supported in the
    clock controller.

Taniya Das (3):
  dt-bindings: clock: Add YAML schemas for the QCOM MSS clock bindings
  dt-bindings: clock: Introduce QCOM Modem clock bindings
  clk: qcom: Add modem clock controller driver for SC7180

 .../devicetree/bindings/clock/qcom,mss.yaml        | 41 ++++++++++
 drivers/clk/qcom/Kconfig                           |  9 +++
 drivers/clk/qcom/Makefile                          |  1 +
 drivers/clk/qcom/gcc-sc7180.c                      | 70 ++++++++++++++++
 drivers/clk/qcom/mss-sc7180.c                      | 94 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sc7180.h        |  5 ++
 include/dt-bindings/clock/qcom,mss-sc7180.h        | 12 +++
 7 files changed, 232 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,mss.yaml
 create mode 100644 drivers/clk/qcom/mss-sc7180.c
 create mode 100644 include/dt-bindings/clock/qcom,mss-sc7180.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
