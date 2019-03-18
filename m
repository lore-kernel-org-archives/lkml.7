Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A56C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8482133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCRSPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:15:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14914 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726703AbfCRSPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:15:03 -0400
X-UUID: a6ece14243f441fb982c062e8c3e002f-20190319
X-UUID: a6ece14243f441fb982c062e8c3e002f-20190319
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1646700858; Tue, 19 Mar 2019 02:14:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Mar 2019 02:14:52 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Mar 2019 02:14:51 +0800
Message-ID: <1552932892.24944.15.camel@mtkswgap22>
Subject: Re: [PATCH v6 0/2] Bluetooth: btusb: Add protocol support for
 MediaTek USB devices
From:   Sean Wang <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Mar 2019 02:14:52 +0800
In-Reply-To: <cover.1548371338.git.sean.wang@mediatek.com>
References: <cover.1548371338.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is just a gentle ping of the series

On Fri, 2019-01-25 at 07:26 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> v6:
> * fix drivers/bluetooth/btusb.c:2683:2-3: Unneeded semicolon based reported by [1]
> * update power-on sequence with adding neccesary tci sleep comand to set up
>   low-power environmnet and a delay to wait the device to be stable.
> * sort variables declarations in reverse xmas order.
> 
> [1]
> http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017017.html
> 
> v5:
> * rebase to latest code base.
> * change the subject prefix.
> * change the place the firmware located at.
> 
> v4:
> * use new BTUSB_TX_WAIT_VND_EVT instead of BTMTKUSB_TX_WAIT_VND_EVT
>   to avoid definition conflict and to fix bulk data transfer fails.
> * use the bluetooth-next as the base
> 
> v3:
> add fixes and enhancements based on [1]
> * reuse flags and evt_skb btusb already had
> * add ctrl_anchor and the corresponding handling
> * apply mtk specific recv function
> * add more comments explaining wmt ctrl urbs behavior.
> 
> [1]
> http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014724.html
> 
> v2:
> 
> add fixes and enhancements based on [1]
> * include /sys/kernel/debug/usb/devices portion in the commit message.
> * turn default into n for config BT_HCIBTUSB_MTK in Kconfig
> * only add MediaTek support to btusb.c
> * drop cmd_sync callback usage
> * use __hci_cmd_send to send WMT commands
> * add wait event handling similar to what is being done in btmtkuart.c
> * submit a control IN URB similar to interrupt IN URB on demand for the WMT
>   commands during setup 
> * add cosmetic changes
> 
> [1]
> http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014650.html
> http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014656.html
> 
> v1:
> 
> This adds the support of enabling MT7668U and MT7663U Bluetooth
> function running on the top of btusb driver. The patch also adds
> a newly created file mtkbt.c able to be reused independently from
> the transport type such as UART, USB and SDIO.
> 
> Sean Wang (2):
>   Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB
>     devices
>   Bluetooth: btusb: Add protocol support for MediaTek MT7663U USB
>     devices
> 
>  drivers/bluetooth/Kconfig |  11 +
>  drivers/bluetooth/btusb.c | 581 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 592 insertions(+)
> 


