Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7407EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D5B20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DF1HwDne";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kGMOcQFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfD3Hop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:44:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50690 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3Hom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:44:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E23660214; Tue, 30 Apr 2019 07:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556610281;
        bh=ObjUo2Emxi2WJIUfB5bP3tzczg3thQ2BFG0+EiKejcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DF1HwDne6KsQJn6A25Ut2I4bvUJhIOjGIJxneekaxPT+JNTuqU1vLmQeuRHPvkmnj
         V6NjozPDiwyGiNa0og23Dg4n+tjlMBUsH6SKvDl3aiXfFqZKuD5hiV6aHic2fdOFBL
         /V1ZpTnhASbiMN/UreAHMuNI8hS+QBlEtgQR2TuE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BD65B60247;
        Tue, 30 Apr 2019 07:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556610280;
        bh=ObjUo2Emxi2WJIUfB5bP3tzczg3thQ2BFG0+EiKejcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kGMOcQFKz3h9bavJPMPr2fToJGjB7cEP2m+hFQW+iXZAVAaceiJRBDBxc2R6zB/yL
         mtAMgC6qweAXy4SUQbrxZZBjuboaZFOkWVN760lOIJqJ2Sg4HKoC4aXKgFfe8sF/O5
         dqJhbWA+dbjWQjDSyKLJ5yNo801QCh6KuLouyv5Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Apr 2019 13:14:40 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_qca: Rename STATE_<flags> to
 QCA_<flags>
In-Reply-To: <20190429232131.183049-1-mka@chromium.org>
References: <20190429232131.183049-1-mka@chromium.org>
Message-ID: <472ef0468852806f6afa8aa6e7713de2@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathhias,

On 2019-04-30 04:51, Matthias Kaehlcke wrote:
> Rename STATE_IN_BAND_SLEEP_ENABLED to QCA_IBS_ENABLED. The constant
> represents a flag (multiple flags can be set at once), not a unique
> state of the controller or driver.
> 
> Also make the flag an enum value instead of a pre-processor constant
> (more flags will be added to the enum group by another patch).
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - rename STATE_IN_BAND_SLEEP_ENABLED to QCA_IBS_ENABLED
> 
> Changes in v2:
> - don't use BIT()
> - change to enum type
> - updated commit message
> ---
>  drivers/bluetooth/hci_qca.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index c53ee8d8ca15..57322c42bb2d 100644
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
> +	QCA_IBS_ENABLED,
> +};
> +
>  /* HCI_IBS transmit side sleep protocol states */
>  enum tx_ibs_states {
>  	HCI_IBS_TX_ASLEEP,
> @@ -792,7 +793,7 @@ static int qca_enqueue(struct hci_uart *hu, struct
> sk_buff *skb)
>  	/* Don't go to sleep in middle of patch download or
>  	 * Out-Of-Band(GPIOs control) sleep is selected.
>  	 */
> -	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
> +	if (!test_bit(QCA_IBS_ENABLED, &qca->flags)) {
>  		skb_queue_tail(&qca->txq, skb);
>  		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>  		return 0;
> @@ -1202,7 +1203,7 @@ static int qca_setup(struct hci_uart *hu)
>  		return ret;
> 
>  	/* Patch downloading has to be done without IBS mode */
> -	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +	clear_bit(QCA_IBS_ENABLED, &qca->flags);
> 
>  	if (qca_is_wcn399x(soc_type)) {
>  		bt_dev_info(hdev, "setting up wcn3990");
> @@ -1246,7 +1247,7 @@ static int qca_setup(struct hci_uart *hu)
>  	/* Setup patch / NVM configurations */
>  	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver);
>  	if (!ret) {
> -		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +		set_bit(QCA_IBS_ENABLED, &qca->flags);
>  		qca_debugfs_init(hdev);
>  	} else if (ret == -ENOENT) {
>  		/* No patch/nvm-config found, run with original fw/config */
> @@ -1315,7 +1316,7 @@ static void qca_power_shutdown(struct hci_uart 
> *hu)
>  	 * data in skb's.
>  	 */
>  	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> -	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +	clear_bit(QCA_IBS_ENABLED, &qca->flags);
>  	qca_flush(hu);
>  	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);

Change looks fine to me.

Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
-- 
Regards
Balakrishna.
