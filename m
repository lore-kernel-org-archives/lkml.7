Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ADAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C722196F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390139AbfISMLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:11:12 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:41463 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfISMLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:11:12 -0400
Received: from droid13.amlogic.com (116.236.93.172) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Thu, 19 Sep 2019
 20:12:05 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: [PATCH 0/3] arm64: meson: add support for A1 Power Domains
Date:   Thu, 19 Sep 2019 08:11:01 -0400
Message-ID: <1568895064-4116-1-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [116.236.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces a "Secure Power Doamin Controller". In A1/C1, power
controller registers such as PWRCTRL_FOCRSTN, PWRCTRL_PWR_OFF, PWRCTRL_MEM_PD
and PWRCTRL_ISO_EN, are in the secure domain, and should be accessed from ATF
by smc.

This patchset is based on A1 DTB series at [0].

[0]  https://lore.kernel.org/linux-amlogic/1568276370-54181-1-git-send-email-jianxin.pan@amlogic.com

Jianxin Pan (3):
  dt-bindings: power: add Amlogic secure power domains bindings
  soc: amlogic: Add support for Secure power domains controller
  arm64: dts: meson: a1: add secure power domain controller

 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  32 ++++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |   6 +
 drivers/soc/amlogic/Kconfig                        |  13 ++
 drivers/soc/amlogic/Makefile                       |   1 +
 drivers/soc/amlogic/meson-secure-pwrc.c            | 182 +++++++++++++++++++++
 include/dt-bindings/power/meson-a1-power.h         |  32 ++++
 6 files changed, 266 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
 create mode 100644 drivers/soc/amlogic/meson-secure-pwrc.c
 create mode 100644 include/dt-bindings/power/meson-a1-power.h

-- 
2.7.4

