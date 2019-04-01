Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A6320700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Br56PKj8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RYHwUSgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbfDAHqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:46:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfDAHqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:46:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91B67602FC; Mon,  1 Apr 2019 07:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554104769;
        bh=j7gP3v5TDkA5/TAThLFoL4MLuggLyY1xxFTs/TISDXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Br56PKj82aY7zseeeQHJLzvcpLx7tijEFXTvY6Y292WAfGNonOwE7Cb2qWRzpHgaz
         +fBY2pwofkczip+VAfjSIvgq6brXN7tUi3DbXGeAjbWn1KwwHEbjv0q/NuEWeVP9FU
         su8IcIePDOBrrCiyuSonQ4m9lMleortWb7PsXmgo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7F209602F2;
        Mon,  1 Apr 2019 07:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554104768;
        bh=j7gP3v5TDkA5/TAThLFoL4MLuggLyY1xxFTs/TISDXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RYHwUSgWDCokRPazfp5P3SnQSInfcEjCqFYZ970IK3ivcWXUHdWesJ5jY9+DX3SnE
         FCZ/bbkvxaZETmsTvvAlZxpPaC/XsjjdapE6z6m3Mzq4spqKuVPw8qQa3zb4A/FlWX
         jhw45VPmAr7MCCpYcjSoHmKnD23LxjaTQpFpeXpg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Apr 2019 13:16:07 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_qca: Rename STATE_<flags> to
 QCA_<flags>
In-Reply-To: <CAG5bF+RLTaYbrn8uSpoU+W=PBmNawR6Ov0EOEcfuSymzuini5w@mail.gmail.com>
References: <20190312204217.73296-1-mka@chromium.org>
 <CAG5bF+RLTaYbrn8uSpoU+W=PBmNawR6Ov0EOEcfuSymzuini5w@mail.gmail.com>
Message-ID: <96ea2aaad3d9ff631a621498a6c12a35@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-03-13 02:12, Matthias Kaehlcke wrote:
> Rename STATE_IN_BAND_SLEEP_ENABLED to QCA_IN_BAND_SLEEP_ENABLED.
> The constant represents a flag (multiple flags can be set at once),
> not a unique state of the controller or driver.
> 
> Also make the flag an enum value instead of a pre-processor constant
> (more flags will be added to the enum group by another patch).
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - don't use BIT()
> - change to enum type
> - updated commit message
> ---
>  drivers/bluetooth/hci_qca.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 237aea34b69f..1b7ba9e9e08a 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -54,9 +54,6 @@
>  #define HCI_IBS_WAKE_ACK	0xFC
>  #define HCI_MAX_IBS_SIZE	10
> 
> -/* Controller states */
> -#define STATE_IN_BAND_SLEEP_ENABLED	1
> -
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
>  #define CMD_TRANS_TIMEOUT_MS		100
> @@ -67,6 +64,10 @@
>  /* Controller debug log header */
>  #define QCA_DEBUG_HANDLE	0x2EDC
> 
> +enum qca_flags {
> +	QCA_IN_BAND_SLEEP_ENABLED,
> +};
> +

[Bala]: I would recommend to go with QCA_IBS_ENABLED as IBS is 
abbreviated as In band sleep.

>  /* HCI_IBS transmit side sleep protocol states */
>  enum tx_ibs_states {
>  	HCI_IBS_TX_ASLEEP,
> @@ -775,7 +776,7 @@ static int qca_enqueue(struct hci_uart *hu, struct
> sk_buff *skb)
>  	/* Don't go to sleep in middle of patch download or
>  	 * Out-Of-Band(GPIOs control) sleep is selected.
>  	 */
> -	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
> +	if (!test_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
>  		skb_queue_tail(&qca->txq, skb);
>  		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>  		return 0;
> @@ -1192,7 +1193,7 @@ static int qca_setup(struct hci_uart *hu)
>  		return ret;
> 
>  	/* Patch downloading has to be done without IBS mode */
> -	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +	clear_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags);
> 
>  	if (qcadev->btsoc_type == QCA_WCN3990) {
>  		bt_dev_info(hdev, "setting up wcn3990");
> @@ -1236,7 +1237,7 @@ static int qca_setup(struct hci_uart *hu)
>  	/* Setup patch / NVM configurations */
>  	ret = qca_uart_setup(hdev, qca_baudrate, qcadev->btsoc_type, 
> soc_ver);
>  	if (!ret) {
> -		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +		set_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags);
>  		qca_debugfs_init(hdev);
>  	} else if (ret == -ENOENT) {
>  		/* No patch/nvm-config found, run with original fw/config */
> @@ -1294,7 +1295,7 @@ static void qca_power_shutdown(struct hci_uart 
> *hu)
>  	 * data in skb's.
>  	 */
>  	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> -	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +	clear_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags);
>  	qca_flush(hu);
>  	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);

-- 
Regards
Balakrishna.
