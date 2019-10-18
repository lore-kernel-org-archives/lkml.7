Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBDCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5653F21D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ljMSkMrF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="boUxtxkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633189AbfJRKMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:12:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404942AbfJRKMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:12:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A06A60AD1; Fri, 18 Oct 2019 10:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571393558;
        bh=p7lbLlSPaQAFwawg879bpgayWgRgmzrYII43r1DU4yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljMSkMrFEgFHEcPhcjGJ8kQwEKaNhV5WocO0k/0NCy4kfZMpEvTug6i/umC4eeEsw
         jqF4uMuWYA5nEy0tDl/hrCVgBSf5L+7tdbnHCjuzThJYv7V1qQFLl+qICJsokveHV0
         YNf99bkh/qnBAAV+QK1sOc7SNEJDP9U1Eb1wp3J0=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1357560930;
        Fri, 18 Oct 2019 10:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571393557;
        bh=p7lbLlSPaQAFwawg879bpgayWgRgmzrYII43r1DU4yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=boUxtxkTBODnIwlrxgGAMRIBJ1cN92DTRur4zvDC9ozZNJ8V9zeUuBjFqpg7Yf1Z1
         0ScSF2H06TY7u7etl7c9l10zd1JpG18O6TSfd8tmti2gBJh9ogKXtVGPkswUwNKerF
         fwUGdAmkushBo1fbQU8c7Brg1PUxzaT8tqw985Ns=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1357560930
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
Subject: [PATCH v1 2/3] dt-bindings: clock: Introduce RPMHCC bindings for SC7180
Date:   Fri, 18 Oct 2019 15:39:23 +0530
Message-Id: <1571393364-32697-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571393364-32697-1-git-send-email-tdas@codeaurora.org>
References: <1571393364-32697-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for SC7180 RPMHCC.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index 326bfd7..e325c6e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
        - qcom,sdm845-rpmh-clk
        - qcom,sm8150-rpmh-clk
+       - qcom,sc7180-rpmh-clk

   clocks:
     maxItems: 1
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

