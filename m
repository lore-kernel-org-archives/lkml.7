Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667F0C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AD921835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Bzh68sST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgACL0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:26:00 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:43437 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727220AbgACLZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:25:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578050759; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: To: From: Sender;
 bh=WE57pxSUJyR+L5tsiqVz5w7Z/BAF2j86LaPJYplaCc0=; b=Bzh68sSTdZpEuEMty18/wKGYJn8NYa03a3WRJrD2zWDkXSdvRKUurlMOL1hcLZgzjmyC51Ou
 852/kiKCqMwrxDQB3DC/BLBmwF7bmWS18UVhbdtKVnOuv2QVnL1H89scwPj3cYR5S7dJA04l
 Fh/wGEHakanS2tbdulfQsWmUOQw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0f24c3.7f4dc728f378-smtp-out-n02;
 Fri, 03 Jan 2020 11:25:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF909C447AE; Fri,  3 Jan 2020 11:25:54 +0000 (UTC)
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 980C9C447B2;
        Fri,  3 Jan 2020 11:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 980C9C447B2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     sricharan@codeaurora.org, agross@kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        sivaprak@codeaurora.org
Subject: [PATCH 0/2] Add Global clock controller support for IPQ6018
Date:   Fri,  3 Jan 2020 16:55:42 +0530
Message-Id: <1578050744-3761-1-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQ6018 is Qualcomm’s 802.11ax SoC for Routers,
Gateways and Access Points.

This series adds Global clock controller support for ipq6018.

The patches were a part of https://patchwork.kernel.org/cover/11303075/,
now moved it outside based on Stephen's suggestion.

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
