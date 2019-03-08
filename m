Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE251C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A58C20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfCHGOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:14:12 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46803 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726175AbfCHGOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:14:12 -0500
X-UUID: 167dc05047ab43a99430f7e7238abdcb-20190308
X-UUID: 167dc05047ab43a99430f7e7238abdcb-20190308
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1167906245; Fri, 08 Mar 2019 14:14:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 8 Mar 2019 14:13:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 8 Mar 2019 14:13:48 +0800
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
Subject: [PATCH 0/5] add USB Type-B connector driver
Date:   Fri, 8 Mar 2019 14:13:37 +0800
Message-ID: <1552025622-15582-1-git-send-email-chunfeng.yun@mediatek.com>
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

Chunfeng Yun (5):
  dt-bindings: connector: add optional properties for Type-B
  dt-bindings: usb: mtu3: add properties about USB Role Switch
  usb: roles: add API to get usb_role_switch by node
  usb: roles: add USB Type-B connector driver
  usb: mtu3: register a USB Role Switch for Dual-Role mode

 .../bindings/connector/usb-connector.txt      |  10 +
 .../devicetree/bindings/usb/mediatek,mtu3.txt |  10 +-
 drivers/usb/mtu3/mtu3.h                       |   5 +
 drivers/usb/mtu3/mtu3_dr.c                    |  50 ++-
 drivers/usb/mtu3/mtu3_plat.c                  |   3 +-
 drivers/usb/roles/Kconfig                     |  14 +
 drivers/usb/roles/Makefile                    |   1 +
 drivers/usb/roles/class.c                     |  30 ++
 drivers/usb/roles/usb-b-connector.c           | 285 ++++++++++++++++++
 include/linux/usb/role.h                      |   1 +
 10 files changed, 403 insertions(+), 6 deletions(-)
 create mode 100644 drivers/usb/roles/usb-b-connector.c

-- 
2.20.1

