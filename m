Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37E5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B52121871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfCOHkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:40:22 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:25482 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727250AbfCOHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:40:22 -0400
X-UUID: 81badba19c8046d68f8830fffdf33ee2-20190315
X-UUID: 81badba19c8046d68f8830fffdf33ee2-20190315
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 196177990; Fri, 15 Mar 2019 15:40:07 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Mar 2019 15:40:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Mar 2019 15:40:05 +0800
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
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 0/6] add USB Type-B GPIO based role switch driver
Date:   Fri, 15 Mar 2019 15:38:27 +0800
Message-ID: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
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
available common driver when use Type-B connector.
This patch series introduce a Type-B connector driver and try
to replace the function provided by extcon-usb-gpio driver.
The main purpose of the patches is also to solve the Type-B
connector problem encountered in [1].

[1]: https://patchwork.kernel.org/patch/10819377/

v2 changes:
 1. make binding clear, and add a extra compatible suggested by Hans

Chunfeng Yun (6):
  dt-bindings: connector: add optional properties for Type-B
  dt-bindings: usb: add binding for Type-B dual role switch by GPIO
  dt-bindings: usb: mtu3: add properties about USB Role Switch
  usb: roles: add API to get usb_role_switch by node
  usb: roles: add driver of USB Type-B role switch by GPIO
  usb: mtu3: register a USB Role Switch for dual role mode

 .../bindings/connector/usb-connector.txt      |   9 +
 .../devicetree/bindings/usb/mediatek,mtu3.txt |  10 +-
 .../bindings/usb/typeb-switch-gpio.txt        |  26 ++
 drivers/usb/mtu3/mtu3.h                       |   5 +
 drivers/usb/mtu3/mtu3_dr.c                    |  50 ++-
 drivers/usb/mtu3/mtu3_plat.c                  |   3 +-
 drivers/usb/roles/Kconfig                     |  14 +
 drivers/usb/roles/Makefile                    |   1 +
 drivers/usb/roles/class.c                     |  30 ++
 drivers/usb/roles/typeb-switch-gpio.c         | 285 ++++++++++++++++++
 include/linux/usb/role.h                      |   1 +
 11 files changed, 428 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/typeb-switch-gpio.txt
 create mode 100644 drivers/usb/roles/typeb-switch-gpio.c

-- 
2.20.1

