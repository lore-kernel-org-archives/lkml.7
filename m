Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A640D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JsVV35ij";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LMU6c3qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCMVS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:18:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfCMVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:18:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D01F960A60; Wed, 13 Mar 2019 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552511936;
        bh=ibrHUwNVtP11xB8FBGv+h9hQxv8MY5GSEsRv7rfU4ZU=;
        h=From:To:Cc:Subject:Date:From;
        b=JsVV35ijIyO82CKdyWcexRQ5HfSCxbYs1AN7UtORXTjLByuGRjo5uK2T+G3mU82Oe
         xwTk08g9DmRaF/sipXAquyqncxwjMgZ5ADpeKX6pdtPC1a3mq6lSQCqvqC75qN6sFA
         GUhbAspNdHS1v2y3hLMT8E4+CdPmEJSNypMtyvpQ=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B905460A05;
        Wed, 13 Mar 2019 21:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552511934;
        bh=ibrHUwNVtP11xB8FBGv+h9hQxv8MY5GSEsRv7rfU4ZU=;
        h=From:To:Cc:Subject:Date:From;
        b=LMU6c3qqXSfKGA3ksQgrTb+OKGfEfXPL1V1reNEmXD0A8oifPNa18K3z6Dn9EIpZu
         d1MWOiJsoSTkjn+4s9p50L0J6v655kjMWk6OMCDySaSoXmv+Wz79HVrzx4Dn1iNOYp
         ui4aOqVH+j0G/LPuywMW/hOk9+YXFOEOEglPvhqw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B905460A05
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v4 00/10] support wakeup capable GPIOs
Date:   Wed, 13 Mar 2019 15:18:34 -0600
Message-Id: <20190313211844.29416-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series adds support for wakeup capable GPIOs. It is based on Thierry's
hiearchical GPIO domains. This approach is based on Stephen's idea [1]. The SoC
that is used for this development is a QCOM SDM845. The current patchset is
rebased on top of 5.0 and adds documentation for the wakeup-parent and
irqdomain-map DT properties along with the the optional irqdomain-map-mask and
irqdomain-map-pass-thru properties. Also incorporating comments from Marc on
the earlier submission [2]. I cleaned up some of the change history in these
patches to match the version number with that of the submission.

The dtsi patches are based on Bjorn's changes for increased address and cell
size [3] and [4].

Kindly review the series.

Thanks,
Lina

[1]. https://lkml.org/lkml/2018/12/19/813
[2]. https://lkml.org/lkml/2019/2/22/716
[3]. https://patchwork.kernel.org/patch/10767511/
[4]. https://lkml.kernel.org/r/20190117042940.25487-2-bjorn.andersson@linaro.org

Lina Iyer (8):
  irqdomain: add bus token DOMAIN_BUS_WAKEUP
  of/irq: document properties for wakeup interrupt parent
  drivers: irqchip: add PDC irqdomain for wakeup capable GPIOs
  dt-bindings: sdm845-pinctrl: add wakeup interrupt parent for GPIO
  drivers: pinctrl: msm: setup GPIO irqchip hierarchy
  arm64: dts: qcom: add PDC interrupt controller for SDM845
  arm64: dts: qcom: setup PDC as wakeup parent for GPIOs for SDM845
  arm64: defconfig: enable PDC interrupt controller for Qualcomm SDM845

Stephen Boyd (1):
  of: irq: add helper to remap interrupts to another irqdomain

Thierry Reding (1):
  gpio: Add support for hierarchical IRQ domains

 .../interrupt-controller/interrupts.txt       |  39 +++++
 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  |   7 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  87 ++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpio/gpiolib.c                        |  15 +-
 drivers/irqchip/qcom-pdc.c                    |  72 ++++++++-
 drivers/of/irq.c                              | 125 +++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm.c            | 151 +++++++++++++++---
 include/linux/gpio/driver.h                   |   6 +
 include/linux/irqdomain.h                     |   1 +
 include/linux/of_irq.h                        |   1 +
 include/linux/soc/qcom/irq.h                  |  23 +++
 12 files changed, 497 insertions(+), 31 deletions(-)
 create mode 100644 include/linux/soc/qcom/irq.h

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

