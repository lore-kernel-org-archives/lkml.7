Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427E0C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B3C24652
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EYD9xJTC";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="WxAIW5/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfLEJw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:52:59 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:60124
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbfLEJw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575539577;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=CO0cVItG7+3d1ni5t/elfx3WOfPpM1c5YYqLbJ16tG0=;
        b=EYD9xJTC06/x58IwDfcMbilMSII7LE0tGNL4+siE1ZconNxhWPNI3ZePYf/ndDVI
        bubwCST1hHSv/myYUO1Ys8ZMYDUKKIsKuAvVMrpOJmlTkifaXvrjWZAi9n5wY6j3dH5
        SDU2m3sEe0eDsRktOJ1e74BtRc/GPuUlreEWKi0s=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575539577;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=CO0cVItG7+3d1ni5t/elfx3WOfPpM1c5YYqLbJ16tG0=;
        b=WxAIW5/zbEtyE1dUXeTGRFOU/kOkgOWCHu8wTSFCoaSsWVf8Y16mh49Jm9Z7wEuL
        8rYjq7rlrowxM6PNrltfpYC57TD+a5MU+CBMPJhIUlP/j13sYkaWjH5MIycW2eC4YoR
        c9T74gTkJGKc7rOkSuU/DSL6Ve7ECBaqurjFG12U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BA2AC447AE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, tsoni@codeaurora.org,
        psodagud@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 0/2] Add EDAC support for Kryo CPU core caches
Date:   Thu, 5 Dec 2019 09:52:57 +0000
Message-ID: <0101016ed57a1246-ffd8974e-2d90-4333-939f-6e0d1aeb158c-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.12.05-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements EDAC support for error reporting on
Kryo{3,4}XX CPU caches L1,L2, L3-SCU. All the cores(big.LITTLE)
in Kryo{3,4}XX CPUs implement RAS extensions and use interrupt
based ECC mechanism to report errors.

This series has been tested on SC7180, SDM845, SM8150 SoCs with
Kryo{3,4}XX CPU cores based on ARM Cortex-A55, Cortex-A75 and
Cortex-A76.

This implementation is platform specific in contrast to the
patch posted last time for generic error reporting on arm cortex
implementations with RAS extensions by Kyle Yan.
 - https://patchwork.kernel.org/patch/10161955/

Downstream implementation of this can be found at:
 - https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/edac/kryo_arm64_edac.c?h=msm-4.14

Sai Prakash Ranjan (2):
  dt-bindings: edac: Add DT bindings for Kryo EDAC
  drivers: edac: Add EDAC support for Kryo CPU caches

 .../bindings/edac/qcom-kryo-edac.yaml         |  67 ++
 MAINTAINERS                                   |   7 +
 drivers/edac/Kconfig                          |  20 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/qcom_kryo_edac.c                 | 679 ++++++++++++++++++
 5 files changed, 774 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
 create mode 100644 drivers/edac/qcom_kryo_edac.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

