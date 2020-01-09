Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F354C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F54206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="D3Zm8BAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgAIIFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:05:41 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:21462 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728340AbgAIIFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:05:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578557140; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: To: From: Sender;
 bh=BuUdAvhMRovZFUB4BJ0UiwY2Y6k8o8mctzHNiqvFTHc=; b=D3Zm8BAvqplK//+gjHBRdggiEsRIzx1/aho097KjVF759u9XFRwhbWVMEoQFm0ll3DLEXqR6
 sU7ttJPYSUOMjSgJ4rFJjewcOGeNA1UTwr12T/xl0KhCdOIMoevk7I1+mWcK4EN1ix/Ly1ff
 pHjQ6pABNnfFFcHrunB+By7/XmI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e16ded1.7fc6d05c2148-smtp-out-n01;
 Thu, 09 Jan 2020 08:05:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E44E8C447A5; Thu,  9 Jan 2020 08:05:35 +0000 (UTC)
Received: from srichara1-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD78EC4479C;
        Thu,  9 Jan 2020 08:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD78EC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     agross@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, robh+dt@kernel.org,
        sivaprak@codeaurora.org, sricharan@codeaurora.org, sboyd@kernel.org
Subject: [PATCH V2 0/2] Add Global clock controller support for IPQ6018
Date:   Thu,  9 Jan 2020 13:35:19 +0530
Message-Id: <1578557121-423-1-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQ6018 is Qualcomm’s 802.11ax/u2019s SoC for Routers,
Gateways and Access Points.

[V2]
 * Addressed sparse warnings reported by Kbuild test robot.

This series adds Global clock controller support for ipq6018.

Sricharan R (2):
  clk: qcom: Add DT bindings for ipq6018 gcc clock controller
  clk: qcom: Add ipq6018 Global Clock Controller support

 .../devicetree/bindings/clock/qcom,gcc.yaml        |    3 +-
 drivers/clk/qcom/Kconfig                           |    8 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-ipq6018.c                     | 4643 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-ipq6018.h       |  262 ++
 include/dt-bindings/reset/qcom,gcc-ipq6018.h       |  157 +
 6 files changed, 5073 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/qcom/gcc-ipq6018.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq6018.h
 create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq6018.h

-- 
1.9.1
