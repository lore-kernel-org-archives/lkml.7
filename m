Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2BDC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8923920700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TvMzJSw7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Tr1EWSSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbfDAHmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:42:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60566 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbfDAHmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:42:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6FCF660712; Mon,  1 Apr 2019 07:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554104532;
        bh=hq7+NJgj2eFnI1NLy1dFFDZsFdTXdmlukyWMrifKSQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TvMzJSw7fAUK2WHS3sMwzeTG84Wl4nMudbFJxmkC5rk+LHT/FHhYZQW12mSeVwTPs
         cKpHAUK3Yw5uA1ZFtOe0eA0Y8n/sA7XhxMxK58eX9Na0z7o7+0kyAueoiAvy8c4/Mt
         6+TyWb5odsk2cWMnBPdi6diIV2LjtKlVqB4YYVFI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C79B560712;
        Mon,  1 Apr 2019 07:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554104531;
        bh=hq7+NJgj2eFnI1NLy1dFFDZsFdTXdmlukyWMrifKSQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tr1EWSSGgDqJ3kNPze5jmrMz15OIAsxRwiAC9Ou8NLWVc3ig0kcKnsmW19qWbWBdD
         13Up4lvQdPOQjUjirsCpd29USqtrZCst0NdFit/dhezgmy8My3gY0029aBTSLfLSHh
         uaeoxwXh+S7DUNt53DhlDB8pAD2kLx9sXQ4uCJ24=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Apr 2019 13:12:11 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Subject: Re: [PATCH] Bluetooth: hci_qca: Fix crash with non-serdev devices
In-Reply-To: <CAG5bF+TCPc=m_O33RHXHrt34T1Dz1zHLSkXfpxAoOTmrffGJ7w@mail.gmail.com>
References: <CAG5bF+TCPc=m_O33RHXHrt34T1Dz1zHLSkXfpxAoOTmrffGJ7w@mail.gmail.com>
Message-ID: <ea3ca645f1ba7c6ce865f2c6f224e93a@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-14 05:22, Matthias Kaehlcke wrote:
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
>  drivers/bluetooth/hci_qca.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4ea995d610d2..714a6a16f9d5 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1004,7 +1004,8 @@ static int qca_set_baudrate(struct hci_dev
> *hdev, uint8_t baudrate)
>  	while (!skb_queue_empty(&qca->txq))
>  		usleep_range(100, 200);
> 
> -	serdev_device_wait_until_sent(hu->serdev,
> +	if (hu->serdev)
> +		serdev_device_wait_until_sent(hu->serdev,
>  		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
> 
>  	/* Give the controller time to process the request */

Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

-- 
Regards
Balakrishna.
