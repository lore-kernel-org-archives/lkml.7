Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4D1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DB02070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HosiR+dr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X4/g8DMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfHSQiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:38:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfHSQiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:38:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C46DC60265; Mon, 19 Aug 2019 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566232688;
        bh=UMfZfA6yghk+4t5zaNzbuEq+Ypcrq2SNh7K2xh44ZEM=;
        h=From:To:Cc:Subject:Date:From;
        b=HosiR+drD9zHL2rUrUEgyq1MKVjFvm6hvZQbTw10ItYenKm/pnIzUEetpAiLfWSqP
         AxgzO5PXtLahOJMPrdrnTrmjLZhX2POZqRhpnHfPTyzE5PXUoSU7wVmMnwZlvXUYZf
         U1uqTht1rt/a7ykPm2Sth61WynjRcU7Mgk5EXUW8=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC96460112;
        Mon, 19 Aug 2019 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566232687;
        bh=UMfZfA6yghk+4t5zaNzbuEq+Ypcrq2SNh7K2xh44ZEM=;
        h=From:To:Cc:Subject:Date:From;
        b=X4/g8DMp8iFC90knWsQjEjT/hke9dmRRru/aSGg5aQQ1pp8BPzpUrmljXyFYNrgyw
         gU2gif94WdcVLF7RsW8ditv8KOZoawgn8G2beh3wKlyN4g5lq+3CjCWHNCaqk1Tt34
         oPoLoMdMNrrmATiuV8M9Xypq5xcDeC4oPp47EaiY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC96460112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>,
        robh+dt@kernel.org
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 0/3] Add Global Clock controller (GCC) driver for SC7180
Date:   Mon, 19 Aug 2019 22:07:45 +0530
Message-Id: <20190819163748.18318-1-tdas@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v2]
 * Update the DFS macro for RCG to reflect the hw init similar to clock
   name.
 * Update the Documentation binding of GCC to YAML schemas.
 * Add comments for CRITICAL clocks, remove PLL forward declarations and
   unwanted comments/prints.

[v1]
  * Add driver support for Global Clock controller for SC7180 and also
    update device tree bindings for the various clocks supported in the
    clock controller.

Taniya Das (3):
  clk: qcom: rcg: update the DFS macro for RCG
  dt-bindings: clk: qcom: Add YAML schemas for the GCC clock bindings
  clk: qcom: Add Global Clock controller (GCC) driver for SC7180

 .../devicetree/bindings/clock/qcom,gcc.yaml   |  141 +
 drivers/clk/qcom/Kconfig                      |   10 +-
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rcg.h                    |    2 +-
 drivers/clk/qcom/gcc-sc7180.c                 | 2497 +++++++++++++++++
 drivers/clk/qcom/gcc-sdm845.c                 |   96 +-
 include/dt-bindings/clock/qcom,gcc-sc7180.h   |  155 +
 7 files changed, 2852 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sc7180.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sc7180.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

