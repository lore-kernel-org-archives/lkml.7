Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3331CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB150222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dc0GgBQr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XsfKzgrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442873AbfJRN5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:57:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47456 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405729AbfJRN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:57:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 22FAD60B12; Fri, 18 Oct 2019 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571407051;
        bh=QjLSs+AKfU8qHXU4DHAP/z888hT5C50E4X5pwHuCIEU=;
        h=From:To:Cc:Subject:Date:From;
        b=Dc0GgBQrPE4qqb+E+Asv5AOSSmGTfvi9aD1wGrqpMZThzGMkrvaE3mrzQKgLm/0BX
         /CEI9nLkz6dlw6Tne7i+1ByukRyAtG5eW8/RCq4lgjowOoVR1Y4wBYJKGaHUTsncs4
         LCmPelERJh3cXC6QNy0gHsnJ2hr2L3CSgj36HseE=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C821D60AA8;
        Fri, 18 Oct 2019 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571407050;
        bh=QjLSs+AKfU8qHXU4DHAP/z888hT5C50E4X5pwHuCIEU=;
        h=From:To:Cc:Subject:Date:From;
        b=XsfKzgrDxq1enXNNFWgloMGPW3E4zQjiTrNBbYRzXpn2WLNHrwkhJ8mEZiIpFX7K1
         RcCDFkObZoipHH5sYKGqB6TSMOJP70zh+vhvw28MknMTgO1hUW0UFPn6KOoCef94Ag
         IcuvSYg8bTWNa5suidxTocHhgoqPH4kI9E+g7s2M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C821D60AA8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 0/2] Add LLCC support for SC7180
Date:   Fri, 18 Oct 2019 19:27:07 +0530
Message-Id: <cover.1571406041.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLCC behaviour is controlled by the configuration data set
in the llcc-qcom driver, add the same for SC7180 SoC.
Also add the compatible for SC7180.

The patch is based on linux-next where llcc driver has been
made generic and not sdm845 specific.

Sai Prakash Ranjan (1):
  dt-bindings: msm: Add LLCC for SC7180

Vivek Gautam (1):
  soc: qcom: llcc: Add configuration data for SC7180

 .../devicetree/bindings/arm/msm/qcom,llcc.txt       |  4 +++-
 drivers/soc/qcom/llcc-qcom.c                        | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

