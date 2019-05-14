Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B7C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12BB2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfENIrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:47:35 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:3018 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725916AbfENIrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:47:35 -0400
X-UUID: 8e0d93c1a50d47b5b186bd4e076a71d6-20190514
X-UUID: 8e0d93c1a50d47b5b186bd4e076a71d6-20190514
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1818909008; Tue, 14 May 2019 16:47:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 14 May 2019 16:47:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 May 2019 16:47:24 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [v5 PATCH 0/6] add USB Type-B GPIO connector driver
Date:   Tue, 14 May 2019 16:47:17 +0800
Message-ID: <1557823643-8616-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the USB Connector is introduced and the requirement of
usb-connector.txt binding, the old way using extcon to support
USB Dual-Role switch is now deprecated, meanwhile there is no
available common driver when use Type-B connector, typically
using an input GPIO to detect USB ID pin.
This patch series introduce a Type-B GPIO connector driver and try
to replace the function provided by extcon-usb-gpio driver.

v5 changes:
  1. remove linux/of.h and put usb_role_switch when error happens,
     suggested by Biju
  2. treat Type-B connector as USB controller's child, but not as
     a virtual device, suggested by Rob
  3. provide and use generic property "usb-role-switch", see [1],
     suggested by Rob

Note: this series still depends on [2]

[1]: [v3] dt-binding: usb: add usb-role-switch property
      https://patchwork.kernel.org/patch/10934835/
[2]: [v6,08/13] usb: roles: Introduce stubs for the exiting functions in role.h
      https://patchwork.kernel.org/patch/10909971/

v4 changes:
  1. use switch_fwnode_match() to find fwnode suggested by Heikki
  2. assign fwnode member of usb_role_switch struct suggested by Heikki
  3. make [4/6] depend on [2]
  3. remove linux/gpio.h suggested by Linus
  4. put node when error happens

  [4/6] usb: roles: add API to get usb_role_switch by node
  [2] [v6,08/13] usb: roles: Introduce stubs for the exiting functions in role.h
    https://patchwork.kernel.org/patch/10909971/

v3 changes:
  1. add GPIO direction, and use fixed-regulator for GPIO controlled
    VBUS regulator suggested by Rob;
  2. rebuild fwnode_usb_role_switch_get() suggested by Andy and Heikki
  3. treat the type-B connector as a virtual device;
  4. change file name of driver again
  5. select USB_ROLE_SWITCH in mtu3/Kconfig suggested by Heikki
  6. rename ssusb_mode_manual_switch() to ssusb_mode_switch()

v2 changes:
 1. make binding clear, and add a extra compatible suggested by Hans

Chunfeng Yun (6):
  dt-bindings: connector: add optional properties for Type-B
  dt-bindings: usb: add binding for Type-B GPIO connector driver
  dt-bindings: usb: mtu3: add properties about USB Role Switch
  usb: roles: add API to get usb_role_switch by node
  usb: roles: add USB Type-B GPIO connector driver
  usb: mtu3: register a USB Role Switch for dual role mode

 .../bindings/connector/usb-connector.txt      |  14 +
 .../devicetree/bindings/usb/mediatek,mtu3.txt |  10 +
 .../bindings/usb/typeb-conn-gpio.txt          |  42 +++
 drivers/usb/mtu3/Kconfig                      |   1 +
 drivers/usb/mtu3/mtu3.h                       |   5 +
 drivers/usb/mtu3/mtu3_debugfs.c               |   4 +-
 drivers/usb/mtu3/mtu3_dr.c                    |  48 ++-
 drivers/usb/mtu3/mtu3_dr.h                    |   6 +-
 drivers/usb/mtu3/mtu3_plat.c                  |   3 +-
 drivers/usb/roles/Kconfig                     |  11 +
 drivers/usb/roles/Makefile                    |   1 +
 drivers/usb/roles/class.c                     |  24 ++
 drivers/usb/roles/typeb-conn-gpio.c           | 295 ++++++++++++++++++
 include/linux/usb/role.h                      |   8 +
 14 files changed, 465 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
 create mode 100644 drivers/usb/roles/typeb-conn-gpio.c

-- 
2.21.0

