Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FA1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 04:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0988E218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 04:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PV+p/k6e";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PV+p/k6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfCVExX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 00:53:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33440 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfCVExX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 00:53:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E300E60C72; Fri, 22 Mar 2019 04:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553230402;
        bh=2V2S0zI3REoNgBHmqjjZbl0J7v7ofo1DgSoFb2MahSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PV+p/k6e0a0p2imfrltql/aXm3K5pKY2tQsXPKos3bK/ylpx0HrQYQwue28t3xD8D
         RUCkQ1OvnaL3wOW5KOky1jeVxtrXmszE9jnnao/5c9/mdvyiQ99LxecBkQ8fHMB1qn
         z5dcMyddY1PGolRq8ntBo8BoJZ97me3DH63+pvSw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 179A960E41;
        Fri, 22 Mar 2019 04:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553230402;
        bh=2V2S0zI3REoNgBHmqjjZbl0J7v7ofo1DgSoFb2MahSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PV+p/k6e0a0p2imfrltql/aXm3K5pKY2tQsXPKos3bK/ylpx0HrQYQwue28t3xD8D
         RUCkQ1OvnaL3wOW5KOky1jeVxtrXmszE9jnnao/5c9/mdvyiQ99LxecBkQ8fHMB1qn
         z5dcMyddY1PGolRq8ntBo8BoJZ97me3DH63+pvSw=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 22 Mar 2019 12:53:22 +0800
From:   rjliao@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH] Bluetooth: hci_qca: Fix crash with non-serdev devices
In-Reply-To: <CAG5bF+TCPc=m_O33RHXHrt34T1Dz1zHLSkXfpxAoOTmrffGJ7w@mail.gmail.com>
References: <CAG5bF+TCPc=m_O33RHXHrt34T1Dz1zHLSkXfpxAoOTmrffGJ7w@mail.gmail.com>
Message-ID: <a3fe19f03ac6db1a2b2c376fd2afe43d@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019-03-14 07:52，Matthias Kaehlcke 写道：
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
Reviewed-by: Rocky Liao <rjliao@codeaurora.org>
Tested-by: Rocky Liao <rjliao@codeaurora.org>
