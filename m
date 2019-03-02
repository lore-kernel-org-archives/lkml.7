Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3E9C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C659C20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfCBJF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 04:05:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725986AbfCBJF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 04:05:28 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9FE8E49CF0B0DB080614;
        Sat,  2 Mar 2019 17:05:25 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Sat, 2 Mar 2019 17:05:19 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <liuyu712@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>
Subject: [PATCH v3 00/12] Add support for usb on Hikey960
Date:   Sat, 2 Mar 2019 17:04:53 +0800
Message-ID: <20190302090505.65542-1-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds support for usb functionality of Hikey960, includes:
- dwc3 driver for Hisilicon Kirin Soc hi3660
- usb driver for HiKey960 board
- some adjustment in dwc3, usb gadget and typec driver
- dts for support usb of HiKey960

This patchset based on patchset https://lkml.org/lkml/2019/1/25/344
of Heikki Krogerus

Yu Chen (12):
  dt-bindings: phy: Add support for HiSilicon's hi3660 USB PHY
  dt-bindings: misc: Add bindings for HiSilicon usb hub and data role
    switch functionality on HiKey960
  usb: dwc3: dwc3-of-simple: Add support for dwc3 of Hisilicon Soc
    Platform
  usb: dwc3: Add splitdisable quirk for Hisilicon Kirin Soc
  usb: dwc3: Execute GCTL Core Soft Reset while switch mdoe for
    Hisilicon Kirin Soc
  usb: dwc3: Increase timeout for CmdAct cleared by device controller
  phy: Add usb phy support for hi3660 Soc of Hisilicon
  usb: roles: Add usb role switch notifier.
  usb: dwc3: Registering a role switch in the DRD code.
  hikey960: Support usb functionality of Hikey960
  usb: gadget: Add configfs attribuite for controling
    match_existing_only
  dts: hi3660: Add support for usb on Hikey960

 .../bindings/misc/hisilicon-hikey-usb.txt          |  52 +++++
 .../devicetree/bindings/phy/phy-hi3660-usb3.txt    |  28 +++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |  53 +++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  74 +++++++
 drivers/misc/Kconfig                               |   6 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/hisi_hikey_usb.c                      | 167 +++++++++++++++
 drivers/phy/hisilicon/Kconfig                      |  10 +
 drivers/phy/hisilicon/Makefile                     |   1 +
 drivers/phy/hisilicon/phy-hi3660-usb3.c            | 232 +++++++++++++++++++++
 drivers/usb/dwc3/Kconfig                           |   1 +
 drivers/usb/dwc3/core.c                            |  43 ++++
 drivers/usb/dwc3/core.h                            |  10 +
 drivers/usb/dwc3/drd.c                             |  58 +++++-
 drivers/usb/dwc3/dwc3-of-simple.c                  |   4 +-
 drivers/usb/dwc3/gadget.c                          |   2 +-
 drivers/usb/gadget/configfs.c                      |  32 +++
 drivers/usb/roles/class.c                          |  20 +-
 include/linux/usb/role.h                           |  46 ++++
 20 files changed, 844 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
 create mode 100644 drivers/misc/hisi_hikey_usb.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-usb3.c

-- 
2.15.0-rc2

