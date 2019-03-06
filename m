Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC051C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828EE20828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfCFLsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:48:04 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:21082 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725267AbfCFLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:46:56 -0500
X-UUID: 9a8ecf3269a4430ca78cea6c031e67cd-20190306
X-UUID: 9a8ecf3269a4430ca78cea6c031e67cd-20190306
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1991209519; Wed, 06 Mar 2019 19:46:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 19:46:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 19:46:43 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 00/11] add debugfs consumers, tracepoints and rebuild QMU
Date:   Wed, 6 Mar 2019 19:46:12 +0800
Message-ID: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to help debug, this series add more debugfs consumers,
introduce a few initial tracepoints;
And support new features introduced by USB3 Gen2 ISOC:
1. TXCSR/RXCSR registers are adjusted to support greater MULT
   and MAX_PKT
2. QMU format is also improved
last, some small problems are fixed.

Chunfeng Yun (11):
  usb: mtu3: check return value of devm_extcon_register_notifier()
  usb: mtu3: print useful information also for device and host modes
  usb: mtu3: remove unnecessary local variable @req
  usb: mtu3: rebuild the code of getting vbus regulator
  usb: mtu3: fix transfer error of USB3 Gen2 isoc
  usb: mtu3: rebuild qmu_gpd struct to prepare to support new QMU format
  usb: mtu3: supports new QMU format
  usb: mtu3: add debugfs interface files
  usb: mtu3: move vbus and mode debugfs interfaces into mtu3_debugfs.c
  usb: mtu3: add tracepoints to help debug
  usb: mtu3: add a function to switch mailbox state to string

 drivers/usb/mtu3/Makefile          |  11 +
 drivers/usb/mtu3/mtu3.h            |  57 ++-
 drivers/usb/mtu3/mtu3_core.c       |  27 +-
 drivers/usb/mtu3/mtu3_debug.h      |  50 +++
 drivers/usb/mtu3/mtu3_debugfs.c    | 539 +++++++++++++++++++++++++++++
 drivers/usb/mtu3/mtu3_dr.c         | 156 ++-------
 drivers/usb/mtu3/mtu3_dr.h         |   4 +
 drivers/usb/mtu3/mtu3_gadget.c     |  20 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c |   4 +
 drivers/usb/mtu3/mtu3_hw_regs.h    |  48 ++-
 drivers/usb/mtu3/mtu3_plat.c       |  28 +-
 drivers/usb/mtu3/mtu3_qmu.c        | 118 ++++---
 drivers/usb/mtu3/mtu3_qmu.h        |   1 +
 drivers/usb/mtu3/mtu3_trace.c      |  23 ++
 drivers/usb/mtu3/mtu3_trace.h      | 279 +++++++++++++++
 15 files changed, 1146 insertions(+), 219 deletions(-)
 create mode 100644 drivers/usb/mtu3/mtu3_debug.h
 create mode 100644 drivers/usb/mtu3/mtu3_debugfs.c
 create mode 100644 drivers/usb/mtu3/mtu3_trace.c
 create mode 100644 drivers/usb/mtu3/mtu3_trace.h

-- 
2.20.1

