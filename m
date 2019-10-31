Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCC1CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B9620650
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X6k6s15e";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EXnfgm3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfJaPEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:04:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36726 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfJaPEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:04:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 897E160397; Thu, 31 Oct 2019 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572534262;
        bh=piPv6KljSbF/JOYPJvzQleKy8QgMYBVVrd7JnibL0NQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X6k6s15e/m2NEUeIyI4nleAVJFlpkd8xDgOAwZ4mLvZXpMwhtxEocP/AuQ5Gxgeq3
         8H06jSW14UOYQBSt7b5A4rxisvKWivHiPdjZaPeaN3V7z+n+yhaykaakFmkxTzWcUJ
         qzrlS2UM+HICPZbihyUD9yw2K/uc6yZLPRoMzgOY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 155A7603A3;
        Thu, 31 Oct 2019 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572534261;
        bh=piPv6KljSbF/JOYPJvzQleKy8QgMYBVVrd7JnibL0NQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EXnfgm3SHhZOBJ/7lA5iOVzov75VUvVkJoNMAE2vULU9k0LUjSQ15M3wMQUBr3N9J
         ZuA8RVcwVd+YeiAfBFk5ceFWJttEcTE1htWC6b+vdYmjVBm84d/2W6dWi5/EbXyZs/
         iivYNhKo5TfPzxa38dCSBfnOdl6xLYfF78Nd0ZdU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 31 Oct 2019 20:34:21 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, rjliao@codeaurora.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH] Bluetooth: hci_qca: add PM support
In-Reply-To: <20191031104614.165120-1-tientzu@chromium.org>
References: <20191031104614.165120-1-tientzu@chromium.org>
Message-ID: <40b0f2f7061cce48fc417f5e4593dddf@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Matthias,

On 2019-10-31 16:16, Claire Chang wrote:
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
> In order to prevent the device from being awaken again after 
> qca_suspend
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
> normal HCI packets. By doing so, only a few HCI_IBS_WAKE_IND packets 
> are
> lost and there is no data packet loss.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 127 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 124 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index c591a8ba9d93..c2062087b46b 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -43,7 +43,8 @@
>  #define HCI_MAX_IBS_SIZE	10
> 
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
> -#define IBS_TX_IDLE_TIMEOUT_MS		2000
> +#define IBS_BTSOC_TX_IDLE_TIMEOUT_MS	40
> +#define IBS_HOST_TX_IDLE_TIMEOUT_MS	2000
>  #define CMD_TRANS_TIMEOUT_MS		100
> 
>  /* susclk rate */
> @@ -55,6 +56,7 @@
>  enum qca_flags {
>  	QCA_IBS_ENABLED,
>  	QCA_DROP_VENDOR_EVENT,
> +	QCA_SUSPENDING,
>  };
> 
>  /* HCI_IBS transmit side sleep protocol states */
> @@ -100,6 +102,7 @@ struct qca_data {
>  	struct work_struct ws_tx_vote_off;
>  	unsigned long flags;
>  	struct completion drop_ev_comp;
> +	wait_queue_head_t suspend_wait_q;
> 
>  	/* For debugging purpose */
>  	u64 ibs_sent_wacks;
> @@ -437,6 +440,12 @@ static void hci_ibs_wake_retrans_timeout(struct
> timer_list *t)
>  	spin_lock_irqsave_nested(&qca->hci_ibs_lock,
>  				 flags, SINGLE_DEPTH_NESTING);
> 
> +	/* Don't retransmit the HCI_IBS_WAKE_IND when suspending. */
> +	if (test_bit(QCA_SUSPENDING, &qca->flags)) {
> +		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +		return;
> +	}
> +
>  	switch (qca->tx_ibs_state) {
>  	case HCI_IBS_TX_WAKING:
>  		/* No WAKE_ACK, retransmit WAKE */
> @@ -496,6 +505,8 @@ static int qca_open(struct hci_uart *hu)
>  	INIT_WORK(&qca->ws_rx_vote_off, qca_wq_serial_rx_clock_vote_off);
>  	INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
> 
> +	init_waitqueue_head(&qca->suspend_wait_q);
> +
>  	qca->hu = hu;
>  	init_completion(&qca->drop_ev_comp);
> 
> @@ -532,7 +543,7 @@ static int qca_open(struct hci_uart *hu)
>  	qca->wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
> 
>  	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
> -	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
> +	qca->tx_idle_delay = IBS_HOST_TX_IDLE_TIMEOUT_MS;
> 
>  	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
>  	       qca->tx_idle_delay, qca->wake_retrans);
> @@ -647,6 +658,12 @@ static void device_want_to_wakeup(struct hci_uart 
> *hu)
> 
>  	qca->ibs_recv_wakes++;
> 
> +	/* Don't wake the rx up when suspending. */
> +	if (test_bit(QCA_SUSPENDING, &qca->flags)) {
> +		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +		return;
> +	}
> +
>  	switch (qca->rx_ibs_state) {
>  	case HCI_IBS_RX_ASLEEP:
>  		/* Make sure clock is on - we may have turned clock off since
> @@ -711,6 +728,8 @@ static void device_want_to_sleep(struct hci_uart 
> *hu)
>  		break;
>  	}
> 
> +	wake_up_interruptible(&qca->suspend_wait_q);
> +
>  	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>  }
> 
> @@ -728,6 +747,12 @@ static void device_woke_up(struct hci_uart *hu)
> 
>  	qca->ibs_recv_wacks++;
> 
> +	/* Don't react to the wake-up-acknowledgment when suspending. */
> +	if (test_bit(QCA_SUSPENDING, &qca->flags)) {
> +		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +		return;
> +	}
> +
>  	switch (qca->tx_ibs_state) {
>  	case HCI_IBS_TX_AWAKE:
>  		/* Expect one if we send 2 WAKEs */
> @@ -780,8 +805,10 @@ static int qca_enqueue(struct hci_uart *hu,
> struct sk_buff *skb)
> 
>  	/* Don't go to sleep in middle of patch download or
>  	 * Out-Of-Band(GPIOs control) sleep is selected.
> +	 * Don't wake the device up when suspending.
>  	 */
> -	if (!test_bit(QCA_IBS_ENABLED, &qca->flags)) {
> +	if (!test_bit(QCA_IBS_ENABLED, &qca->flags) ||
> +	    test_bit(QCA_SUSPENDING, &qca->flags)) {
>  		skb_queue_tail(&qca->txq, skb);
>  		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>  		return 0;
> @@ -1539,6 +1566,99 @@ static void qca_serdev_remove(struct
> serdev_device *serdev)
>  	hci_uart_unregister_device(&qcadev->serdev_hu);
>  }
> 
> +static int __maybe_unused qca_suspend(struct device *dev)
> +{
> +	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct qca_data *qca = hu->priv;
> +	unsigned long flags;
> +	int ret = 0;
> +	u8 cmd;
> +
> +	set_bit(QCA_SUSPENDING, &qca->flags);
> +
> +	/* Device is downloading patch or doesn't support in-band sleep. */
> +	if (!test_bit(QCA_IBS_ENABLED, &qca->flags))
> +		return 0;
> +
> +	cancel_work_sync(&qca->ws_awake_device);
> +	cancel_work_sync(&qca->ws_awake_rx);
> +
> +	spin_lock_irqsave_nested(&qca->hci_ibs_lock,
> +				 flags, SINGLE_DEPTH_NESTING);
> +
> +	switch (qca->tx_ibs_state) {
> +	case HCI_IBS_TX_WAKING:
> +		del_timer(&qca->wake_retrans_timer);
> +		/* Fall through */
> +	case HCI_IBS_TX_AWAKE:
> +		del_timer(&qca->tx_idle_timer);
> +
> +		serdev_device_write_flush(hu->serdev);
> +		cmd = HCI_IBS_SLEEP_IND;
> +		ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
> +
> +		if (ret < 0) {
> +			BT_ERR("Failed to send SLEEP to device");
> +			break;
> +		}
> +
> +		qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
> +		qca->ibs_sent_slps++;
> +
> +		qca_wq_serial_tx_clock_vote_off(&qca->ws_tx_vote_off);
> +		break;
> +
> +	case HCI_IBS_TX_ASLEEP:
> +		break;
> +
> +	default:
> +		BT_ERR("Spurious tx state %d", qca->tx_ibs_state);
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +
> +	if (ret < 0)
> +		goto error;
> +
> +	serdev_device_wait_until_sent(hu->serdev,
> +				      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
> +
> +	/* Wait for HCI_IBS_SLEEP_IND sent by device to indicate its Tx is 
> going
> +	 * to sleep, so that the packet does not wake the system later.
> +	 */
> +
> +	ret = wait_event_interruptible_timeout(qca->suspend_wait_q,
> +			qca->rx_ibs_state == HCI_IBS_RX_ASLEEP,
> +			msecs_to_jiffies(IBS_BTSOC_TX_IDLE_TIMEOUT_MS));
> +
> +	if (ret > 0)
> +		return 0;
> +
> +	if (ret == 0)
> +		ret = -ETIMEDOUT;
> +
> +error:
> +	clear_bit(QCA_SUSPENDING, &qca->flags);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused qca_resume(struct device *dev)
> +{
> +	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct qca_data *qca = hu->priv;
> +
> +	clear_bit(QCA_SUSPENDING, &qca->flags);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, qca_resume);
> +
>  static const struct of_device_id qca_bluetooth_of_match[] = {
>  	{ .compatible = "qcom,qca6174-bt" },
>  	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
> @@ -1553,6 +1673,7 @@ static struct serdev_device_driver 
> qca_serdev_driver = {
>  	.driver = {
>  		.name = "hci_uart_qca",
>  		.of_match_table = qca_bluetooth_of_match,
> +		.pm = &qca_pm_ops,
>  	},
>  };

-- 
Regards
Balakrishna.
