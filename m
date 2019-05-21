Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941E2C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1882173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DdIcQxJz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nMAEaiSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfEUOo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:44:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42988 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfEUOo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:44:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0CCE260E41; Tue, 21 May 2019 14:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558449868;
        bh=9RJTartqJw5pP0Ur3CP53YgFDs7kDaCUu1bvIYsQLIs=;
        h=From:To:Cc:Subject:Date:From;
        b=DdIcQxJzBoz/6d2weEfmyZfZC3JFLx5MBBSU5GnNCZnRCqOKGts6UYoTyB1seX8s3
         C9k6ZfntTzNiDeN3N5XUQxh5qECJh08lO7mYTouYXHrIKv8sDbNWL8VBMSFRql7JOQ
         0+rmf3zpT5b8eAmJnAXWCGB/wtdef/qU+//7ZqvU=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F43C60746;
        Tue, 21 May 2019 14:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558449865;
        bh=9RJTartqJw5pP0Ur3CP53YgFDs7kDaCUu1bvIYsQLIs=;
        h=From:To:Cc:Subject:Date:From;
        b=nMAEaiSSgI+4E4ak1QXYoDpkuUy/zxz2tQNmwTPsPhQA1L4s1OYkUogTdq/psvDbd
         /R/3iEZVaLYoFTu51rrY1S38Sh15IcyytTODnC+zIKR2bKMw9AFPvzjeqpaC7ORY2q
         EKJl8XRZdzrYVZrEnhXNBJBCniGKhCHVSpP9BnAc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F43C60746
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     david.brown@linaro.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        marc.w.gonzalez@free.fr, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v4 0/6] MSM8998 Multimedia Clock Controller
Date:   Tue, 21 May 2019 08:44:03 -0600
Message-Id: <1558449843-19971-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The multimedia clock controller (mmcc) is the main clock controller for
the multimedia subsystem and is required to enable things like display and
camera.

v4:
-fix makefile to use correct config item
-pick up tags
-fix ordering of clocks and clock-names in dt
-drop MODULE_ALIAS
-wait for xo in mmcc since that was found to be useful in some debug configs

v3:
-Rebase onto linux-next to get the final version of the clk parent rewrite
series
-Moved the bindings header to the bindings patch per Rob
-Made xo manditory for GCC to work around the lack of clk orphan probe defer
to avoid the uart console glitch

v2:
-Rebased on the "Rewrite clk parent handling" series and updated to the clk init
mechanisms introduced there.
-Marked XO clk as CLK_IGNORE_UNUSED to avoid the concern about the XO going away
"incorrectly" during late init
-Corrected the name of the XO clock to "xo"
-Dropped the fake XO clock in GCC to prevent a namespace conflict
-Fully enumerated the external clocks (DSI PLLs, etc) in the DT binding
-Cleaned up the weird newlines in the added DT node
-Added DT header file to msm8998 DT for future clients

Jeffrey Hugo (6):
  dt-bindings: clock: Document external clocks for MSM8998 gcc
  arm64: dts: msm8998: Add xo clock to gcc node
  clk: qcom: smd: Add XO clock for MSM8998
  dt-bindings: clock: Add support for the MSM8998 mmcc
  clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver
  arm64: dts: qcom: msm8998: Add mmcc node

 .../devicetree/bindings/clock/qcom,gcc.txt    |   10 +
 .../devicetree/bindings/clock/qcom,mmcc.txt   |   21 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |   16 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-smd-rpm.c                |   24 +-
 drivers/clk/qcom/gcc-msm8998.c                |   29 +-
 drivers/clk/qcom/mmcc-msm8998.c               | 2915 +++++++++++++++++
 include/dt-bindings/clock/qcom,mmcc-msm8998.h |  210 ++
 9 files changed, 3214 insertions(+), 21 deletions(-)
 create mode 100644 drivers/clk/qcom/mmcc-msm8998.c
 create mode 100644 include/dt-bindings/clock/qcom,mmcc-msm8998.h

-- 
2.17.1

