Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAD5C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FF82087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfHSJ3J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:29:09 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57304 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSJ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:29:08 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7J9SqYH003436, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7J9SqYH003436
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 19 Aug 2019 17:28:52 +0800
Received: from RTITMBSVM03.realtek.com.tw ([fe80::e1fe:b2c1:57ec:f8e1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Mon, 19 Aug
 2019 17:28:52 +0800
From:   Max Chou <max.chou@realtek.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        alex_lu <alex_lu@realsil.com.cn>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] Bluetooth: btusb: Fix suspend issue for Realtek devices
Thread-Topic: [PATCH v3] Bluetooth: btusb: Fix suspend issue for Realtek
 devices
Thread-Index: AQHVUpgkG6pBoXbbekKNiT4P/vBZNKb6JA4AgAgVjHA=
Date:   Mon, 19 Aug 2019 09:28:50 +0000
Message-ID: <805C62CFCC3D8947A436168B9486C77DEE396F3E@RTITMBSVM03.realtek.com.tw>
References: <20190814120252.GA4572@toshiba>
 <B5282441-D76E-41B4-901B-664974EC0E50@holtmann.org>
In-Reply-To: <B5282441-D76E-41B4-901B-664974EC0E50@holtmann.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.83.214]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel Maintainer Marcel, 
Sorry for the inconvenience. For the original target, this patch is edited for low power consumption hence controller should not receive DEVICE_REMOTE_WAKE_UP that it's able to save power in suspend mode because BT wake-up function is disabled.
In upstream driver, there should be higher priority for function rather than performance. In other words, this patch can meet the low power consumption in suspend mode but will lose BT wake-up function. It is not a good idea for that. Please help to revert this modification. 
Thank you.


BRs,
Max


-----Original Message-----
From: Marcel Holtmann <marcel@holtmann.org> 
Sent: Wednesday, August 14, 2019 9:54 PM
To: alex_lu <alex_lu@realsil.com.cn>
Cc: Johan Hedberg <johan.hedberg@gmail.com>; linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org; Max Chou <max.chou@realtek.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: Fix suspend issue for Realtek devices

Hi Alex,

> From the perspective of controller, global suspend means there is no 
> SET_FEATURE (DEVICE_REMOTE_WAKEUP) and controller would drop the 
> firmware. It would consume less power. So we should not send this kind 
> of SET_FEATURE when host goes to suspend state.
> Otherwise, when making device enter selective suspend, host should 
> send SET_FEATURE to make sure the firmware remains.
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> ---
> Changes in v3:
>  - Change to fit for bluetooth-next
> Changes in v2:
>  - Change flag to be more descriptive
>  - Delete pointless #ifdef CONFIG_BT_HCIBTUSB_RTL and #endif
> 
> drivers/bluetooth/btusb.c | 34 ++++++++++++++++++++++++++++++----
> 1 file changed, 30 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


------Please consider the environment before printing this e-mail.
