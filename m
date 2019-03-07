Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8C2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C97820663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mc6VhPMp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kReBPNdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfCGCVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:21:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfCGCVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:21:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2B7D46028D; Thu,  7 Mar 2019 02:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551925294;
        bh=J4Fu0YHFCf6KtFZ4WP5SYSfwHrB9s7r4l/gARSgE+LA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mc6VhPMp2N9k1McWZQDHYMYNC8o8THGc7hDU7ltfV1DkbvAwMeflegjCmjNq0TGAi
         0rX8vbT+CBDSmJYvvvTx/03ILtk8brwq4iuKYlPsSp7GcRUmPnEhqEUF0L9wU49Yyy
         1KzV7yy1OOBcVKrmMoZUtVV0GR49juyWan7brpUQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 51C346028D;
        Thu,  7 Mar 2019 02:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551925293;
        bh=J4Fu0YHFCf6KtFZ4WP5SYSfwHrB9s7r4l/gARSgE+LA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kReBPNdyts+3MxVZtFBGuVyVywnLdFByBz4S9hUBjVpWB6CfioGOwUJHX0hoiIqi8
         Gx8M5kaeBl8qg1jd2gBnReWaxxHvXuMHVufaycYEIYRKz9qSipkrxzehAa1xgR6l9Z
         DMx3U3Jz70JE8T1/hIRydmBqwPxOfLjT3zxknP0Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Mar 2019 07:51:33 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH 1/2] Bluetooth: hci_qca: Rename STATE_<flags> to
 QCA_<flags>
In-Reply-To: <20190307004041.38059-2-mka@chromium.org>
References: <20190307004041.38059-1-mka@chromium.org>
 <20190307004041.38059-2-mka@chromium.org>
Message-ID: <9500f5a6edd2ecb9b376e3ba1a5ac4bd@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-07 06:10, Matthias Kaehlcke wrote:
> Rename STATE_IN_BAND_SLEEP_ENABLED to QCA_IN_BAND_SLEEP_ENABLED.
> The constant represents a flag (multiple flags can be set at once),
> not a unique state of the controller or driver. Also use the BIT()
> macro to specify the position of the flag instead of an integer
> literal.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 237aea34b69f1..ab8e59419dbc4 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -54,8 +54,7 @@
>  #define HCI_IBS_WAKE_ACK	0xFC
>  #define HCI_MAX_IBS_SIZE	10
> 
> -/* Controller states */
> -#define STATE_IN_BAND_SLEEP_ENABLED	1
> +#define QCA_IN_BAND_SLEEP_ENABLED	BIT(0)
> 
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
> @@ -775,7 +774,7 @@ static int qca_enqueue(struct hci_uart *hu, struct
> sk_buff *skb)
>  	/* Don't go to sleep in middle of patch download or
>  	 * Out-Of-Band(GPIOs control) sleep is selected.
>  	 */
> -	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
> +	if (!test_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
>  		skb_queue_tail(&qca->txq, skb);
>  		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>  		return 0;
> @@ -1192,7 +1191,7 @@ static int qca_setup(struct hci_uart *hu)
>  		return ret;
> 
>  	/* Patch downloading has to be done without IBS mode */
> -	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +	clear_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags);
> 
>  	if (qcadev->btsoc_type == QCA_WCN3990) {
>  		bt_dev_info(hdev, "setting up wcn3990");
> @@ -1236,7 +1235,7 @@ static int qca_setup(struct hci_uart *hu)
>  	/* Setup patch / NVM configurations */
>  	ret = qca_uart_setup(hdev, qca_baudrate, qcadev->btsoc_type, 
> soc_ver);
>  	if (!ret) {
> -		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +		set_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags);
>  		qca_debugfs_init(hdev);
>  	} else if (ret == -ENOENT) {
>  		/* No patch/nvm-config found, run with original fw/config */
> @@ -1294,7 +1293,7 @@ static void qca_power_shutdown(struct hci_uart 
> *hu)
>  	 * data in skb's.
>  	 */
>  	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> -	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +	clear_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags);
>  	qca_flush(hu);
>  	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);


Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
-- 
Regards
Balakrishna.
