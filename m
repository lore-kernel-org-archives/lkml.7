Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1746EC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E596D21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfDWR0n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:26:43 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50559 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbfDWR0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:26:42 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 366CFCF2DA;
        Tue, 23 Apr 2019 19:34:51 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Fix crash with non-serdev devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAG5bF+TCPc=m_O33RHXHrt34T1Dz1zHLSkXfpxAoOTmrffGJ7w@mail.gmail.com>
Date:   Tue, 23 Apr 2019 19:26:40 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <32C292F9-34DF-436F-896E-A219D961218F@holtmann.org>
References: <CAG5bF+TCPc=m_O33RHXHrt34T1Dz1zHLSkXfpxAoOTmrffGJ7w@mail.gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> qca_set_baudrate() calls serdev_device_wait_until_sent() assuming that
> the HCI is always associated with a serdev device. This isn't true for
> ROME controllers instantiated through ldisc, where the call causes a
> crash due to a NULL pointer dereferentiation. Only call the function
> when we have a serdev device. The timeout for ROME devices at the end
> of qca_set_baudrate() is long enough to be reasonably sure that the
> command was sent.
> 
> Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm
> Bluetooth chip wcn3990")
> Reported-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reported-by: Rocky Liao <rjliao@codeaurora.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> drivers/bluetooth/hci_qca.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4ea995d610d2..714a6a16f9d5 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1004,7 +1004,8 @@ static int qca_set_baudrate(struct hci_dev
> *hdev, uint8_t baudrate)
> 	while (!skb_queue_empty(&qca->txq))
> 		usleep_range(100, 200);
> 
> -	serdev_device_wait_until_sent(hu->serdev,
> +	if (hu->serdev)
> +		serdev_device_wait_until_sent(hu->serdev,
> 		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));

somehow I get a malformed patch when I try to apply it. Can you send a new version against bluetooth-next with all tags added.

Regards

Marcel

