Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0DEC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8392064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfGXIvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:51:23 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:16271 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbfGXIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:51:22 -0400
X-UUID: 93b9a2bc9b2d4628b78105880c333cc9-20190724
X-UUID: 93b9a2bc9b2d4628b78105880c333cc9-20190724
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1533339421; Wed, 24 Jul 2019 16:51:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 16:51:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 16:51:07 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v8 00/11] add USB GPIO based connection detection driver
Date:   Wed, 24 Jul 2019 16:50:34 +0800
Message-ID: <1563958245-6321-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5846A1EA601B9CCF1CA7B9FFE277608E1752F76C73E9B881B4BC6FC11CB36CF52000:8
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
This patch series introduce a USB GPIO based connection detecton
driver and try to replace the function provided by extcon-usb-gpio
driver.

v8 changes:
  1. rename the driver's name suggested by Heikki
  2. move the driver from usb/roles/ into usb/common/ suggested by Heikki
  3. introduce Kconfig for usb common core to add the new driver
  4. modify binding of the driver 
  5. rename the subject title

v7 changes:
  1. [5/10]: add signed-off-by Chunfeng
  2. [6/10]: add signed-off-by Chunfeng
  3. [6/10]: depends on linux-next of Rafael's tree [1]
  4. [7/10]: add signed-off-by Chunfeng and tested-by Biju
  5. [9/10]: add tested-by Nagarjuna, and remove DEV_PMS_OPS suggested by Andy

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=linux-next

v6 changes:
  1. merge [1] and [2] into this series
  2. don't use graph anymore to find usb-role-switch
  3. abandon [3] and introduce three patches (6, 7, 8 in this series)
     to rebuild APIs getting usb-role-switch

  [1]: [v3] dt-binding: usb: add usb-role-switch property
       https://patchwork.kernel.org/patch/10934835/
  [2]: [v6,08/13] usb: roles: Introduce stubs for the exiting functions in role.h
       https://patchwork.kernel.org/patch/10909971/

  [3]: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by node

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

Chunfeng Yun (8):
  dt-binding: usb: add usb-role-switch property
  dt-bindings: connector: add optional properties for Type-B
  dt-bindings: usb: add binding for USB GPIO based connection detection
    driver
  dt-bindings: usb: mtu3: add properties about USB Role Switch
  usb: roles: get usb-role-switch from parent
  usb: common: create Kconfig file
  usb: common: add USB GPIO based connection detection driver
  usb: mtu3: register a USB Role Switch for dual role mode

Heikki Krogerus (2):
  device connection: Add fwnode_connection_find_match()
  usb: roles: Add fwnode_usb_role_switch_get() function

Yu Chen (1):
  usb: roles: Introduce stubs for the exiting functions in role.h.

 .../bindings/connector/usb-connector.txt      |  14 +
 .../devicetree/bindings/usb/generic.txt       |   4 +
 .../devicetree/bindings/usb/mediatek,mtu3.txt |  10 +
 .../devicetree/bindings/usb/usb-conn-gpio.txt |  31 ++
 drivers/base/devcon.c                         |  43 ++-
 drivers/usb/Kconfig                           |  35 +--
 drivers/usb/common/Kconfig                    |  51 ++++
 drivers/usb/common/Makefile                   |   1 +
 drivers/usb/common/usb-conn-gpio.c            | 284 ++++++++++++++++++
 drivers/usb/mtu3/Kconfig                      |   1 +
 drivers/usb/mtu3/mtu3.h                       |   5 +
 drivers/usb/mtu3/mtu3_debugfs.c               |   4 +-
 drivers/usb/mtu3/mtu3_dr.c                    |  48 ++-
 drivers/usb/mtu3/mtu3_dr.h                    |   6 +-
 drivers/usb/mtu3/mtu3_plat.c                  |   3 +-
 drivers/usb/roles/class.c                     |  41 ++-
 include/linux/device.h                        |  10 +-
 include/linux/usb/role.h                      |  37 +++
 18 files changed, 570 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
 create mode 100644 drivers/usb/common/Kconfig
 create mode 100644 drivers/usb/common/usb-conn-gpio.c

-- 
2.21.0

