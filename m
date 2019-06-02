Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E85C28CC3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 00:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EB1277DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 00:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfFBADG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 20:03:06 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:58844 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFBADB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 20:03:01 -0400
X-UUID: c6da88c72c644d519e08893f16711a77-20190601
X-UUID: c6da88c72c644d519e08893f16711a77-20190601
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 974600959; Sat, 01 Jun 2019 16:02:54 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 1 Jun 2019 17:02:52 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 2 Jun 2019 08:02:50 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v7 0/2] Bluetooth: btusb: Add protocol support for MediaTek USB devices
Date:   Sun, 2 Jun 2019 08:02:47 +0800
Message-ID: <1559433769-23749-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

v7:
* rebase to latest code base.

v6:
* fix drivers/bluetooth/btusb.c:2683:2-3: Unneeded semicolon based reported by [1]
* update power-on sequence with adding neccesary tci sleep comand to set up
  low-power environmnet and a delay to wait the device to be stable.
* sort variables declarations in reverse xmas order.

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017017.html

v5:
* rebase to latest code base.
* change the subject prefix.
* change the place the firmware located at.

v4:
* use new BTUSB_TX_WAIT_VND_EVT instead of BTMTKUSB_TX_WAIT_VND_EVT
  to avoid definition conflict and to fix bulk data transfer fails.
* use the bluetooth-next as the base

v3:
add fixes and enhancements based on [1]
* reuse flags and evt_skb btusb already had
* add ctrl_anchor and the corresponding handling
* apply mtk specific recv function
* add more comments explaining wmt ctrl urbs behavior.

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014724.html

v2:

add fixes and enhancements based on [1]
* include /sys/kernel/debug/usb/devices portion in the commit message.
* turn default into n for config BT_HCIBTUSB_MTK in Kconfig
* only add MediaTek support to btusb.c
* drop cmd_sync callback usage
* use __hci_cmd_send to send WMT commands
* add wait event handling similar to what is being done in btmtkuart.c
* submit a control IN URB similar to interrupt IN URB on demand for the WMT
  commands during setup 
* add cosmetic changes

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014650.html
http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014656.html

v1:

This adds the support of enabling MT7668U and MT7663U Bluetooth
function running on the top of btusb driver. The patch also adds
a newly created file mtkbt.c able to be reused independently from
the transport type such as UART, USB and SDIO.

Sean Wang (2):
  Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB
    devices
  Bluetooth: btusb: Add protocol support for MediaTek MT7663U USB
    devices

 drivers/bluetooth/Kconfig |  11 +
 drivers/bluetooth/btusb.c | 581 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 592 insertions(+)

-- 
2.17.1

