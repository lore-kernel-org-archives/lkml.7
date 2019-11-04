Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C0ACA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4189A218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfKDOTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:19:53 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40716 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfKDOTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:19:52 -0500
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id EEC21CECD6;
        Mon,  4 Nov 2019 15:28:53 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] Bluetooth: hci_qca: add PM support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191031104614.165120-1-tientzu@chromium.org>
Date:   Mon, 4 Nov 2019 15:19:50 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A80987FF-C9E1-4790-91F1-F86E405B9691@holtmann.org>
References: <20191031104614.165120-1-tientzu@chromium.org>
To:     Claire Chang <tientzu@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claire,

> Add PM suspend/resume callbacks for hci_qca driver.
> 
> BT host will make sure both Rx and Tx go into sleep state in
> qca_suspend. Without this, Tx may still remain in awake state, which
> prevents BTSOC from entering deep sleep. For example, BlueZ will send
> Set Event Mask to device when suspending and this will wake the device
> Rx up. However, the Tx idle timeout on the host side is 2000 ms. If the
> host is suspended before its Tx idle times out, it won't send
> HCI_IBS_SLEEP_IND to the device and the device Rx will remain awake.
> 
> We implement this by canceling relevant work in workqueue, sending
> HCI_IBS_SLEEP_IND to the device and then waiting HCI_IBS_SLEEP_IND sent
> by the device.
> 
> In order to prevent the device from being awaken again after qca_suspend
> is called, we introduce QCA_SUSPEND flag. QCA_SUSPEND is set in the
> beginning of qca_suspend to indicate system is suspending and that we'd
> like to ignore any further wake events.
> 
> With QCA_SUSPEND and spinlock, we can avoid race condition, e.g. if
> qca_enqueue acquires qca->hci_ibs_lock before qca_suspend calls
> cancel_work_sync and then qca_enqueue adds a new qca->ws_awake_device
> work after the previous one is cancelled.
> 
> If BTSOC wants to wake the whole system up after qca_suspend is called,
> it will keep sending HCI_IBS_WAKE_IND and uart driver will take care of
> waking the system. For example, uart driver will reconfigure its Rx pin
> to a normal GPIO pin and enable irq wake on that pin when suspending.
> Once host detects Rx falling, the system will begin resuming. Then, the
> BT host clears QCA_SUSPEND flag in qca_resume and begins dealing with
> normal HCI packets. By doing so, only a few HCI_IBS_WAKE_IND packets are
> lost and there is no data packet loss.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
> drivers/bluetooth/hci_qca.c | 127 +++++++++++++++++++++++++++++++++++-
> 1 file changed, 124 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

