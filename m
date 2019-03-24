Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAA3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3202148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j3n2Wr/0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j3n2Wr/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfCXRuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:50:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfCXRuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:50:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8C1A7602BA; Sun, 24 Mar 2019 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553449820;
        bh=JPVvdr6sYodnuE8/K03cryitCK+rxM8adHKveJWBSTc=;
        h=From:To:Cc:Subject:Date:From;
        b=j3n2Wr/0xVZhKdOSj77NJtUv2oTAWtffCuiuhLuMSSvopMAnRogpKsAuFF8oDxRWM
         w9SLk2ePUTW3ake3n/lkoNvxbT7zfuV2kuElSAoN5UOlpCm2fOY9p7FTQgmIG5UBUm
         CQ0tF3r0vZOhTPjG4Or5QpTxXGLnoHVNMigYBy8w=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EE3D602BA;
        Sun, 24 Mar 2019 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553449820;
        bh=JPVvdr6sYodnuE8/K03cryitCK+rxM8adHKveJWBSTc=;
        h=From:To:Cc:Subject:Date:From;
        b=j3n2Wr/0xVZhKdOSj77NJtUv2oTAWtffCuiuhLuMSSvopMAnRogpKsAuFF8oDxRWM
         w9SLk2ePUTW3ake3n/lkoNvxbT7zfuV2kuElSAoN5UOlpCm2fOY9p7FTQgmIG5UBUm
         CQ0tF3r0vZOhTPjG4Or5QpTxXGLnoHVNMigYBy8w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5EE3D602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 0/9] RPMPD for QCS404 and MSM8998
Date:   Sun, 24 Mar 2019 23:19:58 +0530
Message-Id: <20190324175007.29040-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-worked the macros of the rpmpd driver. Add power domains support
for QCS404 and MSM8998.

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
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  55 ++++++++
 drivers/soc/qcom/rpmpd.c                      | 129 ++++++++++++++----
 include/dt-bindings/power/qcom-rpmpd.h        |  34 +++++
 5 files changed, 248 insertions(+), 23 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

