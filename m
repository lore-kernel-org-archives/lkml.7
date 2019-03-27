Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8443AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515B020700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XxvJXKdz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ESbFnQ/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfC0Miq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:38:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbfC0Mip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:38:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 808D960A44; Wed, 27 Mar 2019 12:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690324;
        bh=sB4GS/0GeE4N3pG0EV3IU5n6Gt8wZoZqm+E/EnSko0k=;
        h=From:To:Cc:Subject:Date:From;
        b=XxvJXKdzAFX0w5CMtMgshYRzMiUXk9ABh83qKOYqRFIIDO6444OvQLiG0Q6HNFyph
         +vsZsUAMYh0a0VS5Yg/0kpUEZ4TsTT9oDdUx/t0sWnHupJlbyZuytEHUELyMCh30im
         WGJFXBXXM2UjBG5oMGWJwCHQnXrmK0VAXU8OOqbs=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16CD660A44;
        Wed, 27 Mar 2019 12:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690323;
        bh=sB4GS/0GeE4N3pG0EV3IU5n6Gt8wZoZqm+E/EnSko0k=;
        h=From:To:Cc:Subject:Date:From;
        b=ESbFnQ/NJ8imcEUhySCboHoJlRUOdgaduRPNd1ON6wHPtkCziBXwB3m+FdG0M1aqN
         v0TZSaByAaa9j1HbYdBHE6d5qwpx7eoKKoqMnzgwFRZM66zBs39qMZlqx0BGEiLDcH
         onjvj6O+Dbpi/WlPu9WFBnznwbhlQY3RiSccYk+Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16CD660A44
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 0/9] RPMPD for QCS404 and MSM8998
Date:   Wed, 27 Mar 2019 18:08:23 +0530
Message-Id: <20190327123832.11566-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-worked the macros of the rpmpd driver. Add power domains support
for QCS404 and MSM8998.

V3:
* always send level updates to vfc and vfl in set_performance state
* fixup commit messages [Rajendra]
* fixup s-o-b ordering

V2:
* Add rpmpd support for msm8998
* fixup corner/vfc with vlfl/vfl

Bjorn Andersson (4):
  soc: qcom: rpmpd: Modify corner defining macros
  dt-bindings: power: Add rpm power domain bindings for qcs404
  soc: qcom: rpmpd: Add QCS404 power-domains
  arm64: dts: qcom: qcs404: Add rpmpd node

Sibi Sankar (5):
  soc: qcom: rpmpd: fixup rpmpd set performance state
  soc: qcom: rpmpd: Add support to set rpmpd state to max
  dt-bindings: power: Add rpm power domain bindings for msm8998
  soc: qcom: rpmpd: Add MSM8998 power-domains
  arm64: dts: qcom: msm8998: Add rpmpd node

 .../devicetree/bindings/power/qcom,rpmpd.txt  |   2 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  51 +++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  55 +++++++
 drivers/soc/qcom/rpmpd.c                      | 135 ++++++++++++++----
 include/dt-bindings/power/qcom-rpmpd.h        |  34 +++++
 5 files changed, 252 insertions(+), 25 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

