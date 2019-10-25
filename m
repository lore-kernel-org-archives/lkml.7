Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2FFCA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B7420867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404656AbfJYGNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:13:11 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:39195 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404602AbfJYGNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:13:10 -0400
Received: from droid12-sz.software.amlogic (10.28.8.22) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Fri, 25 Oct 2019
 14:13:20 +0800
From:   Xingyu Chen <xingyu.chen@amlogic.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/4] add meson secure watchdog driver
Date:   Fri, 25 Oct 2019 14:13:00 +0800
Message-ID: <1571983984-11771-1-git-send-email-xingyu.chen@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.22]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog controller on the Meson-A/C series SoCs is moved to secure world,
We have to call SMC instruction to trap the ATF for watchdog operation. These
operations are different from previous SoCs, so we introduce a new watchdog
driver to support this kind of SoCs.

Changes since v2 at [1]:
- remove useless dependency in Kconfig
- return zero when getting left time value fails

Changes since v1 at [0]:
- add a new dependency in Kconfig
- simplify/add the return operation
- remove useless ping operation when setting the timeout
- fix some return values
- fix the license statement

[0]:https://lore.kernel.org/linux-amlogic/1570874721-36077-1-git-send-email-xingyu.chen@amlogic.com
[1]:https://lore.kernel.org/linux-amlogic/1571387622-35132-1-git-send-email-xingyu.chen@amlogic.com

Xingyu Chen (4):
  firmware: meson_sm: add new SMC ID support for accessing secure
    watchdog
  dt-bindings: watchdog: add new binding for meson secure watchdog
  watchdog: add meson secure watchdog driver
  arm64: dts: a1: add secure watchdog controller

 .../bindings/watchdog/amlogic,meson-sec-wdt.yaml   |  34 ++++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |   6 +
 drivers/firmware/meson/meson_sm.c                  |   1 +
 drivers/watchdog/Kconfig                           |  16 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/meson_sec_wdt.c                   | 187 +++++++++++++++++++++
 include/linux/firmware/meson/meson_sm.h            |   1 +
 7 files changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/amlogic,meson-sec-wdt.yaml
 create mode 100644 drivers/watchdog/meson_sec_wdt.c

-- 
2.7.4

