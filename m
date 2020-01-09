Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15B2C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BB620673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XENCkjTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgAIJTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:19:21 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:37932 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729035AbgAIJTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:19:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578561560; h=Message-Id: Date: Subject: To: From: Sender;
 bh=Hu9qqYaZoI6+5+2Lw05UTvgV7v1yjGAb7GeM8gI205E=; b=XENCkjTvtQPoK8FUIjGx4i5/kdHg/ITZtQjR+zRfihs3wRECOl5tGxZ96rYWT8A3Fg2zkPEJ
 SyHNd8Y4G6bLxA2ovLV+6asLAjiatsg/0CrDe3j1bCi5/ndhcL+b1ol3g7FgBSQ7eLgriii0
 LbYDV9oUy6ARP7wDQOT5cdQt6ck=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e16f015.7f39f238d810-smtp-out-n03;
 Thu, 09 Jan 2020 09:19:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA9EDC433CB; Thu,  9 Jan 2020 09:19:15 +0000 (UTC)
Received: from srichara1-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F032C43383;
        Thu,  9 Jan 2020 09:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F032C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     agross@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, sivaprak@codeaurora.org,
        sricharan@codeaurora.org
Subject: [PATCH V4 0/5] Add minimal boot support for IPQ6018
Date:   Thu,  9 Jan 2020 14:48:58 +0530
Message-Id: <1578561543-23132-1-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQ6018 is Qualcomm\u2019s 802.11ax SoC for Routers,
Gateways and Access Points.

This series adds minimal board boot support for ipq6018-cp01 board.

[v4]
 * Addressed review comments in pinctrl bindings from Rob.
 * Ran make dt_binding_check and no issues was reported.
 * Deleted absahu email id from patch 4, since its bouncing now.
 * Patch 4 arm64: dts: Add ipq6018 SoC and CP01 board support has build
   dependency with,
	https://lkml.org/lkml/2020/1/9/84

[V3]
 * Removed clock driver and bindings from this patch series, and added them
   as a different series.
 * Removed qpic_padN from pinctrl driver.
 * Addressed review comments in dts, and added the remaining fixed clocks their
 * Fixed review comments in pinctrl bindings
 * Patch 4 arm64: dts: Add ipq6018 SoC and CP01 board support has build
   dependency with,
	https://patchwork.ozlabs.org/patch/1217293/

[v2]
 * Splitted dt bindings  and driver into different patches. Added missing bindings
   and some style changes.
 * Added ipq6018 schema
 * Addressed review comments for gcc clock bindings.
 * Removed all clk critical flags, removed 1/1 factor clocks, moved to new
   way of specifying clk parents, and addressed other review comments.
 * Sorted nodes based on address, name, label. Removed unused clock nodes,
   Addressed other review comments.

Sricharan R (5):
  dt-bindings: pinctrl: qcom: Add ipq6018 pinctrl bindings
  pinctrl: qcom: Add ipq6018 pinctrl driver
  dt-bindings: qcom: Add ipq6018 bindings
  arm64: dts: Add ipq6018 SoC and CP01 board support
  arm64: defconfig: Enable qcom ipq6018 clock and pinctrl

 Documentation/devicetree/bindings/arm/qcom.yaml    |    8 +
 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     |  174 +++
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts       |   30 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  263 +++++
 arch/arm64/configs/defconfig                       |    3 +
 drivers/pinctrl/qcom/Kconfig                       |   10 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq6018.c             | 1107 ++++++++++++++++++++
 9 files changed, 1597 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq6018.dtsi
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq6018.c

-- 
1.9.1
